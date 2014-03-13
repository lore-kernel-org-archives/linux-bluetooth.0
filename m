Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Scott James Remnant <keybuk@chromium.org>
Cc: linux-bluetooth@vger.kernel.org,
	Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 2/3] bluetooth: rfcomm: Create new session if closing old session
Date: Thu, 13 Mar 2014 12:43:05 -0400
Message-Id: <1394728986-5096-3-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1394728986-5096-1-git-send-email-peter@hurleysoftware.com>
References: <15A2D205-97BC-4790-A998-52AD8941DB3F@holtmann.org>
 <1394728986-5096-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the rfcomm session has already sent DISC (thus in BT_DISCONN
state), allow dlc opens to create a new session instead of trying
to open a dlc in a closing session (and instead of returning an
error).

Allow multiple rfcomm sessions with the same endpoints as long as
the existing sessions are either in BT_DISCONN or BT_CLOSED states.

Fixes multi-second delays when running rctest -c on one station
and rctest -r on the other.

Reported-by: Scott James Remnant <keybuk@chromium.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/rfcomm/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 6aa90c0..292322c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -695,6 +695,9 @@ static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
 		s = list_entry(p, struct rfcomm_session, list);
 		chan = l2cap_pi(s->sock->sk)->chan;
 
+		if (s->state == BT_DISCONN || s->state == BT_CLOSED)
+			continue;
+
 		if ((!bacmp(src, BDADDR_ANY) || !bacmp(&chan->src, src)) &&
 		    !bacmp(&chan->dst, dst))
 			return s;
-- 
1.8.1.2

