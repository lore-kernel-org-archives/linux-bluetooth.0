Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 0/8] android/gatt: Server command handlers
Date: Fri, 11 Apr 2014 15:15:11 +0200
Message-Id: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds stubs for handling GATT Server's attribute database operations.
If attribute database API is accepted in proposed state, we will just need to
trigger db transactions and send proper notifications.

Jakub Tyszkowski (8):
  android/gatt: Add find_server_by_id helper
  android/gatt: Add Server's add_service stub
  android/gatt: Add Server's add_included_service stub
  android/gatt: Add Server's add_characteristic stub
  android/gatt: Add Server's add_descriptor stub
  android/gatt: Add Server's start_service stub
  android/gatt: Add Server's stop_service stub
  android/gatt: Add Server's delete_service stub

 android/gatt.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 164 insertions(+), 10 deletions(-)

--
1.9.1

