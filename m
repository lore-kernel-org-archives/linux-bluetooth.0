Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Apr 2012 13:31:05 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Fix registering hci with duplicate name
Message-ID: <20120411103103.GF17779@aemeltch-MOBL1>
References: <1334132612-29610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334137632-30696-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334137926.16897.104.camel@aeonflux>
 <20120411100526.GE17779@aemeltch-MOBL1>
 <1334139637.16897.107.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334139637.16897.107.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 11, 2012 at 12:20:37PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > > > @@ -1755,16 +1756,17 @@ int hci_register_dev(struct hci_dev *hdev)
> > > >  
> > > >  	write_lock(&hci_dev_list_lock);
> > > >  
> > > > -	/* Find first available device id */
> > > > -	list_for_each(p, &hci_dev_list) {
> > > > -		if (list_entry(p, struct hci_dev, list)->id != id)
> > > > -			break;
> > > > -		head = p; id++;
> > > > -	}
> > > I am now a little bit confused. Is it not enough to just replace head
> > > with &hci_dev_list to get this fixed? Or why is this failing in the
> > > first place actually.
> > 
> > You can see actual code above. If you have hci0 and hci1 adding third AMP
> > will fail since it just checks 0!=1 => break and trying to create hci1
> > again.
> 
> I see a problem when you having only AMPs (no BR/EDR controller). Then
> hci0 will be skipped and keep trying to create hci1 over and over again.
> 
> However in the case we have BR/EDR controller on hci0 and hci1 as AMP,
> then this should just work.
> 
> So we need to fix the case where we have no BR/EDR controller on hci0
> and trying to fix something else. Or did I get confused?

I think you got confused. 

We have hci0 (BREDR) and hci1 (AMP)

so list_for_each would give us first entry with id=0; Adding third (AMP)
would compare 1 (as given by id = (hdev->dev_type == HCI_BREDR) ? 0 : 1)
and 0 (id for BREDR) => break from the loop and tries to use id=1 again
for third controller.

Actually I do not know how the current code works at all, it is really
broken.

> 
> > > Also this change will of course break the fix that we added to ensure
> > > that the HCI list comes sorted when calling hciconfig.
> > 
> > Actually it still works. But if we want it to stay ordered after
> > deleting/adding then we need a small fix.
> 
> We added a fix for it to keep them sorted. So we might should retain
> that behavior from now on.

will do that.

Best regards 
Andrei Emeltchenko 
