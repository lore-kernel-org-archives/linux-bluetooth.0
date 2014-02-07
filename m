Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000001cf238d$a774e310$f65ea930$@lampreynetworks.com>
References: <000201cf21ed$d18f02d0$74ad0870$@lampreynetworks.com>
	<CAJdJm_PEQEmCz1owo8MZ+29R-O5u8qm8x85WgeuKy9U1x74zGw@mail.gmail.com>
	<000001cf238d$a774e310$f65ea930$@lampreynetworks.com>
Date: Thu, 6 Feb 2014 20:55:02 -0400
Message-ID: <CAJdJm_OeMUO5Qj3Amg7ADtkJRsRBpoixD2MEBBWHUA3V1M1OqA@mail.gmail.com>
Subject: Re: possible bug in blueZ 5.8 gatt tool or library
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Caleb Reinhold <creinhold@lampreynetworks.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 6, 2014 at 6:48 PM, Caleb Reinhold
<creinhold@lampreynetworks.com> wrote:
> It seemed that calling g_attrib_register() in the connection callback might
> be causing the client to start listening for indications and notifications
> too late, but registering right after the gatt_connect() call doesn't seem
> to help. Nor does placing a watch on the GIOChannel inside bt_io_connect(),
> so registering earlier doesn't appear to be the right approach. Do you know
> why we keep missing this initial indication on medium security, and how we
> might fix this issue?

If I remember correctly, the issue is in the kernel: if connect() is
called when security level is medium, the socket only gets POLLOUT
once SMP pairing finishes, and any ATT PDU received during that time
is lost.

Note that it's almost certain that your device is sending the
indication without requiring encryption. Otherwise, it would have sent
a Security Request (which triggers a Pairing Request from the Linux
side) and wait for the encryption to be enabled before sending the
indication. If that was the case, the kernel would deliver the ATT PDU
to gatttool after encryption is enabled and it would work as expected.

PS: Please, as common netiquette, avoid top-posting (i.e. answer
before the original message) and quote only the text that gives
context to your answer.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
