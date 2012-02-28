Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] hciops: Remove set_limited_discoverable callback
Date: Tue, 28 Feb 2012 13:23:25 +0200
Message-Id: <1330428206-8185-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
References: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/hciops.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 61fb718..c166027 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3877,7 +3877,6 @@ static struct btd_adapter_ops hci_ops = {
 	.cleanup = hciops_cleanup,
 	.set_powered = hciops_set_powered,
 	.set_discoverable = hciops_set_discoverable,
-	.set_limited_discoverable = hciops_set_limited_discoverable,
 	.set_pairable = hciops_set_pairable,
 	.start_discovery = hciops_start_discovery,
 	.stop_discovery = hciops_stop_discovery,
-- 
1.7.7.6

