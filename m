Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: "complex" Bluetooth handling
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <c290d35f-1637-1199-11a2-e2424262b175@gmail.com>
 <A4D30064D9E2C94BAAF5CE9449A29AAC4B864E3F@hasmsx109.ger.corp.intel.com>
 <4eaaac10-30a0-2483-8235-99e9c5d993cc@gmail.com>
 <CABBYNZL-BYpN=fuHfv4vdjeWPGAicn+hveXPFPCngxAwVR8LdA@mail.gmail.com>
Cc: "Ben-melech, Shiran" <shiran.ben-melech@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Marco Trapanese <marcotrapanese@gmail.com>
Message-ID: <dc7e087d-59ed-f9cf-381a-05c0e8b8ca3f@gmail.com>
Date: Wed, 15 Jun 2016 09:59:29 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZL-BYpN=fuHfv4vdjeWPGAicn+hveXPFPCngxAwVR8LdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Il 15/06/2016 09:53, Luiz Augusto von Dentz ha scritto:
>
> I guess you don't want a mixed topology with both LE/BR, in that case
> you will probably need to work in support GATT over BR/EDR properly
> since the focus was on LE link. For audio, and media in general, that
> have been a lot of work around car IVI systems, so provided you use
> the same components (e.g. PulseAudio, oFono) this should work out of
> the box.

Yes, PulseAudio and oFono "work out of the box" after fixing a looooot 
of issues :)
But I still need a library to handle them for example to enable them or 
manage connections, pairing, trusting, etc.. from my application.

About LE it's the only topology I need to exchange data, i.e. no need 
for "old" RFCOMM.
But still I need to have both a GATT server and an ANCS consumer (which 
should be a GATT client acting as a Central as far as I understand) 
working at the same time.

Thanks
Marco

