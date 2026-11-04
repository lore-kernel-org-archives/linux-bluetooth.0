Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781294;
	b=0XpqHgyCCf1HDe6F3nimF01DHQAzAMJYk6WY1LZeUK1NxKQ21xbjAJM6lgD0QYhy394H
	 HgHkRjgXyvqp9p0iO74mqHvwjcslXDU347X/LHmPlRWq+Mwn+sOTUmZfhQurHQqsrlY4P
	 fJNuAP3T9L2VJpOsFN2K0g9W7mNCIC1qgK+QsQxG0mlP0ZmJY4hjMRKf4y4vlv2iStztQ
	 XNdT9jNDYMk9hacUlFASXUC43zooA68DBmFd8Bc7vw4hdljJL+tKGCcvfgxgoeB3p9UiF
	 l3ZJtWsgNxPKV/O60wrRr6lnQYQ7JrEBBdffWgl3bB7OVlWEFWIx/LWtEBEl4qxqQRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781294;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tlFsRVa9iakvEG8viNsYxi+LpAy1CFFSbRs+46MnmjY=;
	b=FuvQUFUM/TTD2sfW9vb9fKDL4jg5JANCUv3ug8woXHf4aob1Zp7OQ0/OaJvE2G+Ho6uS
	 mt5fnvOK/71kK7o2DaBOYPBpNvgG/hGL3W+bQM/u9SwRrNnCTuFFBIiT42uV1QWC1qxlp
	 7q6Fmg/FDPd0oJv58Uxq45R8FxbBbnqKL8+UxLDY0xNKmoFrp4UVnAtWMbYgGDM4r8ofI
	 2+9r3352ndncXYOGx1+Fhco2Rx60nG6qMjp+2mRFHIAe8tKbH9DLKNtRYR8DV1bFjKBAk
	 UmilkqM4Dd6XoIqMUSMK865VzNVe5x9LOVii3/pGIJcOzMEZpxO6rMtnBDPRyUIJAtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lPLMyG76;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF3F606D80F
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF3F606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lPLMyG76
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48L0Cm1274964
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tlFsRVa9iak
	vEG8viNsYxi+LpAy1CFFSbRs+46MnmjY=; b=lPLMyG76P2004Bt8U3lyDQkiMAm
	B8uzCNVfTaJcJnrxqk9Yw07jZrole1o3srd4HVBBkzfRJ8HsVeZwntg9hnuobNAx
	UIBOkBoM+OAGQMDD2OUYKiACzRjlSU65PCcf54G7nQYaphN4bDoXcIxfZFCBJCJj
	g0F9FQHnuSdhk9p5N9DR50x88TAd1s8L1lcFCW+OiarmddaP5x9KMnGW4lvHqHEM
	rk0INQX/9usgTbTK/04gQP2eOPAXLCMyPPYfgauwi8O9sz39jqq6YIvOvsGyFvr9
	ucsQg2JwPyZyS2awksLNZNlBoapLfxfz8e6KLzwtjNLCAbAhSv4JU/bzaFA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhypm1af-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:39 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YaiB2686473;
	Wed, 4 Nov 2026 08:34:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A48Yaac2686431
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 80A64279BE; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 12/18] obexd/pbap: Add persistent database identifier
Date: Wed,  4 Nov 2026 16:34:23 +0800
Message-Id: <20261104083429.4111632-13-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
References: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX8HFtSPBfuWVn
 1L9C4FYcbzn2o/echth/g4gMFVADKPDYMCt8fytpF35Wv3A/u7WRQjJmFSlMBSOjraUaDd/MALd
 W7CZ7GgfqHawICKE6oCyNF0Dpc/y+V8=
