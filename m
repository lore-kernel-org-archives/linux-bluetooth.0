Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 0/7] Improvements on connection parameters update
Date: Thu, 16 Feb 2017 18:03:08 +0000
Message-Id: <20170216180315.30531-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is one of the parts of a series of patches related to connection
parameters update.

This initial implementation adds supports to GAP Peripheral Preferred
Connection Parameters (PPCP) characteristic and the Slave Connection Interval
Range Advertising Data (AD).

There is a problem described in #4 that due to a limitation of the BlueZ API
it is not possible to update the current connection with specific parameters.
I am working on a socket option API to allow something similar. Hopefully I
will be able to write something that covers this use-case as well. This
problem also applies to patch #6.

Changes from v1:
 * Added Slave Connection Interval Range AD support;
 * Unit tests for connection interval.

Felipe F. Tonello (7):
  profiles/gap: Some code cleanup
  src/adapter: Added connection parameter load/store functions
  src/device: Added function to set connection parameters
  profiles/gap: Added support for PPCP characteristic
  src/eir: Added support for Slave Connection Interval Range AD
  src/adapter: Store Slave Connection Interval Range
  unit/test-eir: Added tests for connection interval

 profiles/gap/gas.c | 111 +++++++++++++++++++++++++++++++++++++++++++----------
 src/adapter.c      |  46 +++++++++++++++++++++-
 src/adapter.h      |   9 +++++
 src/device.c       |  16 ++++++++
 src/device.h       |   4 ++
 src/eir.c          |   7 ++++
 src/eir.h          |   3 ++
 unit/test-eir.c    |  26 +++++++++++--
 8 files changed, 196 insertions(+), 26 deletions(-)

-- 
2.11.1

