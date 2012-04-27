Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 27 Apr 2012 10:21:23 -0500
Message-ID: <CAB7rCTgK1eZwHQVp-VXxzWH_CmE_uygvcJ2HMJfZSTdE_LGiSw@mail.gmail.com>
Subject: hcidump / avtest issues
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm having issues where hcidump seems to be losing packets.  I'm
trying to collect traces of avtest running.  Avtest properly prints
out that it sent a packet and received a reply, but I don't always see
it in hcidump.  Seems if I run avtest a lot successively, it does show
up.  I'm running a 2.6.33.20 kernel with hcidump-2.3.  Let me know if
the kernel is just too ancient, but I'd like to know if others have
seen this type of issue.

Thanks,
Mike