X-Proofpoint-ORIG-GUID: NnZw-9CDex3QNpDMeYJ0xSYhVWbASBsu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX6lSJ/w3K3CA7
 /IIdzZ8j84g3HOWgWJTkSuF5g3d1nyHeDjAiAuiuVdDLfTZ5YwiDXdhvkvkyEa2ul3eKnuwP3yC
 penQdC/I35QVEU108UnD7nEe0RifdNktyDFJQG0q21yVj8e4XrL0GxqbKgELXhs8NyX3f5ezzEi
 CI2t+naMUhoc/OhQjFss4u8+z3pKSU4+NzJDOe7+AHpPxRufcOvrP1kQL1AKa8qQs3knuxz5XaU
 hU3ITqqw4MlCzXS0uwOUjsIVPM1Vr2eQw7HCL4/7afc80A/2+/UCE2rMaoWhfWFcRMOG+la271v
 IYo51FKePwWO6TAg/nXK4D8kUrixzxfV4aI9kx/zuAp5HNcIYCd7iPh+/PerWF9qGMTXODqJraN
 Z9GmBAae0GNKx0/y02IoaHl6yqxe6fEd3uIXJlUXE5tdw2xpnPpqCFJr6Lz6S/wKLck7+urWGt2
 xJRXHjnNvIUS41BhtVg==
X-Proofpoint-GUID: NnZw-9CDex3QNpDMeYJ0xSYhVWbASBsu
X-Authority-Analysis: v=2.4 cv=T94Z3PKQ c=1 sm=1 tr=0 ts=6aeaee1f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=cJBrMpTn7pYZM8YZh9UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040034

Add a 128-bit Database Identifier for the PSE. The dummy backend
generates it when it is missing and stores it in a metadata file. The
ebook and tracker backends do not persist it and report it as zero.

Assisted-by: Claude:claude-sonnet-5-5
---
 Makefile.obexd                     |   2 +
 obexd/plugins/phonebook-dummy.c    |  23 ++++
 obexd/plugins/phonebook-metadata.c | 194 +++++++++++++++++++++++++++++
 obexd/plugins/phonebook-metadata.h |  45 +++++++
 obexd/plugins/phonebook.c          |   7 ++
 obexd/plugins/phonebook.h          |  11 ++
 6 files changed, 282 insertions(+)
 create mode 100644 obexd/plugins/phonebook-metadata.c
 create mode 100644 obexd/plugins/phonebook-metadata.h

diff --git a/Makefile.obexd b/Makefile.obexd
index 9daa5aac2..4b3d08f01 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -49,6 +49,8 @@ obexd_builtin_sources += obexd/plugins/pbap.c \
 				obexd/plugins/vcard.h obexd/plugins/vcard.c \
 				obexd/plugins/phonebook.h \
 				obexd/plugins/phonebook.c \
+				obexd/plugins/phonebook-metadata.h \
+				obexd/plugins/phonebook-metadata.c \
 				obexd/plugins/phonebook-@PLUGIN_PHONEBOOK@.c
 EXTRA_DIST += obexd/plugins/phonebook-dummy.c obexd/plugins/phonebook-ebook.c \
 				obexd/plugins/phonebook-tracker.c
diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 237349bef..698510f6f 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -31,6 +31,7 @@
 
 #include "obexd/src/log.h"
 #include "phonebook.h"
+#include "phonebook-metadata.h"
 
 typedef void (*vcard_func_t) (const char *file, VObject *vo, void *user_data);
 
@@ -75,14 +76,36 @@ static void query_free(void *user_data)
 	g_free(query);
 }
 
+static void dummy_metadata_init(void)
+{
+	metadata_identifier_update();
+	metadata_save();
+}
+
 int phonebook_driver_init(void)
 {
+	char *metadata_path;
+	uint8_t id[16];
+
 	if (root_folder)
 		return 0;
 
 	/* FIXME: It should NOT be hard-coded */
 	root_folder = g_build_filename(getenv("HOME"), "phonebook", NULL);
 
+	metadata_path = g_build_filename(root_folder,
+					"phonebook-metadata", NULL);
+
+	if (!metadata_file_open(metadata_path)) {
+		g_free(metadata_path);
+		return 0;
+	}
+
+	g_free(metadata_path);
+
+	if (!metadata_get("identifier", "value", id))
+		dummy_metadata_init();
+
 	return 0;
 }
 
