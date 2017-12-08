Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH V2 00/10] Initial code for BTP client
Date: Fri,  8 Dec 2017 15:03:39 +0100
Message-Id: <20171208140348.30342-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes in V2:
 - adapter index is simply mapped to queue length
 - added support for reseting (removing all bonding) adapter
 - fixes for issues reported by valgrind


Cover letter from V1:
This adds initial code for BTP client. BTP stands for Bluetooth Tester
Protocol and aims at automated testing of BT stack. BTP is binary
protocol and is already implemented in Zephyr Project. This adds
similar client to BlueZ tree. BTP specification is available at [1].

Notable thing about this serie is that it doesn't use glib, gdbus or
utils from src/shared folder. Instead it makes use of Embedded Linux
Library which is available at [2].

Comments are welcome.

BR
Szymon Janc

[1] https://github.com/zephyrproject-rtos/zephyr/blob/master/tests/bluetooth/tester/btp_spec.txt
[2] https://git.kernel.org/pub/scm/libs/ell/ell.git/

Szymon Janc (10):
  shared/btp: Add initial code for library
  tools/btpclient: Add initial code
  shared/btp: Add definitions for GAP service
  tools/btpclient: Add initial support for GAP service
  tools/btpclient: Add initial support for read controller info command
  tools/btpclient: Get initial values for adapter setttings
  tools/btpclient: Add support for tracking mutable adapter settings
  tools/btpclient: Add support for configuring adapter settings
  tools/btpclient: Store devices per adapter
  tools/btpclient: Add support for reseting adapter

 .gitignore        |   1 +
 Makefile.tools    |   8 +
 configure.ac      |  11 +
 src/shared/btp.c  | 383 +++++++++++++++++++++++
 src/shared/btp.h  | 320 ++++++++++++++++++++
 tools/btpclient.c | 884 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1607 insertions(+)
 create mode 100644 src/shared/btp.c
 create mode 100644 src/shared/btp.h
 create mode 100644 tools/btpclient.c

-- 
2.14.3

