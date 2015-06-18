Return-Path: <cyrus@holtmann.org>
Message-ID: <1434610500.2794.24.camel@linux.intel.com>
Subject: Re: Query regarding IPv6 address configuration for BT 6lowpan
 device/interface
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: paras kumar <paras.kumar@samsung.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org
Date: Thu, 18 Jun 2015 09:55:00 +0300
In-Reply-To: <037201d0a986$4f1ff2b0$ed5fd810$@samsung.com>
References: <037201d0a986$4f1ff2b0$ed5fd810$@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paras,

On to, 2015-06-18 at 10:48 +0530, paras kumar wrote:
> Hi Marcel,
> 
> Could you please provide me answer of below query.
> 
> When BT 6Lowpan interface is UP after BLE & IPSP L2CAP connection (Say for
> example "bt0").
> I don't find interface is configured with inet6/IPv6 address which should be
> configured during device initialization.
> 
> The snapshot is here:
> sh-4.1# ifconfig
> bt0: flags=4177<UP,POINTOPOINT,RUNNING,MULTICAST>  mtu 1280
>         unspec 00-02-FA-FF-FE-72-2D-17-00-00-00-00-00-00-00-00  txqueuelen 0
> (UNSPEC)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 0  bytes 0 (0.0 B)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> 
> My query is how IPv6 address is configured or generated for BT interface? Or
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
