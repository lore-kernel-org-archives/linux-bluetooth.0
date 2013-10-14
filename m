Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Oct 2013 14:36:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Add connectable argument to
 enable_advertising()
Message-ID: <20131014113622.GE26222@x220.p-661hnu-f1>
References: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com>
 <1381747965-24599-2-git-send-email-johan.hedberg@gmail.com>
 <9E7A5B1E-F415-4F2D-BDBF-B6C4ACB6B142@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9E7A5B1E-F415-4F2D-BDBF-B6C4ACB6B142@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 14, 2013, Marcel Holtmann wrote:
> > We want to be able to control whether enable_advertising() enables
> > connectable or non-connectable advertising based on the connectable
> > setting of the adapter. We could have the function check directly for
> > the HCI_CONNECTABLE flag, but since the flag may not be set or unset
> > before we call the function it's necessary to pass an explicit parameter
> > value to it.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > net/bluetooth/mgmt.c | 16 +++++++++++-----
> > 1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 020f95b..6f07523 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -1418,7 +1418,7 @@ unlock:
> > 	return err;
> > }
> > 
> > -static void enable_advertising(struct hci_request *req)
> > +static void enable_advertising(struct hci_request *req, bool connectable)
> > {
> > 	struct hci_dev *hdev = req->hdev;
> > 	struct hci_cp_le_set_adv_param cp;
> > @@ -1427,7 +1427,10 @@ static void enable_advertising(struct hci_request *req)
> > 	memset(&cp, 0, sizeof(cp));
> > 	cp.min_interval = __constant_cpu_to_le16(0x0800);
> > 	cp.max_interval = __constant_cpu_to_le16(0x0800);
> > -	cp.type = LE_ADV_IND;
> > +	if (connectable)
> > +		cp.type = LE_ADV_IND;
> > +	else
> > +		cp.type = LE_ADV_NONCONN_IND;
> 
> this is the part that I do not like. Having the extra parameter seems
> rather pointless. We could check for the HCI_CONNECTABLE bit in
> dev_flags right here.

This is what I tried to explain in the commit message. When we do
set_connectable() we want to call enable_advertising() with an explicit
value since the HCI_CONNECTABLE flag gets toggled only when the HCI
commands have been successful.

Johan
