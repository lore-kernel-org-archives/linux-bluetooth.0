Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 10:46:43 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCH] Bluetooth: Assure BREDR HCI device first in the list
Message-ID: <20111116084642.GE30662@aemeltch-MOBL1>
References: <1321361939-24024-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1111150822270.7320@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1111150822270.7320@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Tue, Nov 15, 2011 at 08:45:47AM -0800, Mat Martineau wrote:
> >Using different list_add to make sure that BR/EDR HCI device is the
> >first device in the hci_dev_list. This is needed for e.g. A2MP Discover
> >Command which requires that "entry for Controller ID 0x00 (Primary
> >BR/EDR controller) shall always be sent and shall be the first entry
> >in the Controller List.
> >Also output from hciconfig looks nicer :-)
> >
> >Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >---
> >net/bluetooth/hci_core.c |    6 +++++-
> >1 files changed, 5 insertions(+), 1 deletions(-)
> >
> >diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >index 02a6f15..bf24218 100644
> >--- a/net/bluetooth/hci_core.c
> >+++ b/net/bluetooth/hci_core.c
> >@@ -1501,7 +1501,11 @@ int hci_register_dev(struct hci_dev *hdev)
> >
> >	sprintf(hdev->name, "hci%d", id);
> >	hdev->id = id;
> >-	list_add(&hdev->list, head);
> >+
> >+	if (hdev->dev_type == HCI_BREDR)
> >+		list_add(&hdev->list, head);
> >+	else
> >+		list_add_tail(&hdev->list, head);
> >
> >	atomic_set(&hdev->refcnt, 1);
> >	spin_lock_init(&hdev->lock);
> >-- 
> >1.7.4.1
> 
> I'm don't think it works to depend on the ordering in hdev->list for
> A2MP discover, since there might be multiple BR/EDR controllers.

What about following change:

-    list_add(&hdev->list, head);
+    list_add_tail(&hdev->list, head);

This way hci devices queued to the list as opposed to stacked now.
Usual use case is that we have the 1st device BR/EDR and second AMP.

> Controller 0x00 is the BR/EDR controller that received the A2MP
> discover request.  The rest of the list should be only AMP
> controllers, any other BR/EDR controllers should not be listed.  In
> practice, this means that the 0x00 entry in the list is hard-coded
> and hdev->list is only used to look for AMP controllers.

It is actually how it is done in my RFC, I wanted to make it nicer :-(

Best regards 
Andrei Emeltchenko 
