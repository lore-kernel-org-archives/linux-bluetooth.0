Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/13] shared: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:34 +0100
Message-Id: <1417541318-24259-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10.
---
 src/shared/att.c          | 15 +++++++++++++++
 src/shared/gatt-helpers.c |  1 +
 src/shared/gatt-server.c  |  1 +
 src/shared/hfp.c          |  9 +++++++++
 src/shared/io-glib.c      |  3 +++
 5 files changed, 29 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index bc01827..ee425d8 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -488,6 +488,12 @@ static bool can_write_data(struct io *io, void *user_data)
 	case ATT_OP_TYPE_RSP:
 		/* Set in_req to false to indicate that no request is pending */
 		att->in_req = false;
+
+		/* Fall through to the next case */
+	case ATT_OP_TYPE_CMD:
+	case ATT_OP_TYPE_NOT:
+	case ATT_OP_TYPE_CONF:
+	case ATT_OP_TYPE_UNKNOWN:
 	default:
 		destroy_att_send_op(op);
 		return true;
@@ -784,6 +790,10 @@ static bool can_read_data(struct io *io, void *user_data)
 		att->in_req = true;
 
 		/* Fall through to the next case */
+	case ATT_OP_TYPE_CMD:
+	case ATT_OP_TYPE_NOT:
+	case ATT_OP_TYPE_UNKNOWN:
+	case ATT_OP_TYPE_IND:
 	default:
 		/* For all other opcodes notify the upper layer of the PDU and
 		 * let them act on it.
@@ -1067,6 +1077,11 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	case ATT_OP_TYPE_IND:
 		result = queue_push_tail(att->ind_queue, op);
 		break;
+	case ATT_OP_TYPE_CMD:
+	case ATT_OP_TYPE_NOT:
+	case ATT_OP_TYPE_UNKNOWN:
+	case ATT_OP_TYPE_RSP:
+	case ATT_OP_TYPE_CONF:
 	default:
 		result = queue_push_tail(att->write_queue, op);
 		break;
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index dc4a8e8..c6e179c 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -581,6 +581,7 @@ static void put_uuid_le(const bt_uuid_t *src, void *dst)
 		bt_uuid_to_uuid128(src, &uuid);
 		bswap_128(&uuid.value.u128, dst);
 		break;
+	case BT_UUID_UNSPEC:
 	default:
 		break;
 	}
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index ef91289..5eb2e4f 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -512,6 +512,7 @@ static void put_uuid_le(const bt_uuid_t *src, void *dst)
 		bt_uuid_to_uuid128(src, &uuid);
 		bswap_128(&uuid.value.u128, dst);
 		break;
+	case BT_UUID_UNSPEC:
 	default:
 		break;
 	}
diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 5a91d12..0a5a57e 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -738,6 +738,15 @@ bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
 	case HFP_RESULT_ERROR:
 		str = "ERROR";
 		break;
+	case HFP_RESULT_RING:
+	case HFP_RESULT_NO_CARRIER:
+	case HFP_RESULT_BUSY:
+	case HFP_RESULT_NO_ANSWER:
+	case HFP_RESULT_DELAYED:
+	case HFP_RESULT_BLACKLISTED:
+	case HFP_RESULT_CME_ERROR:
+	case HFP_RESULT_NO_DIALTONE:
+	case HFP_RESULT_CONNECT:
 	default:
 		return false;
 	}
diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index e9578e1..6687a6b 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -220,6 +220,9 @@ static bool io_set_handler(struct io *io, GIOCondition cond,
 	case G_IO_HUP:
 		watch = &io->disconnect_watch;
 		break;
+	case G_IO_PRI:
+	case G_IO_ERR:
+	case G_IO_NVAL:
 	default:
 		return false;
 	}
-- 
1.9.1

