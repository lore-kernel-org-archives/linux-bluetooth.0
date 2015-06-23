Return-Path: <cyrus@holtmann.org>
From: paras kumar <paras.kumar@samsung.com>
To: 'Alexander Aring' <alex.aring@gmail.com>
Cc: jukka.rissanen@linux.intel.com, marcel@holtmann.org,
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
References: <037401d0a9a4$b5f9c4c0$21ed4e40$@samsung.com>
 <20150618090842.GA4544@omega>
In-reply-to: <20150618090842.GA4544@omega>
Subject: RE: Re: Query regarding IPv6 address configuration for BT 6lowpan
 device/interface
Date: Tue, 23 Jun 2015 12:30:02 +0530
Message-id: <011a01d0ad82$47a5b420$d6f11c60$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

Thanks for the code modification you suggested [0].

After adding the case "ARPHRD_6LOWPAN" to generate IPv6 address for BT interface; kernel gets panicked.
May be this panic is because I am using below setup.

1. Linux kernel version 3.10.
2. For 6LoWPAN:  Just copied [net/6lowpan/.. and net/Bluetooth/.. code from 4.0.2 kernel]
Rest all other modules are older only (kernel 3.10) including IPV6 module.

As I cannot upgrade whole kernel  due to official reasons,
please suggest which other dependent modules I need to upgrade mandatorily to get the 6LoWPAN working for Bluetooth properly.
Or
Above setup is sufficient to work for Bluetooth 6lowpan? 

Please let me know your suggestions.
 
Thanking you,
Paras

[0] http://lxr.free-electrons.com/source/net/ipv6/addrconf.c#L1912


-----Original Message-----
From: Alexander Aring [mailto:alex.aring@gmail.com] 
Sent: Thursday, June 18, 2015 2:39 PM
To: paras kumar
Cc: jukka.rissanen@linux.intel.com; marcel@holtmann.org; johan.hedberg@gmail.com; linux-bluetooth@vger.kernel.org
Subject: Re: Re: Query regarding IPv6 address configuration for BT 6lowpan device/interface

Hi,

On Thu, Jun 18, 2015 at 02:26:40PM +0530, paras kumar wrote:
> Thanks Jukka for your response,
> 
> I could see link -local address is configured for other interfaces 
> like wlan0, but not getting configured for bt0 interface when it is UP.
> I am using linux kernel version 3.10 and had merged net/6lowpan/.. 
> changes from linux kernel version 4.0.2 as below to enable bt 6lowpan.
> 
> I am able to make the BT interface UP after merging 6lowpan changes as 
> above. But not able to get the ipv6 address for the same.
> 
> Please tell me if any system environment or module dependencies are there?
>

Maybe you missing [0].

- Alex

[0] http://lxr.free-electrons.com/source/net/ipv6/addrconf.c#L1912

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
