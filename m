Return-Path: <cyrus@holtmann.org>
Message-ID: <1349346388.27233.33.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: AMP: Register AMP only if High Speed enabled
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 04 Oct 2012 12:26:28 +0200
In-Reply-To: <20121004101010.GA12229@aemeltch-MOBL1>
References: <1349339215-8422-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1349344331.27233.9.camel@aeonflux> <20121004101010.GA12229@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > Make sure that AMP controller is registered only if HS enables.
> > > Return EINVAL if High Speed is not enabled and dev_type is HCI_AMP.
> > 
> > I don't think this is a good idea. I like to keep the adapter registers,
> > but maybe have a hciconfig hciX up fail. Not the registration itself.
> 
> So currently AMP registers itself as RAW device, maybe leave it as is.

we can do that, but that will also never give us enough testing
exposure. An adapter registered a RAW device, can not undo the RAW
device from userspace, you need to recompile the kernel.

So as I said, I rather have hciconfig hciX up fail in the case enable_hs
is set to false.

I am even fine with allowing to bring up AMP controllers. Just when it
comes to A2MP, you can not announce them to the other side unless
enable_hs is set to true.

You can not even list A2MP in the fixed channel list if enanble_hs is
false and L2CAP and A2MP procedures should just fail or return an error.

Regards

Marcel


