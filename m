Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/5] ERTM improvements
Date: Mon, 9 Jan 2012 16:19:46 +0100
Message-ID: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Those patches introduce some improvements to ERTM related to avoiding
acking I-frames more than once.

Following PTS test-cases were affected:
TC_ERM_BV_07_C
TC_ERM_BV_22_C

Szymon Janc (5):
  Bluetooth: Make l2cap_clear_timer return if timer was running or not
  Bluetooth: Set P-bit for SREJ frame only if there are I-frames to ack
  Bluetooth: Clear ack_timer when sending ack
  Bluetooth: Don't send RNR immediately when entering local busy
  Bluetooth: Drop L2CAP chan reference if ERTM ack_timer fired

 include/net/bluetooth/l2cap.h |    9 +++++++--
 net/bluetooth/l2cap_core.c    |   33 ++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 17 deletions(-)

-- 
on behalf of ST-Ericsson

