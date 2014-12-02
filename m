Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 12/13] tools: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:37 +0100
Message-Id: <1417541318-24259-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10.
---
 tools/hid2hci.c    |  1 +
 tools/parser/lmp.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index 2dbfca7..a183bfa 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -382,6 +382,7 @@ int main(int argc, char *argv[])
 		err = hid_switch_logitech(device);
 		break;
 	}
+	case METHOD_UNDEF:
 	default:
 		break;
 	}
diff --git a/tools/parser/lmp.c b/tools/parser/lmp.c
index c303c1b..3f65ace 100644
--- a/tools/parser/lmp.c
+++ b/tools/parser/lmp.c
@@ -120,6 +120,11 @@ static inline void comb_key(struct frame *frm)
 		memcpy(pairing_data.comb_key_s, val, 16);
 		pairing_state = AU_RAND_M;
 		break;
+	case IN_RAND:
+	case AU_RAND_M:
+	case AU_RAND_S:
+	case SRES_M:
+	case SRES_S:
 	default:
 		pairing_state = IN_RAND;
 		break;
@@ -139,6 +144,11 @@ static inline void au_rand(struct frame *frm)
 		memcpy(pairing_data.au_rand_s, val, 16);
 		pairing_state = SRES_S;
 		break;
+	case COMB_KEY_M:
+	case COMB_KEY_S:
+	case IN_RAND:
+	case SRES_M:
+	case SRES_S:
 	default:
 		pairing_state = IN_RAND;
 		break;
@@ -159,6 +169,11 @@ static inline void sres(struct frame *frm)
 		pairing_state = IN_RAND;
 		pairing_data_dump();
 		break;
+	case COMB_KEY_M:
+	case COMB_KEY_S:
+	case IN_RAND:
+	case AU_RAND_M:
+	case AU_RAND_S:
 	default:
 		pairing_state = IN_RAND;
 		break;
-- 
1.9.1

