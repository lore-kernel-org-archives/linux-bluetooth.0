Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv2 3/9] Bluetooth: Add channel policy to getsockopt/setsockopt
Date: Wed, 19 Oct 2011 10:44:01 -0700
Message-Id: <1319046247-3391-4-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Each channel has a policy to require BR/EDR (the default),
prefer BR/EDR, or prefer AMP.

Check for valid policy value and L2CAP mode.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_sock.c    |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fd090db..b0c9345 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -366,6 +366,7 @@ struct l2cap_chan {
 	__u16		flush_to;
 	__u8		mode;
 	__u8		chan_type;
+	__u8		chan_policy;
 
 	__le16		sport;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 836d12e..1230e6e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -467,6 +467,16 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 		break;
 
+	case BT_CHANNEL_POLICY:
+		if (!enable_hs) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		if (put_user(chan->chan_policy, (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -690,6 +700,31 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 			clear_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 		break;
 
+	case BT_CHANNEL_POLICY:
+		if (!enable_hs) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opt > BT_CHANNEL_POLICY_AMP_PREFERRED) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (chan->mode != L2CAP_MODE_ERTM &&
+			 chan->mode != L2CAP_MODE_STREAMING) {
+			err = -EINVAL;
+			break;
+		}
+
+		chan->chan_policy = (u8) opt;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.7.7

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

