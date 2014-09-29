Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 0/2] Bluetooth: 6lowpan: Fix multicast support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411997846-23949-1-git-send-email-jukka.rissanen@linux.intel.com>
Date: Mon, 29 Sep 2014 17:11:17 +0200
Cc: linux-bluetooth@vger.kernel.org, alex.aring@gmail.com
Message-Id: <A1D4450E-FA81-4A1F-95DB-357217AD827F@holtmann.org>
References: <1411997846-23949-1-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> patch 1 implements similar issue that was done for IEEE 802.154
> 6LoWPAN in commit f19f4f9525cf32f9 ("ieee802154: 6lowpan: ensure
> header compression does not corrupt ipv6 header") few days ago.
> So we copy the skb before mangling the IPv6 headers in the packet
> so that it does not get corrupted if sent to non-6lowpan interface,
> like when sending multicast packet to more that one interface.
> 
> The multicast support was disabled for the interface so the
> issue fixed in patch 1 is not really seen earlier. The patch 2
> enables multicast support for the 6lowpan network interface.
> 
> 
> Cheers,
> Jukka
> 
> 
> Jukka Rissanen (2):
>  Bluetooth: 6lowpan: Ensure header compression does not corrupt IPv6
>    header
>  Bluetooth: 6lowpan: Enable multicast support
> 
> net/bluetooth/6lowpan.c | 140 +++++++++++++++++++++++++++++-------------------
> 1 file changed, 86 insertions(+), 54 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

