Return-Path: <linux-wpan-owner@vger.kernel.org>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
From: Alexander Aring <aar@pengutronix.de>
Subject: current btle 6lowpan issues
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-wpan@vger.kernel.org, kernel@pengutronix.de
Message-ID: <ccd6b822-4af0-ea89-2dba-b914e6427191@pengutronix.de>
Date: Wed, 15 Jun 2016 20:02:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I like to collect some _big_ issues which I detected on current btle 6lowpan
implementation, these are:

 1. The l2 daddr comes not from ndisc cache. This should come from ndisc
    cache, instead the implementation construct the l2 from L3 address
    which only works for autoconfiguration addresses, all other
    addresses seems not be working for btle 6lowpan.

 2. The dev->dev_addr should be the 6 byte baddr and NOT the eui64
    generated baddr with fffe pattern and u/l bit. The eui64 should not
    be part of source/target address options of ndisc messages, it should
    be the baddr in big endian format. (dev->addr_len need to be 6 then,
    as well). baddr is the mac address of btle transceiver.

The 1. is easy to fix, but then I detected if we do that, the neighbour
cache messages NS/NA/RS, etc use the eui64 fffe pattern with u/l bit for
these messages, because the issue 2. So we will get the wrong address
from ndisc. The ndisc should store the 6 bytes baddr in big endian format.
So these two issues need to be fixed in some patch and changes everything
in btle 6lowpan.

I started to work on this but the issue 2. is a big change in btle 6lowpan
so I want to start the discussion about to fix that to doing it in the
right way.

Jukka, do you agree that this behaviour is currently broken in btle 6lowpan?

- Alex
