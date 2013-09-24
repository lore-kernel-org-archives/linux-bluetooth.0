Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] MAP notification API
Date: Tue, 24 Sep 2013 16:16:00 +0200
Message-Id: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This patchset adds the event handlers for new message, message shift/deleted
and message status update events.

New messages are signaled by registering a corresponding message event, that
is announced using the ObjectManager.

For moved / deleted messages:
  - If we have the Message interface, we simply update property 'Folder'.
  - If the message was moved into the current folder, we register its
    Message interface.

The status update events change the property 'Status'.

Note that this patchset depends on the changed map_msg_create function from
'obexd: Fix setting message folder' sent on 23.09.2013.

Christian Fetzer (7):
  obexd: Handle new message event
  obexd: Add function set_reception_status to MAP client
  obexd: Handle message status events
  obexd: Update Status property in map documentation
  obexd: Add function set_folder to MAP client
  obexd: Handle message shift and message deleted events
  obexd: Prefix folders in event reports with leading slash

 doc/obex-api.txt   | 10 ++++--
 obexd/client/map.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 obexd/client/mns.c | 16 +++++++--
 3 files changed, 120 insertions(+), 5 deletions(-)

-- 
1.8.3.4

