Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Apr 2012 13:05:28 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Fix registering hci with duplicate name
Message-ID: <20120411100526.GE17779@aemeltch-MOBL1>
References: <1334132612-29610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334137632-30696-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334137926.16897.104.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334137926.16897.104.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 11, 2012 at 11:52:06AM +0200, Marcel Holtmann wrote:
> > @@ -1755,16 +1756,17 @@ int hci_register_dev(struct hci_dev *hdev)
> >  
> >  	write_lock(&hci_dev_list_lock);
> >  
> > -	/* Find first available device id */
> > -	list_for_each(p, &hci_dev_list) {
> > -		if (list_entry(p, struct hci_dev, list)->id != id)
> > -			break;
> > -		head = p; id++;
> > -	}
> I am now a little bit confused. Is it not enough to just replace head
> with &hci_dev_list to get this fixed? Or why is this failing in the
> first place actually.

You can see actual code above. If you have hci0 and hci1 adding third AMP
will fail since it just checks 0!=1 => break and trying to create hci1
again.

> Also this change will of course break the fix that we added to ensure
> that the HCI list comes sorted when calling hciconfig.

Actually it still works. But if we want it to stay ordered after
deleting/adding then we need a small fix.

Best regards 
Andrei Emeltchenko 
