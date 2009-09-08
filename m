Return-Path: <cyrus@holtmann.org>
Message-ID: <4AA6379D.4000306@team-embedded.nl>
Date: Tue, 08 Sep 2009 12:53:17 +0200
From: "Ithamar R. Adema" <ithamar.adema@team-embedded.nl>
MIME-Version: 1.0
To: Kartikey Parmar <kartikey2781@gmail.com>
CC: Linux_Arm_Kernel <linux-arm-kernel@lists.arm.linux.org.uk>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Address not supported by protocol error
References: <6887eb5d0909080320p7a420fd9lc4bfa2ad13659232@mail.gmail.com>
In-Reply-To: <6887eb5d0909080320p7a420fd9lc4bfa2ad13659232@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Kartikey Parmar wrote:
> Dear friends,
>
> I have prepared an application to connect speech on bluetooth headset.
> when I m cross compiling it & running on ARM platform with kernel 2.6.30 and
> bluez 4.30 cross compiled on it, it gives me an error "Address family not
> supported by protocol"
>
> What should I do to overcome this problem?
Sounds like either you're kernel isn't configured with bluetooth 
support, or the module isn't loaded...

Ithamar.

