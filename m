Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 0/7] Generic GATT API changes
Date: Mon, 23 Jul 2012 11:55:13 -0400
Message-Id: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This series contains the latest updates to the Generic GATT API planned for
the next major BlueZ release. It was based on the discussions on the last BlueZ
meeting, plus a few tweaks to the signature of some methods. For instance, the
Register() method of the Service interface contains an optional "id" setting,
which could allow to load the correct storage for registered GATT services when
BlueZ daemon is restarted.

While reviewing these patches, please keep in mind that the plan is to allow to
use the same API (or, more likely, a subset) when implementing external GATT
services. This avoids creating another "asymmetric" API just for service
registration. This approach has been already successfully adopted by other
(audio related?) profiles in BlueZ.

Comments and suggestions are welcome.

Anderson Lizardo (6):
  attrib-api: Remove local service hierarchy
  attrib-api: Update introduction text
  attrib-api: Remove GATT service hierarchy
  attrib-api: Update Characteristic interface
  attrib-api: Update Watcher interface methods
  attrib-api: Add RegisterWatcher/UnregisterWatcher methods

Claudio Takahasi (1):
  doc: Add Register/Unregister GATT based services

 doc/attribute-api.txt |  195 ++++++++++++++++++++-----------------------------
 doc/service-api.txt   |   54 ++++++++++++++
 2 files changed, 134 insertions(+), 115 deletions(-)

-- 
1.7.9.5

