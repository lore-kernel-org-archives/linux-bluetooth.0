Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 00/10] GATT plugin: Service Changed and MTU exchange
Date: Mon, 20 Aug 2012 14:22:45 -0300
Message-Id: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series implements Service Changed attribute of the remote
Generic Attribute Profile Service, and the MTU exchange sub-procedure.

Service Changed characteristic is used to indicate to connected devices
that services have changed (i.e., added, removed or modified).

The MTU exchange sub-procedure is used by the client to set the ATT_MTU
to the maximum possible value that can be supported by both devices when
the client supports a value greater than the default ATT_MTU for the
Attribute Protocol. BlueZ host will always start this sub-procedure when
the ATT channel is established.

Claudio Takahasi (10):
  gatt: Add Service Changed read
  gatt: Add Service Changed CCC discovery
  gatt: Enable indication for Service Changed
  gatt: Confirm the indication received
  gatt: Start Discover Services when handle changes
  core: Rename update_services
  core: Add updating GATT services
  gatt: Primary service interval may not change
  core: Rename services_changed to uuids_changed
  gatt: Add MTU exchange procedure

 attrib/gatt.h       |    1 +
 profiles/gatt/gas.c |  214 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.c        |  101 +++++++++++++++++++------
 src/device.h        |    2 +
 4 files changed, 295 insertions(+), 23 deletions(-)

-- 
1.7.8.6

