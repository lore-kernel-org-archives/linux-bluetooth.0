Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9F89C4B87365E4408446E7FF5C4AE97115A0CB9EAF@SMUCM17V.europe.bmw.corp>
References: <1354891631-17994-1-git-send-email-luiz.dentz@gmail.com>
	<9F89C4B87365E4408446E7FF5C4AE97115A0CB9A78@SMUCM17V.europe.bmw.corp>
	<CABBYNZ+1PR_M+G=g8iFp19-sokNWoCkE7Mk+xV5KqNkb7Qk-9A@mail.gmail.com>
	<9F89C4B87365E4408446E7FF5C4AE97115A0CB9EAF@SMUCM17V.europe.bmw.corp>
Date: Wed, 12 Dec 2012 16:45:04 +0200
Message-ID: <CABBYNZJS4-DX17kO1A6Cr+w_A3LVHCAcwfgxZpZnOLQG-GC_yQ@mail.gmail.com>
Subject: Re: [RFC BlueZ v1] media-api: Add org.bluez.MediaLibrary1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Oleksandr.Domin@bmw.de
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oleksandr,

On Tue, Dec 11, 2012 at 6:53 PM,  <Oleksandr.Domin@bmw.de> wrote:
> Hi Luiz
>>
>>Hi Oleksandr,
>>
>>On Tue, Dec 11, 2012 at 2:57 PM,  <Oleksandr.Domin@bmw.de> wrote:
>>> Hi Luiz,
>>>
>>>>From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>
>>>>This interface adds support for browsing and searching in the player's
>>>>storage using AVRCP 1.4/1.5.
>>>>
>>>>Some remarks about the design:
>>>>
>>>>  - Exposing UIDCounter and UIDs was considered, but the spec seems to
>>have
>>>>    missed to define the player's id persistency. There are also the fact
>>>>that
>>>>    UIDCounter alone does not guarantee persistency across sessions and do
>>>>not
>>>>    provide what exact items have changed, so in the end exposing these
>>>>    details will bring almost no value.
>>>
>>> In case UIDCounter I agree we have no value, but we need to expose UIDs
>>> for found and browsed media items. I am thinking about IVI use cases like
>>> "search", "file browsing" and "content browsing". In this case you have
>>> not only AVRCP device but also USB and other devices you would like to
>>> run you use cases. And you would like to combine results in to one
>>> global list and initiate playback.
>>
>>If you need to cache any information, which is not recommended, you
>>are in your own to assume the player id or name are persistent, but if
>>you do so you can also assume the folder are persistent as well then
>>just cache them. The important part is that you have to rediscover
>>them to find out what is the current UID for the item.
>>
>>> I know we cannot rely on this UIDs but in case we get UIDCounter changed
>>> application has to delete all UIDs and start from the beginning.
>>
>>Yes, and that would be done automatically by ObjectManager for the
>>current listed items.
>>
>>>>  - Indexing or caching the whole media library is not recommended,
>>>>Bluetooth
>>>>    is too slow for that and even vendors such as Apple do not recommend
>>>>doing
>>>>    it, so the only items keep in cache are the current listed ones.
>>>
>>> Question is why do we need this cache on D-Bus (Object manager)? If we
>>> return this information it's up to the application to do whatever
>>> it wants.
>>
>>To track the item's UID, otherwise we always have to access by path
>>and discover the UID in the background since the UID is unreliable.
>
> So I see. We have the an Item represented as an object. This item has
> internally the UID to be able to send it to the target for playing. In case
> UIDCounter will be updated the object will be deleted. But if UIDCounter
> is unchanged you can use only PlayItem(UID) ignoring the Item object?

Nope, you can't have the UID as they are unreliable and Im quite sure
this would create a lot of other problems that the application
themselves would have to resolve such as the player persistency. The
items filesystem path is probably much more deterministic than the UID
and that is something you can probably use together with Search to
discover the Item UID when you want it to be played or added to now
playing list.

