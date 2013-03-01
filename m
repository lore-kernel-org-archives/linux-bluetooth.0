Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 00/10] Service Discovery/GATT cleanup
Date: Fri,  1 Mar 2013 20:22:23 -0300
Message-Id: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I know that this series is somewhat disorganized, but I am sending it
in its current form to get some input if the problems that it tries to
solve are really problems.

And suggestions about how to better organize it are very welcome.

This series started with the aim to solve the crashes that were
happening when a GATT Service Discovery was interrupted (device going
out of range, misbehaved device, etc). Those crashes were solved for
all the cases that I could test.

And it caused me to take a critical look at how Service Discovery
(including SDP) is done inside bluetoothd. It seems the code tries to
solve a few problems that aren't applicable anymore, one example is
PATCH 10/10. Can anyone remember anything else that can be trimmed?

Cheers,


Vinicius Costa Gomes (10):
  device: Clean up the ATT Connection attempt when it is cancelled
  device: Separate SDP browse from GATT discover primary services
  device: Fix removing profiles
  device: Remove misleading function
  device: Use only one entry point for LE connections
  gatt: Handle errors when g_attrib_send() in gatt_discover_primary()
  gatt: Track the lifetime of Primary Discovery requests
  gatt: Better lifetime tracking for Find Included services
  gatt: Add lifetime tracking for Discover Characteristics requests
  device: Remove detection of removed services during SDP browse

 attrib/gatt.c | 234 ++++++++++++++++++++-----------
 src/device.c  | 434 +++++++++++++++++++++++++---------------------------------
 2 files changed, 342 insertions(+), 326 deletions(-)

-- 
1.8.1.3

