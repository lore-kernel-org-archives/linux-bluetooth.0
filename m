Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OK5TW3ECqQgF_JnUzO3McPCW=inG3HOxm1c_K4ODkWEQ@mail.gmail.com>
References: <CAPm3yA3cOM0auyzqPLdKj5FFFva-REk3TnsrZcD9siV6kba+eA@mail.gmail.com>
	<CAJdJm_OK5TW3ECqQgF_JnUzO3McPCW=inG3HOxm1c_K4ODkWEQ@mail.gmail.com>
Date: Wed, 5 Feb 2014 10:51:14 -0400
Message-ID: <CAPm3yA2LJMPOSGGzscQe8XV+gu8+kf5WZurk8DsSWEBBCOJcew@mail.gmail.com>
Subject: Re: LE Connection Update Disallowed
From: Sandy Chapman <schapman@lixar.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Wed, Feb 5, 2014 at 9:12 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Sandy,
>
> On Wed, Feb 5, 2014 at 8:26 AM, Sandy Chapman <schapman@lixar.com> wrote:
>> I establish an LE connection between the devices. The central
>> successfully discovers the services and characteristics and can read
>> them. Once the connection is established, I run this command on the
>> Linux peripheral:
>>
>> $ sudo ./bin/hcitool lecup --handle 64 --min 24 --max 50 --latency 4
>> --timeout 550
>>>>> Could not change connection params: Input/output error(5)
>>
>> In my hcidump -X, I get this:
>>
>> < HCI Command: LE Connection Update (0x08|0x0013) plen 14
>>   0000: 40 00 18 00 32 00 04 00  26 02 01 00 01 00        @...2...&.....
>>> HCI Event: Command Status (0x0f) plen 4
>>     LE Connection Update (0x08|0x0013) status 0x0c ncmd 1
>>     Error: Command Disallowed
>
> This errors comes directly from the controller. The host is not at
> fault here, as hcitool issues HCI commands directly to the controller.
>
>> How do I initiate a Connection Update from the peripheral?
>
> I never tried this procedure myself, but my guess it that you are
> using the incorrect mechanism on the slave role. Take a look at the
> "Connection Parameters Update Request" on Vol 3, Part A, Section 4.20.
> I believe this is the correct way to request from the slave (from what
> I understand while reading the Linux kernel implementation of the
> master side).
>
> Note that when Linux is the master, this command is issued
> automatically by the kernel when requested by the slave.

I've taken a look at that section and it appears that this is what is
used to trigger the Connection Update. It states that the command
shall only be issued from the slave to the master. I can confirm that
my device is in the slave role using 'hcitool con'.

$ hcitool con
<<< Connections:
<<< Unknown 53:DC:05:A5:FA:7B handle 64 state 1 lm SLAVE

>
>> If this
>> isn't possible, how to I dictate the connection parameters (the
>> current connection is much too slow)?
>
> You may want to take a look at the "GAP Peripheral Preferred
> Connection Parameters" characteristic (see Vol 3, Part C, Section
> 12.3). If iPhones reads this characteristic and honours the
> parameters, it may help.

Unfortunately, it appears Apple explicitly ignores this parameter
(section 3.6 in this document
https://developer.apple.com/hardwaredrivers/BluetoothDesignGuidelines.pdf).

>
> Best Regards,
> --
> Anderson Lizardo
> http://www.indt.org/?lang=en
> INdT - Manaus - Brazil

Now what I want to do is to issue a command to the controller to begin
the Connection Update. This would result in the linux slave issuing a
Connection Update packet to the iPhone master. This doesn't seem to be
happening and is being blocked.

I believe that 'hcitool lecup' is exactly supposed to initiate this
process. I've also tried to use 'hcitool cmd' to issue direct commands
to the controller (using Vol 3, Part A, Section 4.20 as a guide), but
I am having no luck. It's stating that the command is disallowed (not
that the parameters are invalid), so I'm guessing there's something
else wrong. Since this is directly communicating with the controller,
where would the problem be? In the kernel, itself? Could it be a
problem with the Broadcom chipset in my MacBook?

Thanks again,
Sandy

-- 

