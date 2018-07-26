Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Cinaed Simson <cinaed.simson@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: print_bitfield
Message-ID: <4b6731b3-a13c-babf-8ccf-2e1d68150521@GMail.COM>
Date: Wed, 25 Jul 2018 23:10:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


After installing ell, the latest git version builds on jessie provided I
move both

   struct bitfield_data
   inline uint64_t print_bitfield()

from

   monitor/display.h

to near the top of

   monitor/packet.c

Jessie is using

   gcc (Debian 4.9.2-10+deb8u1) 4.9.2

- maybe it's a compiler problem with jessie?

-- Cinaed

