Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, <ulrik.lauren@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 0/2] Fix usage of sk_sndtimeo value in l2cap
Date: Thu, 10 Nov 2011 10:37:23 +0100
Message-ID: <1320917845-20135-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

It seems sk_sndtimeo is initialized incorrectly in l2cap_sock.c to
miliseconds, this will cause invalid value to be set or read using
SO_SNDTIMEO sockopt since it is assumed this value is specified in
jiffies.

Initial value of sk_sndtimeo was changed in 6be6b11f006840ba7d8d4b
and I belive this was because of regression introduced by commit
942ecc9c4643db5ce071562e0a23f99464d6b461.

My two patches revert mentioned commit and solve issue in proper way.
Regression introduced by 942ecc9c4643db5ce071562e0a23f99464d6b461 is
already fixed by other commit.


Andrzej Kaczmarek (2):
  Buetooth: Revert "Fixed wrong L2CAP Sock timer value"
  Bluetooth: Fix usage of sk_sndtimeo value

 net/bluetooth/l2cap_core.c |    8 ++++----
 net/bluetooth/l2cap_sock.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
on behalf of ST-Ericsson

