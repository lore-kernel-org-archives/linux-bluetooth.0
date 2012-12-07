Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v1] media-api: Add org.bluez.MediaLibrary1
Date: Fri,  7 Dec 2012 16:47:11 +0200
Message-Id: <1354891631-17994-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This interface adds support for browsing and searching in the player's
storage using AVRCP 1.4/1.5.

Some remarks about the design:

  - Exposing UIDCounter and UIDs was considered, but the spec seems to have
    missed to define the player's id persistency. There are also the fact that
    UIDCounter alone does not guarantee persistency across sessions and do not
    provide what exact items have changed, so in the end exposing these
    details will bring almost no value.
  - Indexing or caching the whole media library is not recommended, Bluetooth
    is too slow for that and even vendors such as Apple do not recommend doing
    it, so the only items keep in cache are the current listed ones.
  - Addressed vs Browsed player is done implicitly when accessed, this was done
    to simplify the API and avoid confusions between applications and players.
---
v1: Rename to MediaLibrary and add versioning, also rename Properties filter
to attributes and don't use camel case for values.

 doc/media-api.txt | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 1865df9..0926e43 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -219,6 +219,179 @@ Properties	string Equalizer [readwrite]
 			possible to signal its end by setting position to the
 			maximum uint32 value.
 
+		string Name [readonly]
+
+			Player name
+
+		boolean Browsable [readonly]
+
+			If present indicates the player can be browsed using
+			MediaLibrary interface.
+
+			Possible values:
+
+				True: Supported and active
+				False: Supported but inactive
+
+			Note: If supported but inactive clients can enable it
+			by using MediaLibrary interface but it might interfere
+			in the playback of other players.
+
+
+		boolean Searchable [readonly]
+
+			If present indicates the player can be searched using
+			MediaLibrary interface.
+
+			Possible values:
+
+				True: Supported and active
+				False: Supported but inactive
+
+			Note: If supported but inactive clients can enable it
+			by using MediaLibrary interface but it might interfere
+			in the playback of other players.
+
+		array{string} Buttons [readonly]
+
+			If available indicates the buttons supported by the
+			player.
+
+			Possible values:
+
+				"Play", "Pause", "Stop", "Next", "Previous",
+				"FastForward" and "Rewind"
+
+			Default value: All
+
+MediaLibrary1 hierarchy
+=======================
+
+Service		unique name (Target role)
+		org.bluez (Controller role)
+Interface	org.bluez.MediaLibrary1
+Object path	freely definable (Target role)
+		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
+		(Controller role)
+
+Methods		array{objects, properties} Search(string value, dict filter)
+
+			Return a list of MediaItem found
+
+		array{objects, properties} ListItems(dict filter)
+
+			Return a list of MediaItem found
+
+		void ChangeFolder(string path)
+
+			Change current folder, support both relative or
+			absolute paths.
+
+Properties	uint32 NumberOfItems:
+
+			Number of items in the current folder
+
+		string Path:
+
+			Current path:
+
+			Possible values: "/root/folder" or "/NowPlaying"
+
+			Note: /NowPlaying might not be listed if player is
+			stopped
+
+Filters		uint32 Start:
+
+			Offset of the first item.
+
+			Default value: 0
+
+		uint32 End:
+
+			Offset of the last item.
+
+			Default value: NumbeOfItems
+
+		array{string} Attributes
+
+			Item properties that should be included in the list.
+
+			Possible Values:
+
+				"title", "artist", "album", "genre",
+				"number-of-tracks", "number", "duration"
+
+			Default Value: All
+
+MediaItem1 hierarchy
+====================
+
+Service		unique name (Target role)
+		org.bluez (Controller role)
+Interface	org.bluez.MediaItem1
+Object path	freely definable (Target role)
+		[variable
+		prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX/itemX
+		(Controller role)
+
+Methods		void Play()
+
+			Play item
+
+		void AddtoNowPlaying()
+
+			Add item to now playing list
+
+Properties	string Name [readonly]
+
+			Item displayable name
+
+		boolean Folder [readonly]
+
+			Indicates whether the item is a folder
+
+		string Type [readonly]
+
+			Item type
+
+			Possible values:
+
+				Folder: "Mixed", "Titles", "Albums", "Artists"
+				Other Items: "Video", "Audio"
+
+		boolean Playable [readonly]
+
+			Indicates if the item can be played
+
+		string Title:
+
+			Item title name
+
+		string Artist:
+
+			Item artist name
+
+		string Album:
+
+			Item album name
+
+		string Genre:
+
+			Item genre name
+
+		uint32 NumberOfTracks:
+
+			Item album number of tracks in total
+
+		uint32 Number:
+
+			Item album number
+
+		uint32 Duration:
+
+			Item duration in milliseconds
+
+
 MediaEndpoint1 hierarchy
 ========================
 
-- 
1.7.11.7

