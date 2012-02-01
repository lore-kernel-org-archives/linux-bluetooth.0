Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 1 Feb 2012 08:28:43 +0100
Subject: [RFC]: AVRCP 1.4 Media API
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B20FD87385C@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I have seen quite a few post in community about AVRCP 1.4 and there were few discussion which have happened in past for this. I plan to resume the work for developing following features of AVRCP 1.4

            As per spec section 6.9.1     SetAddressedPlayer
            As per spec section 6.9.2     Addressed Player Changed Notification
            As per spec section 6.9.3     SetBrowsedPlayer
            As per spec section 6.9.4     Available Players Changed Notification
            As per spec section 6.10.3.3    UIDs Changed Notification
            As per spec section 6.10.4.1    ChangePath
            As per spec section 6.10.4.2    GetFolderItems
            As per spec section 6.10.4.3    GetItemAttributes
            As per spec section 6.12.1      PlayItem
            As per spec section 6.13.1      Absolute Volume
            As per spec section 6.13.3      Notify volume change

Hence I would like to propose following APIs for developing this feature.


>From a8fbf052e5ad409d767fa54343ac8ce462ee80da Mon Sep 17 00:00:00 2001
From: Vani Patel <vani.patel@stericsson.com>
Date: Tue, 24 Jan 2012 16:05:05 +0530
Subject: [PATCH] AVRCP: Media API for AVRCP 1.4

---
doc/media-api.txt |  321 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
1 files changed, 316 insertions(+), 5 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt index c53ab7b..b6f557e 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -2,7 +2,7 @@ BlueZ D-Bus Media API description
*********************************

 Media hierarchy
-===============
+=================================

 Service          org.bluez
Interface  org.bluez.Media
@@ -85,6 +85,113 @@ Methods         void RegisterEndpoint(object endpoint, dict properties)
                       uint32 Position

                              Playback position in milliseconds
+
+                       string Name
+
+                             Unique name of media player
+
+                       array{string} Type
+
+                             Possible values:
+                                   "Audio",
+                                   "Video",
+                                   "Broadcast Audio",
+                                   "Broadcast Video"
+
+                       array{string} SubType
+
+                             Possible values:
+                                   "Audiobook",
+                                   "Podcast"
+
+                       uint16 UidCounter
+
+                             Changes of this field signal changes in media player
+                             filesystem
+
+                       array{string} Features
+
+                             Possible values:
+                                   "PASSTHROUGH Select",
+                                   "PASSTHROUGH Up",
+                                   "PASSTHROUGH Down",
+                                   "PASSTHROUGH Left",
+                                   "PASSTHROUGH Right",
+                                   "PASSTHROUGH Right-Up",
+                                   "PASSTHROUGH Right-Down",
+                                   "PASSTHROUGH Left-Up",
+                                   "PASSTHROUGH Left-Down",
+                                   "PASSTHROUGH Root Menu",
+                                   "PASSTHROUGH Setup Menu",
+                                   "PASSTHROUGH Contents Menu",
+                                   "PASSTHROUGH Favourite Manu",
+                                   "PASSTHROUGH Exit",
+                                   "PASSTHROUGH 0",
+                                   "PASSTHROUGH 1",
+                                   "PASSTHROUGH 2",
+                                   "PASSTHROUGH 3",
+                                   "PASSTHROUGH 4",
+                                   "PASSTHROUGH 5",
+                                   "PASSTHROUGH 6",
+                                   "PASSTHROUGH 7",
+                                   "PASSTHROUGH 8",
+                                   "PASSTHROUGH 9",
+                                   "PASSTHROUGH Dot",
+                                   "PASSTHROUGH Enter",
+                                   "PASSTHROUGH Clear",
+                                   "PASSTHROUGH Channel Up",
+                                   "PASSTHROUGH Channel Down",
+                                   "PASSTHROUGH Previous Channel",
+                                   "PASSTHROUGH Sound Select",
+                                   "PASSTHROUGH Input Select",
+                                   "PASSTHROUGH Display Information",
+                                   "PASSTHROUGH Help",
+                                   "PASSTHROUGH Page Up",
+                                   "PASSTHROUGH Page Down",
+                                   "PASSTHROUGH Power",
+                                   "PASSTHROUGH Volume Up",
+                                   "PASSTHROUGH Volume Down",
+                                   "PASSTHROUGH Mute",
+                                   "PASSTHROUGH Play",
+                                   "PASSTHROUGH Stop",
+                                   "PASSTHROUGH Pause",
+                                   "PASSTHROUGH Record",
+                                   "PASSTHROUGH Rewind",
+                                   "PASSTHROUGH Fast Forward",
+                                   "PASSTHROUGH Eject",
+                                   "PASSTHROUGH Forward",
+                                   "PASSTHROUGH Backward",
+                                   "PASSTHROUGH Angle",
+                                   "PASSTHROUGH SubPicture",
+                                   "PASSTHROUGH F1",
+                                   "PASSTHROUGH F2",
+                                   "PASSTHROUGH F3",
+                                   "PASSTHROUGH F4",
+                                   "PASSTHROUGH F4",
+                                   "PASSTHROUGH F5",
+                                   "Vendor Unique",
+                                   "Basic Group Navigation",
+                                   "Advanced Control Player",
+                                   "Browsing",
+                                   "Searching",
+                                   "AddToNowPlaying",
+                                   "UID Unique",
+                                   "Only Browseable When Addresed",
+                                   "Only Searchable When Addresed",
+                                   "NowPlaying",
+                                   "UID Persistancy"
+
+                       byte Volume
+
+                             Current Volume in percent range: 0 - 100
+
+                       string Path
+
+                             Cuurent path in unix style, e.g. /root/music/
+
+                       uint32 NumberOfItems
+
+                             Number of items in "Path"

                  Metadata:

