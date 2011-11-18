Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Nov 2011 22:30:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michael Schmitt <tcwardrobe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
Message-ID: <20111118203019.GA24250@x220.ger.corp.intel.com>
References: <4EC679A0.7050309@gmail.com>
 <20111118153652.GA3647@fusion.localdomain>
 <4EC67E88.6060202@gmail.com>
 <20111118162111.GA4680@fusion.localdomain>
 <4EC68909.40108@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
In-Reply-To: <4EC68909.40108@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

HI Michael,

On Fri, Nov 18, 2011, Michael Schmitt wrote:
> Thanks for the input. But do you know why the device works with
> older kernel / userland?>

Probably because the list of supported commands wasn't previously
requested as part of the adapter init sequence, or because the kernel
code didn't actually wait for all commands to complete before notifying
success to user space (I know the latter is at least true since I
submitted a patch for it).

> So, and what do we do from here on?

Well, the attached patch will at least make sure that the failure of
this command is correctly detected so you get an immediate error instead
of a timeout. The next step is to decide whether to do a quirk for your
specific adapter or to make it a general rule that errors for this
particular HCI command are ignored (for that we'd need feedback from the
real kernel experts like Marcel and Gustavo).

Johan

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Bluetooth-Fix-request-completion-for-command-status-.patch"

>From e8cc224c3d8b6ea5b956efb33cdc3569fc782d4c Mon Sep 17 00:00:00 2001
From: Johan Hedberg <johan.hedberg@intel.com>
Date: Fri, 18 Nov 2011 22:21:48 +0200
Subject: [PATCH] Bluetooth: Fix request completion for command status events

If a HCI command triggered by hci_request() fails at the command status
phase we need to properly inform the request tracking code of the
completion of the request.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dfe6fbc..236f895 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2055,6 +2055,9 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	opcode = __le16_to_cpu(ev->opcode);
 
+	if (ev->status != 0)
+		hci_req_complete(hdev, opcode, ev->status);
+
 	switch (opcode) {
 	case HCI_OP_INQUIRY:
 		hci_cs_inquiry(hdev, ev->status);
-- 
1.7.7.2


--rwEMma7ioTxnRzrJ--
