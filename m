Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/8] Fix message order
Date: Mon, 19 Aug 2013 17:32:50 +0300
Message-Id: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set fixes a couple of issues introduced with the use of ObjectManager due
the processing of signals on idle to group changes, this has been causing
issues with external components such as ofono and pulseaudio that sometimes
receives connections from devices objects that have pending signals thus
cannot be properly processed or have to be assumed paired and with certain
UUIDs which is not ideal.

Luiz Augusto von Dentz (8):
  gdbus: Fix not maintaining message order for signals
  gdbus: Add g_dbus_send_message_with_reply
  gdbus: Avoid calling dbus_connection_send*
  gdbus: Fix emitting PropertiesChanged twice
  core: Make use of g_dbus_send_message_with_reply
  neard: Make use of g_dbus_send_message_with_reply
  audio/media: Make use of g_dbus_send_message_with_reply
  obexd: Make use of g_dbus_send_message*

 gdbus/client.c                |  14 ++---
 gdbus/gdbus.h                 |   3 +
 gdbus/object.c                | 143 ++++++++++++++++++++++++------------------
 obexd/plugins/bluetooth.c     |   2 +-
 obexd/plugins/pcsuite.c       |   5 +-
 obexd/plugins/syncevolution.c |   6 +-
 obexd/src/manager.c           |   3 +-
 plugins/neard.c               |   2 +-
 profiles/audio/media.c        |   2 +-
 src/agent.c                   |  12 ++--
 src/profile.c                 |   4 +-
 11 files changed, 109 insertions(+), 87 deletions(-)

-- 
1.8.3.1

