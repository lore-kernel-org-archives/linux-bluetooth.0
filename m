Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Bluetooth: hci_intel: Give priority to LPM packets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441818482-16357-1-git-send-email-loic.poulain@intel.com>
Date: Wed, 9 Sep 2015 10:42:52 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0C71E45D-994C-45A3-989A-F5C7AE700CF1@holtmann.org>
References: <1441818482-16357-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Change the way to insert LPM packets into the txq.
> Use skb_queue_head instead of skb_queue_tail to always prioritise LPM
> packets over potential tx queue content.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

