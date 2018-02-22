Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ 0/3] Receiving monitor data stream over RTT
Date: Thu, 22 Feb 2018 10:20:52 +0100
Message-Id: <20180222092055.22493-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's patch series which adds support for receiving monitor data stream over
Segger RTT channel. This allows to stream data from embedded device without
need to spare a UART for monitor data and is also much faster. It is now
supported by Apache Mynewt (NimBLE stack), but I believe it can be also added
to other RTOS-es like Zephyr Project.

RTT is handled natively by talking to J-Link via libjlinkarm.so. Since there
is no public documentation for this library, interface was done mostly by
trial and error so it may be lacking something - I tried it with few Cortex-M
devices and it works smoothly.

Both J-Link and RTT needs few configuration parameters to work so I combined
them into two command line options:
  -J --jlink <device>,<interface>,<speed>,<serialno>
  -R --rtt <address>,<area>,<buffer>

<device> - one of devices supported by J-Link (no default)
<interface> - only 'swd' supported for now (default: swd)
<speed> - interface speed (default: 1000)
<serialno> - emu serial number or 0 if not used (detault: 0)
<address> - RTT control block address (default: 0)
<area> - RTT control block search area length (default: 0)
<buffer> - RTT buffer name with monitor data stream (default: monitor)


Andrzej Kaczmarek (3):
  monitor: Extract TTY data processing to separate function
  monitor: Add interface for J-Link library
  monitor: Add support for reading over J-Link RTT

 Makefile.tools    |   3 +-
 monitor/control.c |  87 +++++++++++++----
 monitor/control.h |   1 +
 monitor/jlink.c   | 282 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/jlink.h   |  27 ++++++
 monitor/main.c    |  30 +++++-
 6 files changed, 409 insertions(+), 21 deletions(-)
 create mode 100644 monitor/jlink.c
 create mode 100644 monitor/jlink.h

-- 
2.16.2

