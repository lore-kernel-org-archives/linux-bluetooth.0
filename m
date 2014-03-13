Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Scott James Remnant <keybuk@chromium.org>
Cc: linux-bluetooth@vger.kernel.org,
	Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 0/3] Fix RFCOMM connect/disconn races
Date: Thu, 13 Mar 2014 12:43:03 -0400
Message-Id: <1394728986-5096-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <15A2D205-97BC-4790-A998-52AD8941DB3F@holtmann.org>
References: <15A2D205-97BC-4790-A998-52AD8941DB3F@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

This patch series fixes the observed errors when running
rctest -r on one station and rctest -c on the other.

Please note that patch 2/3 is somewhat risky in that it allows
multiple RFCOMM sessions between the same endpoints to co-exist,
provided that all but one of the sessions is closing or is closed.
I did test this, but there may be some subtlety I've overlooked.

[I note this because you may prefer the simpler and more bulletproof
solution of returning -EBUSY from __rfcomm_dlc_open() in this
situation; I can understand if you have lost patience for RFCOMM
breakage.]

This series does not address the excessive latency from sending
the DISC command to receiving the UA reply. I think a partial
solution would be to skip the rfcomm thread and run
rfcomm_process_sessions() directly from rfcomm_l2data_ready();
this would require some rework where sk->sk_data_ready() is
called directly from contexts that aren't suitable for running
rfcomm_process_sessions(). And this wouldn't address the
USB polling latency at all.

Regards,

Peter Hurley (3):
  bluetooth: rfcomm: Reply with DM after dlc disconnect
  bluetooth: rfcomm: Create new session if closing old session
  bluetooth: rfcomm: Defer session teardown after last dlc

 net/bluetooth/rfcomm/core.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

-- 
1.8.1.2