diff --git a/obexd/plugins/phonebook-metadata.c b/obexd/plugins/phonebook-metadata.c
new file mode 100644
index 000000000..06cfa2a8a
--- /dev/null
+++ b/obexd/plugins/phonebook-metadata.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include "obexd/src/log.h"
+#include "phonebook.h"
+#include "phonebook-metadata.h"
+
+static char *metadata_file;
+static GKeyFile *metadata_kf;
+static gboolean metadata_dirty;
+
+gboolean metadata_get(const char *group,
+					const char *key, uint8_t buf[16])
+{
+	char *str;
+	uint8_t value[16];
+	unsigned int i;
+
+	if (!metadata_kf)
+		return FALSE;
+
+	str = g_key_file_get_string(metadata_kf, group, key, NULL);
+	if (!str || strlen(str) != 32)
+		goto failed;
+
+	for (i = 0; i < 16; i++) {
+		int high = g_ascii_xdigit_value(str[i * 2]);
+		int low = g_ascii_xdigit_value(str[i * 2 + 1]);
+
+		if (high < 0 || low < 0)
+			goto failed;
+
+		value[i] = (high << 4) | low;
+	}
+
+	memcpy(buf, value, sizeof(value));
+	g_free(str);
+	return TRUE;
+
+failed:
+	g_free(str);
+	return FALSE;
+}
+
+void metadata_set(const char *group, const char *key,
+						const uint8_t buf[16])
+{
+	char hex[33];
+	unsigned int i;
+
+	if (!metadata_file || !metadata_kf)
+		return;
+
+	for (i = 0; i < 16; i++)
+		sprintf(hex + (i * 2), "%02X", buf[i]);
+
+	g_key_file_set_string(metadata_kf, group, key, hex);
+	metadata_dirty = TRUE;
+}
+
+void metadata_identifier_update(void)
+{
+	uint8_t identifier[16];
+	unsigned int i;
+
+	if (!metadata_file || !metadata_kf)
+		return;
+
+	for (i = 0; i < 16; i += sizeof(uint32_t)) {
+		uint32_t value = g_random_int();
+
+		identifier[i] = (value >> 24) & 0xff;
+		identifier[i + 1] = (value >> 16) & 0xff;
+		identifier[i + 2] = (value >> 8) & 0xff;
+		identifier[i + 3] = value & 0xff;
+	}
+
+	metadata_set("identifier", "value", identifier);
+}
+
+gboolean metadata_save(void)
+{
+	char *data;
+	gsize len;
+	GError *gerr = NULL;
+
+	if (!metadata_file || !metadata_kf)
+		return FALSE;
+
+	if (!metadata_dirty)
+		return TRUE;
+
+	data = g_key_file_to_data(metadata_kf, &len, NULL);
+
+	if (len > 0) {
+		if (!g_file_set_contents(metadata_file, data, len, &gerr)) {
+			error("Unable to save metadata file: %s",
+					gerr->message);
+			g_error_free(gerr);
+			g_free(data);
+			return FALSE;
+		}
+	}
+
+	g_free(data);
+	metadata_dirty = FALSE;
+
+	return TRUE;
+}
+
+gboolean metadata_file_open(const char *file)
+{
+	GError *gerr = NULL;
+
+	if (!file)
+		return FALSE;
+
+	metadata_file = g_strdup(file);
+	if (!metadata_file)
+		return FALSE;
+
+	if (!g_file_test(metadata_file, G_FILE_TEST_EXISTS)) {
+		if (!g_file_set_contents(metadata_file, "", 0, &gerr)) {
+			error("Unable to create metadata file: %s",
+							gerr->message);
+			g_error_free(gerr);
+			gerr = NULL;
+		}
+	}
+
+	metadata_kf = g_key_file_new();
+
+	if (metadata_kf && !g_key_file_load_from_file(metadata_kf,
+					metadata_file, 0, &gerr)) {
+		error("Unable to load metadata file: %s", gerr->message);
+		g_error_free(gerr);
+		g_key_file_free(metadata_kf);
+		metadata_kf = NULL;
+		g_free(metadata_file);
+		metadata_file = NULL;
+		return FALSE;
+	}
+
+	metadata_dirty = FALSE;
+
+	return TRUE;
+}
+
+gboolean metadata_read(struct phonebook_metadata *metadata)
+{
+	memset(metadata, 0, sizeof(*metadata));
+
+	if (!metadata_file || !metadata_kf)
+		return FALSE;
+
+	/* Values which are not saved are reported as not persistent. */
+	if (metadata_dirty)
+		return FALSE;
+
+	if (!metadata_get("identifier", "value", metadata->database_identifier))
+		DBG("identifier not found in metadata");
+
+	return TRUE;
+}
+
+void metadata_file_close(void)
+{
+	if (metadata_kf) {
+		g_key_file_free(metadata_kf);
+		metadata_kf = NULL;
+	}
+
+	if (metadata_file) {
+		g_free(metadata_file);
+		metadata_file = NULL;
+	}
+}
diff --git a/obexd/plugins/phonebook-metadata.h b/obexd/plugins/phonebook-metadata.h
new file mode 100644
index 000000000..c70c20ecd
--- /dev/null
+++ b/obexd/plugins/phonebook-metadata.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *
+ */
+
+#include <stdint.h>
+
+#include <glib.h>
+
+struct phonebook_metadata;
+
+/*
+ * Opens and loads the metadata file, creating it when it doesn't exist.
+ * The key file is cached internally. Returns FALSE on error.
+ */
+gboolean metadata_file_open(const char *file);
+
+/* Closes the metadata file and releases cached resources. */
+void metadata_file_close(void);
+
+/* Reads metadata and zeroes invalid or unsaved values. */
+gboolean metadata_read(struct phonebook_metadata *metadata);
+
+/* Stores a hex encoded byte array. */
+void metadata_set(const char *group, const char *key,
+						const uint8_t buf[16]);
+
+/*
+ * Reads a hex encoded byte array. Returns FALSE when the value is
+ * missing or invalid.
+ */
+gboolean metadata_get(const char *group, const char *key, uint8_t buf[16]);
+
+/* Generates and stores a new database identifier. */
+void metadata_identifier_update(void);
+
+/*
+ * Persists the metadata file. Returns TRUE on success.
+ */
+gboolean metadata_save(void);
diff --git a/obexd/plugins/phonebook.c b/obexd/plugins/phonebook.c
index 6afdb7abb..059414446 100644
--- a/obexd/plugins/phonebook.c
+++ b/obexd/plugins/phonebook.c
@@ -17,6 +17,7 @@
 #include <glib.h>
 
 #include "phonebook.h"
