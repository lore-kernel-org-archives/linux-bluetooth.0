Return-Path: <cyrus@holtmann.org>
From: paras kumar <paras.kumar@samsung.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com
Subject: Query regarding IPv6 address configuration for BT 6lowpan
 device/interface
Date: Thu, 18 Jun 2015 10:48:52 +0530
Message-id: <037201d0a986$4f1ff2b0$ed5fd810$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Could you please provide me answer of below query.

When BT 6Lowpan interface is UP after BLE & IPSP L2CAP connection (Say for
example "bt0").
I don't find interface is configured with inet6/IPv6 address which should be
configured during device initialization.

The snapshot is here:
sh-4.1# ifconfig
bt0: flags=4177<UP,POINTOPOINT,RUNNING,MULTICAST>  mtu 1280
        unspec 00-02-FA-FF-FE-72-2D-17-00-00-00-00-00-00-00-00  txqueuelen 0
(UNSPEC)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

My query is how IPv6 address is configured or generated for BT interface? Or
the process which should be followed to get IPv6 address configured ?

Please give me some pointer in kernel code also, where to check?

Thanks & regards,
Paras
