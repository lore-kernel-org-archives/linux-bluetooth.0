Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC] DeviceClassic1 and DeviceSmart1 interfaces
Date: Fri,  4 Mar 2016 16:53:00 +0100
Message-Id: <1457106781-8566-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

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
  doc: Add DeviceClassic1 and DeviceSmart1 interfaces

 doc/device-classic-api.txt | 203 +++++++++++++++++++++++++++++++++++++++++++++
 doc/device-smart-api.txt   | 164 ++++++++++++++++++++++++++++++++++++
 2 files changed, 367 insertions(+)
 create mode 100644 doc/device-classic-api.txt
 create mode 100644 doc/device-smart-api.txt

-- 
2.6.2

