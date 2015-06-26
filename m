Return-Path: <cyrus@holtmann.org>
From: paras kumar <paras.kumar@samsung.com>
To: 'Alexander Aring' <alex.aring@gmail.com>, jukka.rissanen@linux.intel.com,
 marcel@holtmann.org, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
References: <037401d0a9a4$b5f9c4c0$21ed4e40$@samsung.com>
 <20150618090842.GA4544@omega>
In-reply-to: 
Subject: RE: Re: Query regarding IPv6 address configuration for BT 6lowpan
 device/interface
Date: Fri, 26 Jun 2015 10:28:10 +0530
Message-id: <022a01d0afcc$b9936c20$2cba4460$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hello All,

Please help me to understand below queries.

Thanks & Regards,
Paras


-----Original Message-----
From: paras kumar [mailto:paras.kumar@samsung.com]=20
Sent: Tuesday, June 23, 2015 12:30 PM
To: 'Alexander Aring'
Cc: 'jukka.rissanen@linux.intel.com'; 'marcel@holtmann.org'; =
'johan.hedberg@gmail.com'; 'linux-bluetooth@vger.kernel.org'
Subject: RE: Re: Query regarding IPv6 address configuration for BT =
6lowpan device/interface

Hi Alexander,

Thanks for the code modification you suggested [0].

After adding the case "ARPHRD_6LOWPAN" to generate IPv6 address for BT =
interface in IPv6 module (addrconf.c file); kernel gets panicked.
May be this panic is because I am using below setup.

1. Linux kernel version 3.10.
2. For 6LoWPAN:  Just copied [net/6lowpan/.. and net/Bluetooth/.. code =
from 4.0.2 kernel] Rest all other modules are older only (kernel 3.10) =
including IPV6 module.

As I cannot upgrade whole kernel  due to official reasons, please =
suggest which other dependent modules I need to upgrade mandatorily to =
get the 6LoWPAN working for Bluetooth properly.
Or
Above setup is sufficient to work for Bluetooth 6lowpan?=20

Please let me know your suggestions.
=20
Thanking you,
Paras

[0] http://lxr.free-electrons.com/source/net/ipv6/addrconf.c#L1912


-----Original Message-----
From: Alexander Aring [mailto:alex.aring@gmail.com]
Sent: Thursday, June 18, 2015 2:39 PM
To: paras kumar
Cc: jukka.rissanen@linux.intel.com; marcel@holtmann.org; =
johan.hedberg@gmail.com; linux-bluetooth@vger.kernel.org
Subject: Re: Re: Query regarding IPv6 address configuration for BT =
6lowpan device/interface

Hi,

On Thu, Jun 18, 2015 at 02:26:40PM +0530, paras kumar wrote:
> Thanks Jukka for your response,
>=20
> I could see link -local address is configured for other interfaces=20
> like wlan0, but not getting configured for bt0 interface when it is =
UP.
> I am using linux kernel version 3.10 and had merged net/6lowpan/..=20
> changes from linux kernel version 4.0.2 as below to enable bt 6lowpan.
>=20
> I am able to make the BT interface UP after merging 6lowpan changes as =

> above. But not able to get the ipv6 address for the same.
>=20
> Please tell me if any system environment or module dependencies are =
there?
>

Maybe you missing [0].

- Alex

[0] http://lxr.free-electrons.com/source/net/ipv6/addrconf.c#L1912
