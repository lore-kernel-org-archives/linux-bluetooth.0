Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/3] android: Improve of handling stop discovery
Date: Mon, 10 Mar 2014 00:06:34 +0100
Message-ID: <1394406397-6843-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches improves handling of stop discovery in scenario of
big inflow of device found events.

v2:
* Fix confirm name callback

Lukasz Rymanowski (3):
  android: Add tracking for pending confirm name command
  android: Cancel all pending confirm name before stop discovery
  android: Send confirm name request with mgmt_send

 android/bluetooth.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

-- 
1.8.4

