Return-Path: <cyrus@holtmann.org>
Message-ID: <4B87A10C.4070100@nokia.com>
Date: Fri, 26 Feb 2010 12:23:08 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Nick Pelly <npelly@google.com>
CC: Dave Young <hidave.darkstar@gmail.com>,
	Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Subject: Re: Kernel panic in rfcomm_run - unbalanced refcount on 	rfcomm_session
References: <35c90d961002172104q3af1ca8p850004f8b93e8af7@mail.gmail.com> 	<a8e1da1002200017t6e856c7cu1300ac5b3b3a43b@mail.gmail.com> <35c90d961002211300s25507542y9b73724881be5540@mail.gmail.com>
In-Reply-To: <35c90d961002211300s25507542y9b73724881be5540@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------090600040003040804080802"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090600040003040804080802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Pelly wrote:
> On Sat, Feb 20, 2010 at 12:17 AM, Dave Young <hidave.darkstar@gmail.com> wrote:
>> On Thu, Feb 18, 2010 at 1:04 PM, Nick Pelly <npelly@google.com> wrote:
>>> Since 2.6.32 we are seeing kernel panics like:
>>>
>>> [10651.110229] Unable to handle kernel paging request at virtual
>>> address 6b6b6b6b
>>> [10651.111968] Internal error: Oops: 5 [#1] PREEMPT
>>> [10651.113952] CPU: 0    Tainted: G        W   (2.6.32-59979-gd0c97db #1)
>>> [10651.114624] PC is at rfcomm_run+0xa04/0xdbc
>>> <...>
>>> [10651.406188] [<c031ad24>] (rfcomm_run+0xa04/0xdbc) from [<c006ce30>]
>>> (kthread+0x78/0x80)
>>> [10651.406585] [<c006ce30>] (kthread+0x78/0x80) from [<c002793c>]
>>> (kernel_thread_exit+0x0/0x8)
>>>
>>> (rfcomm_run() is all inlined so theres not much of a stack trace))

l2cap socket status might change while rfcomm is processing frames. And 
that makes rfcomm_process_rx to do double rfcomm_session_put() for 
incoming session reference. We cannot use sk_state.

Could you try with this patch if it helps to your problems also? My OPP 
problems went away with this patch.

I moved rfcomm_session_put() for incoming session to 
rfcomm_session_close in order to get more clear _hold()/_put() pairs.

-- 
Ville


--------------090600040003040804080802
Content-Type: text/x-patch;
 name="0001-Bluetooth-Drop-rfcomm-session-reference-only-once-fo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Bluetooth-Drop-rfcomm-session-reference-only-once-fo.pa";
 filename*1="tch"

>From e713b2e8ae93aa46465984237247698d18f6a671 Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Fri, 26 Feb 2010 12:21:01 +0200
Subject: [PATCH] Bluetooth: Drop rfcomm session reference only once for incoming session

Move decision to drop reference for incoming session to
rfcomm_session_close to get more clear
rfcomm_session_hold()/rfcomm_session_put() pairs.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/rfcomm/core.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 89f4a59..adccd92 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -662,6 +662,9 @@ static void rfcomm_session_close(struct rfcomm_session *s, int err)
 
 	BT_DBG("session %p state %ld err %d", s, s->state, err);
 
+	if (s->state == BT_CLOSED)
+		return;
+
 	rfcomm_session_hold(s);
 
 	s->state = BT_CLOSED;
@@ -674,6 +677,11 @@ static void rfcomm_session_close(struct rfcomm_session *s, int err)
 	}
 
 	rfcomm_session_clear_timer(s);
+
+	/* Drop reference for incoming sessions */
+	if (!s->initiator)
+		rfcomm_session_put(s);
+
 	rfcomm_session_put(s);
 }
 
@@ -1150,11 +1158,7 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 			break;
 
 		case BT_DISCONN:
-			/* When socket is closed and we are not RFCOMM
-			 * initiator rfcomm_process_rx already calls
-			 * rfcomm_session_put() */
-			if (s->sock->sk->sk_state != BT_CLOSED)
-				rfcomm_session_put(s);
+			rfcomm_session_close(s, 0);
 			break;
 		}
 	}
@@ -1185,7 +1189,6 @@ static int rfcomm_recv_dm(struct rfcomm_session *s, u8 dlci)
 		else
 			err = ECONNRESET;
 
-		s->state = BT_CLOSED;
 		rfcomm_session_close(s, err);
 	}
 	return 0;
@@ -1220,7 +1223,6 @@ static int rfcomm_recv_disc(struct rfcomm_session *s, u8 dlci)
 		else
 			err = ECONNRESET;
 
-		s->state = BT_CLOSED;
 		rfcomm_session_close(s, err);
 	}
 
@@ -1845,12 +1847,8 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
 		rfcomm_recv_frame(s, skb);
 	}
 
-	if (sk->sk_state == BT_CLOSED) {
-		if (!s->initiator)
-			rfcomm_session_put(s);
-
+	if (sk->sk_state == BT_CLOSED)
 		rfcomm_session_close(s, sk->sk_err);
-	}
 }
 
 static inline void rfcomm_accept_connection(struct rfcomm_session *s)
@@ -1904,7 +1902,6 @@ static inline void rfcomm_check_connection(struct rfcomm_session *s)
 		break;
 
 	case BT_CLOSED:
-		s->state = BT_CLOSED;
 		rfcomm_session_close(s, sk->sk_err);
 		break;
 	}
-- 
1.6.4.4


--------------090600040003040804080802--