@@ -133,24 +240,163 @@ Object path  freely definable
Methods          void SetProperty(string property, variant value)

                  Changes the value of the specified property. Only
                  properties that are listed as read-write can be changed.

                 On success this will emit a PropertyChanged signal.

-           void Release()
+                 void Release()

                  This method gets called when the service daemon
                 unregisters the player which can then perform
                 cleanup tasks. There is no need to unregister the
                 player, because when this method gets called it has
                 already been unregistered.
-
+
+                 DBusMessage ChangePath(uint8 direction, uint8 uid)
+
+                 This method is called when a remote device in role Controller sends ChangePath.
+
+                       direction:
+                             0x00 - FolderUp
+                             0x01 - FolderDown
+                       uid: The UID of the folder to navigate to. This may be retrieved via
+                             a GetFolderItems command.
+                             If the navigation command is Folder Up this field is reserved (8
+octets)
+
+                       Format of reply:
+                             uint8 status:           See section "Appendix" for more information
+                             uint32 numberOfItems:   If the ChangePath succeeded, the number of items
+                             in the folder which has been changed to, ie the new current folder
+(4octets)
+
+                 DBusMessage GetFolderItems(uint8 scope, uint32 startItem, uint32 endItem,
+                                   uint8 attributeCount, array{uint32} attributeList)
+
+                 This method is called when a remote device in role Controller request about GetFolderItems.
+
+                       Scope:      Refer Appendix for Scope field (1 octet)
+                       startItem:  The offset within the listing of the item which should be the first
+                                   returned item.
+                                   The first media element in the listing is at offset 0 (4 octets)
+                       endItem:    The offset within the listing of the item which should be the final
+                                   returned item.
+                                   If this is set to a value beyond what is available the TG shall
+                                   return items from the provided Start Item index to the index of the
+                                   final item.
+                                   If the End Item index is smaller than the Start Item index the TG
+                                   shall return an error.
+                                   If CT requests too many items, TG can respond with a sub-set of the
+                                   requested items.
+                       attributeCount:   1 octet
+                             0x00 - All attributes are requested. There is no following Attribute List.
+                             0x01-0xFE - The following Attribute List contains this number of attributes.
+                             0xFF - No attributes are requested. There is no following Attribute List.
+                       attributeList:    See section "Media Attribute IDs" of "Appendix" for more information
+
+                 Format of reply:
+                       uint8 status:                 See section "Appendix" for more information
+                       uidCounter:             For Database Unaware Players uidCounter is 0
+                                                           For Database Aware players the UID is unique across the entire media browsing tree.
+                                                           Any change to the Media Database shall result in an increase of the uidCounter and
+                                                           a UIDsChangedNotification.
+                       uint16 numberOfItems    the number of items returned in this listing
+                       itemList                      sequence of items
+
+                 Format of itemList entry:
+
+                       FolderItem:
+                             uint8 ItemType = FolderItem - must be 0x02
+                             uint16 ItemLength Length of folder item in octets, not including Item
+                                               Type and Item Length fields.
+                             array{uint8} uid  UID as defined in 6.10.3 of AVRCP1.4 Specification
+                             uint8 folderType
+                                         0x00 - Mixed
+                                         0x01 - Titles
+                                         0x02 - Albums
+                                         0x03 - Artists
+                                         0x04 - Playlists
+                                         0x05 - Generes
+                                         0x06 - years
+                             uint8 isPlayable
+                                         0x00 - The folder cannot be played. This means that the folder
+                                               UID shall not be passed to either the PlayItem or
+                                               AddToNowPlaying commands.
+                                         0x01 - The folder can be played. The folder UID may be passed
+                                               to the PlayItem and AddtoNowPlaying (if supported) commands.
+                                         The media player behavior on playing a folder should be same as on
+                                         the local user interface.
+                             uint16 characterSetId   Specifies the character set ID to be displayed on CT as
+                                               defined in IANA character set document
+                             uint16 itemNameLength   Length of Displayable Name in octets. The name shall
+                                         be limited such that a response to a GetFolderItems containing
+                                         one folder item fits within the maximum size of PDU which can
+                                         be received by the CT.
+                             array{uint8} itemName   Displayable name of folder
+
+                       MediaElementItem:
+                             uint8 ItemType = MediaElementItem - must be 0x03
+                             uint16 ItemLength Length of folder item in octets, not including Item
+                                               Type and Item Length fields.
+                             array{uint8} uid  UID as defined in 6.10.3 of AVRCP1.4 Specification
+                             uint8 mediaType
+                                         0x00 - Audio
+                                         0x02 - Video
+                             uint16 characterSetId   Specifies the character set ID to be displayed on
+                                               CT as defined in IANA character set document
+                             uint16 itemNameLength   Length of Displayable Name in octets. The name shall
+                                               be limited such that a response to a GetFolderItems
+                                               containing one media player item fits within the maximum
+                                               size of PDU which can be received by the CT.
+                             array{uint8} itemName   Displayable name of Media Element Item.
+                             uint8 numberOfAttributes      The number of attributes included with this media
+                                               element item
+                             AttributeValueEntry     The attributes in the list will be controlled by the
+                                               request that has caused this Media Element Item to be returned.
+
+                             Format of AttributeValueEntry:
+                             uint32 attributeId      See section "Appendix" for more information.
+                             uint16 charaterSetId    Specifies the character set ID to be displayed on CT as
+                                               defined in IANA character set document
+                             uint16 attributeValueLeangth  Length of the value of this attribute
+                             array{uint8} attributeValue   The value of this attribute, in the specified
+                                                     character set
+
+                 DBusMessage AbsoluteVolume(uint8 volume)
+
+                 This method is called when a remote device in role Controller send SetAbsoluteVolume.
+
+                 Format of reply:
+                       uint8 volume:
+                             0x00 - No Sound
+                             0x7F - Full Volume
+
+                 Note: 7 bits used for volume (range 0x00..0x7F), last bit is reserved. Volume in response
+                 shall be same as send in parameter.
+
+                 DBusMessage GetBrowsedPlayerInfo()
+
+                 This method is called when a remote device in role Controller sends SetBrowsedPlayer command.
+
+                 Format of reply:
+                       uint16 uidCounter:            refer GetFolderItems for this field.
+                       uint32 numberOfItems:   number of items in directory specified in "path"
+                       string path:                  path format "/root/folder1/folder2" or "/root/folder1/folder2/folder3"
+                                                           This is current path in MediaPlayer on scope VFS.
+
+                 DBusMessage PlayItem(uint8 scope, array{uint8} uid)
+
+                 This method is called when a remote device in role Controller sends PlayItem.
+                       scope:            See section "Appendix" for more information.
+                       uid:        Size of this array shall be 8 (octets)
+
+                 Format of reply:
+                       uint8 status: See section "Appendix" for more information
+
Signals          PropertyChanged(string setting, variant value)

                  This signal indicates a changed value of the given
                 property.

