Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Re: Work-around for broken MS device
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1237011673.24751.10.camel@localhost.localdomain>
References: <1236278908.3602.1896.camel@cookie.hadess.net>
	 <1237397279.15346.1157.camel@cookie.hadess.net>
	 <1237011673.24751.10.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 23 Mar 2009 13:59:02 +0000
Message-Id: <1237816742.19118.1234.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2009-03-14 at 07:21 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
>  
> > > As seen in https://bugzilla.redhat.com/show_bug.cgi?id=450081
> > > The Microsoft Wireless Notebook Presenter Mouse 8000 has its name in
> > > ISO-8859-1 instead of UTF-8, as required by the BT spec.
> > > 
> > > I've implemented a small work-around. This isn't very invasive, IMO, as
> > > we already do UTF-8 checks.
> > > 
> > > In my tests, this makes the mouse show up as:
> > > Microsoft® Wireless Notebook Presenter Mouse 8000
> > 
> > Attached is patch in the proper format.
> 
> I see the need for this one, but just a failing UTF-8 check to assume we
> are using ISO-8859-1 is not good enough. Since the mouse has a DID
> record, can we tie this together with the VID and PID?

In those kind of cases, we can only guess what the encoding would be, we
can't detect those encodings reliably. Given that we fallback to the old
behaviour when the device, and that ISO-8859-X corresponds 1-1 with
UTF-8 for the ASCII characters, I don't think it's such a stretch to
think that American companies (who'd be using ISO-8859-1) would be the
worst offenders for this sort of mistake.

I don't think special casing only this device would be a good idea. As I
mentioned, I reproduced the bug by making my computer, running BlueZ,
adopt that name.
