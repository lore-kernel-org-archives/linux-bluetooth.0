Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Re: Work-around for broken MS device
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1237397279.15346.1157.camel@cookie.hadess.net>
References: <1236278908.3602.1896.camel@cookie.hadess.net>
	 <1237397279.15346.1157.camel@cookie.hadess.net>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 14 Mar 2009 07:21:13 +0100
Message-Id: <1237011673.24751.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

 
> > As seen in https://bugzilla.redhat.com/show_bug.cgi?id=450081
> > The Microsoft Wireless Notebook Presenter Mouse 8000 has its name in
> > ISO-8859-1 instead of UTF-8, as required by the BT spec.
> > 
> > I've implemented a small work-around. This isn't very invasive, IMO, as
> > we already do UTF-8 checks.
> > 
> > In my tests, this makes the mouse show up as:
> > Microsoft® Wireless Notebook Presenter Mouse 8000
> 
> Attached is patch in the proper format.

I see the need for this one, but just a failing UTF-8 check to assume we
are using ISO-8859-1 is not good enough. Since the mouse has a DID
record, can we tie this together with the VID and PID?

Regards

Marcel


