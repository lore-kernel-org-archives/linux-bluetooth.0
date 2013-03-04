Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/10 v4] AVRCP Fixes
Date: Mon,  4 Mar 2013 10:06:00 +0200
Message-Id: <1362384369-20709-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set fixes some bugs with iOS and WP8 stacks, excessive changes on the
metadata causing duplicate signals and some missing signals when properties
changes.

v2: Rework MediaItem Type to be clear about folder items
v3: Add defines for item types an folder types
v4: Change defines to enums

Luiz Augusto von Dentz (10):
  player: Fix property Device type
  media: Rework MediaItem Type property
  player: Add enums for item types and folder types
  player: Add Playlist property
  player: Fix not emitting PropertiesChanged for Browsable and
    Searchable
  AVRCP: Fix changing track metadata too many times
  player: Only emit PropertiesChanged for Position if track exists
  player: Only expose Track property if there is metadata
  AVRCP: Add support to UIDs changed event for CT role
  AVRCP: Fix storing wrong UID counter

 doc/media-api.txt       |  51 +++++++++----
 profiles/audio/avrcp.c  |  29 +++++--
 profiles/audio/avrcp.h  |   1 +
 profiles/audio/player.c | 195 ++++++++++++++++++++++++++++++++++++++++++------
 profiles/audio/player.h |  22 +++++-
 5 files changed, 255 insertions(+), 43 deletions(-)

-- 
1.8.1.2

