Return-Path: <cyrus@holtmann.org>
From: <Oleksandr.Domin@bmw.de>
To: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
Date: Tue, 11 Dec 2012 13:57:51 +0100
Subject: RE: [RFC BlueZ v1] media-api: Add org.bluez.MediaLibrary1
Message-ID: <9F89C4B87365E4408446E7FF5C4AE97115A0CB9A78@SMUCM17V.europe.bmw.corp>
References: <1354891631-17994-1-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1354891631-17994-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luis,

>From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
>This interface adds support for browsing and searching in the player's
>storage using AVRCP 1.4/1.5.
>
>Some remarks about the design:
>
>  - Exposing UIDCounter and UIDs was considered, but the spec seems to have
>    missed to define the player's id persistency. There are also the fact
>that
>    UIDCounter alone does not guarantee persistency across sessions and do
>not
>    provide what exact items have changed, so in the end exposing these
>    details will bring almost no value.

In case UIDCounter I agree we have no value, but we need to expose UIDs 
for found and browsed media items. I am thinking about IVI use cases like
"search", "file browsing" and "content browsing". In this case you have
not only AVRCP device but also USB and other devices you would like to
run you use cases. And you would like to combine results in to one 
global list and initiate playback.

I know we cannot rely on this UIDs but in case we get UIDCounter changed
application has to delete all UIDs and start from the beginning. 

>  - Indexing or caching the whole media library is not recommended,
>Bluetooth
>    is too slow for that and even vendors such as Apple do not recommend
>doing
>    it, so the only items keep in cache are the current listed ones.

Question is why do we need this cache on D-Bus (Object manager)? If we
return this information it's up to the application to do whatever
it wants.

>  - Addressed vs Browsed player is done implicitly when accessed, this was
>done
>    to simplify the API and avoid confusions between applications and
>players.
>---
>v1: Rename to MediaLibrary and add versioning, also rename Properties filter
>to attributes and don't use camel case for values.
>
> doc/media-api.txt | 173
>++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 173 insertions(+)
>
>diff --git a/doc/media-api.txt b/doc/media-api.txt
>index 1865df9..0926e43 100644
>--- a/doc/media-api.txt
>+++ b/doc/media-api.txt
>@@ -219,6 +219,179 @@ Properties	string Equalizer [readwrite]
> 			possible to signal its end by setting position to the
> 			maximum uint32 value.

As I see we have properties like "Equalizer", "Repeat" "Shuffle" 
and "Scan" per player. But I think from the application point of view
it's good to set it once and to lat BlueZ handle this state's internally.
In this case we would also reduce calls on D-Bus and simplify the logic
in the application above.


>
>+		string Name [readonly]
>+
>+			Player name
>+
>+		boolean Browsable [readonly]
>+
>+			If present indicates the player can be browsed using
>+			MediaLibrary interface.
>+
>+			Possible values:
>+
>+				True: Supported and active
>+				False: Supported but inactive

Is it possible to change to: Supported while active and supported while
inactive? In case of active we are talking about while addressed player.

>+
>+			Note: If supported but inactive clients can enable it
>+			by using MediaLibrary interface but it might interfere
>+			in the playback of other players.
>+
>+
>+		boolean Searchable [readonly]
>+
>+			If present indicates the player can be searched using
>+			MediaLibrary interface.
>+
>+			Possible values:
>+
>+				True: Supported and active
>+				False: Supported but inactive
>+
>+			Note: If supported but inactive clients can enable it
>+			by using MediaLibrary interface but it might interfere
>+			in the playback of other players.
>+
>+		array{string} Buttons [readonly]
>+
>+			If available indicates the buttons supported by the
>+			player.
>+
>+			Possible values:
>+
>+				"Play", "Pause", "Stop", "Next", "Previous",
>+				"FastForward" and "Rewind"
>+
>+			Default value: All

Do we return the enum ALL or to we return all values?

In addition I miss the Media Player Type and Player Subtype properties.
In case MediaPlayerType we have:
	Audio
	Video
	Broadcastingaudio
	Broadcastingvideo

In case PlayerSubType we have:
	AudioBook
	Podcast

