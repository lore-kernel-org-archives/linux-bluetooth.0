Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <marcel@holtmann.org>, Andrzej Kaczmarek
	<andrzej.kaczmarek@tieto.com>
Subject: [PATCH 0/9] Connection parameters D-Bus API
Date: Tue, 27 May 2014 09:52:42 +0200
Message-ID: <1401177171-19994-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Following patches add possibility for applications to have RSSI and TX
power data for connected device. This uses recently introduced mgmt
command Get Connection Information.

There are 3 new properties for RSSI, current TX power and max TX power.
Polling for RSSI and TX power can be enabled via Start-/Stop- methods
in a manner similar to discovery on adapter. Max TX power is read once
when device is connected and obviously does not change.

As for now polling interval is set to arbitrary chosen value of 2secs,
but perhapts this could be configurable via main.conf entry.

Changes from RFC to v1:
- connection props exist only when someone requested monitoring
- rebased


Andrzej Kaczmarek (8):
  core: Add ConnectionRSSI property
  core: Add ConnectionTXPower property
  core: Add ConnectionTXPowerMax property
  core: Make connection properties exist only when connected
  core: Read max TX power when device connected
  core: Add API to start/stop connection monitoring
  core: Store list of monitored devices in adapter
  core: Poll for connection info

Lukasz Rymanowski (1):
  doc: Introduce connection monitoring API

 doc/device-api.txt |  56 +++++++++++
 src/adapter.c      | 205 ++++++++++++++++++++++++++++++++++++++++
 src/adapter.h      |   7 ++
 src/device.c       | 272 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h       |   3 +
 5 files changed, 543 insertions(+)

-- 
1.9.3
