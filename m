Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 3/9] Bluetooth: Get/set AMP policy socket option
Date: Thu, 13 Oct 2011 15:00:41 -0700
Message-Id: <1318543247-27130-4-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Checks for valid policy value and L2CAP mode.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_sock.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 836d12e..9431e38 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -467,6 +467,11 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 		break;
 
+	case BT_AMP_POLICY:
+		if (put_user(chan->amp_policy, (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -690,6 +695,26 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 			clear_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 		break;
 
+	case BT_AMP_POLICY:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opt > BT_AMP_POLICY_PREFER_BR_EDR) {
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
+		chan->amp_policy = (u8) opt;
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