>+
>+MediaLibrary1 hierarchy
>+=======================
>+
>+Service		unique name (Target role)
>+		org.bluez (Controller role)
>+Interface	org.bluez.MediaLibrary1
>+Object path	freely definable (Target role)
>+		[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/player

Are you talking about 
[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/MediaLibraryX

>+		(Controller role)
>+
>+Methods		array{objects, properties} Search(string value, dict
>filter)
>+
>+			Return a list of MediaItem found

I think in this case we need to return only the number of media items
found by the search method. In the second step you can ask the stack
to list all items (ListItems).

>+
>+		array{objects, properties} ListItems(dict filter)
>+
>+			Return a list of MediaItem found

Also here we need a numberOfItems parameter instead of the filter.
If you have to search you would like also to set the filter if you
want to browse (and we are talking about file browsing) we have
to return all results in the folder. We have to use the filter
other in Search or in ListItem but not in both.
 
I am also not a freand of returning objects. I think we need to
return a dict with the media item ID and meta data.

>+
>+		void ChangeFolder(string path)
>+
>+			Change current folder, support both relative or
>+			absolute paths.
>+
>+Properties	uint32 NumberOfItems:
>+
>+			Number of items in the current folder

I think we need this property as a return value. Result of the 
Search and ChangeFolder return different values. For example you
do start search and the system will update the number of items
and in the second step you execute ChangeFolder and BleuZ is 
updating the number of items. How do you know now how mach items
do you have in search? So we need for Search and ChangeFolder
different properties.

>+
>+		string Path:
>+
>+			Current path:
>+
>+			Possible values: "/root/folder" or "/NowPlaying"
>+
>+			Note: /NowPlaying might not be listed if player is
>+			stopped

It's good to have this property but I think we also need 
ListNowPlaing method without changing the paht to /NowPlaying.
Requests ChangeFolder and ListNowPlaying are addressed to
different players the one to the browsed and the second to the
addressed player

>+
>+Filters		uint32 Start:
>+
>+			Offset of the first item.
>+
>+			Default value: 0
>+
>+		uint32 End:
>+
>+			Offset of the last item.
>+
>+			Default value: NumbeOfItems

In case we use NumberOfItems we also need one value not only for the
ChangeFolder but even for Search.

>+
>+		array{string} Attributes
>+
>+			Item properties that should be included in the list.
>+
>+			Possible Values:
>+
>+				"title", "artist", "album", "genre",
>+				"number-of-tracks", "number", "duration"
>+
>+			Default Value: All
>+
>+MediaItem1 hierarchy
>+====================
>+
>+Service		unique name (Target role)
>+		org.bluez (Controller role)
>+Interface	org.bluez.MediaItem1
>+Object path	freely definable (Target role)
>+		[variable
>+		prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX/itemX
>+		(Controller role)

In fact I do not like this Item representation as object in D-Bus.
In this case we have 1000 D-Bus calls and more if you are trying to 
remove and add items from D-Bus.

The second limitation is on IVI you cannot create your own lists to
play. And I think the API should be as generic as possible in this 
case.

>+
>+Methods		void Play()
>+
>+			Play item
>+
>+		void AddtoNowPlaying()
>+
>+			Add item to now playing list
>+
>+Properties	string Name [readonly]
>+
>+			Item displayable name
>+
>+		boolean Folder [readonly]
>+
>+			Indicates whether the item is a folder
>+
>+		string Type [readonly]
>+
>+			Item type
>+
>+			Possible values:
>+
>+				Folder: "Mixed", "Titles", "Albums", "Artists"
>+				Other Items: "Video", "Audio"
>+
>+		boolean Playable [readonly]
>+
>+			Indicates if the item can be played
>+
>+		string Title:
>+
>+			Item title name
>+
>+		string Artist:
>+
>+			Item artist name
>+
>+		string Album:
>+
>+			Item album name
>+
>+		string Genre:
>+
>+			Item genre name
>+
>+		uint32 NumberOfTracks:
>+
>+			Item album number of tracks in total
>+
>+		uint32 Number:
>+
>+			Item album number
>+
>+		uint32 Duration:
>+
>+			Item duration in milliseconds
>+
>+
> MediaEndpoint1 hierarchy
> ========================
>
>--
>1.7.11.7
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