-           TrackChanged(dict metadata)
+                 TrackChanged(dict metadata)

                  This signal indicates that current track has changed.
                 All available metadata for the new track shall be set
@@ -187,6 +433,16 @@ Signals        PropertyChanged(string setting, variant value)
                       uint32 Duration:

                              Track duration in milliseconds
+
+
+                 AddressedPlayerChanged(uint16 player_id, uint16 uid_counter)
+
+                 This signal indicates that the Addressed Player has changed.
+
+                 NowPlayingContentChanged()
+
+                 This signal indicates that the NowPlaying list has changed.
+

 Properties string Equalizer [readwrite]

@@ -221,6 +477,16 @@ Properties     string Equalizer [readwrite]
                 that even if duration is not available in metadata it's
                 possible to signal its end by setting position to the
                 maximum uint32 value.
+
+           uint16 UidCounter [readonly]
+
+                 Changes of this field signalize changes in media player
+                 filesystem
+
+           byte Volume [readwrite]
+
+                 Current Volume in range: 0 - 255
+                 This changes volume on remote device, not media player.

 MediaEndpoint hierarchy
=======================
@@ -341,3 +607,48 @@ Properties     object Device [readonly]
                 Optional. Indicates where is the transport being routed

                  Possible Values: "HCI" or "PCM"
