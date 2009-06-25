Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1245943061.12994.89.camel@localhost.localdomain>
References: <40b986310906241549q5d6e354dw372aeb488cdbd8ed@mail.gmail.com>
	<1245901566.15367.151.camel@violet> <40b986310906250815n79358f70ic786d05b06030f86@mail.gmail.com>
	<1245943061.12994.89.camel@localhost.localdomain>
From: Rodolpho Atoji <rodolpho.atoji@gmail.com>
Date: Thu, 25 Jun 2009 12:23:30 -0300
Message-ID: <40b986310906250823n3ec9cff9s2ba3f881c6ccfc0e@mail.gmail.com>
Subject: Re: SDP_RETRY_IF_BUSY and timeout of service search process
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> I'm using bluez-4.42 and I would like to know the timeout
>> for the service search process, with or without using
>> SDP_RETRY_IF_BUSY.
>
> and where do we actually use that flag inside bluetoothd? If we do that
> is a bug and it needs to be changed to use SDP async API.

In fact I use a library which is linked to bluez.

This library does the service search just like sdptool does
in do_search() (sdp.c:3616).

Is this deprecated and shouldn't be used, then?

Regards,
Rodolpho
