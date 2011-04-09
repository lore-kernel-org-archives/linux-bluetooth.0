Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Apr 2011 21:08:57 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Keith Packard <keithp@keithp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: 2.6.39-rc2 regression: X201s fails to resume
 b77dcf8460ae57d4eb9fd3633eb4f97b8fb20716
Message-ID: <20110409000857.GB25581@piper>
References: <yun1v1fj024.fsf@aiko.keithp.com>
 <alpine.LFD.2.00.1104070022280.3971@localhost6.localdomain6>
 <alpine.LFD.2.00.1104082340020.2724@localhost6.localdomain6>
 <yunaag0tjzb.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <yunaag0tjzb.fsf@aiko.keithp.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Keith,

On 16:13 Fri 08 Apr, Keith Packard wrote:
> On Fri, 8 Apr 2011 23:44:51 +0200 (CEST), Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Can the bluetooth folks please have a look at that ASAP? The obvious
> > fast fix for Linus tree is to revert the second hunk for now, but this
> > needs to be fixed proper.
> 
> Who will submit this patch? I'd rather have your name on it so that
> people come complain at you...

I took a shot at it and just sent a patch (also attached for convenience) 
that should solve the problem.

> 
> -- 
> keith.packard@intel.com


Cheers,
-- 
Vinicius

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Bluetooth-Fix-keeping-the-command-timer-running.patch"

>From 1a617e2dde807ae932531ddd9b451011f236546c Mon Sep 17 00:00:00 2001
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Date: Fri, 8 Apr 2011 20:33:17 -0300
Subject: [PATCH] Bluetooth: Fix keeping the command timer running

In the teardown path the reset command is sent to the controller,
this event causes the command timer to be reactivated.

Now we remove the timer after the reset command is sent.

Reported-by: Keith Packard <keithp@keithp.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a80bc1c..7467eaa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -586,9 +586,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_req_cancel(hdev, ENODEV);
 	hci_req_lock(hdev);
 
-	/* Stop timer, it might be running */
-	del_timer_sync(&hdev->cmd_timer);
-
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
 		hci_req_unlock(hdev);
 		return 0;
@@ -618,6 +615,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
+	/* Stop timer, it might be running */
+	del_timer_sync(&hdev->cmd_timer);
+
 	/* Kill cmd task */
 	tasklet_kill(&hdev->cmd_task);
 
-- 
1.7.4.3


--gBBFr7Ir9EOA20Yy--
