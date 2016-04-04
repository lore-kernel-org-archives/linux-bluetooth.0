Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC v2] DeviceLE1 and DeviceBR1 interface
Date: Mon,  4 Apr 2016 03:22:03 +0200
Message-Id: <1459732924-26643-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

New proposal with new names: DeviceLE1 and DeviceBR1.
I've also updated interfaces to cover ServicesResolved property.

>From original cover letter:

Current Device1 interface doesn't handle dualmode devices very well and
doesn't provide information if remote supports LE, BR/EDR or both.
There is a problem with bond information, connected transport, supported
technologies etc.

Instead of duplicating properties which would require LE, BR/EDR and
(as currently) mixed variants I propose having two separates interfaces
DeviceSmart1 and DeviceClassic1 which would represent supported transports.

Thanks to this applications can easily track if remote device is LE or not
which is important eg with discovery where different apps can do different
type of discovery or when it want to use profile only over specific
transport.

Eventually those new interfaces would deprecate Device1 interface.

Comments are welcome.

Szymon Janc (1):
  doc: Add DeviceBR1 and DeviceLE1 interfaces

 doc/device-br-api.txt | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/device-le-api.txt | 161 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 361 insertions(+)
 create mode 100644 doc/device-br-api.txt
 create mode 100644 doc/device-le-api.txt

-- 
2.6.2

