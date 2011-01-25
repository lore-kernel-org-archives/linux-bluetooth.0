Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1295973136-30908-1-git-send-email-pavan_savoy@sify.com>
References: <1295973136-30908-1-git-send-email-pavan_savoy@sify.com>
Date: Tue, 25 Jan 2011 22:03:39 +0530
Message-ID: <AANLkTinGAorqPagx_hLakiSoadbOQKv5OE4KBSa1fr5q@mail.gmail.com>
Subject: [PATCH] plugins: hciops: remove scan disable on poweroff
From: Pavan Savoy <pavan_savoy@sify.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Pavan Savoy <pavan_savoy@sify.com>

remove sending of the scan disable command when the
device is being powered off.

Signed-off-by: Pavan Savoy <pavan_savoy@sify.com>
---
 plugins/hciops.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 719ef01..59a15a0 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -335,14 +335,9 @@ static int hciops_set_pairable(int index,
gboolean pairable)
 static int hciops_power_off(int index)
 {
       struct dev_info *dev = &devs[index];
-       uint8_t mode = SCAN_DISABLED;

       DBG("hci%d", index);

-       if (hci_send_cmd(dev->sk, OGF_HOST_CTL,
-                                       OCF_WRITE_SCAN_ENABLE, 1, &mode) < 0)
-               return -errno;
-
       if (ioctl(dev->sk, HCIDEVDOWN, index) < 0 && errno != EALREADY)
               return -errno;

--
1.7.0.4
