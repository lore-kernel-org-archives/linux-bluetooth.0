Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Jun 2015 11:08:45 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: paras kumar <paras.kumar@samsung.com>
Cc: jukka.rissanen@linux.intel.com, marcel@holtmann.org,
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: Re: Query regarding IPv6 address configuration for BT 6lowpan
 device/interface
Message-ID: <20150618090842.GA4544@omega>
References: <037401d0a9a4$b5f9c4c0$21ed4e40$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <037401d0a9a4$b5f9c4c0$21ed4e40$@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 18, 2015 at 02:26:40PM +0530, paras kumar wrote:
> Thanks Jukka for your response,
> 
> I could see link -local address is configured for other interfaces like
> wlan0, but not getting configured for bt0 interface when it is UP.
> I am using linux kernel version 3.10 and had merged net/6lowpan/.. changes
> from linux kernel version 4.0.2 as below to enable bt 6lowpan.
> 
> I am able to make the BT interface UP after merging 6lowpan changes as
> above. But not able to get the ipv6 address for the same.
> 
> Please tell me if any system environment or module dependencies are there?
>

Maybe you missing [0].

- Alex

[0] http://lxr.free-electrons.com/source/net/ipv6/addrconf.c#L1912
