Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 0/3] Fix GATT server issues with BlueZ as LE peripheral
Date: Tue, 28 Jan 2014 11:51:35 -0400
Message-Id: <1390924298-13804-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Currently, we do not officially support running BlueZ as LE peripheral. But
there is already enough support from the kernel to support this. For instance,
there is the "Set Advertising" mgmt command to keep LE advertising enabled
after each connection.

The current tracking of connections in BlueZ does not fully work for peripheral
role. These patches are a first attempt to improve the situation. Other fixes
are necessary to have full LE Peripheral support.

In particular, with these patches, notifications for PASP and ANP profiles
(implemented in profiles/alert/*) should work when BlueZ is on the peripheral
role. Other GATT server profiles will need fixing as well.

I'm sending as RFC because I only did minimal testing. I hope that people
having issues with GATT server profiles running on peripheral role can tests
these patches. Otherwise, I'll do more tests later today and send a final
version by tomorrow.

Notes: 
* The first patch is just cleanup, so can be applied as is.
* For testing, make sure to enable advertising on the machine running as
  peripheral (I use btmgmt tool for this).

Best Regards,
Anderson Lizardo

Anderson Lizardo (3):
  attrib-server: Remove unnecessary fields from struct gatt_channel
  core: Fix associating a GAttrib to a device on incoming connections
  alert: Only remove attio callback after ATT request was sent

 profiles/alert/server.c | 18 +++++++++++++++++-
 src/attrib-server.c     | 45 +++++++++++++++++++++++++++++----------------
 src/attrib-server.h     |  1 +
 src/device.c            |  5 +++++
 4 files changed, 52 insertions(+), 17 deletions(-)

-- 
1.8.3.2

