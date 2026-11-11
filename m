Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390279;
	b=UzX35+BIVNd8im5J6GE6YIBRkAUD7DusgRGokx0smbVw5WQ+9A+GDsNQRXgQH5tHgQMc
	 31I2/STrJbdbgL2Ms97vg3NVDmMwSEWNKox8K5MrWO7ifjttbX9HCns+p0zfjb2mjQp3L
	 QqCyvtsJJ1jT/UTACmzQp+zKgjGEr46oXeFCWk3zn3CYarvafnpkia2phSlMs9DfxI0jP
	 lFCI4aK9Dvbtjoa330N0lcjJpYUJUjpau2cn6AWKQoasynv4HWtyqxluFopoJkmsKiVQ9
	 Bjr3XLABFxgnXLsMHXFjrTswb5zZjIBvsvBEX5aB9EyUitk+8sQAmPBV79J4mDkQizQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8oOBK8u6o0/Cu3d5vztWdIxcCzBS+LQA40M847r8hLE=;
	b=f+g3RpFeXjwZvC4xr+T89YLsA2h7BYbUbankdvCa5bgRFjuCvJB1B/fAbEE10Wymg9oc
	 Q59gR3mlpxLciHigadbcsVUvw0Yl25dKKm5SDvUeYmRyBxX2qYCSprSxKDIFu9GbsOAEQ
	 z1cc4wXBWCVV4FITwkPpAruRPBiGbn706GUz5JsUcB8hcM/V/7THsKwxGQLXHk4UgjBwt
	 +RtqOZS5bowI22gr0H+D5mz4ktuUsDfnx+ge+2F+QoUWj7Pw4pDaL7zh9l2/Md6mOaQCo
	 n7nMAbx4Qxzwx60OCbpWNYuHmORX87Gt8D7+mYzXWzGecD8Y1c/tLjo1JJw//CzIfRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QsSyF4Xz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F7606A32E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 136F7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QsSyF4Xz
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KM8a2017398;
	Wed, 11 Nov 2026 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8oOBK8u6o0/
	Cu3d5vztWdIxcCzBS+LQA40M847r8hLE=; b=QsSyF4XzIqt18l0x3WdZgbmG4lb
	KukaO5qaJWBaw15QcMoPe1oexmHe0UCHlXOQtxFiq7oebZ7OIc9vw8XIibsWxBLJ
	s/RfJPM1NuTjyf2mmsYww6A+Ga7WpUC5uC3x/7aWruQlonCMftDhExNqDZn2ZWHt
	e8ws9KWeAWmRoRFu9otOeTdD5Cyk6pbd+k5ewqenQLNpThoftHB3au8nP5w2OP+X
	51jzYui4VC+AlD1XaoH0f+3D2OlKA2yAd2oguITPrZ7VGGVNY1U+/4I09yPj/SPd
	BDKFTJ776YwgFFEj1V2MN2lGkqS53fWJm7g/SHkaXU4JPkYXlDH6xAe19UQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97cb3df-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iZKv2424417;
	Wed, 11 Nov 2026 09:44:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AB9iZTC2424367
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 6313C243D4; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 14/20] obexd/pbap: Add persistent database identifier
Date: Wed, 11 Nov 2026 17:44:19 +0800
Message-Id: <20261111094425.1444893-15-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
References: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX5JhWzfFHe+KN
 A4LYbNgB40s4iCtn+r34zu597kQM9mUisDpx511W9V3s4wqA5fCxjPZZw6Mji1lOSzLyoYjwfCB
 I9woBU7LQLgmZJm2YT8K3eOWZgTm+JVyxS/mkEZ7Vig6wo9zFagCz9SLWx8Q1ZRwgT6Qtg6J1OQ
 z5MZdEuC2vRmb5RoiJS88aR0XKzLRkK1TTwmsRiLt7y0XKY5oFQ27gCFBjPfuTDBPD+5UCv6bzM
 P+FLgW4dCao36TsVe21dRuIQwy2D8HFne6CtWv5Tk28rSBmDBaZQJw1SB88ono4BvWSh0nVwqbE
 Xzx6hu/7aXHhtCgVAEzbkcFOEqTFJ8LN/rpYkAo//Kx/DrKo3x55JrPOm4RoHbC1v3UfCiDN1xB
 Foc9sQyXFEdT3kc8ICmrmXERxWw2lcZGqV85D5cD3MPhiYPiiO12/SWwj6aKiozZG9B32ffrya3
 rxf3emzYIWxLpsX1/Tw==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af43905 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=cJBrMpTn7pYZM8YZh9UA:9
X-Proofpoint-GUID: bPc6HbHjdSUl23pvhVgdz-PjbzfZXnih
X-Proofpoint-ORIG-GUID: bPc6HbHjdSUl23pvhVgdz-PjbzfZXnih
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX4DhWwkDqHUTn
 dqqHcELjD/wX80+7tus0XxZw9W8V2A072v3uycy5YoZEO4jRPHzr6Okh/kR/0QadrnHUypKNrtP
 uzL46w5sdm+VIO6W5H1bIzD1h5yUOiE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

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
index 59fc77d6d..f97693d0f 100644
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

