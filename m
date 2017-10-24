Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH] Bluetooth: Fix potential memory leak
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171024085831.GA3889@x1c>
Date: Tue, 24 Oct 2017 14:43:25 +0200
Cc: Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <7127E793-A2AE-413D-AA65-239B23229380@holtmann.org>
References: <1508830195-13824-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <F0B9BF0A-BC07-4074-923E-518E6A227DF0@holtmann.org>
 <20171024085831.GA3889@x1c>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> index 1fba2a0..58045ee 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -6383,6 +6383,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
>>> 	if (skb_queue_empty(&req.cmd_q) ||
>>> 	    !hdev_is_powered(hdev) ||
>>> 	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
>>> +		skb_queue_purge(&req.cmd_q);
>>> 		rp.instance = cp->instance;
>>> 		err = mgmt_cmd_complete(sk, hdev->id,
>>> 					MGMT_OP_REMOVE_ADVERTISING,
>> 
>> this does not look right to me. It most likely has side affects. The
>> fix must be differently if there is a memory leak.
> 
> Actually, it looks like the right fix to me. We don't have a separate
> helper to clean up a hci_request that never got used, and
> skb_queue_purge is what other places in the code seem to be doing in
> this kind of cases.

then we need a helper to do this. This is pretty bad style if we hook into the queue directly with a skb_queue_purge. Since that cmd_q should be a hidden detail.

Regards

Marcel

