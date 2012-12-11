Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9F89C4B87365E4408446E7FF5C4AE97115A0CB9A78@SMUCM17V.europe.bmw.corp>
References: <1354891631-17994-1-git-send-email-luiz.dentz@gmail.com>
	<9F89C4B87365E4408446E7FF5C4AE97115A0CB9A78@SMUCM17V.europe.bmw.corp>
Date: Tue, 11 Dec 2012 16:35:17 +0200
Message-ID: <CABBYNZ+1PR_M+G=g8iFp19-sokNWoCkE7Mk+xV5KqNkb7Qk-9A@mail.gmail.com>
Subject: Re: [RFC BlueZ v1] media-api: Add org.bluez.MediaLibrary1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Oleksandr.Domin@bmw.de
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oleksandr,

On Tue, Dec 11, 2012 at 2:57 PM,  <Oleksandr.Domin@bmw.de> wrote:
> Hi Luis,
>
>>From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>>This interface adds support for browsing and searching in the player's
>>storage using AVRCP 1.4/1.5.
>>
>>Some remarks about the design:
>>
>>  - Exposing UIDCounter and UIDs was considered, but the spec seems to have
>>    missed to define the player's id persistency. There are also the fact
>>that
>>    UIDCounter alone does not guarantee persistency across sessions and do
>>not
>>    provide what exact items have changed, so in the end exposing these
>>    details will bring almost no value.
>
> In case UIDCounter I agree we have no value, but we need to expose UIDs
> for found and browsed media items. I am thinking about IVI use cases like
> "search", "file browsing" and "content browsing". In this case you have
> not only AVRCP device but also USB and other devices you would like to
> run you use cases. And you would like to combine results in to one
> global list and initiate playback.

If you need to cache any information, which is not recommended, you
are in your own to assume the player id or name are persistent, but if
you do so you can also assume the folder are persistent as well then
just cache them. The important part is that you have to rediscover
them to find out what is the current UID for the item.

> I know we cannot rely on this UIDs but in case we get UIDCounter changed
> application has to delete all UIDs and start from the beginning.

Yes, and that would be done automatically by ObjectManager for the
current listed items.

>>  - Indexing or caching the whole media library is not recommended,
>>Bluetooth
>>    is too slow for that and even vendors such as Apple do not recommend
>>doing
>>    it, so the only items keep in cache are the current listed ones.
>
> Question is why do we need this cache on D-Bus (Object manager)? If we
> return this information it's up to the application to do whatever
> it wants.

To track the item's UID, otherwise we always have to access by path
and discover the UID in the background since the UID is unreliable.

>>  - Addressed vs Browsed player is done implicitly when accessed, this was
>>done
>>    to simplify the API and avoid confusions between applications and
>>players.
>>---
>>v1: Rename to MediaLibrary and add versioning, also rename Properties filter
>>to attributes and don't use camel case for values.
>>
>> doc/media-api.txt | 173
>>++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 173 insertions(+)
>>
>>diff --git a/doc/media-api.txt b/doc/media-api.txt
>>index 1865df9..0926e43 100644
>>--- a/doc/media-api.txt
>>+++ b/doc/media-api.txt
>>@@ -219,6 +219,179 @@ Properties       string Equalizer [readwrite]
>>                       possible to signal its end by setting position to the
>>                       maximum uint32 value.
>
> As I see we have properties like "Equalizer", "Repeat" "Shuffle"
> and "Scan" per player. But I think from the application point of view
> it's good to set it once and to lat BlueZ handle this state's internally.
> In this case we would also reduce calls on D-Bus and simplify the logic
> in the application above.

This is per player, if you want to replicate your status to each
player you can do it but I don't think BlueZ should assume all of them
have the same setting.

>
>>
>>+              string Name [readonly]
>>+
>>+                      Player name
>>+
>>+              boolean Browsable [readonly]
>>+
>>+                      If present indicates the player can be browsed using
>>+                      MediaLibrary interface.
>>+
>>+                      Possible values:
>>+
>>+                              True: Supported and active
>>+                              False: Supported but inactive
>
> Is it possible to change to: Supported while active and supported while
> inactive? In case of active we are talking about while addressed player.

Sure that can be done.

>>+
>>+                      Note: If supported but inactive clients can enable it
>>+                      by using MediaLibrary interface but it might interfere
>>+                      in the playback of other players.
>>+
>>+
>>+              boolean Searchable [readonly]
>>+
>>+                      If present indicates the player can be searched using
>>+                      MediaLibrary interface.
>>+
>>+                      Possible values:
>>+
>>+                              True: Supported and active
>>+                              False: Supported but inactive
>>+
>>+                      Note: If supported but inactive clients can enable it
>>+                      by using MediaLibrary interface but it might interfere
>>+                      in the playback of other players.
>>+
>>+              array{string} Buttons [readonly]
>>+
>>+                      If available indicates the buttons supported by the
>>+                      player.
>>+
>>+                      Possible values:
>>+
>>+                              "Play", "Pause", "Stop", "Next", "Previous",
>>+                              "FastForward" and "Rewind"
>>+
>>+                      Default value: All
>
> Do we return the enum ALL or to we return all values?
>
> In addition I miss the Media Player Type and Player Subtype properties.
> In case MediaPlayerType we have:
>         Audio
>         Video
>         Broadcastingaudio
>         Broadcastingvideo
>
> In case PlayerSubType we have:
>         AudioBook
>         Podcast

