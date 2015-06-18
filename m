Return-Path: <cyrus@holtmann.org>
From: paras kumar <paras.kumar@samsung.com>
To: jukka.rissanen@linux.intel.com, marcel@holtmann.org,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: Re: Query regarding IPv6 address configuration for BT 6lowpan
 device/interface
Date: Thu, 18 Jun 2015 14:26:40 +0530
Message-id: <037401d0a9a4$b5f9c4c0$21ed4e40$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Jukka for your response,

I could see link -local address is configured for other interfaces like
wlan0, but not getting configured for bt0 interface when it is UP.
I am using linux kernel version 3.10 and had merged net/6lowpan/.. changes
from linux kernel version 4.0.2 as below to enable bt 6lowpan.

I am able to make the BT interface UP after merging 6lowpan changes as
above. But not able to get the ipv6 address for the same.

Please tell me if any system environment or module dependencies are there?

Thanks for your help,
Paras


------- Original Message -------
Sender : Jukka Rissanen<jukka.rissanen@linux.intel.com>
Date : Jun 18, 2015 12:25 (GMT+05:30)
Title : Re: Query regarding IPv6 address configuration for BT 6lowpan
device/interface


Hi Paras,

On to, 2015-06-18 at 10:48 +0530, paras kumar wrote:
> Hi Marcel,
> 
> Could you please provide me answer of below query.
> 
> When BT 6Lowpan interface is UP after BLE & IPSP L2CAP connection (Say for
> example "bt0").
> I don't find interface is configured with inet6/IPv6 address which should
be
> configured during device initialization.
> 
> The snapshot is here:
> sh-4.1# ifconfig
> bt0: flags=4177  mtu 1280
>         unspec 00-02-FA-FF-FE-72-2D-17-00-00-00-00-00-00-00-00  txqueuelen
0
> (UNSPEC)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 0  bytes 0 (0.0 B)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> 
> My query is how IPv6 address is configured or generated for BT interface?
Or
> the process which should be followed to get IPv6 address configured ?
> 
> Please give me some pointer in kernel code also, where to check?
> 
> Thanks & regards,
> Paras
> 
> 

See net/bluetooth/6lowpan.c:chan_ready_cb(), it will setup the netdev
and take the interface up. This should then cause the interface to have
the IPv6 link local address properly setup by the kernel.


Cheers,
Jukka