+
+Appendix:
+
+     Status: Status of operation
+           0x00 - Invalid Command
+           0x01 - Invalid Parameter
+           0x02 - Parameter not found
+           0x03 - Internal Error
+           0x04 - Ok
+           0x05 - Uid Changed
+           0x06 - Reserved
+           0x07 - Invalid Direction
+           0x08 - Not a Directory
+           0x09 - Not Exist
+           0x0A - Invalid Scope
+           0x0B - Range Out of Bounds
+           0x0C - Uid is a directory
+           0x0D - Media in use
+           0x0E - Now Playing List is Full
+           0x0F - Search not supported
+           0x10 - Search in progress
+           0x11 - Invalid player Id
+           0x12 - Player not brwoseable
+           0x13 - Player not addressed
+           0x14 - Not valid search results
+           0x15 - No available
+           0x16 - Addressed player changed
+
+
+     Scope: The scope in which the UID of the media element item or folder
+           item is valid (1 octet)
+           0x00 - Media Player List (Contains all available media players)
+           0x01 - Media Player Virtual Filesystem (The virtual filesystem
+                 containing the media content of the browsed player)
+           0x02 - Search, Media Element Item (The results of a search
+                 operation on the browsed player)
+           0x03 - Now Playing, Media Element Item (The Now Playing list
+                 or queue of the addressed player)
+
+
+     Player Application setting attribute IDs:
+           0x01 - Equalizer
+           0x02 - Repeat Mode
+           0x03 - Shuffle
+           0x04 - Scan


Vani

