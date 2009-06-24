Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Rodolpho Atoji <rodolpho.atoji@gmail.com>
Date: Wed, 24 Jun 2009 19:49:17 -0300
Message-ID: <40b986310906241549q5d6e354dw372aeb488cdbd8ed@mail.gmail.com>
Subject: SDP_RETRY_IF_BUSY and timeout of service search process
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm using bluez-3.32 and I would like to know the timeout
for the service search process, with or without using
SDP_RETRY_IF_BUSY.

Reading the code, it's possible to see that the function
sdp_send_req_w4_resp() is used for all the search functions.

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

As shown on (sdp.c:4095):

do {
...
} while (errno == EBUSY && (flags & SDP_RETRY_IF_BUSY));

When SDP_RETRY_IF_BUSY is used, the timeout of
service search process can be indefinitely extended
above the timeout calculated?

Thanks in advance and best regards,

Rodolpho
