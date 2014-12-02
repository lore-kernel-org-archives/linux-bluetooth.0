Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/4] android/handsfree: Add default case to all the switches
Date: Tue,  2 Dec 2014 11:59:37 +0100
Message-Id: <1417517979-18136-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417517979-18136-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417517979-18136-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Minor fix, each switch should have default case.
---
 android/handsfree.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index f5576a2..45826d9 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -371,6 +371,7 @@ static void at_cmd_vgm(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -407,6 +408,7 @@ static void at_cmd_vgs(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -441,6 +443,7 @@ static void at_cmd_cops(struct hfp_context *context,
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -486,6 +489,7 @@ static void at_cmd_bia(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -517,6 +521,7 @@ static void at_cmd_a(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_SET:
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
+	default:
 		break;
 	}
 
@@ -563,6 +568,7 @@ static void at_cmd_d(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -592,6 +598,7 @@ static void at_cmd_ccwa(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -622,6 +629,7 @@ static void at_cmd_chup(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_SET:
+	default:
 		break;
 	}
 
@@ -649,6 +657,7 @@ static void at_cmd_clcc(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_SET:
+	default:
 		break;
 	}
 
@@ -678,6 +687,7 @@ static void at_cmd_cmee(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -707,6 +717,7 @@ static void at_cmd_clip(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -747,6 +758,7 @@ static void at_cmd_vts(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -774,6 +786,7 @@ static void at_cmd_cnum(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_SET:
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
+	default:
 		break;
 	}
 
@@ -814,6 +827,7 @@ static void at_cmd_bldn(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_SET:
+	default:
 		break;
 	}
 
@@ -850,6 +864,7 @@ static void at_cmd_bvra(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -890,6 +905,7 @@ static void at_cmd_nrec(struct hfp_context *context,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -1087,6 +1103,7 @@ static void at_cmd_bcc(struct hfp_context *result, enum hfp_gw_cmd_type type,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_SET:
+	default:
 		break;
 	}
 
@@ -1130,6 +1147,7 @@ static void at_cmd_bcs(struct hfp_context *result, enum hfp_gw_cmd_type type,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -1164,6 +1182,7 @@ static void at_cmd_ckpd(struct hfp_context *result, enum hfp_gw_cmd_type type,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -1242,6 +1261,7 @@ static void at_cmd_cmer(struct hfp_context *result, enum hfp_gw_cmd_type type,
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -1306,6 +1326,7 @@ static void at_cmd_cind(struct hfp_context *result, enum hfp_gw_cmd_type type,
 		return;
 	case HFP_GW_CMD_TYPE_SET:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -1338,6 +1359,7 @@ static void at_cmd_brsf(struct hfp_context *result, enum hfp_gw_cmd_type type,
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -1381,6 +1403,7 @@ static void at_cmd_chld(struct hfp_context *result, enum hfp_gw_cmd_type type,
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
@@ -1456,6 +1479,7 @@ static void at_cmd_bac(struct hfp_context *result, enum hfp_gw_cmd_type type,
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_COMMAND:
+	default:
 		break;
 	}
 
-- 
1.8.4

