Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/9] AVRCP Fixes
Date: Wed, 27 Feb 2013 15:15:52 +0200
Message-Id: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set fixes some bugs with iOS and WP8 stacks, excessive changes on the
metadata causing duplicate signals and some missing signals when properties
changes.

Luiz Augusto von Dentz (9):
  player: Fix property Device type
  player: Add media_player_create_item
  player: Add Playlist property
  player: Fix not emitting PropertiesChanged for Browsable and
    Searchable
  AVRCP: Fix changing track metadata too many times
  player: Only emit PropertiesChanged for Position if track exists
  player: Only expose Track property if there is metadata
  AVRCP: Add support to UIDs changed event for CT role
  AVRCP: Fix storing wrong UID counter

 doc/media-api.txt       |   4 ++
 profiles/audio/avrcp.c  |  23 +++++++++--
 profiles/audio/avrcp.h  |   1 +
 profiles/audio/player.c | 104 +++++++++++++++++++++++++++++++++++++++++++-----
 profiles/audio/player.h |   1 +
 5 files changed, 118 insertions(+), 15 deletions(-)

-- 
1.8.1.2

