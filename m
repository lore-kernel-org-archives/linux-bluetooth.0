Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Add support for command line arguments on hid2hci
 tool
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4A0DE78B.8080503@dell.com>
References: <4A0DC533.8080900@dell.com>
	 <1242418278.3446.20.camel@localhost.localdomain>
	 <4A0DE78B.8080503@dell.com>
Content-Type: text/plain
Date: Sat, 16 May 2009 06:35:51 -0700
Message-Id: <1242480951.3446.33.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> > please restrict the commit message to 70-72 chars per line.
> >
> > And please do the following changes:
> >
> > s/radiomode/mode/ since it is not about the radio part here.
> >
> > s/hidproxy/csr/ if you wanna expose this then call it what it is.
> >
> > And go over the coding style once more since there are some cases where
> > it breaks.
> >
> > Also please split Makefile/rules changes from the actual code changes. I
> > want two patches here. One that fixes the code and another one that
> > takes care of the udev integration.
> >
> > Other than that, looks pretty good.
> >   
> Thanks for the feedback.  I've hopefully addressed all of your
> concerns.  If you still have problems with coding style, can you please
> point them out specifically?  The attached patch is the code portion of
> the split up patch.  Again it's attached so my mail server doesn't
> mangle it.

patch has been applied. However I was serious about the 70-72 chars
width of the commit message. Had to manually fix that.

Also it is Bluetooth and not bluetooth when writing about it. That is a
trademark issue :)

Regards

Marcel


