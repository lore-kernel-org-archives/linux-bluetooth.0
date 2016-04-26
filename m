Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] FIx select-attribute behaviour
Date: Tue, 26 Apr 2016 10:30:27 +0200
Message-Id: <1461659429-19139-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the weird terminal behaviour when performing the
`select-attribute` command in bluetoothctl.

Francois Beaufort (1):
  [client] Fix select-attribute behaviour

 client/main.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.7.0

