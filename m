Return-Path: <cyrus@holtmann.org>
Subject: Re: SDP_RETRY_IF_BUSY and timeout of service search process
From: Marcel Holtmann <marcel@holtmann.org>
To: Rodolpho Atoji <rodolpho.atoji@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <40b986310906250823n3ec9cff9s2ba3f881c6ccfc0e@mail.gmail.com>
References: <40b986310906241549q5d6e354dw372aeb488cdbd8ed@mail.gmail.com>
	 <1245901566.15367.151.camel@violet>
	 <40b986310906250815n79358f70ic786d05b06030f86@mail.gmail.com>
	 <1245943061.12994.89.camel@localhost.localdomain>
	 <40b986310906250823n3ec9cff9s2ba3f881c6ccfc0e@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 26 Jun 2009 09:04:42 +0200
Message-Id: <1245999882.12994.105.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rodolpho,

> >> I'm using bluez-4.42 and I would like to know the timeout
> >> for the service search process, with or without using
> >> SDP_RETRY_IF_BUSY.
> >
> > and where do we actually use that flag inside bluetoothd? If we do that
> > is a bug and it needs to be changed to use SDP async API.
> 
> In fact I use a library which is linked to bluez.
> 
> This library does the service search just like sdptool does
> in do_search() (sdp.c:3616).
> 
> Is this deprecated and shouldn't be used, then?

it is not deprecated, but it shouldn't be used. However feel free to fix
it, but as I mentioned we are not even using it. The SDP async API is
what I would recommend.

Regards

Marcel


