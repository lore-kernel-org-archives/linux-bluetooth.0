Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
From: Alexander Aring <aar@pengutronix.de>
Subject: thesis - MLE
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Message-ID: <5fb7e439-4b49-a3f7-20f1-dacf2fec694b@pengutronix.de>
Date: Sun, 7 Aug 2016 17:01:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I will start my master thesis the next days and will try to create a
userspace application for [0] inside a Linux context and using the
mainline 802.15.4 subsystem/for testing the mainline 6LoWPAN stuff
etc. I will not use any UART/SLIP solution for that.

There exists an implementation outside which is openthread [1]. I will
try to create a native 802.15.4/6LoWPAN developing environment like I
did for RIOT-OS [2] with an af802154 driver to speak with 802.15.4 Linux
interfaces.

If anybody is already working on these parts, so please tell me.
... or better tell me not, because then I can't working on this parts
anymore in my thesis.

I added bluetooth mailinglist here because [0] is 6lo working group,
maybe there comes some TLV's which are bluetooth related soon?

Don't know I am not an expert for [0], I need to figure out how it's
working. Seems to require multicast fowarding stuff, but this can be
replaced later by $better_multicast_routing_protocol. This could be also
what thread used. Well I need to figure it out, I will not depend my
work on a better multicast forwarding protocol.

Anyway for 802.15.4 I need to implement some kernel parts to calculate
ETX, which means I need some ack received/non ack received counters or
something else which can be inserted for the ETX calculation (I need to
look into that).

I am sure I will have some fun with that.

- Alex

[0] https://tools.ietf.org/html/draft-kelsey-6lo-mesh-link-establishment-00
[1] https://github.com/openthread/openthread/blob/master/src/core/thread/mle.cpp
[2] https://github.com/RIOT-OS/RIOT/pull/5582
