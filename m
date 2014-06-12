Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Subject: Updated bluetooth.git tree
Date: Thu, 12 Jun 2014 07:34:08 +0200
Message-Id: <9A6A4711-653B-480A-9852-4C12B9352E0A@holtmann.org>
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

since Dave closed the net-next tree for preparing his merge request to Linus, I took his tree and merged it into bluetooth.git tree. This will become the base for our 3.16-rcX patches.

I cherry-picked 8 patches out of our current bluetooth-next.git tree to make the first batch of bug fixes. The ones that also apply to 3.15 are marked with the CC: stable.

38fc2ce57961 Bluetooth: Reuse hci_stop_discovery function when cleaning up HCI state
9f7ec8871132 Bluetooth: Refactor discovery stopping into its own function
deef2a3f56ea Bluetooth: Fix indicating discovery state when canceling inquiry
20881a7eaaab Bluetooth: Fix setting correct authentication information for SMP STK
71f28af57066 Bluetooth: Add clarifying comment for conn->auth_type
1f1970881bbf Bluetooth: Fix SSP acceptor just-works confirmation without MITM
3b5c24f5db4e Bluetooth: Fix check for connection encryption
343a2a9da15c Bluetooth: Fix incorrectly overriding conn->src_type

It is to note that while 9f7ec8871132 is not strictly a bug fix, it is required for 38fc2ce57961 to fix our bug with the controller power procedure and canceling baseband resources consumed by inquiry and remote name requests. We have a real bug with an Intel controller requiring this patch to operate correctly after power cycles.

And 71f28af57066 is strictly speaking not a bug fix. It just adds an extra comment clarification. However since this comment is related to Bluetooth security support, I included it here as well.

So in theory John should be able to merge this tree once Dave released a rebased net.git and we get a wireless.git based on that. I have however no idea on when this is going to happen. I just wanted to make sure these ones do not get lost since they are more bug fixes than I would have expected coming up during such a short time window.

I am leaving bluetooth-next.git as it currently is. We can rebase that one after 3.16-rc2 or whenever wireless-next.git rebased against Linus' tree.

Regards

Marcel

