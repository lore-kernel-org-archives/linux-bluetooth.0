Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2] DBus OutOfBand API update
Date: Fri, 27 Jul 2012 14:22:02 +0200
Message-ID: <1343391723-32072-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes in V2:
Added TK and 'SM OOB Flags' fields for BLE as suggested by Vinicius.

Some of V1 questions are still valid:
- short name vs full name distinguish
- emit DeviceDisappeared when removing oob data?
- enable OOB interface only for BLE and/or SSP capable adapters?

Comment are welcome.

-- 
BR
Szymon Janc

Szymon Janc (1):
  dbusoob: Update API

 doc/oob-api.txt |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 6 deletions(-)

-- 
1.7.9.5

