Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC v2] Cycling Speed and Cadence profile (CSCP) API
Date: Tue, 25 Sep 2012 17:07:26 +0200
Message-ID: <1348585647-25458-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes since v1:
- minor fixes in descriptions (some pointed out by Anderson Lizardo)
- changed base name for interfaces to org.bluez.CyclingSpeed
  previous name was org.bluez.Cycling
  other option is e.g. org.bluez.CyclingSc
  still need to figure out which is the best

Comments are welcome.



Andrzej Kaczmarek (1):
  Cycling Speed and Cadence profile (CSCP) API

 doc/cycling-api.txt | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 doc/cycling-api.txt

-- 
1.7.11.3

