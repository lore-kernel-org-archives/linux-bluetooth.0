Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Feb 2010 15:42:32 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bastien Nocera <hadess@hadess.net>,
	Michael Poole <mdpoole@troilus.org>,
	"Gunn, Brian" <bgunn@solekai.com>, Ping <pinglinux@gmail.com>,
	linux-kernel@vger.kernel.org,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/3] HID: Enable Sixaxis controller over Bluetooth
In-Reply-To: <1265206650.31341.113.camel@localhost.localdomain>
Message-ID: <alpine.LNX.2.00.1002031542222.15395@pobox.suse.cz>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>  <1264783166.29532.5302.camel@localhost.localdomain>  <87iqakifm8.fsf@troilus.org>  <1264860663.29532.7887.camel@localhost.localdomain>  <87bpg7glf7.fsf@troilus.org>  <1265190440.32444.8417.camel@localhost.localdomain>
  <alpine.LNX.2.00.1002031202040.15395@pobox.suse.cz>  <alpine.LNX.2.00.1002031343500.15395@pobox.suse.cz>  <alpine.LNX.2.00.1002031349550.15395@pobox.suse.cz> <1265206650.31341.113.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 3 Feb 2010, Marcel Holtmann wrote:

> Hi Jiri,
> 
> > Now that hid_output_raw_report works, port the PS3 Sixaxis
> > Bluetooth quirk from user-space, into kernel-space.
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>  
> > -	ret = sony_set_operational(hdev);
> > +	if (hdev->bus == BUS_USB)
> > +		ret = sony_set_operational(hdev);
> > +	else if (hdev->bus == BUS_BLUETOOTH)
> > +		ret = sony_set_operational_bt(hdev);
> > +	else
> > +		ret = 0;
> > +
> 
> I would do sony_set_operational_usb() and sony_set_operational_bt() and
> also turn this into a switch statement for better readability.

Fixed and applied. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
