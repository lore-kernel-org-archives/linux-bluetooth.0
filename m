Return-Path: <hadess@hadess.net>
Message-ID: <1510754477.2510.23.camel@hadess.net>
Subject: Re: [PATCH] Bluettoth: btusb: Prevent USB devices to autosuspend
 while setting interface
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>, abhijeet.kumar@intel.com
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg
	 <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Wed, 15 Nov 2017 15:01:17 +0100
In-Reply-To: <395C47EC-9D79-451D-B774-9F6D6555F100@holtmann.org>
References: <1510747888-13912-1-git-send-email-abhijeet.kumar@intel.com>
	 <395C47EC-9D79-451D-B774-9F6D6555F100@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-11-15 at 14:54 +0100, Marcel Holtmann wrote:
> Hi Abhijeet,
> 
> > Runtime resume USB device in order to ensure that PM framework
> > knows
> > that the we might be using the device in a short time and doesn't
> > autosuspend the device while we update it's interface.
> > 
> > Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
> > ---
> > drivers/bluetooth/btusb.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 7a5c06aaa181..588aabf991be 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -1444,6 +1444,12 @@ static void btusb_work(struct work_struct
> > *work)
> > 			data->sco_skb = NULL;
> > 			spin_unlock_irqrestore(&data->rxlock, flags);
> > 
> > +			 /*
> > +			  *Letting runtime PM know that we wish to
> > use
> > +			  *the device in a short time.
> > +			  */
> > +			  pm_runtime_get(&data->udev->dev);
> > +
> 
> the indentation is wrong here and the comment coding style if off.
> Please fix.

And there's a typo in the commit message ("its interface").
