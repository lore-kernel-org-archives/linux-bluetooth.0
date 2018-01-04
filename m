Return-Path: <carlo@endlessm.com>
MIME-Version: 1.0
In-Reply-To: <CAFBinCAFsDRpp=4We1hQPiutM1Q0MrqebPLyS3e2_e+JcBoSmg@mail.gmail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-8-martin.blumenstingl@googlemail.com>
 <563D6F9F-8495-40D4-BE56-5338ED2B9B99@holtmann.org> <CAL9uMOEMDup4hRkxD-tM8R0YirGs5uQi31AjJUnFCPNMKUdRHg@mail.gmail.com>
 <E8E39477-CF1A-4A3E-84C5-830E182C2266@holtmann.org> <CAL9uMOH0N-4jgQncmPjK-KyU0vY9Q0ZnHYSAGgz3z3ywzc8Avw@mail.gmail.com>
 <CAFBinCBB=SmviOMRHGDH6vzjTjV-mrtQEc8nBUhDbJGs9SBpgw@mail.gmail.com>
 <CAL9uMOFyfr_qGf5BeTojkMeWeH8LqPoKj=LrdgEMB2wmhGBxmA@mail.gmail.com> <CAFBinCAFsDRpp=4We1hQPiutM1Q0MrqebPLyS3e2_e+JcBoSmg@mail.gmail.com>
From: Carlo Caione <carlo@endlessm.com>
Date: Thu, 4 Jan 2018 09:46:12 +0000
Message-ID: <CAL9uMOGkZefjD_JNxjf4yJ0ATFtOG5Cm_XQq1fy0VQDjiMFBmg@mail.gmail.com>
Subject: Re: [RFC v2 7/9] bluetooth: btrtl: load the config blob from
 devicetree when available
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.com,
	johan@kernel.org, linux-amlogic@lists.infradead.org,
	Larry.Finger@lwfinger.net, Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 3, 2018 at 8:50 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Hi Carlo,

Hi Martin,

>> As Marcel suggested we can assume that the information in the DSDT is
>> correct so that we can get rid of the config blob also for x86
>> platforms (assuming that the only useful information in the config
>> blobs is the UART configuration).
> in my tests I tried to send only the firmware without the config to my
> RTL8723BS. unfortunately the last firmware chunk (sent to the
> controller) times out in that case (even if I set a proper baudrate
> before or if I specify no baudrate at all and keep the serdev at
> 115200)

What's in the config blobs besides UART configuration?

It's odd because reading into hciattach_rtk.c it seems that the config
file is actually only used by the userspace tools (hciattach) to
retrieve the UART configuration and nothing else, whereas in the
kernel driver the config blob is appended to the firmware.

> have you tested this (= uploading the firmware without the config
> blob) on your x86 board before?

No, on the cherry-trail I have I'm using hciattach to upload the
firmware and AFAICT only the firmware is uploaded and (as written
before) the config blob is only used to get the UART configuration.

> so far the following solutions for the config blob were discussed:
> 1) put the config blob in userspace (/lib/firmware/...) -> not good
> because it makes the rootfs board-specific
> 2) auto-generate the config blob -> didn't work for me, last firmware
> chunk times out (just as if I had no config at all)
> 3) putting the config blob in DT -> possible but not very nice to read
>
> I had another idea:
> what if we mix solution 1) and 2)?
> the idea: load the config blob from userspace (/lib/firmware/...) and
> update it's settings with the values we got from devicetree-properties
> / DSDT

If you are shipping already the config blob in userspace I don't see
why you would do the update since you have already all the info you
need.
I would rather check why (2) didn't work fine. Have you any
documentation how the config blobs are generated? The code in
hciattach_rtk.c seems a good starting point.

> I have not tested this yet, but I just want to hear everyone's (at
> least Marcel, Rob and Carlo) opinion on that
> (this would also allow us to fully auto-generate the config blob in
> the future once we figure out how to do that)
>
>> Adding the ACPI support on top of your patches is (hopefully) trivial,
>> just follow what was done for hci_bcm.c, basically adding a new _HID
>> and reading the configuration for GPIOs and UART, all the rest should
>> be transparent for serdev.
> thanks for the reference to hci_bcm.c - I will have a look at this for
> the next version
> one question: "_HID" would be OBDA8723 in our case?

Yes

>> I'll test your patches on the hardware I have.
> great, thank you!

Cheers!

-- 
Carlo Caione  |  +44.7384.69.16.04  |  Endless
