Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 0/5] Client descriptor operations
Date: Tue,  1 Apr 2014 17:19:22 +0200
Message-Id: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2 changes:
	* Rebased on top of latest changes and cleanups.
	* Function flow was redesigned to minimize label jumps.

Jakub Tyszkowski (5):
  android/gatt: Add queue for characteristic descriptors caching
  android/gatt: Handle get descriptor client command
  android/gatt: Add descriptors sending and caching for client
  android/gatt: Add client read descriptor handler
  android/gatt: Add client write descriptor handler

 android/gatt.c | 529 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 525 insertions(+), 4 deletions(-)

--
1.9.0