>>
>>>>  - Addressed vs Browsed player is done implicitly when accessed, this was
>>>>done
>>>>    to simplify the API and avoid confusions between applications and
>>>>players.
>>>>---
>>>>v1: Rename to MediaLibrary and add versioning, also rename Properties
>>filter
>>>>to attributes and don't use camel case for values.
>>>>
>>>> doc/media-api.txt | 173
>>>>++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>> 1 file changed, 173 insertions(+)
>>>>
>>>>diff --git a/doc/media-api.txt b/doc/media-api.txt
>>>>index 1865df9..0926e43 100644
>>>>--- a/doc/media-api.txt
>>>>+++ b/doc/media-api.txt
>>>>@@ -219,6 +219,179 @@ Properties       string Equalizer [readwrite]
>>>>                       possible to signal its end by setting position to
>>the
>>>>                       maximum uint32 value.
>>>
>>> As I see we have properties like "Equalizer", "Repeat" "Shuffle"
>>> and "Scan" per player. But I think from the application point of view
>>> it's good to set it once and to lat BlueZ handle this state's internally.
>>> In this case we would also reduce calls on D-Bus and simplify the logic
>>> in the application above.
>>
>>This is per player, if you want to replicate your status to each
>>player you can do it but I don't think BlueZ should assume all of them
>>have the same setting.
>
> I think we what design our applications as simple as possible. Please think
> about the following use case:
>         1. The customer is changing the player configuration.
>         2. This configuration will be applied for each media source
> Bluetooth AVRCP is in our case one audio source but with several players.
> But still I would expect BlueZ can handle this. I also agree if I
> change the player I can first of all read settings by the upper application
> and set it to the customer settings. But you need to do this every time
> you changing the player ;-)

But AVRCP is not meant to be audio source, it is a player or to be
more precise it is a remote control that can browse the player's media
library, so the behavior of your UI should be consistent with the
player you are controlling which is the opposite of what you are
suggesting which is to reflect the local player settings.

>>If that is useful I can add it no problem, but note that since you can
>>only play items from its own media library Im not sure this will be
>>useful for anything except maybe for filtering what player you display
>>to the user.
>
> I am not sure, but I think this information could be useful.

We can add it latter if we have a use case that does actually use these details.

