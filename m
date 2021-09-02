Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6593C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D8560EE6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhIBEIq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhIBEIi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:08:38 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02409C061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:07:40 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r3-20020a0cc403000000b00377a3318261so580096qvi.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1mM4fV/PxTjsjhYpIn5XCfcA+Zf+3ZIJ9u4uTgbrHoE=;
        b=Hy9teKHrGQlolAks4wQAhqX5Dzo7G/1srTlbBEThCDxxNURYbHTQf44hAM0CCo5X49
         kX+15dku/kbVsugfgCyAIK/SoG7yBktLJku/HbB2a70L5tJYVD5bsFbB4CfBAV64WYcw
         hPL1xveDPrfK9/0E6UaZ/sEmHCL9qDPeA9uXmjx29MjfCSn301CVW3p3tpmCGQcpCsrp
         cfgMuMDrKrjUa87V1KZC0gmX270MlAfxpBa/fCaCmyvvj34pY6ggskgvqr6i1ZBs61I7
         rd+e+2mboCi5GebQrLJ1lBi5R9BqAwKrz3lBlhJ306a4gGep4halcvnmgYvLWCcwq0ak
         11/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1mM4fV/PxTjsjhYpIn5XCfcA+Zf+3ZIJ9u4uTgbrHoE=;
        b=RRa8K1MRaQ0oD8DfI0RWhDXkhgoEItfTDQcLNCkzkiMNnE0zHpjJgOdzLNxFCVnOrD
         P25UHGmjJQje+eeSvgeCtoy5LSd3BjVPNmxg4+QjmWkHypVg6T/k77B/CnYdzomJzkVb
         gP80pK0MQhmgMMwiynT5LcMlIWVMwF0Vw5a4tf4gcQTK5yU+13cEDW3RyH9qqBwI9E12
         s7xo6CRSfuD2XdvXfgSMdDEVdohpXgAxmWto41HLfJosXLX6Gt02292vynCOqp5sBXRg
         d/9jRT9sEDPYxgSqmJ9atQ7sfTgg1GVOi3n5DN9v92f5RPGuUeouHtlrmLHzaEQl/waC
         8yhA==
X-Gm-Message-State: AOAM531l9jrGlYNEH0yCJdUcFjDtgxJQMRjMgPoxDbk716OjfXRjL6Og
        N2fRY+PUuhU4CuqAd6+PX6U1fiP+e9KK0wO8wqlbDckoFtXA/7M/GojapQf02Y4tt1Qop8lNkgZ
        xTiu+6Qm5wkEgEDN2o3SJjM/FH9i+8adGWIGHjpLa95OiB0OfVebT523rhEa/EEj6DS/mVpb9bK
        xV
X-Google-Smtp-Source: ABdhPJwofq1xBOuDPBWfW4c9n4+1ydiUnAvXja2IKBW/mVnzix8ger9Rvt9V9ytLNaZGzPy0qNjzHvYaNRmk
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a05:6214:104e:: with SMTP id
 l14mr1020034qvr.45.1630555659103; Wed, 01 Sep 2021 21:07:39 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:06:59 +0800
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
Message-Id: <20210902120509.Bluez.v2.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
Mime-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 01/13] lib: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

BT core spec 5.3 promotes the usage of inclusive languages.
This CL replaces some terms with the more appropriate counterparts,
such as "central", "peripheral", and "accept list".
---