If that is useful I can add it no problem, but note that since you can
only play items from its own media library Im not sure this will be
useful for anything except maybe for filtering what player you display
to the user.

>>+
>>+MediaLibrary1 hierarchy
>>+=======================
>>+
>>+Service               unique name (Target role)
>>+              org.bluez (Controller role)
>>+Interface     org.bluez.MediaLibrary1
>>+Object path   freely definable (Target role)
>>+              [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/player
>
> Are you talking about
> [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/MediaLibraryX
>
>>+              (Controller role)
>>+
>>+Methods               array{objects, properties} Search(string value, dict
>>filter)
>>+
>>+                      Return a list of MediaItem found
>
> I think in this case we need to return only the number of media items
> found by the search method. In the second step you can ask the stack
> to list all items (ListItems).

Well the underlining protocol is designed like this so to get the
number of items you have to search anyway so why not return the items
too? Perhaps you are suggesting to join this with ListItems so we
could in theory have a search string as filter which will do just the
same.

>>+
>>+              array{objects, properties} ListItems(dict filter)
>>+
>>+                      Return a list of MediaItem found
>
> Also here we need a numberOfItems parameter instead of the filter.
> If you have to search you would like also to set the filter if you
> want to browse (and we are talking about file browsing) we have
> to return all results in the folder. We have to use the filter
> other in Search or in ListItem but not in both.

You can provide Start and End as filter with that you can select how
many items you want in the return.

> I am also not a freand of returning objects. I think we need to
> return a dict with the media item ID and meta data.

The object is an id and the metadata is the properties and they both
are returned.

>>+
>>+              void ChangeFolder(string path)
>>+
>>+                      Change current folder, support both relative or
>>+                      absolute paths.
>>+
>>+Properties    uint32 NumberOfItems:
>>+
>>+                      Number of items in the current folder
>
> I think we need this property as a return value. Result of the
> Search and ChangeFolder return different values. For example you
> do start search and the system will update the number of items
> and in the second step you execute ChangeFolder and BleuZ is
> updating the number of items. How do you know now how mach items
> do you have in search? So we need for Search and ChangeFolder
> different properties.

What do you mean how many items you have in the search, we return a
list which the application will have to iterate, the number of items
is only interesting if you are not listen them, we could perhaps even
have it as return to ChangeFolder but anyway the property will be
updated everytime you change the folder.

>>+
>>+              string Path:
>>+
>>+                      Current path:
>>+
>>+                      Possible values: "/root/folder" or "/NowPlaying"
>>+
>>+                      Note: /NowPlaying might not be listed if player is
>>+                      stopped
>
> It's good to have this property but I think we also need
> ListNowPlaing method without changing the paht to /NowPlaying.
> Requests ChangeFolder and ListNowPlaying are addressed to
> different players the one to the browsed and the second to the
> addressed player

But that is exactly the purpose to expose NowPlaying as a folder, the
application has to request it explicitly which may not be there if the
player is not addressed and in addition we list the items there. Btw,
you can still do browse one player and list NowPlaying on other the
only thing that we are limiting is browsing both NowPlaying and
filesystem together which anyway is not possible since that would be
to the same device and the requests are no done in parallel

>>+
>>+Filters               uint32 Start:
>>+
>>+                      Offset of the first item.
>>+
>>+                      Default value: 0
>>+
>>+              uint32 End:
>>+
>>+                      Offset of the last item.
>>+
>>+                      Default value: NumbeOfItems
>
> In case we use NumberOfItems we also need one value not only for the
> ChangeFolder but even for Search.

Search return a list of items found, NumberOfItems represents the
items in the folder just so the application can know in advance how
much traffic it would cause and possible download them in windowing
mode.

>>+
>>+              array{string} Attributes
>>+
>>+                      Item properties that should be included in the list.
>>+
>>+                      Possible Values:
>>+
>>+                              "title", "artist", "album", "genre",
>>+                              "number-of-tracks", "number", "duration"
>>+
>>+                      Default Value: All
>>+
>>+MediaItem1 hierarchy
>>+====================
>>+
>>+Service               unique name (Target role)
>>+              org.bluez (Controller role)
>>+Interface     org.bluez.MediaItem1
>>+Object path   freely definable (Target role)
>>+              [variable
>>+              prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX/itemX
>>+              (Controller role)
>
> In fact I do not like this Item representation as object in D-Bus.
> In this case we have 1000 D-Bus calls and more if you are trying to
> remove and add items from D-Bus.

You don't remove or add, you list them, if you want to list only 10
items you can do that and only 10 objects would be created.

> The second limitation is on IVI you cannot create your own lists to
> play. And I think the API should be as generic as possible in this
> case.

You can create your own list, you just have to list them to refresh
the UID, btw if you use the NowPlaying list that should be persistent.
It the mixing of different sources that would be a problem, since with
that you cannot use NowPlaying, or perhaps you can by stopping the
playing when switching to another source but this could racy.

--
Luiz Augusto von Dentz
