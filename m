Return-Path: <cyrus@holtmann.org>
Message-ID: <1334139637.16897.107.camel@aeonflux>
Subject: Re: [PATCHv2] Bluetooth: Fix registering hci with duplicate name
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 11 Apr 2012 12:20:37 +0200
In-Reply-To: <20120411100526.GE17779@aemeltch-MOBL1>
References: <1334132612-29610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1334137632-30696-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1334137926.16897.104.camel@aeonflux>
	 <20120411100526.GE17779@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > @@ -1755,16 +1756,17 @@ int hci_register_dev(struct hci_dev *hdev)
> > >  
> > >  	write_lock(&hci_dev_list_lock);
> > >  
> > > -	/* Find first available device id */
> > > -	list_for_each(p, &hci_dev_list) {
> > > -		if (list_entry(p, struct hci_dev, list)->id != id)
> > > -			break;
> > > -		head = p; id++;
> > > -	}
> > I am now a little bit confused. Is it not enough to just replace head
> > with &hci_dev_list to get this fixed? Or why is this failing in the
> > first place actually.
> 
> You can see actual code above. If you have hci0 and hci1 adding third AMP
> will fail since it just checks 0!=1 => break and trying to create hci1
> again.

I see a problem when you having only AMPs (no BR/EDR controller). Then
hci0 will be skipped and keep trying to create hci1 over and over again.

However in the case we have BR/EDR controller on hci0 and hci1 as AMP,
then this should just work.

So we need to fix the case where we have no BR/EDR controller on hci0
and trying to fix something else. Or did I get confused?

> > Also this change will of course break the fix that we added to ensure
> > that the HCI list comes sorted when calling hciconfig.
> 
> Actually it still works. But if we want it to stay ordered after
> deleting/adding then we need a small fix.

We added a fix for it to keep them sorted. So we might should retain
that behavior from now on.

Regards

Marcel