Changes in v2:
* Merging several patches from the same directory into one

 android/bluetooth.c    |  4 ++--
 btio/btio.c            | 20 ++++++++--------
 lib/hci.c              | 52 +++++++++++++++++++++---------------------
 lib/hci.h              | 44 +++++++++++++++++------------------
 lib/hci_lib.h          |  8 +++----
 lib/l2cap.h            |  2 +-
 lib/mgmt.h             |  2 +-
 lib/rfcomm.h           |  2 +-
 monitor/control.c      |  4 ++--
 profiles/health/mcap.c |  2 +-
 src/adapter.c          |  4 ++--
 src/sdpd-server.c      |  2 +-
 tools/hcitool.c        |  8 +++----
 tools/l2test.c         |  4 ++--
 tools/oobtest.c        |  4 ++--
 tools/parser/hci.c     | 14 ++++++------
 tools/rctest.c         |  4 ++--
 tools/rfcomm.c         |  2 +-
 18 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index c3ad503497..fe956b5d43 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2276,7 +2276,7 @@ static void new_long_term_key_event(uint16_t index, uint16_t length,
 		ediv = le16_to_cpu(key->ediv);
 		rand = le64_to_cpu(key->rand);
 
-		store_ltk(&key->addr.bdaddr, key->addr.type, key->master,
+		store_ltk(&key->addr.bdaddr, key->addr.type, key->central,
 				key->val, key->type, key->enc_size, ediv, rand);
 	}
 
@@ -3097,7 +3097,7 @@ static struct mgmt_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
 	info->ediv = g_key_file_get_integer(key_file, peer, ediv_s, NULL);
 	info->ediv = cpu_to_le16(info->ediv);
 
-	info->master = master;
+	info->central = master;
 
 failed:
 	g_free(key);
diff --git a/btio/btio.c b/btio/btio.c
index 1f1c374bca..ce958bdd09 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -369,13 +369,13 @@ static int l2cap_set_master(int sock, int master)
 		return -errno;
 
 	if (master) {
-		if (flags & L2CAP_LM_MASTER)
+		if (flags & L2CAP_LM_CENTRAL)
 			return 0;
-		flags |= L2CAP_LM_MASTER;
+		flags |= L2CAP_LM_CENTRAL;
 	} else {
-		if (!(flags & L2CAP_LM_MASTER))
+		if (!(flags & L2CAP_LM_CENTRAL))
 			return 0;
-		flags &= ~L2CAP_LM_MASTER;
+		flags &= ~L2CAP_LM_CENTRAL;
 	}
 
 	if (setsockopt(sock, SOL_L2CAP, L2CAP_LM, &flags, sizeof(flags)) < 0)
@@ -394,13 +394,13 @@ static int rfcomm_set_master(int sock, int master)
 		return -errno;
 
 	if (master) {
-		if (flags & RFCOMM_LM_MASTER)
+		if (flags & RFCOMM_LM_CENTRAL)
 			return 0;
-		flags |= RFCOMM_LM_MASTER;
+		flags |= RFCOMM_LM_CENTRAL;
 	} else {
-		if (!(flags & RFCOMM_LM_MASTER))
+		if (!(flags & RFCOMM_LM_CENTRAL))
 			return 0;
-		flags &= ~RFCOMM_LM_MASTER;
+		flags &= ~RFCOMM_LM_CENTRAL;
 	}
 
 	if (setsockopt(sock, SOL_RFCOMM, RFCOMM_LM, &flags, sizeof(flags)) < 0)
@@ -1180,7 +1180,7 @@ parse_opts:
 				return FALSE;
 			}
 			*(va_arg(args, gboolean *)) =
-				(flags & L2CAP_LM_MASTER) ? TRUE : FALSE;
+				(flags & L2CAP_LM_CENTRAL) ? TRUE : FALSE;
 			break;
 		case BT_IO_OPT_HANDLE:
 			if (l2cap_get_info(sock, &handle, dev_class) < 0) {
@@ -1345,7 +1345,7 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 				return FALSE;
 			}
 			*(va_arg(args, gboolean *)) =
