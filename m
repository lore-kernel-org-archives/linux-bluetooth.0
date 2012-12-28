Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/11] Add experimental command line switch option
Date: Fri, 28 Dec 2012 14:50:58 +0200
Message-Id: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These set of patches introduces g_dbus_set_flags along with experimental flags,
g_dbus_set_flags is not per connection as originally suggested to avoid using
dbus_connection_allocate_data_slot which requires calling
dbus_connection_free_data_slot once done but currently we don't keep any data
associated with connections, besides the flags comes from command line options
which would end up setting the same flags for every connection anyway.

In addition to experimental it also add support to enable deprecated via compat
swith option, this makes any API marked as deprecated to be disabled if compat
is not set. This is on purpose to expose applications using deprecated APIs.

Luiz Augusto von Dentz (11):
  gdbus: Introduce G_DBUS_METHOD_FLAG_EXPERIMENTAL
  gdbus: Introduce G_DBUS_SIGNAL_FLAG_EXPERIMENTAL
  gdbus: Introduce G_DBUS_PROPERTY_FLAG_EXPERIMENTAL
  gdbus: Check if the interface being registered is valid
  gdbus: Call check_signals when sending signals with
    g_dbus_send_message
  gdbus: Introduce G_DBUS_FLAG_ENABLE_DEPRECATED
  core: Add command line switch for enabling experimental interfaces
  core: Reuse --compat/-C switch for enabling deprecated interfaces
  media: Enable RegisterPlayer and UnregisterPlayer methods as
    experimental
  player: Enable MediaPlayer1 interface as experimental
  AVRCP: Fix not checking for media_player_controller_create

 gdbus/gdbus.h           |  39 ++++++++++--
 gdbus/object.c          | 153 ++++++++++++++++++++++++++++++++++++++++++++----
 profiles/audio/avrcp.c  |   7 ++-
 profiles/audio/media.c  |  10 +---
 profiles/audio/player.c |  28 +++++----
 src/main.c              |  13 +++-
 6 files changed, 211 insertions(+), 39 deletions(-)

-- 
1.8.0.1

