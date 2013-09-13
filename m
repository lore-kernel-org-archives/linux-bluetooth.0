Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] obexd: Fix setting message folder
Date: Fri, 13 Sep 2013 11:23:28 +0200
Message-Id: <1379064212-30056-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This fixes an issue that the folder property for messages was set incorrectly
when ListMessages got called with a subfolder parameter.

Calling ListMessages within /telecom/msg for the subfolder inbox would set the
folder property to /telecom/msg instead of /telecom/msg/inbox.

The patchset therefore changes map_msg_create to not set the folder property
to the current folder, but to a folder given as parameter. This change will be
needed as well for new message notifications (that can indicate new messages
for any folder).

In addition I've updated the documentation to clarify that the folder property
for ListMessages and PushMessage can be used only for a subfolder of the
current folder. It's not possible to specify an absolute or relative path.

Christian Fetzer (4):
  obexd: Add folder property to map_msg_create
  obexd: Fix setting message folder for relative folder in ListMessages
  obexd: Clarify the folder property of ListMessages
  obexd: Clarify the folder property of PushMessage

 doc/obex-api.txt   |  8 +++++---
 obexd/client/map.c | 23 ++++++++++++++++++++---
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
1.8.3.4

