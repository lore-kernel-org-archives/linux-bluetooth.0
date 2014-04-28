Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 0/7] android/gatt: Further connection handling refactor
Date: Mon, 28 Apr 2014 15:31:59 +0200
Message-Id: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set unifies how client and server connections are handled.

Last patch adds the actual server connection handling, which mostly use common
code.

Jakub Tyszkowski (7):
  android/gatt: Use common struct for client and server applications
  android/gatt: Store client and server apps on a single list
  android/gatt: Rename connection list
  android/gatt: Rename connection struct
  android/gatt: Fix some whitespace issues
  ndroid/gatt: Extract common code from client_connect
  android/gatt: Handle Server apps connections

 android/gatt.c | 488 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 248 insertions(+), 240 deletions(-)

--
1.9.1

