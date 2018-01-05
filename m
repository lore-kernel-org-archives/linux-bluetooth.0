Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC v2 7/9] bluetooth: btrtl: load the config blob from
 devicetree when available
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <EC216531-81EC-4EE8-BAC4-C6954C222092@holtmann.org>
Date: Fri, 5 Jan 2018 17:15:48 +0100
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Daniel Drake <drake@endlessm.com>
Message-Id: <1F394D8B-CFB8-48BA-BC6B-15D1EE51DB08@holtmann.org>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-8-martin.blumenstingl@googlemail.com>
 <563D6F9F-8495-40D4-BE56-5338ED2B9B99@holtmann.org>
 <CAL9uMOEMDup4hRkxD-tM8R0YirGs5uQi31AjJUnFCPNMKUdRHg@mail.gmail.com>
 <E8E39477-CF1A-4A3E-84C5-830E182C2266@holtmann.org>
 <CAL9uMOH0N-4jgQncmPjK-KyU0vY9Q0ZnHYSAGgz3z3ywzc8Avw@mail.gmail.com>
 <CAFBinCBB=SmviOMRHGDH6vzjTjV-mrtQEc8nBUhDbJGs9SBpgw@mail.gmail.com>
 <CAL9uMOFyfr_qGf5BeTojkMeWeH8LqPoKj=LrdgEMB2wmhGBxmA@mail.gmail.com>
 <CAFBinCAFsDRpp=4We1hQPiutM1Q0MrqebPLyS3e2_e+JcBoSmg@mail.gmail.com>
 <CAL9uMOGkZefjD_JNxjf4yJ0ATFtOG5Cm_XQq1fy0VQDjiMFBmg@mail.gmail.com>
 <EC216531-81EC-4EE8-BAC4-C6954C222092@holtmann.org>
To: Carlo Caione <carlo@endlessm.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Carlo,

>>>> As Marcel suggested we can assume that the information in the DSDT is
>>>> correct so that we can get rid of the config blob also for x86
>>>> platforms (assuming that the only useful information in the config
>>>> blobs is the UART configuration).
>>> in my tests I tried to send only the firmware without the config to my
>>> RTL8723BS. unfortunately the last firmware chunk (sent to the
>>> controller) times out in that case (even if I set a proper baudrate
>>> before or if I specify no baudrate at all and keep the serdev at
>>> 115200)
>> 
>> What's in the config blobs besides UART configuration?
> 
> is anybody writing a rtlfw.c tool (like nokfw.c) so that we can print out what we actually have in these config files?
> 
>> It's odd because reading into hciattach_rtk.c it seems that the config
>> file is actually only used by the userspace tools (hciattach) to
>> retrieve the UART configuration and nothing else, whereas in the
>> kernel driver the config blob is appended to the firmware.
> 
> Frankly, I am inclined to not use the config file even for DT based system and just allow specifying the UART settings via normal DT properties like we do for Broadcom and others.

so I googled for a few config files and this is what this turns into:

Analyzing rtl8723d_config_1000000_noflow.dms
Signature:   0x8723ab55
Data length: 41
len=1   offset=f4,{ 01 }
len=2   offset=f6,{ 81 00 }
len=2   offset=fa,{ 12 80 }
len=16  offset=0c,{ 04 50 00 00 50 c5 ea 19 e1 1b fd af 5b 01 a4 0b }
len=1   offset=d9,{ 0f }
len=1   offset=e4,{ 08 }
Analyzing rtl8723d_config.dms
Signature:   0x8723ab55
Data length: 41
len=1   offset=f4,{ 01 }
len=2   offset=f6,{ 81 00 }
len=2   offset=fa,{ 12 80 }
len=16  offset=0c,{ 02 80 92 04 50 c5 ea 19 e1 1b fd af 5f 01 a4 0b }
len=1   offset=d9,{ 0f }
len=1   offset=e4,{ 08 }
Analyzing rtl8822b_config.bin
Signature:   0x8723ab55
Data length: 8
len=1   offset=d9,{ 0f }
len=1   offset=e4,{ 08 }

The first two are some UART based ones and the last one is USB based.

So the 0x3c offset seems to be the BD_ADDR and 0x0c offset is the UART configuration. It would be good to know which settings the other ones control.

Also the 16 octet UART config blob seems to be decoded like this:

	uart_config {
		le32 baudrate;
		u8[8] reserved1;
		u8 flowctl;
		u8[3] reserved2;
	}

Actually hciattach_rtk just takes the baud rate and and hardware flow control bit out of this file. That is clearly two things that are better written in plain text in the DT file.

Regards

Marcel

