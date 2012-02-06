Return-Path: <cyrus@holtmann.org>
Message-ID: <1328554926.2062.84.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix device reset
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Mon, 06 Feb 2012 11:02:06 -0800
In-Reply-To: <20120206152113.GA12729@x220>
References: <1328536743-8343-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <20120206152113.GA12729@x220>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/hci_core.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index e77cc79..3f30714 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -822,7 +822,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> >  	skb_queue_purge(&hdev->cmd_q);
> >  	atomic_set(&hdev->cmd_cnt, 1);
> >  	if (!test_bit(HCI_RAW, &hdev->flags) &&
> > -				test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
> > +			!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
> >  		set_bit(HCI_INIT, &hdev->flags);
> >  		__hci_request(hdev, hci_reset_req, 0,
> >  					msecs_to_jiffies(250));
> 
> Nack. The NO_RESET quirk is supposed to prevent reset during the device
> init sequence. The purpose of the test in hci_dev_do_close() is to let
> the reset be done there instead.

we might wanna rename this into HCI_QUIRK_RESET_ON_CLOSE. Otherwise
people keep in getting confused.

Regards

Marcel


