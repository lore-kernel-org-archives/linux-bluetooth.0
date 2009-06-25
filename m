Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1245901566.15367.151.camel@violet>
References: <40b986310906241549q5d6e354dw372aeb488cdbd8ed@mail.gmail.com>
	<1245901566.15367.151.camel@violet>
From: Rodolpho Atoji <rodolpho.atoji@gmail.com>
Date: Thu, 25 Jun 2009 12:15:57 -0300
Message-ID: <40b986310906250815n79358f70ic786d05b06030f86@mail.gmail.com>
Subject: Re: SDP_RETRY_IF_BUSY and timeout of service search process
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> I'm using bluez-3.32 and I would like to know the timeout
>> for the service search process, with or without using
>> SDP_RETRY_IF_BUSY.
>
> I can stop you right here. Our current release is 4.42 and the 3.x
> series is fully in maintenance mode.

Ok!

I'll be moving to 4.42, so I'll update my post based on the 4.42
sources, which are almost the same regarding to the
service search routines:

====== Updated post ======

I'm using bluez-4.42 and I would like to know the timeout
for the service search process, with or without using
SDP_RETRY_IF_BUSY.

Reading the code, it's possible to see that the function
sdp_send_req_w4_resp() is used by all the search functions.

So, without using SDP_RETRY_IF_BUSY the timeout
should be the sum of timeouts of sdp_send_req() and
sdp_read_rsp().

The timeout of sdp_send_req() is the timeout of send(),
which is SO_SNDTIMEO. The timeout of sdp_read_rsp()
is SDP_RESPONSE_TIMEOUT, so the timeout of
the service search process without retries should be
SO_SNDTIMEO + SDP_RESPONSE_TIMEOUT, am I
right?

Regarding to the "busy" state of the device, what is
it, exactly?

As shown on (sdp.c:4526):

do {
...
} while (errno == EBUSY && (flags & SDP_RETRY_IF_BUSY));

When SDP_RETRY_IF_BUSY is used, the timeout of
service search process can be indefinitely extended
above the timeout calculated?

Thanks and best regards,

Rodolpho
