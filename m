Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MScMpFNekv-9E3eFneNmLsgdurKb-R3kMTP66Gy40yaQ@mail.gmail.com>
References: <CAPm3yA3cOM0auyzqPLdKj5FFFva-REk3TnsrZcD9siV6kba+eA@mail.gmail.com>
	<CAJdJm_OK5TW3ECqQgF_JnUzO3McPCW=inG3HOxm1c_K4ODkWEQ@mail.gmail.com>
	<CAPm3yA2LJMPOSGGzscQe8XV+gu8+kf5WZurk8DsSWEBBCOJcew@mail.gmail.com>
	<CAJdJm_MScMpFNekv-9E3eFneNmLsgdurKb-R3kMTP66Gy40yaQ@mail.gmail.com>
Date: Thu, 6 Feb 2014 12:21:50 -0400
Message-ID: <CAPm3yA0m0AUyQd04J4H+mQ3NL7XjvkLX3M8R7cKhc8QGGG25hA@mail.gmail.com>
Subject: Re: LE Connection Update Disallowed
From: Sandy Chapman <schapman@lixar.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Wed, Feb 5, 2014 at 11:23 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> HI Sandy,
>
> On Wed, Feb 5, 2014 at 10:51 AM, Sandy Chapman <schapman@lixar.com> wrote:
>>>> How do I initiate a Connection Update from the peripheral?
>>>
>>> I never tried this procedure myself, but my guess it that you are
>>> using the incorrect mechanism on the slave role. Take a look at the
>>> "Connection Parameters Update Request" on Vol 3, Part A, Section 4.20.
>>> I believe this is the correct way to request from the slave (from what
>>> I understand while reading the Linux kernel implementation of the
>>> master side).
>>>
>>> Note that when Linux is the master, this command is issued
>>> automatically by the kernel when requested by the slave.
>>
>> I've taken a look at that section and it appears that this is what is
>> used to trigger the Connection Update. It states that the command
>> shall only be issued from the slave to the master. I can confirm that
>> my device is in the slave role using 'hcitool con'.
>
> I think you didn't notice that the section I mentioned is about a
> L2CAP signalling packet, not an HCI command (which in this case is to
> be used on the master side). I suggest you read a bit more on the
> L2CAP section to understand how these signalling packets work. Then
> you can try building such packet with "hcitool cmd" (unless there is
> some support for it on the current kernel, which I didn't check)
>

Yes, you right, I missed that part. I've built out what my packet
should look like, but I'm having troubles sending it to the
controller. I really am stuck on issuing this packet. It appears that
I need to send an HCI ACL Data Packet which holds a Signalling
Command. This signalling command then holds the connection parameter
update request as it's payload. It looks like 'hcitool cmd' can't send
ACL packets though as the command requires an OGF and OCF which are
part of the HCI Command Packet, not the HCI ACL Data Packet. From what
I can tell, the best chance I'd have is to send it via the l2test tool
over L2CAP, but attempting to use le_public address type doesn't work
(which I believe will send the message over CID 0x0005 - the fixed LE
channel). It fails on getsockopt/setsockopt for the SOL_BLUETOOTH
type. From what I can tell, it requires a kernel with CoC (not sure
what it means or if I have it). I'm really hoping I'm not going to
have to compile the bluetooth kernel module myself to send this
connection update packet.

>>> You may want to take a look at the "GAP Peripheral Preferred
>>> Connection Parameters" characteristic (see Vol 3, Part C, Section
>>> 12.3). If iPhones reads this characteristic and honours the
>>> parameters, it may help.
>>
>> Unfortunately, it appears Apple explicitly ignores this parameter
>> (section 3.6 in this document
>> https://developer.apple.com/hardwaredrivers/BluetoothDesignGuidelines.pdf).
>
> This is unfortunate. It would be the easiest way to pass custom
> connection parameters IMHO.
>
>> I believe that 'hcitool lecup' is exactly supposed to initiate this
>> process. I've also tried to use 'hcitool cmd' to issue direct commands
>> to the controller (using Vol 3, Part A, Section 4.20 as a guide), but
>> I am having no luck. It's stating that the command is disallowed (not
>> that the parameters are invalid), so I'm guessing there's something
>> else wrong. Since this is directly communicating with the controller,
>> where would the problem be? In the kernel, itself? Could it be a
>> problem with the Broadcom chipset in my MacBook?
>
> "hcitool lecup" is just a helper, it uses the same mechanism that
> "hcitool cmd" uses (and both are just "raw" interfaces to the
> Bluetooth controller). If you are getting an "Invalid Parameters" on
> any of them, is either because you built the packet incorrectly on
> "hcitool cmd" or given invalid values as per the spec.
>
> By the way, I suggest using "btmon" instead of "hcidump", as the
> former has nicer output and is more up-to-date (although I'm not sure
> it supports parsing "LE Connection Update" parameters).
>

You're right btmon is much nicer and does support recognition of the
LE commands.

> Best Regards,
> --
> Anderson Lizardo
> http://www.indt.org/?lang=en
> INdT - Manaus - Brazil

I know what I'm doing might not be typical, but I really appreciate
your help. If there's any direction you could point me in, I'd be
really thankful. I don't really know what to try next.

Thanks again,

Sandy

-- 

