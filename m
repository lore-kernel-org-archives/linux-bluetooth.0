Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/9 v2] AVRCP Fixes
Date: Thu, 28 Feb 2013 14:21:59 +0200
Message-Id: <1362054128-20569-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set fixes some bugs with iOS and WP8 stacks, excessive changes on the
metadata causing duplicate signals and some missing signals when properties
changes.

v2: Rework MediaItem Type to be clear about folder items

Luiz Augusto von Dentz (9):
  player: Fix property Device type
  media: Rework MediaItem Type property
  player: Add Playlist property
  player: Fix not emitting PropertiesChanged for Browsable and
    Searchable
  AVRCP: Fix changing track metadata too many times
  player: Only emit PropertiesChanged for Position if track exists
  player: Only expose Track property if there is metadata
  AVRCP: Add support to UIDs changed event for CT role
  AVRCP: Fix storing wrong UID counter

 doc/media-api.txt       |  51 +++++++++++-----
 profiles/audio/avrcp.c  |  27 +++++++--
 profiles/audio/avrcp.h  |   1 +
 profiles/audio/player.c | 152 +++++++++++++++++++++++++++++++++++++++++-------
 profiles/audio/player.h |   4 +-
 5 files changed, 191 insertions(+), 44 deletions(-)

-- 
1.8.1.2

