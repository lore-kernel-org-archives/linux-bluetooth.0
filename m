Return-Path: <cyrus@holtmann.org>
Subject: Re: SDP_RETRY_IF_BUSY and timeout of service search process
From: Marcel Holtmann <marcel@holtmann.org>
To: Rodolpho Atoji <rodolpho.atoji@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <40b986310906250815n79358f70ic786d05b06030f86@mail.gmail.com>
References: <40b986310906241549q5d6e354dw372aeb488cdbd8ed@mail.gmail.com>
	 <1245901566.15367.151.camel@violet>
	 <40b986310906250815n79358f70ic786d05b06030f86@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 25 Jun 2009 17:17:41 +0200
Message-Id: <1245943061.12994.89.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rodolpho,

> >> I'm using bluez-3.32 and I would like to know the timeout
> >> for the service search process, with or without using
> >> SDP_RETRY_IF_BUSY.
> >
> > I can stop you right here. Our current release is 4.42 and the 3.x
> > series is fully in maintenance mode.
> 
> Ok!
> 
> I'll be moving to 4.42, so I'll update my post based on the 4.42
> sources, which are almost the same regarding to the
> service search routines:
> 
> ====== Updated post ======
> 
> I'm using bluez-4.42 and I would like to know the timeout
> for the service search process, with or without using
> SDP_RETRY_IF_BUSY.

and where do we actually use that flag inside bluetoothd? If we do that
is a bug and it needs to be changed to use SDP async API.

Regards

Marcel


