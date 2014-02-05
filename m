Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPm3yA2LJMPOSGGzscQe8XV+gu8+kf5WZurk8DsSWEBBCOJcew@mail.gmail.com>
References: <CAPm3yA3cOM0auyzqPLdKj5FFFva-REk3TnsrZcD9siV6kba+eA@mail.gmail.com>
	<CAJdJm_OK5TW3ECqQgF_JnUzO3McPCW=inG3HOxm1c_K4ODkWEQ@mail.gmail.com>
	<CAPm3yA2LJMPOSGGzscQe8XV+gu8+kf5WZurk8DsSWEBBCOJcew@mail.gmail.com>
Date: Wed, 5 Feb 2014 11:23:22 -0400
Message-ID: <CAJdJm_MScMpFNekv-9E3eFneNmLsgdurKb-R3kMTP66Gy40yaQ@mail.gmail.com>
Subject: Re: LE Connection Update Disallowed
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Sandy Chapman <schapman@lixar.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Sandy,

On Wed, Feb 5, 2014 at 10:51 AM, Sandy Chapman <schapman@lixar.com> wrote:
>>> How do I initiate a Connection Update from the peripheral?
>>
>> I never tried this procedure myself, but my guess it that you are
>> using the incorrect mechanism on the slave role. Take a look at the
>> "Connection Parameters Update Request" on Vol 3, Part A, Section 4.20.
>> I believe this is the correct way to request from the slave (from what
>> I understand while reading the Linux kernel implementation of the
>> master side).
>>
>> Note that when Linux is the master, this command is issued
>> automatically by the kernel when requested by the slave.
>
> I've taken a look at that section and it appears that this is what is
> used to trigger the Connection Update. It states that the command
> shall only be issued from the slave to the master. I can confirm that
> my device is in the slave role using 'hcitool con'.

I think you didn't notice that the section I mentioned is about a
L2CAP signalling packet, not an HCI command (which in this case is to
be used on the master side). I suggest you read a bit more on the
L2CAP section to understand how these signalling packets work. Then
you can try building such packet with "hcitool cmd" (unless there is
some support for it on the current kernel, which I didn't check)

>> You may want to take a look at the "GAP Peripheral Preferred
>> Connection Parameters" characteristic (see Vol 3, Part C, Section
>> 12.3). If iPhones reads this characteristic and honours the
>> parameters, it may help.
>
> Unfortunately, it appears Apple explicitly ignores this parameter
> (section 3.6 in this document
> https://developer.apple.com/hardwaredrivers/BluetoothDesignGuidelines.pdf).

This is unfortunate. It would be the easiest way to pass custom
connection parameters IMHO.

> I believe that 'hcitool lecup' is exactly supposed to initiate this
> process. I've also tried to use 'hcitool cmd' to issue direct commands
> to the controller (using Vol 3, Part A, Section 4.20 as a guide), but
> I am having no luck. It's stating that the command is disallowed (not
> that the parameters are invalid), so I'm guessing there's something
> else wrong. Since this is directly communicating with the controller,
> where would the problem be? In the kernel, itself? Could it be a
> problem with the Broadcom chipset in my MacBook?

"hcitool lecup" is just a helper, it uses the same mechanism that
"hcitool cmd" uses (and both are just "raw" interfaces to the
Bluetooth controller). If you are getting an "Invalid Parameters" on
any of them, is either because you built the packet incorrectly on
"hcitool cmd" or given invalid values as per the spec.

By the way, I suggest using "btmon" instead of "hcidump", as the
former has nicer output and is more up-to-date (although I'm not sure
it supports parsing "LE Connection Update" parameters).

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
