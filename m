Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb autosuspend and circular lock dep
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Arjan Van De Ven <arjan@linux.intel.com>,
	saharabeara@gmail.com
In-Reply-To: <200908241429.49498.oliver@neukum.org>
References: <20090615175435.GA4772@gamba.jf.intel.com>
	 <200908241149.34224.oliver@neukum.org>
	 <1251108975.2950.37.camel@localhost.localdomain>
	 <200908241429.49498.oliver@neukum.org>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 09:56:54 -0700
Message-Id: <1251133014.2950.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > +skip_waking:
> > >       usb_anchor_urb(urb, &data->tx_anchor);
> > >  
> > >       err = usb_submit_urb(urb, GFP_ATOMIC);
> > > @@ -646,10 +723,13 @@ static int btusb_send_frame(struct sk_buff *skb)
> > >               BT_ERR("%s urb %p submission failed", hdev->name, urb);
> > >               kfree(urb->setup_packet);
> > >               usb_unanchor_urb(urb);
> > > +     } else {
> > > +             usb_mark_last_busy(data->udev);
> > >       }
> > >  
> > >       usb_free_urb(urb);
> > >  
> > > +out:
> > >       return err;
> > >  }
> >
> > Please call the labels simply skip and done.
> 
> In this particular case skip_waking seems to be clearer because it
> tells you right away what is skipped.

agree, keep it then.

> > > @@ -721,8 +801,19 @@ static void btusb_work(struct work_struct *work)
> > >  {
> > >       struct btusb_data *data = container_of(work, struct btusb_data,
> > > work); struct hci_dev *hdev = data->hdev;
> > > +     int err;
> > >  
> > >       if (hdev->conn_hash.sco_num > 0) {
> > > +             if (!data->did_iso_resume) {
> > > +                     err = usb_autopm_get_interface(data->isoc);
> > > +                     if (!err) {
> > > +                             data->did_iso_resume = 1;
> > > +                     } else {
> > > +                             clear_bit(BTUSB_ISOC_RUNNING,
> > > &data->flags);
> > > +                             usb_kill_anchored_urbs(&data->isoc_anchor);
> > > +                             return;
> > > +                     }
> >
> > Having this as like this is simpler to read:
> >
> >                 if (err < 0) {
> >                         clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> >                         usb_kill_anchored_urbs(&data->isoc_anchor);
> >                         return;
> >                 }
> >
> >                 data->did_iso_resume = 1;
> 
> Do you generally prefer the "else" branch implicit?

I prefer: if error, cleanup and leave function. It is easier to read and
understand by people that are not familiar enough with the code.

If we have a lot of else branches you have to think too much which one
gets executed in case of success. If the command and the follow command
in case of success are on the same indentation, I find it a lot simpler
to follow. My take on these :)

Regards

Marcel


