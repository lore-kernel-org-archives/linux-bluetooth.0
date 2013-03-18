Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Mar 2013 15:41:02 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: remove __le16_to_cpu() from u8 var
Message-ID: <20130318184102.GD3072@joana>
References: <1363629135-6720-1-git-send-email-gustavo@padovan.org>
 <040583C3-DDAC-42A8-BAEC-43E5791147B6@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <040583C3-DDAC-42A8-BAEC-43E5791147B6@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2013-03-18 11:26:59 -0700]:

> Hi Gustavo,
> 
> > We don't any endianness conversion in a single byte variable.
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> > net/bluetooth/hci_event.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 8a1f511..1385807 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -641,7 +641,7 @@ static void hci_cc_read_page_scan_type(struct hci_dev *hdev,
> > 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> > 
> > 	if (test_bit(HCI_INIT, &hdev->flags) && !rp->status)
> > -		hdev->page_scan_type = __le16_to_cpu(rp->type);
> > +		hdev->page_scan_type = rp->type;
> > }
> 
> we could also just fix up the patch with this mistake. Since it has not gotten into wireless-next yet.

Yes, the broken patch is now fixed in bluetooth-next.

	Gustavo
