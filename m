Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 23 Aug 2010 23:06:17 -0700
Message-ID: <AANLkTimS=j0vMv84Xc9MjED254Kn9g9n59qWCmotvDhF@mail.gmail.com>
Subject: ping slowness over bluetooth PAN
From: Han <keepsimple@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I noticed that ping is much more slow over bluetooth PAN connection
than a typical WiFI LAN:

especially the first packet:  (Ubuntu 9.10)

PAN:

64 bytes from 10.0.0.1: icmp_seq=1 ttl=64 time=365 ms

WLAN:

64 bytes from Amelie (192.168.1.71): icmp_seq=1 ttl=128 time=3.53 ms

The WLAN case is 100 times faster on the first ping!  Is this
expected?  (I don't think this is due to the absolute bandwidth).  Any
insight is appreciated.

Han
