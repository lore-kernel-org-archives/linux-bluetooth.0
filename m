Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 6/8] Bluetooth: 6lowpan: Fix MAC address universal/local bit handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400837248-12179-7-git-send-email-jukka.rissanen@linux.intel.com>
Date: Sat, 24 May 2014 22:05:33 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4AB1907F-0DCF-4350-BED5-AE8BA888E289@holtmann.org>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com> <1400837248-12179-7-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> The universal/local bit handling was incorrectly done in the code.
> 
> So when setting EUI address from BD address we do this:
> - If BD address type is PUBLIC, then we clear the universal bit
>  in EUI address. If the address type is RANDOM, then the universal
>  bit is set (BT 6lowpan draft chapter 3.2.2)
> - After this we invert the universal/local bit according to RFC 2464
> 
> When figuring out BD address we do the reverse:
> - Take EUI address from stateless IPv6 address, invert the
>  universal/local bit according to RFC 2464
> - If universal bit is 1 in this modified EUI address, then address
>  type is set to RANDOM, otherwise it is PUBLIC
> 
> Note that 6lowpan_iphc.[ch] does the final toggling of U/L bit
> before sending or receiving the network packet.

is this broken in the current code as well? We might want to fix it there first.

Regards

Marcel

