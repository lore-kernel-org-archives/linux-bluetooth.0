Return-Path: <foo00@h08.hostsharing.net>
Message-Id: <f181189de5fd4c75da4708425df99e70abc6a127.1510875912.git.lukas@wunner.de>
In-Reply-To: <CALAqxLX-qp=rc8P7ynGrUwWHgP2EBAwoEES-aOOuehtnJSDR+A@mail.gmail.com>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 17 Nov 2017 00:54:53 +0100
Subject: [PATCH] Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <CALAqxLVTff-XX7bbQ8a1Pihqe=QW1HDMKST3F3okCV8jY+wGqw@mail.gmail.com>
	<CALAqxLW9gzcBrwy3TWB5x_OpKtcLTe7P8PX4KeUgvibbAaMX_A@mail.gmail.com>
	<20171116213045.GA17506@wunner.de> <20171116214504.GB17506@wunner.de>
	<CALAqxLX-qp=rc8P7ynGrUwWHgP2EBAwoEES-aOOuehtnJSDR+A@mail.gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo@h08.hostsharing.net, "Padovan <gustavo"@padovan.org,
	Johan@h08.hostsharing.net, "Hedberg <johan.hedberg"@gmail.com,
	Rob Herring <rob.herring@linaro.org>, Johan Hovold <johan@kernel.org>
Cc: Ronald Tschalaer <ronald@innovation.ch>, Sumit Semwal <sumit.semwal@linaro.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

John Stultz reports a boot time crash with the HiKey board (which uses
hci_serdev) occurring in hci_uart_tx_wakeup().  That function is
contained in hci_ldisc.c, but also called from the newer hci_serdev.c.
It acquires the proto_lock in struct hci_uart and it turns out that we
forgot to init the lock in the serdev code path, thus causing the crash.

John bisected the crash to commit 67d2f8781b9f ("Bluetooth: hci_ldisc:
Allow sleeping while proto locks are held"), but the issue was present
before and the commit merely exposed it.  (Perhaps by luck, the crash
did not occur with rwlocks.)

Init the proto_lock in the serdev code path to avoid the oops.

Stack trace for posterity:

Unable to handle kernel read from unreadable memory at 406f127000
[000000406f127000] user address but active_mm is swapper
Internal error: Oops: 96000005 [#1] PREEMPT SMP
Hardware name: HiKey Development Board (DT)
Call trace:
 hci_uart_tx_wakeup+0x38/0x148
 hci_uart_send_frame+0x28/0x38
 hci_send_frame+0x64/0xc0
 hci_cmd_work+0x98/0x110
 process_one_work+0x134/0x330
 worker_thread+0x130/0x468
 kthread+0xf8/0x128
 ret_from_fork+0x10/0x18

Link: https://lkml.org/lkml/2017/11/15/908
Reported-and-tested-by: John Stultz <john.stultz@linaro.org>
Cc: Ronald Tschalär <ronald@innovation.ch>
Cc: Rob Herring <rob.herring@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
@Rob (and everyone else):  I'm not sure if this is in fact the correct
approach, or if we should instead duplicate hci_uart_tx_wakeup() in
hci_serdev.c (sans locking?), much as we've duplicated a lot of other
functions there.  Let me know what your preference is.  Thanks!

 drivers/bluetooth/hci_serdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 71664b2..e0e6461 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -303,6 +303,7 @@ int hci_uart_register_device(struct hci_uart *hu,
 	hci_set_drvdata(hdev, hu);
 
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
+	percpu_init_rwsem(&hu->proto_lock);
 
 	/* Only when vendor specific setup callback is provided, consider
 	 * the manufacturer information valid. This avoids filling in the
-- 
2.11.0