>>
>>>>+
>>>>+MediaLibrary1 hierarchy
>>>>+=======================
>>>>+
>>>>+Service               unique name (Target role)
>>>>+              org.bluez (Controller role)
>>>>+Interface     org.bluez.MediaLibrary1
>>>>+Object path   freely definable (Target role)
>>>>+              [variable
>>prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/player
>>>
>>> Are you talking about
>>> [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/MediaLibraryX
>>>
>>>>+              (Controller role)
>>>>+
>>>>+Methods               array{objects, properties} Search(string value,
>>dict
>>>>filter)
>>>>+
>>>>+                      Return a list of MediaItem found
>>>
>>> I think in this case we need to return only the number of media items
>>> found by the search method. In the second step you can ask the stack
>>> to list all items (ListItems).
>>
>>Well the underlining protocol is designed like this so to get the
>>number of items you have to search anyway so why not return the items
>>too? Perhaps you are suggesting to join this with ListItems so we
>>could in theory have a search string as filter which will do just the
>>same.
>
> No, in case you are searching you will get the number of items
> found by the search. You need to call getFolderItems and the
> number of items you would like to download. And if you remember our
> discussion, if we have low budget IVI system you could download only
> the first 100 items. If you do it in one call you will return all items.

Then it can search from the last index + 100 items, otherwise we need
a specific folder to map search scope of the items.

> The second reason is if you use only one function to download item
> by calling ListItems you can easily cancel the previous initiated
> ListItems call (canceling previous item download).

Other operations such as ListItems or ChangeFolder could trigger
search to cancel, furthermore there is no cancel for AVRCP Browsing
commands so could just ignore the response but not really stop
anything.

>>
>>>>+
>>>>+              array{objects, properties} ListItems(dict filter)
>>>>+
>>>>+                      Return a list of MediaItem found
>>>
>>> Also here we need a numberOfItems parameter instead of the filter.
>>> If you have to search you would like also to set the filter if you
>>> want to browse (and we are talking about file browsing) we have
>>> to return all results in the folder. We have to use the filter
>>> other in Search or in ListItem but not in both.
>>
>>You can provide Start and End as filter with that you can select how
>>many items you want in the return.
>
> You will know the start and end items only if you know the number of
> items before you start ListItems
>
>>
>>> I am also not a freand of returning objects. I think we need to
>>> return a dict with the media item ID and meta data.
>>
>>The object is an id and the metadata is the properties and they both
>>are returned.
>
> Yes, I agree but I think in our case it's not what we want.
>
>>
>>>>+
>>>>+              void ChangeFolder(string path)
>>>>+
>>>>+                      Change current folder, support both relative or
>>>>+                      absolute paths.
>>>>+
>>>>+Properties    uint32 NumberOfItems:
>>>>+
>>>>+                      Number of items in the current folder
>>>
>>> I think we need this property as a return value. Result of the
>>> Search and ChangeFolder return different values. For example you
>>> do start search and the system will update the number of items
>>> and in the second step you execute ChangeFolder and BleuZ is
>>> updating the number of items. How do you know now how mach items
>>> do you have in search? So we need for Search and ChangeFolder
>>> different properties.
>>
>>What do you mean how many items you have in the search, we return a
>>list which the application will have to iterate, the number of items
>>is only interesting if you are not listen them, we could perhaps even
>>have it as return to ChangeFolder but anyway the property will be
>>updated everytime you change the folder.
>
> No the use case is as followed:
> 1. initiate ChangeFolder "/"
> 2. NumberOfItems will be set to 20
> 3. initiate Search
> 4. NumberOfItems will be set to 50
> 5. How do I get the number of items in the "/" directory know?

Right now Search do not affect the NumberOfItems because you haven't
changed the folder, and you can still request the amount of items you
want via filters, internally we should be able to keep the search
context active if you want more items, the application can also filter
the list itself.

>>
>>>>+
>>>>+              string Path:
>>>>+
>>>>+                      Current path:
>>>>+
>>>>+                      Possible values: "/root/folder" or "/NowPlaying"
>>>>+
>>>>+                      Note: /NowPlaying might not be listed if player is
>>>>+                      stopped
>>>
>>> It's good to have this property but I think we also need
>>> ListNowPlaing method without changing the paht to /NowPlaying.
>>> Requests ChangeFolder and ListNowPlaying are addressed to
>>> different players the one to the browsed and the second to the
>>> addressed player
>>
>>But that is exactly the purpose to expose NowPlaying as a folder, the
>>application has to request it explicitly which may not be there if the
>>player is not addressed and in addition we list the items there. Btw,
>>you can still do browse one player and list NowPlaying on other the
>>only thing that we are limiting is browsing both NowPlaying and
>>filesystem together which anyway is not possible since that would be
>>to the same device and the requests are no done in parallel
>
> This is something I would like to understand. I think you can do
> Change folder "path" for the browsed player and list know playing
> For the addressed player in parallel. But please correct me If I am wrong.

Yes, you can, NowPlaying list is persistent for this reason, you just
have to switch folder to change the scope.

>>
>>>>+
>>>>+Filters               uint32 Start:
>>>>+
>>>>+                      Offset of the first item.
>>>>+
>>>>+                      Default value: 0
>>>>+
>>>>+              uint32 End:
>>>>+
>>>>+                      Offset of the last item.
>>>>+
>>>>+                      Default value: NumbeOfItems
>>>
>>> In case we use NumberOfItems we also need one value not only for the
>>> ChangeFolder but even for Search.
>>
>>Search return a list of items found, NumberOfItems represents the
>>items in the folder just so the application can know in advance how
>>much traffic it would cause and possible download them in windowing
>>mode.
>>
>>>>+
>>>>+              array{string} Attributes
>>>>+
>>>>+                      Item properties that should be included in the
>>list.
>>>>+
>>>>+                      Possible Values:
>>>>+
>>>>+                              "title", "artist", "album", "genre",
>>>>+                              "number-of-tracks", "number", "duration"
>>>>+
>>>>+                      Default Value: All
>>>>+
>>>>+MediaItem1 hierarchy
>>>>+====================
>>>>+
>>>>+Service               unique name (Target role)
>>>>+              org.bluez (Controller role)
>>>>+Interface     org.bluez.MediaItem1
>>>>+Object path   freely definable (Target role)
>>>>+              [variable
>>>>+              prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX/itemX
>>>>+              (Controller role)
>>>
>>> In fact I do not like this Item representation as object in D-Bus.
>>> In this case we have 1000 D-Bus calls and more if you are trying to
>>> remove and add items from D-Bus.
>>
>>You don't remove or add, you list them, if you want to list only 10
>>items you can do that and only 10 objects would be created.
>>
>>> The second limitation is on IVI you cannot create your own lists to
>>> play. And I think the API should be as generic as possible in this
>>> case.
>>
>>You can create your own list, you just have to list them to refresh
>>the UID, btw if you use the NowPlaying list that should be persistent.
>>It the mixing of different sources that would be a problem, since with
>>that you cannot use NowPlaying, or perhaps you can by stopping the
>>playing when switching to another source but this could racy.
>
> I think in IVI do use our own global item list to play and not the
> NowPlaing one from the phone. Because we have already different
> Interpretations of the implementation with Iphone and the Windows 8.

Exactly, and the IVI system should be consistent what the target
player it is controlling, the use case you are trying to implement is
something completely different which perhaps could be possible with
something like OBEX FTP or MTP, but even this protocols are not meant
for indexing but for syncing the library.

> If you select on the Iphone any item in a folder to play all folder
> Items will be added to the NowPlaying list. In case on Windows 8 only
> this item will be added to the NowPlaing list and this item will play
> in a loop.

Yes devices will behave differently, actually even player of the same
device could probably behave completely different and have completely
different feature set.


--
Luiz Augusto von Dentz
