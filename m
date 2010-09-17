Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Subject: Re: [PATCH 2/3] bluetooth: Remove some unnecessary error messages
Date: Fri, 17 Sep 2010 10:59:06 +0200
Cc: Matthew Garrett <mjg@redhat.com>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	marcel@holtmann.org
References: <1284659895-27984-1-git-send-email-mjg@redhat.com> <1284659895-27984-2-git-send-email-mjg@redhat.com> <AANLkTi=NBrb70ZvafQxZMnLZZcmuGEPeon4Vqq4vkpce@mail.gmail.com>
In-Reply-To: <AANLkTi=NBrb70ZvafQxZMnLZZcmuGEPeon4Vqq4vkpce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201009171059.06486.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Freitag, 17. September 2010, 10:33:30 schrieb Andrei Emeltchenko:
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index d22ce3c..3ace025 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -229,11 +229,8 @@ static void btusb_intr_complete(struct urb *urb)
> >        usb_anchor_urb(urb, &data->intr_anchor);
> >
> >        err = usb_submit_urb(urb, GFP_ATOMIC);
> > -       if (err < 0) {
> > -               BT_ERR("%s urb %p failed to resubmit (%d)",
> > -                                               hdev->name, urb, -err);
> > +       if (err < 0)
> >                usb_unanchor_urb(urb);
> > -       }
> >  }
> >
> 
> I do not get the point here. Cannot you just undef BT_ERR if you
> enabled debug? I believe this is standard behavior.

You can undefine BT_ERR, but then you'll miss error reports.
This message may indicate an error, but usually doesn't if
you use runtime pm.

	Regards
		Oliver
