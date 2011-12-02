Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 21:25:22 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: use buffer priority to mark URB_ISO_ASAP
 flag
Message-ID: <20111202122522.GG2570@joana>
References: <1320241924-2300-1-git-send-email-luiz.dentz@gmail.com>
 <1320241924-2300-4-git-send-email-luiz.dentz@gmail.com>
 <20111130172428.GA9425@samus>
 <CABBYNZKod-HNwzuFhoLRUQc66uJkEQL-u7NCknPAjbtvOMorgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZKod-HNwzuFhoLRUQc66uJkEQL-u7NCknPAjbtvOMorgw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-12-01 09:23:09 +0200]:

> Hi Vinicius,
> 
> On Wed, Nov 30, 2011 at 7:24 PM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > Hi,
> >
> > On 15:52 Wed 02 Nov, Luiz Augusto von Dentz wrote:
> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>
> >> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> ---
> >>  drivers/bluetooth/btusb.c |    3 +++
> >>  1 files changed, 3 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >> index abfc4ee..9db2476 100644
> >> --- a/drivers/bluetooth/btusb.c
> >> +++ b/drivers/bluetooth/btusb.c
> >> @@ -727,6 +727,9 @@ static int btusb_send_frame(struct sk_buff *skb)
> >>               usb_fill_bulk_urb(urb, data->udev, pipe,
> >>                               skb->data, skb->len, btusb_tx_complete, skb);
> >>
> >> +             if (skb->priority >= HCI_PRIO_MAX - 1)
> >> +                     urb->transfer_flags  = URB_ISO_ASAP;
> >> +
> >
> > In case someone is having problems:
> >
> > With CONFIG_USB_DEBUG enabled the check that the URB_ISO_ASAP flag is
> > not valid for bulk endpoints is enabled, and that urb is rejected.
> 
> Hmm, you are right URB_ISO_ASAP is not meant for bulk so usb_submit_urb drop it:
> 
>  	/* fail if submitter gave bogus flags */
> 	if (urb->transfer_flags != orig_flags) {
> 		dev_err(&dev->dev, "BOGUS urb flags, %x --> %x\n",
> 			orig_flags, urb->transfer_flags);
> 		return -EINVAL;
> 	}
> 
> So we better remove asap.

Can you prepare a patch?

	Gustavo
