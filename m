Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] Bluetooth: Fix not registering BR/EDR SMP channel with force_bredr flag
Date: Fri,  9 Sep 2016 20:24:40 +0200
Message-Id: <1473445480-5177-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If force_bredr is set SMP BR/EDR channel should also be for non-SC
capable controllers. Since hcidev flag is persistent wrt power toggle
it can be already set when calling smp_register(). This resulted in
SMP BR/EDR channel not being registered even if HCI_FORCE_BREDR_SMP
flag was set.

This also fix NULL pointer dereference when trying to disable
force_bredr after power cycle.

BUG: unable to handle kernel NULL pointer dereference at 0000000000000388
IP: [<ffffffffc0493ad8>] smp_del_chan+0x18/0x80 [bluetooth]

Call Trace:
[<ffffffffc04950ca>] force_bredr_smp_write+0xba/0x100 [bluetooth]
[<ffffffff8133be14>] full_proxy_write+0x54/0x90
[<ffffffff81245967>] __vfs_write+0x37/0x160
[<ffffffff813617f7>] ? selinux_file_permission+0xd7/0x110
[<ffffffff81356fbd>] ? security_file_permission+0x3d/0xc0
[<ffffffff810eb5b2>] ? percpu_down_read+0x12/0x50
[<ffffffff812462a5>] vfs_write+0xb5/0x1a0
[<ffffffff812476f5>] SyS_write+0x55/0xc0
[<ffffffff817eb872>] entry_SYSCALL_64_fastpath+0x1a/0xa4
Code: 48 8b 45 f0 eb c1 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
      44 00 00 f6 05 c6 3b 02 00 04 55 48 89 e5 41 54 53 49 89 fc 75
      4b
      <49> 8b 9c 24 88 03 00 00 48 85 db 74 31 49 c7 84 24 88 03 00 00
RIP  [<ffffffffc0493ad8>] smp_del_chan+0x18/0x80 [bluetooth]
RSP <ffff8802aee3bd90>
CR2: 0000000000000388

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/smp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4c1a16a..43faf2a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3387,7 +3387,10 @@ int smp_register(struct hci_dev *hdev)
 	if (!lmp_sc_capable(hdev)) {
 		debugfs_create_file("force_bredr_smp", 0644, hdev->debugfs,
 				    hdev, &force_bredr_smp_fops);
-		return 0;
+
+		/* Flag can be already set here (due to power toggle) */
+		if (!hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
+			return 0;
 	}
 
 	if (WARN_ON(hdev->smp_bredr_data)) {
-- 
2.7.4

