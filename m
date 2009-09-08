Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6887eb5d0909080325s7031cd9bvde9f5f0fe6a85cd2@mail.gmail.com>
References: <6887eb5d0909080325s7031cd9bvde9f5f0fe6a85cd2@mail.gmail.com>
Date: Tue, 8 Sep 2009 23:01:44 +0530
Message-ID: <ef974dc70909081031w43fc3507y3377805edbec9497@mail.gmail.com>
Subject: Re: Address not supported by protocol error
From: Maxin John <arm.maxinbjohn@gmail.com>
To: Kartikey Parmar <kartikey2781@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Linux_Arm <linux-arm@lists.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Hi Kartikey,

Make sure that you have enabled the below given option in your kernel
configuration (.config file)
CONFIG_BT_SCO=y

"SCO link provides voice transport over Bluetooth.  SCO support is
required for voice applications like
Headset and Audio"

Hope this helps.

Best Regards,
Maxin B. John



On Tue, Sep 8, 2009 at 3:55 PM, Kartikey Parmar<kartikey2781@gmail.com> wrote:
> Dear friends,
>
> I have prepared an application to connect speech on bluetooth headset.
> when I m cross compiling it & running on ARM platform with kernel
> 2.6.30 and bluez 4.30 cross compiled on it, it gives me an error
> "Address family not supported by protocol"
>
> What should I do to overcome this problem?
>
> --
> Kartikey Parmar
> R&D Software Engg
> Matrix Telecom Pvt Ltd
> Baroda, Gujarat (India)
> 09879095390 (M)
>
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>
