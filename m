Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Oct 2012 13:10:11 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: AMP: Register AMP only if High Speed enabled
Message-ID: <20121004101010.GA12229@aemeltch-MOBL1>
References: <1349339215-8422-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1349344331.27233.9.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349344331.27233.9.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 04, 2012 at 11:52:11AM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Make sure that AMP controller is registered only if HS enables.
> > Return EINVAL if High Speed is not enabled and dev_type is HCI_AMP.
> 
> I don't think this is a good idea. I like to keep the adapter registers,
> but maybe have a hciconfig hciX up fail. Not the registration itself.

So currently AMP registers itself as RAW device, maybe leave it as is.

Best regards 
Andrei Emeltchenko 

> 
> If you would fail the registration itself, then you have the problem
> that you need to unplug and replug the hardware once you changed
> enable_hs. And that might not always be possible.
> 
> Regards
> 
> Marcel
> 
> 
