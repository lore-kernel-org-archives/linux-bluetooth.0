Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/5] Some ERTM improvements
Date: Wed, 11 Jan 2012 10:59:44 +0100
Message-ID: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No code changes since v1.
Only improved commits messages as requested by Marcel.

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

