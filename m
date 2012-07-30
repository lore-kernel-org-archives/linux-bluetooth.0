Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v3] DBus OutOfBand API update
Date: Mon, 30 Jul 2012 17:32:43 +0200
Message-ID: <1343662364-9595-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

changes since V2:
- removed BLE support from API added in v2-  currently available whitepaper
 describes OOB pairing only for SSP,  API is now flexible and can be extended
  if needed
- added org.bluez.Error.NotSupported error - will be used for non-SSP adapters
- added extra comment about SSP and (no)BLE support

Szymon Janc (1):
  dbusoob: Update API

 doc/oob-api.txt |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 6 deletions(-)

-- 
1.7.9.5

