Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 00/16] MediaFolder and MediaItem implementation
Date: Fri, 14 Jun 2013 15:41:34 +0300
Message-Id: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

v2: Fixes ChangeFolder not working for subfolders past /Filesystem
v3: Add Search implementation, fix not forwarding errors properly and add
patch to create current item if it doesn't exist.

This set of patches implements most of the functionality of MediaFolder and
MediaItem interfaces.

Some remarks:

- ChangeFolder can only change one level at time, this perhaps gonna be
  changed in the future but for now this matches the limitation of AVRCP
  itself.
- ListItems returns the items in the correct order but GetManagedObjects
  does the reverse order due to use of g_slist_prepend.
- PlayItem and AddToNowPlaying works fine with iPhone but with WP8 is not
  working probably because the UIDCounter changes more frequently
  which needs some new notifications that are currently not implemented.

This can be tested using tools/mpris-player which will browse the NowPlaying
list and show which item is currently being played, but the gnome extention
itself needs patching which can be found here:

https://github.com/Vudentz/gnome-shell-extensions-mediaplayer

Or use the command line tool: tools/bluetooth-player

Luiz Augusto von Dentz (16):
  audio/player: Split item creation
  audio/AVRCP: Add browsed flag to player
  audio/AVRCP: Add support for GetFolderItems command
  audio/player: Add implementation of MediaFolder.ListItems
  audio/player: Add support for setting current Item object
  audio/player: Add function media_item_set_playable
  audio/player: Add support for MediaItem.Metadata property
  audio/AVRCP: Add support for ChangePath command
  audio/player: Add implementation of MediaFolder.ChangeFolder
  audio/AVRCP: Add support for PlayItem command
  audio/player: Add implementation of MediaItem.Play
  audio/AVRCP: Add support for AddToNowPlaying command
  audio/player: Add implementation of MediaItem.AddToNowPlaying
  audio/AVRCP: Add support for Search command
  audio/player: Add implementation of MediaFolder.Search
  audio/player: Create item on media_player_set_playlist_item

 profiles/audio/avrcp.c  | 488 ++++++++++++++++++++++++++++-
 profiles/audio/player.c | 804 ++++++++++++++++++++++++++++++++++++++++--------
 profiles/audio/player.h |  35 ++-
 3 files changed, 1187 insertions(+), 140 deletions(-)

-- 
1.8.1.4

