Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: fabien.proriolpatch@kazoe.org
To: linux-bluetooth@vger.kernel.org
Cc: Fabien Proriol <fabien.proriol@jdsu.com>
Subject: [PATCH BlueZ] Fix obex protocol for powerpc
Date: Tue, 26 Jul 2016 15:22:48 +0200
Message-Id: <1469539369-17245-1-git-send-email-fabien.proriolpatch@kazoe.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Fabien Proriol <fabien.proriol@jdsu.com>

omtu and imtu is define as uint16_t in l2cap_get function (use with va_arg).
But in connect_event, in file bluetooth.c, variables are define as int (32bit in powerpc).
When we use a platform with big endian, the result is omtu and imtu pass to obex_server_new_connection is bigger than needed.
And file transfert will be lock until timeout (for file with size > 630 bytes)

Fabien Proriol (1):
  Fix obex protocol for powerpc

 obexd/plugins/bluetooth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.3