-				(flags & RFCOMM_LM_MASTER) ? TRUE : FALSE;
+				(flags & RFCOMM_LM_CENTRAL) ? TRUE : FALSE;
 			break;
 		case BT_IO_OPT_HANDLE:
 			if (rfcomm_get_info(sock, &handle, dev_class) < 0) {
diff --git a/lib/hci.c b/lib/hci.c
index 53af0a1148..d2753a934d 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -288,7 +288,7 @@ int hci_strtolp(char *str, unsigned int *val)
 static hci_map link_mode_map[] = {
 	{ "NONE",	0		},
 	{ "ACCEPT",	HCI_LM_ACCEPT	},
-	{ "MASTER",	HCI_LM_MASTER	},
+	{ "CENTRAL",	HCI_LM_CENTRAL	},
 	{ "AUTH",	HCI_LM_AUTH	},
 	{ "ENCRYPT",	HCI_LM_ENCRYPT	},
 	{ "TRUSTED",	HCI_LM_TRUSTED	},
@@ -304,8 +304,8 @@ char *hci_lmtostr(unsigned int lm)
 		return NULL;
 
 	*str = 0;
-	if (!(lm & HCI_LM_MASTER))
-		strcpy(str, "SLAVE ");
+	if (!(lm & HCI_LM_CENTRAL))
+		strcpy(str, "PERIPHERAL ");
 
 	s = hci_bit2str(link_mode_map, lm);
 	if (!s) {
@@ -345,7 +345,7 @@ static hci_map commands_map[] = {
 
 	{ "Set Connection Encryption",			16  },
 	{ "Change Connection Link Key",			17  },
-	{ "Master Link Key",				18  },
+	{ "Temporary Link Key",				18  },
 	{ "Remote Name Request",			19  },
 	{ "Cancel Remote Name Request",			20  },
 	{ "Read Remote Supported Features",		21  },
@@ -565,11 +565,11 @@ static hci_map commands_map[] = {
 	{ "LE Set Scan Enable",				211 },
 	{ "LE Create Connection",			212 },
 	{ "LE Create Connection Cancel",		213 },
-	{ "LE Read White List Size",			214 },
-	{ "LE Clear White List",			215 },
+	{ "LE Read Accept List Size",			214 },
+	{ "LE Clear Accept List",			215 },
 
-	{ "LE Add Device To White List",		216 },
-	{ "LE Remove Device From White List",		217 },
+	{ "LE Add Device To Accept List",		216 },
+	{ "LE Remove Device From Accept List",		217 },
 	{ "LE Connection Update",			218 },
 	{ "LE Set Host Channel Classification",		219 },
 	{ "LE Read Channel Map",			220 },
@@ -735,8 +735,8 @@ static hci_map lmp_features_map[8][9] = {
 		{ "<EV4 packets>",	LMP_EV4		},	/* Bit 0 */
 		{ "<EV5 packets>",	LMP_EV5		},	/* Bit 1 */
 		{ "<no. 34>",		0x04		},	/* Bit 2 */
-		{ "<AFH cap. slave>",	LMP_AFH_CAP_SLV	},	/* Bit 3 */
-		{ "<AFH class. slave>",	LMP_AFH_CLS_SLV	},	/* Bit 4 */
+		{ "<AFH cap. perip.>",	LMP_AFH_CAP_PRP	},	/* Bit 3 */
+		{ "<AFH class. perip.>",LMP_AFH_CLS_PRP	},	/* Bit 4 */
 		{ "<BR/EDR not supp.>",	LMP_NO_BREDR	},	/* Bit 5 */
 		{ "<LE support>",	LMP_LE		},	/* Bit 6 */
 		{ "<3-slot EDR ACL>",	LMP_EDR_3SLOT	},	/* Bit 7 */
@@ -746,8 +746,8 @@ static hci_map lmp_features_map[8][9] = {
 		{ "<5-slot EDR ACL>",	LMP_EDR_5SLOT	},	/* Bit 0 */
 		{ "<sniff subrating>",	LMP_SNIFF_SUBR	},	/* Bit 1 */
 		{ "<pause encryption>",	LMP_PAUSE_ENC	},	/* Bit 2 */
-		{ "<AFH cap. master>",	LMP_AFH_CAP_MST	},	/* Bit 3 */
-		{ "<AFH class. master>",LMP_AFH_CLS_MST	},	/* Bit 4 */
+		{ "<AFH cap. central>",	LMP_AFH_CAP_CEN	},	/* Bit 3 */
+		{ "<AFH class. cent.>",	LMP_AFH_CLS_CEN	},	/* Bit 4 */
 		{ "<EDR eSCO 2 Mbps>",	LMP_EDR_ESCO_2M	},	/* Bit 5 */
 		{ "<EDR eSCO 3 Mbps>",	LMP_EDR_ESCO_3M	},	/* Bit 6 */
 		{ "<3-slot EDR eSCO>",	LMP_EDR_3S_ESCO	},	/* Bit 7 */
@@ -1322,10 +1322,10 @@ int hci_disconnect(int dd, uint16_t handle, uint8_t reason, int to)
 	return 0;
 }
 
-int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
+int hci_le_add_accept_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 {
 	struct hci_request rq;
-	le_add_device_to_white_list_cp cp;
+	le_add_device_to_accept_list_cp cp;
 	uint8_t status;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1334,9 +1334,9 @@ int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf = OGF_LE_CTL;
-	rq.ocf = OCF_LE_ADD_DEVICE_TO_WHITE_LIST;
+	rq.ocf = OCF_LE_ADD_DEVICE_TO_ACCEPT_LIST;
 	rq.cparam = &cp;
-	rq.clen = LE_ADD_DEVICE_TO_WHITE_LIST_CP_SIZE;
+	rq.clen = LE_ADD_DEVICE_TO_ACCEPT_LIST_CP_SIZE;
 	rq.rparam = &status;
 	rq.rlen = 1;
 
@@ -1351,10 +1351,10 @@ int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 	return 0;
 }
 
-int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
+int hci_le_rm_accept_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 {
 	struct hci_request rq;
-	le_remove_device_from_white_list_cp cp;
+	le_remove_device_from_accept_list_cp cp;
 	uint8_t status;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1363,9 +1363,9 @@ int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf = OGF_LE_CTL;
-	rq.ocf = OCF_LE_REMOVE_DEVICE_FROM_WHITE_LIST;
+	rq.ocf = OCF_LE_REMOVE_DEVICE_FROM_ACCEPT_LIST;
 	rq.cparam = &cp;
-	rq.clen = LE_REMOVE_DEVICE_FROM_WHITE_LIST_CP_SIZE;
+	rq.clen = LE_REMOVE_DEVICE_FROM_ACCEPT_LIST_CP_SIZE;
 	rq.rparam = &status;
 	rq.rlen = 1;
 
@@ -1380,18 +1380,18 @@ int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to)
 	return 0;
 }
 
-int hci_le_read_white_list_size(int dd, uint8_t *size, int to)
+int hci_le_read_accept_list_size(int dd, uint8_t *size, int to)
 {
 	struct hci_request rq;
-	le_read_white_list_size_rp rp;
+	le_read_accept_list_size_rp rp;
 
 	memset(&rp, 0, sizeof(rp));
 	memset(&rq, 0, sizeof(rq));
 
 	rq.ogf = OGF_LE_CTL;
-	rq.ocf = OCF_LE_READ_WHITE_LIST_SIZE;
+	rq.ocf = OCF_LE_READ_ACCEPT_LIST_SIZE;
 	rq.rparam = &rp;
-	rq.rlen = LE_READ_WHITE_LIST_SIZE_RP_SIZE;
+	rq.rlen = LE_READ_ACCEPT_LIST_SIZE_RP_SIZE;
 
 	if (hci_send_req(dd, &rq, to) < 0)
 		return -1;
@@ -1407,14 +1407,14 @@ int hci_le_read_white_list_size(int dd, uint8_t *size, int to)
 	return 0;
 }
 
-int hci_le_clear_white_list(int dd, int to)
+int hci_le_clear_accept_list(int dd, int to)
 {
 	struct hci_request rq;
 	uint8_t status;
 
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf = OGF_LE_CTL;
-	rq.ocf = OCF_LE_CLEAR_WHITE_LIST;
+	rq.ocf = OCF_LE_CLEAR_ACCEPT_LIST;
 	rq.rparam = &status;
 	rq.rlen = 1;
 
diff --git a/lib/hci.h b/lib/hci.h
index 3382b87bf3..e31685b644 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -241,8 +241,8 @@ enum {
 
 #define LMP_EV4		0x01
 #define LMP_EV5		0x02
-#define LMP_AFH_CAP_SLV	0x08
-#define LMP_AFH_CLS_SLV	0x10
+#define LMP_AFH_CAP_PRP	0x08
+#define LMP_AFH_CLS_PRP	0x10
 #define LMP_NO_BREDR	0x20
 #define LMP_LE		0x40
 #define LMP_EDR_3SLOT	0x80
@@ -250,8 +250,8 @@ enum {
 #define LMP_EDR_5SLOT	0x01
 #define LMP_SNIFF_SUBR	0x02
 #define LMP_PAUSE_ENC	0x04
-#define LMP_AFH_CAP_MST	0x08
-#define LMP_AFH_CLS_MST	0x10
+#define LMP_AFH_CAP_CEN	0x08
+#define LMP_AFH_CLS_CEN	0x10
 #define LMP_EDR_ESCO_2M	0x20
 #define LMP_EDR_ESCO_3M	0x40
 #define LMP_EDR_3S_ESCO	0x80
@@ -281,7 +281,7 @@ enum {
 
 /* Link mode */
 #define HCI_LM_ACCEPT	0x8000
-#define HCI_LM_MASTER	0x0001
+#define HCI_LM_CENTRAL	0x0001
 #define HCI_LM_AUTH	0x0002
 #define HCI_LM_ENCRYPT	0x0004
 #define HCI_LM_TRUSTED	0x0008
@@ -421,11 +421,11 @@ typedef struct {
 } __attribute__ ((packed)) change_conn_link_key_cp;
 #define CHANGE_CONN_LINK_KEY_CP_SIZE 2
 
-#define OCF_MASTER_LINK_KEY		0x0017
+#define OCF_CENTRAL_LINK_KEY		0x0017
 typedef struct {
 	uint8_t		key_flag;
-} __attribute__ ((packed)) master_link_key_cp;
-#define MASTER_LINK_KEY_CP_SIZE 1
+} __attribute__ ((packed)) central_link_key_cp;
+#define CENTRAL_LINK_KEY_CP_SIZE 1
 
 #define OCF_REMOTE_NAME_REQ		0x0019
 typedef struct {
@@ -1561,28 +1561,28 @@ typedef struct {
 
 #define OCF_LE_CREATE_CONN_CANCEL		0x000E
 
-#define OCF_LE_READ_WHITE_LIST_SIZE		0x000F
+#define OCF_LE_READ_ACCEPT_LIST_SIZE		0x000F
 typedef struct {
 	uint8_t		status;
 	uint8_t		size;
-} __attribute__ ((packed)) le_read_white_list_size_rp;
-#define LE_READ_WHITE_LIST_SIZE_RP_SIZE 2
+} __attribute__ ((packed)) le_read_accept_list_size_rp;
+#define LE_READ_ACCEPT_LIST_SIZE_RP_SIZE 2
 
-#define OCF_LE_CLEAR_WHITE_LIST			0x0010
+#define OCF_LE_CLEAR_ACCEPT_LIST		0x0010
 
-#define OCF_LE_ADD_DEVICE_TO_WHITE_LIST		0x0011
+#define OCF_LE_ADD_DEVICE_TO_ACCEPT_LIST	0x0011
 typedef struct {
 	uint8_t		bdaddr_type;
 	bdaddr_t	bdaddr;
-} __attribute__ ((packed)) le_add_device_to_white_list_cp;
-#define LE_ADD_DEVICE_TO_WHITE_LIST_CP_SIZE 7
+} __attribute__ ((packed)) le_add_device_to_accept_list_cp;
+#define LE_ADD_DEVICE_TO_ACCEPT_LIST_CP_SIZE 7
 
-#define OCF_LE_REMOVE_DEVICE_FROM_WHITE_LIST	0x0012
+#define OCF_LE_REMOVE_DEVICE_FROM_ACCEPT_LIST	0x0012
 typedef struct {
 	uint8_t		bdaddr_type;
 	bdaddr_t	bdaddr;
-} __attribute__ ((packed)) le_remove_device_from_white_list_cp;
-#define LE_REMOVE_DEVICE_FROM_WHITE_LIST_CP_SIZE 7
+} __attribute__ ((packed)) le_remove_device_from_accept_list_cp;
+#define LE_REMOVE_DEVICE_FROM_ACCEPT_LIST_CP_SIZE 7
 
 #define OCF_LE_CONN_UPDATE			0x0013
 typedef struct {
@@ -1804,13 +1804,13 @@ typedef struct {
 }  __attribute__ ((packed)) evt_change_conn_link_key_complete;
 #define EVT_CHANGE_CONN_LINK_KEY_COMPLETE_SIZE 3
 
-#define EVT_MASTER_LINK_KEY_COMPLETE		0x0A
+#define EVT_CENTRAL_LINK_KEY_COMPLETE		0x0A
 typedef struct {
 	uint8_t		status;
 	uint16_t	handle;
 	uint8_t		key_flag;
-} __attribute__ ((packed)) evt_master_link_key_complete;
-#define EVT_MASTER_LINK_KEY_COMPLETE_SIZE 4
+} __attribute__ ((packed)) evt_central_link_key_complete;
+#define EVT_CENTRAL_LINK_KEY_COMPLETE_SIZE 4
 
 #define EVT_READ_REMOTE_FEATURES_COMPLETE	0x0B
 typedef struct {
@@ -2149,7 +2149,7 @@ typedef struct {
 	uint16_t	interval;
 	uint16_t	latency;
 	uint16_t	supervision_timeout;
-	uint8_t		master_clock_accuracy;
+	uint8_t		central_clock_accuracy;
 } __attribute__ ((packed)) evt_le_connection_complete;
 #define EVT_LE_CONN_COMPLETE_SIZE 18
 
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index 6b1a548b55..a0dfed615f 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -117,10 +117,10 @@ int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 int hci_le_conn_update(int dd, uint16_t handle, uint16_t min_interval,
 			uint16_t max_interval, uint16_t latency,
 			uint16_t supervision_timeout, int to);
-int hci_le_add_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
-int hci_le_rm_white_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
-int hci_le_read_white_list_size(int dd, uint8_t *size, int to);
-int hci_le_clear_white_list(int dd, int to);
+int hci_le_add_accept_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
+int hci_le_rm_accept_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
+int hci_le_read_accept_list_size(int dd, uint8_t *size, int to);
+int hci_le_clear_accept_list(int dd, int to);
 int hci_le_add_resolving_list(int dd, const bdaddr_t *bdaddr, uint8_t type,
 				uint8_t *peer_irk, uint8_t *local_irk, int to);
 int hci_le_rm_resolving_list(int dd, const bdaddr_t *bdaddr, uint8_t type, int to);
diff --git a/lib/l2cap.h b/lib/l2cap.h
index 9197800df4..a0ea111839 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -52,7 +52,7 @@ struct l2cap_conninfo {
 };
 
 #define L2CAP_LM	0x03
-#define L2CAP_LM_MASTER		0x0001
+#define L2CAP_LM_CENTRAL	0x0001
 #define L2CAP_LM_AUTH		0x0002
 #define L2CAP_LM_ENCRYPT	0x0004
 #define L2CAP_LM_TRUSTED	0x0008
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0a6349321a..0d1678f01d 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -179,7 +179,7 @@ struct mgmt_cp_load_link_keys {
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
 	uint8_t type;
-	uint8_t master;
+	uint8_t central;
 	uint8_t enc_size;
 	uint16_t ediv;
 	uint64_t rand;
diff --git a/lib/rfcomm.h b/lib/rfcomm.h
index 0347ddc367..ab1df888c2 100644
--- a/lib/rfcomm.h
+++ b/lib/rfcomm.h
@@ -38,7 +38,7 @@ struct rfcomm_conninfo {
 };
 
 #define RFCOMM_LM	0x03
-#define RFCOMM_LM_MASTER	0x0001
+#define RFCOMM_LM_CENTRAL	0x0001
 #define RFCOMM_LM_AUTH		0x0002
 #define RFCOMM_LM_ENCRYPT	0x0004
 #define RFCOMM_LM_TRUSTED	0x0008
diff --git a/monitor/control.c b/monitor/control.c
index 266602a34c..dad23a0e62 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -308,13 +308,13 @@ static void mgmt_new_long_term_key(uint16_t len, const void *buf)
 	/* LE SC keys are both for master and slave */
 	switch (ev->key.type) {
 	case 0x00:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Master (Unauthenticated)";
 		else
 			type = "Slave (Unauthenticated)";
 		break;
 	case 0x01:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Master (Authenticated)";
 		else
 			type = "Slave (Authenticated)";
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index be13af37a0..ab05a2bc24 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -2426,7 +2426,7 @@ static gboolean get_btrole(struct mcap_mcl *mcl)
 	if (getsockopt(sock, SOL_L2CAP, L2CAP_LM, &flags, &len))
 		DBG("CSP: could not read role");
 
-	return flags & L2CAP_LM_MASTER;
+	return flags & L2CAP_LM_CENTRAL;
 }
 
 uint64_t mcap_get_timestamp(struct mcap_mcl *mcl,
diff --git a/src/adapter.c b/src/adapter.c
index ddd8967515..ac1e02af6c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4122,7 +4122,7 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 		key->rand = cpu_to_le64(info->rand);
 		key->ediv = cpu_to_le16(info->ediv);
 		key->type = info->authenticated;
-		key->master = info->master;
+		key->central = info->master;
 		key->enc_size = info->enc_size;
 	}
 
@@ -8307,7 +8307,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 		rand = le64_to_cpu(key->rand);
 
 		store_longtermkey(adapter, &key->addr.bdaddr,
-					key->addr.type, key->val, key->master,
+					key->addr.type, key->val, key->central,
 					key->type, key->enc_size, ediv, rand);
 
 		device_set_bonded(device, addr->type);
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index 306b92a44c..c71e2c22da 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -72,7 +72,7 @@ static int init_server(uint16_t mtu, int master, int compat)
 	}
 
 	if (master) {
-		int opt = L2CAP_LM_MASTER;
+		int opt = L2CAP_LM_CENTRAL;
 		if (setsockopt(l2cap_sock, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0) {
 			error("setsockopt: %s", strerror(errno));
 			return -1;
diff --git a/tools/hcitool.c b/tools/hcitool.c
index c6a9093733..f7fca5216c 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2793,7 +2793,7 @@ static void cmd_lewladd(int dev_id, int argc, char **argv)
 
 	str2ba(argv[0], &bdaddr);
 
-	err = hci_le_add_white_list(dd, &bdaddr, bdaddr_type, 1000);
+	err = hci_le_add_accept_list(dd, &bdaddr, bdaddr_type, 1000);
 	hci_close_dev(dd);
 
 	if (err < 0) {
@@ -2839,7 +2839,7 @@ static void cmd_lewlrm(int dev_id, int argc, char **argv)
 
 	str2ba(argv[0], &bdaddr);
 
-	err = hci_le_rm_white_list(dd, &bdaddr, LE_PUBLIC_ADDRESS, 1000);
+	err = hci_le_rm_accept_list(dd, &bdaddr, LE_PUBLIC_ADDRESS, 1000);
 	hci_close_dev(dd);
 
 	if (err < 0) {
@@ -2883,7 +2883,7 @@ static void cmd_lewlsz(int dev_id, int argc, char **argv)
 		exit(1);
 	}
 
-	err = hci_le_read_white_list_size(dd, &size, 1000);
+	err = hci_le_read_accept_list_size(dd, &size, 1000);
 	hci_close_dev(dd);
 
 	if (err < 0) {
@@ -2928,7 +2928,7 @@ static void cmd_lewlclr(int dev_id, int argc, char **argv)
 		exit(1);
 	}
 
-	err = hci_le_clear_white_list(dd, 1000);
+	err = hci_le_clear_accept_list(dd, 1000);
 	hci_close_dev(dd);
 
 	if (err < 0) {
diff --git a/tools/l2test.c b/tools/l2test.c
index 6e07f7b842..822cdc8cc9 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -484,7 +484,7 @@ static int do_connect(char *svr)
 	if (reliable)
 		opt |= L2CAP_LM_RELIABLE;
 	if (master)
-		opt |= L2CAP_LM_MASTER;
+		opt |= L2CAP_LM_CENTRAL;
 	if (auth)
 		opt |= L2CAP_LM_AUTH;
 	if (encr)
@@ -587,7 +587,7 @@ static void do_listen(void (*handler)(int sk))
 	if (reliable)
 		opt |= L2CAP_LM_RELIABLE;
 	if (master)
-		opt |= L2CAP_LM_MASTER;
+		opt |= L2CAP_LM_CENTRAL;
 	if (auth)
 		opt |= L2CAP_LM_AUTH;
 	if (encr)
diff --git a/tools/oobtest.c b/tools/oobtest.c
index c095036fe7..0368bc3865 100644
--- a/tools/oobtest.c
+++ b/tools/oobtest.c
@@ -133,13 +133,13 @@ static void new_long_term_key_event(uint16_t index, uint16_t len,
 
 	switch (ev->key.type) {
 	case 0x00:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Unauthenticated, Master";
 		else
 			type = "Unauthenticated, Slave";
 		break;
 	case 0x01:
-		if (ev->key.master)
+		if (ev->key.central)
 			type = "Authenticated, Master";
 		else
 			type = "Authenticated, Slave";
diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index d395e37f54..02ebcfc442 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -1084,7 +1084,7 @@ static inline void remote_name_req_dump(int level, struct frame *frm)
 
 static inline void master_link_key_dump(int level, struct frame *frm)
 {
-	master_link_key_cp *cp = frm->ptr;
+	central_link_key_cp *cp = frm->ptr;
 
 	p_indent(level, frm);
 	printf("flag %d\n", cp->key_flag);
@@ -1771,7 +1771,7 @@ static inline void command_dump(int level, struct frame *frm)
 		case OCF_DISCONNECT_LOGICAL_LINK:
 			generic_command_dump(level + 1, frm);
 			return;
-		case OCF_MASTER_LINK_KEY:
+		case OCF_CENTRAL_LINK_KEY:
 			master_link_key_dump(level + 1, frm);
 			return;
 		case OCF_READ_REMOTE_EXT_FEATURES:
@@ -2969,9 +2969,9 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 		case OCF_LE_SET_SCAN_PARAMETERS:
 		case OCF_LE_SET_SCAN_ENABLE:
 		case OCF_LE_CREATE_CONN:
-		case OCF_LE_CLEAR_WHITE_LIST:
-		case OCF_LE_ADD_DEVICE_TO_WHITE_LIST:
-		case OCF_LE_REMOVE_DEVICE_FROM_WHITE_LIST:
+		case OCF_LE_CLEAR_ACCEPT_LIST:
+		case OCF_LE_ADD_DEVICE_TO_ACCEPT_LIST:
+		case OCF_LE_REMOVE_DEVICE_FROM_ACCEPT_LIST:
 		case OCF_LE_SET_HOST_CHANNEL_CLASSIFICATION:
 		case OCF_LE_RECEIVER_TEST:
 		case OCF_LE_TRANSMITTER_TEST:
@@ -3116,7 +3116,7 @@ static inline void remote_name_req_complete_dump(int level, struct frame *frm)
 
 static inline void master_link_key_complete_dump(int level, struct frame *frm)
 {
-	evt_master_link_key_complete *evt = frm->ptr;
+	evt_central_link_key_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
 	printf("status 0x%2.2x handle %d flag %d\n",
@@ -3874,7 +3874,7 @@ static inline void event_dump(int level, struct frame *frm)
 	case EVT_CHANGE_CONN_LINK_KEY_COMPLETE:
 		generic_response_dump(level + 1, frm);
 		break;
-	case EVT_MASTER_LINK_KEY_COMPLETE:
+	case EVT_CENTRAL_LINK_KEY_COMPLETE:
 		master_link_key_complete_dump(level + 1, frm);
 		break;
 	case EVT_REMOTE_NAME_REQ_COMPLETE:
diff --git a/tools/rctest.c b/tools/rctest.c
index 7d688691c4..034ae167b2 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -203,7 +203,7 @@ static int do_connect(const char *svr)
 	/* Set link mode */
 	opt = 0;
 	if (master)
-		opt |= RFCOMM_LM_MASTER;
+		opt |= RFCOMM_LM_CENTRAL;
 	if (auth)
 		opt |= RFCOMM_LM_AUTH;
 	if (encr)
@@ -294,7 +294,7 @@ static void do_listen(void (*handler)(int sk))
 	/* Set link mode */
 	opt = 0;
 	if (master)
-		opt |= RFCOMM_LM_MASTER;
+		opt |= RFCOMM_LM_CENTRAL;
 	if (auth)
 		opt |= RFCOMM_LM_AUTH;
 	if (encr)
diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index 8e1db8ebaa..7ad7ca5ad6 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -435,7 +435,7 @@ static void cmd_listen(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv
 
 	lm = 0;
 	if (master)
-		lm |= RFCOMM_LM_MASTER;
+		lm |= RFCOMM_LM_CENTRAL;
 	if (auth)
 		lm |= RFCOMM_LM_AUTH;
 	if (encryption)
-- 
2.33.0.259.gc128427fd7-goog

