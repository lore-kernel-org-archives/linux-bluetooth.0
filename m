Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPm3yA3cOM0auyzqPLdKj5FFFva-REk3TnsrZcD9siV6kba+eA@mail.gmail.com>
References: <CAPm3yA3cOM0auyzqPLdKj5FFFva-REk3TnsrZcD9siV6kba+eA@mail.gmail.com>
Date: Wed, 5 Feb 2014 09:12:11 -0400
Message-ID: <CAJdJm_OK5TW3ECqQgF_JnUzO3McPCW=inG3HOxm1c_K4ODkWEQ@mail.gmail.com>
Subject: Re: LE Connection Update Disallowed
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Sandy Chapman <schapman@lixar.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sandy,

On Wed, Feb 5, 2014 at 8:26 AM, Sandy Chapman <schapman@lixar.com> wrote:
> I establish an LE connection between the devices. The central
> successfully discovers the services and characteristics and can read
> them. Once the connection is established, I run this command on the
> Linux peripheral:
>
> $ sudo ./bin/hcitool lecup --handle 64 --min 24 --max 50 --latency 4
> --timeout 550
>>>> Could not change connection params: Input/output error(5)
>
> In my hcidump -X, I get this:
>
> < HCI Command: LE Connection Update (0x08|0x0013) plen 14
>   0000: 40 00 18 00 32 00 04 00  26 02 01 00 01 00        @...2...&.....
>> HCI Event: Command Status (0x0f) plen 4
>     LE Connection Update (0x08|0x0013) status 0x0c ncmd 1
>     Error: Command Disallowed

This errors comes directly from the controller. The host is not at
fault here, as hcitool issues HCI commands directly to the controller.

> How do I initiate a Connection Update from the peripheral?

I never tried this procedure myself, but my guess it that you are
using the incorrect mechanism on the slave role. Take a look at the
"Connection Parameters Update Request" on Vol 3, Part A, Section 4.20.
I believe this is the correct way to request from the slave (from what
I understand while reading the Linux kernel implementation of the
master side).

Note that when Linux is the master, this command is issued
automatically by the kernel when requested by the slave.

> If this
> isn't possible, how to I dictate the connection parameters (the
> current connection is much too slow)?

You may want to take a look at the "GAP Peripheral Preferred
Connection Parameters" characteristic (see Vol 3, Part C, Section
12.3). If iPhones reads this characteristic and honours the
parameters, it may help.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
