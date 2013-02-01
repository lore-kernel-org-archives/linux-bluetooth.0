Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] media-api: Add org.bluez.MediaFolder1
Date: Thu, 31 Jan 2013 21:58:32 -0600
Message-Id: <1359691117-13847-1-git-send-email-luiz.dentz@gmail.com>
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
 doc/media-api.txt | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 972716e..54e53b9 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -226,6 +226,189 @@ Properties	string Equalizer [readwrite]
 
 			Device object path.
 
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
+MediaFolder1 hierarchy
+======================
+
+Service		unique name (Target role)
+		org.bluez (Controller role)
+Interface	org.bluez.MediaFolder1 [Experimental]
+Object path	freely definable (Target role)
+		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
+		(Controller role)
+
+Methods		object Search(string value, dict filter)
+
+			Return a folder object containing the search result.
+
+			To list the items found use the folder object returned
+			and pass to ChangeFolder.
+
+		array{objects, properties} ListItems(dict filter)
+
+			Return a list of items found
+
+		void ChangeFolder(object folder)
+
+			Change current folder.
+
+			Note: By changing folder the items of previous folder
+			might be destroyed and have to be listed again, the
+			exception is NowPlaying folder which should be always
+			present while the player is active.
+
+Properties	uint32 NumberOfItems:
+
+			Number of items in the folder
+
+		string Name:
+
+			Folder name:
+
+			Possible values:
+				"/Filesystem/...": Filesystem scope
+				"/NowPlaying/...": NowPlaying scope
+
+			Note: /NowPlaying folder might not be listed if player
+			is stopped, folders created by Search are virtual so
+			once another Search is perform or the folder is
+			changed using ChangeFolder it will no longer be listed.
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
+Interface	org.bluez.MediaItem1 [Experimental]
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
 MediaEndpoint1 hierarchy
 ========================
 
-- 
1.8.1

