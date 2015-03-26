Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Handling extended headers of bnep control frames
Date: Thu, 26 Mar 2015 12:02:32 +0100
Message-Id: <1427367755-13950-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds support for handling extended headers of bnep control
frames which is mandatory. Until now extended headers for control messages was
ignored.

Patch [1/3] adds setting of err variable if control message is not understood.
Patch [2/3] adds additional ioctl for get supported bnep features. This is
needed for user space to know if handling of sending success setup response
frame should be handled by kernel or by user space.
Patch [3/3] adds support for handling extended headers of bnep control frames.

Patch set tested with PTS bnep test cases. No regression, issues found during
testing.

Grzegorz Kolodziejczyk (3):
  Bluetooth: bnep: Return err value while sending cmd is not understood
  Bluetooth: bnep: Add support for get bnep features via ioctl
  Bluetooth: bnep: Add support to extended headers of control frames

 net/bluetooth/bnep/bnep.h |  4 ++++
 net/bluetooth/bnep/core.c | 57 +++++++++++++++++++++++++++++++++++++----------
 net/bluetooth/bnep/sock.c |  8 +++++++
 3 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.1.0