+#include "phonebook-metadata.h"
 
 static unsigned int refcount = 0;
 
@@ -44,4 +45,10 @@ void phonebook_exit(void)
 		return;
 
 	phonebook_driver_exit();
+	metadata_file_close();
+}
+
+int phonebook_get_metadata(struct phonebook_metadata *metadata)
+{
+	return metadata_read(metadata);
 }
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index 9ab5b72f6..6fb91f7e0 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -55,6 +55,11 @@ struct apparam_field {
 	char *searchval;
 };
 
+/* Metadata identifying the current database contents. */
+struct phonebook_metadata {
+	uint8_t database_identifier[16];
+};
+
 /*
  * Interface between the PBAP core and backends to retrieve
  * all contacts that match the application parameters rules.
@@ -99,6 +104,12 @@ void phonebook_driver_exit(void);
 char *phonebook_set_folder(const char *current_folder,
 		const char *new_folder, uint8_t flags, int *err);
 
+/*
+ * Returns the metadata identifying the current database contents. A zero
+ * database identifier means the values are not persistent.
+ */
+int phonebook_get_metadata(struct phonebook_metadata *metadata);
+
 /*
  * phonebook_pull should be used only to prepare pull request - prepared
  * request data is returned by this function. Start of fetching data from
-- 
2.34.1

