Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/13] MediaFolder and MediaItem implementation
Date: Mon, 27 May 2013 14:33:50 +0300
Message-Id: <1369654443-11514-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set of patches implements most of the functionality of MediaFolder and
MediaItem interfaces.

Some remarks:

- ChangeFolder can only change one level at time, this perhaps gonna be
  changed in the future but for now this matches the limitation of AVRCP
  itself.
- ListItems returns the items in the correct order but GetManagedObjects does
  the reverse order due to use of g_slist_prepend.
- PlayItem and AddToNowPlaying works fine with iPhone but with WP8 is not
  working probably because the UIDCounter changes more frequently which needs
  some new notifications that are currently not implemented.

This can be tested using tools/mpris-player which will browse the NowPlaying
list and show which item is currently being played, but the gnome extention
itself needs patching which can be found here:

https://github.com/Vudentz/gnome-shell-extensions-mediaplayer

Luiz Augusto von Dentz (13):
  player: Split item creation
  AVRCP: Add browsed flag to player
  AVRCP: Add support for GetFolderItems command
  player: Add implementation of MediaFolder.ListItems
  player: Add support for setting current Item object
  player: Add function media_item_set_playable
  player: Add support for MediaItem.Metadata property
  AVRCP: Add support for ChangePath command
  player: Add implementation of MediaFolder.ChangeFolder
  AVRCP: Add support for PlayItem command
  player: Add implementation of MediaItem.Play
  AVRCP: Add support for AddToNowPlaying command
  player: Add implementation of MediaItem.AddToNowPlaying

 profiles/audio/avrcp.c  | 390 ++++++++++++++++++++++++++++-
 profiles/audio/player.c | 650 ++++++++++++++++++++++++++++++++++++++++--------
 profiles/audio/player.h |  23 +-
 3 files changed, 943 insertions(+), 120 deletions(-)

-- 
1.8.1.4

