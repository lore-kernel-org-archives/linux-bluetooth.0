Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/4] Improvements on connection parameters update
Date: Wed, 15 Feb 2017 18:18:20 +0000
Message-Id: <20170215181824.9041-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is one of the parts of a series of patches related to connection
parameters update.

This initial implementation adds supports to GAP Peripheral Preferred
Connection Parameters (PPCP) characteristic

There is a problem described in #4 that due to a limitation of the BlueZ API
it is not possible to update the current connection with specific parameters.
I am working on a socket option API to allow something similar. Hopefully I
will be able to write something that covers this use-case as well.

Next step is to support connection parameters via the advertising data (AD).
On that case, hopefully it is possible to set this parameters before the
connection is actually established.

Felipe F. Tonello (4):
  profiles/gap: Some code cleanup
  src/adapter: Added connection parameter load/store functions
  src/device: Added function to set connection parameters
  profiles/gap: Added support for PPCP characteristic

 profiles/gap/gas.c | 104 ++++++++++++++++++++++++++++++++++++++++++-----------
 src/adapter.c      |  24 +++++++++++--
 src/adapter.h      |   9 +++++
 src/device.c       |  16 +++++++++
 src/device.h       |   4 +++
 5 files changed, 134 insertions(+), 23 deletions(-)

-- 
2.11.1

