Return-Path: <johan.hedberg@gmail.com>
Date: Tue, 24 Oct 2017 10:58:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: Re: [PATCH] Bluetooth: Fix potential memory leak
Message-ID: <20171024085831.GA3889@x1c>
References: <1508830195-13824-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <F0B9BF0A-BC07-4074-923E-518E6A227DF0@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F0B9BF0A-BC07-4074-923E-518E6A227DF0@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 24, 2017, Marcel Holtmann wrote:
> > index 1fba2a0..58045ee 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -6383,6 +6383,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
> > 	if (skb_queue_empty(&req.cmd_q) ||
> > 	    !hdev_is_powered(hdev) ||
> > 	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
> > +		skb_queue_purge(&req.cmd_q);
> > 		rp.instance = cp->instance;
> > 		err = mgmt_cmd_complete(sk, hdev->id,
> > 					MGMT_OP_REMOVE_ADVERTISING,
> 
> this does not look right to me. It most likely has side affects. The
> fix must be differently if there is a memory leak.

Actually, it looks like the right fix to me. We don't have a separate
helper to clean up a hci_request that never got used, and
skb_queue_purge is what other places in the code seem to be doing in
this kind of cases.

Johan
