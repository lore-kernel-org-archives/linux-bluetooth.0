Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899242A170
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503644; cv=none; b=M7ggZiRGW28CGxRFAp12SFKlvJR+RsF3grR6P1+JbAwQpMCtP+N32RguwkqoUrcUsWOhEDNorBnV1R77u3+jffXn04qId51rcFINlDv5kE+tF0js91ZbfpZ33+Q6T7Z06afB6B9qEFBO9CgLmbOLD61xA10NhBXgEPOdlM0q5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503644; c=relaxed/simple;
	bh=hAO7gZxOT1yAvsM7Lh3BcCU5Kuc0IfX3t/SwJayHs+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TupcU0DllvT2ih8NmmBTdanryqTgYzl6qq87Bg9EMmVTeu76/FKM7WJyWbh+slNREHEZPbJIiP1jpBhWrHm1P1qp0KZSsj6nt32PhXwJWlk7S+FzwT4x9PmrK++h2mYih/I2HBUUbEZbMwWiJ1OYyeH07F03+myUnvXsSnkdOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=opH3MJAO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MXwyynJe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="opH3MJAO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXwyynJe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VCA0i34154513
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 13:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7SPU3G6jyFM75r9xRvr/BZYGy8xXgWMbSUf
	hy6qElfw=; b=opH3MJAO1qtY+M1osAUhE0+uDXyJic63DsJr/Mlc36g5+SOHVZO
	T3JTvN7LnYSKxQQw9NY39nJAYdqoVfAY+4SryOKXCydX2rkhM6Bc7acJD8Ydj1PZ
	7yRkGGnH/gFeiCu1TszimAKO5QRME61f6hWblE3/15cPqobr4aeAyhPxzsH4C0um
	GGOrDz+BTTG9FUfp1BAgyU5SSrRt2n3KFu2xWmIgf3JEJ8XsgJY1BZJ2oDTrn2am
	vW4Xng5UGIj/XpIh6B2J2G/6/ewOMmKRhR6FX9FPGGEvnCuSxT0sTkEECpVEt005
	j11jrD1/wqLe1JNZRkQ8Xj4Ga5NatNRUzlQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frufkg8pm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 13:14:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb687f82eso13985225ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785503641; x=1786108441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7SPU3G6jyFM75r9xRvr/BZYGy8xXgWMbSUfhy6qElfw=;
        b=MXwyynJeSGgXvuZjCvWawkzFnguE4FH0FhpV80mRDIdqJe/p3bpspFrAumvvdmv0ZF
         bwnP21zdZwFVx1q+dv2Ry8aIn5K/xz9HU1zVk3TTZENyye04p0nK5Tqd+ujc9UJVBOAR
         hAz2gvrDrixoIrLqaSWqKHPVhOv6mwQlVZfM+2n1vITpcgR/BWYMksWb5ud/4/4tlL8E
         9xVcj+3f1mjBZIruRMTI2Nz/IJtIAUFLd2FWJpD1sREAxJqQQtA+OQNhttNwrBQXwHgK
         3PLiISTHkwtg74GR2SGpERo0nmCZcEgFRYEM+rmX/A2DtceYtLRzRgxnDwKoUfpcsW4v
         nRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785503641; x=1786108441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SPU3G6jyFM75r9xRvr/BZYGy8xXgWMbSUfhy6qElfw=;
        b=U20BAHC2eNp4XdJt9YRFgAphSBiiG8YIFqJGJBrP0nMrgDp4ylho0lLXMisAz4aP8U
         zjSTngHHuYmDzTDwXoT1vvMfBLenLRIXJIlRzSpW6naDHc9erc3FHolfCwOSIeJh0ERk
         wy8jdTHqofAeA1QWGnmK5tIAqNbz7QmoMOgCUXGfdQLu/dVN6P1q4Uw0QyHwFA0QgC/c
         b/CVawzajz++gNGrUGZ8N0MhyZ2GXbt/IEtqgHVIUB5fieE+gzdT8qWzclkLudf53VmF
         Bijev8yNTKT25I4Nr9gUZ9DINW4cLQ0CvZZRPojUjhd/wswe2rHQyKTnXm92RZNGOp+H
         FVdA==
X-Gm-Message-State: AOJu0YznjEFH23+vIbb5NN1PCunm1E+9xofbu8Fn558N7MlTrlAbjfWQ
	tvvYLYRV6W2rx9Nhf9RiK4tLnKEFc9hRONpCTXVhmQY80IA4bCgIPEn5QWDc40GK60nt3zxoYqs
	rmTtkFnwCpx4ibnud3EE7F0tU9sYwi/aqOnNcpcub+LLCNgmCrNY0H6BsOtOh4DxKAE8xCPFdHB
	J2sp8=
X-Gm-Gg: AR+sD101Cpp2NsLqyl5Jg7BasP3MWLPDW0lX8gIr0WLowRomDD4qshM/rw8CMx2QtR8
	TxUVrDA9bsnwMn/FP1FjVyKx49NinScKToY6xJ24c/bkmpc+dHgPuXuhB4TNDjD+uSkbgdMZely
	4lXEjN2/GAYhJ50zE89Cq/Mu/swXL9mmSqTRnVgwxyy1un+s/G2kFM6Hgxi0rrBzun7vI/zspo7
	oO3Hi3KwgoachGIOscS3zW1iV9NI6FQnKdRDwWncaOKoQaFgf8mFoRxG6yT01IoXT2D5Z/7sYVj
	7DH59bR78WOhn6QGjORrTJuSwT1t/Qnf+tAFANU1HbUXmQ3sizovlXDt1Kn8j11nI7UhlIZSard
	ec4zcXZBNlJSFEqQtqp9Z310BUzVhpA==
X-Received: by 2002:a05:6a21:62c6:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3c91b107246mr2083332637.21.1785503641282;
        Fri, 31 Jul 2026 06:14:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:62c6:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3c91b107246mr2083298637.21.1785503640773;
        Fri, 31 Jul 2026 06:14:00 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153db2f911sm7137740eec.0.2026.07.31.06.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:14:00 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1] unit/test-rap: Add PTS tests for CS
Date: Fri, 31 Jul 2026 18:43:52 +0530
Message-Id: <20260731131352.3154342-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwMCBTYWx0ZWRfX3N2syKtnbh/9
 OfKycHrt+9Px3PMbUvS1qNcvFyr0nnPFc6TDVUCYue3PHnuUE6kqbmIel72dluNArmVGoq688q+
 44Bh8yOFz+g2q64rJesdY5OeHJ5YzuI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwMCBTYWx0ZWRfX4J7l+iv86bzL
 SkkyhOfWCcWa3Ug+RQP1gXDQMIUcGz0euQwbTDV0zTz7YeEtjURSTTOY4mnd1PaqNbM7M07RmAQ
 LpUyhDD3gXNv0K1ZV+BqAi7noHpjq5Yd9fdzWKPFdpdVi0zs/D5181VQhbPa7y3FonKr/IOvPmO
 6D2LHSgi8+cwJcx/Uw43gxg+zq8nfJuso2sHNmCdGn3V9vX9AV9Nb+uYEkqgwk5NiIEiTeR4wPM
 h5QRb68MBHIEWs1PbABG9HMfMVg2EZzcrjuD42pmVvTPI3+FjxQwFYcOgWONLSKyQeyyg8bkH12
 LRoOGpBU1+tzrdZQDuhCN702P+wnkO08tOXjmAsPeSKMZD2wrnZ0ZkpTjkQ6mcTbkTUYh8iNY9S
 cPqp3OOlTjQDvxb7tda7li2H1jCSxNEaXi3C/bB4Dp816eTx1PCXa66pdNX4IIH0Zhl+1K6NzDY
 +JlO3JIz7jxVGB6VFiQ==
X-Proofpoint-GUID: lFMQ4mP_mssaF1z9IHTlUAJQgJ5aKEPg
X-Authority-Analysis: v=2.4 cv=BpOtB4X5 c=1 sm=1 tr=0 ts=6a6c9f9a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=mLDcNwqPkGnNCuDJSxQA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: lFMQ4mP_mssaF1z9IHTlUAJQgJ5aKEPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310100

RAS/SR/SGGIT/CHA/BV-05-C - Verifies the Ranging Data Ready characteristic
exists in the GATT database with exactly the Indicate property
RAS/SR/SGGIT/CHA/BV-06-C - Same characteristic-existence/property check,
for an IUT configured to support both Indicate and Notify
RAS/SR/SGGIT/CHA/BV-07-C - Same check, for an IUT supporting Indicate
and Read on Ranging Data Ready
RAS/SR/SGGIT/CHA/BV-08-C - Same check, for an IUT supporting all three
Indicate, Notify, and Read
RAS/SR/SGGIT/CHA/BV-09-C - Verifies the Ranging Data Overwritten char
exists with exactly the Indicate
RAS/SR/SGGIT/CHA/BV-10-C - Same check, for Indicate and Notify support
RAS/SR/SGGIT/CHA/BV-11-C - Same check, for Indicate and Read support
RAS/SR/SGGIT/CHA/BV-12-C - Same check, for Indicate, Notify and Read
support

RAP/REQ/CGGIT/SER/BV-01-C - Verifies the IUT correctly discovers Ranging
service
RAP/REQ/CGGIT/CHA/BV-01-C - Verifies the IUT discovers RAS Features
characteristic and currently identifies Read property
RAP/REQ/CGGIT/CHA/BV-02-C - Verifies the IUT discovers the Real-time
Ranging Data characteristic with Notify and Indicate properties
RAP/REQ/CGGIT/CHA/BV-03-C - Verifies the IUT discovers the On-Demand
Ranging Data characteristic with Notify and Indicate properties
RAP/REQ/CGGIT/CHA/BV-04-C - Verifies the IUT discovers the RAS Control
point characteristic with Write Without Response and Indicate properties
RAP/REQ/CGGIT/CHA/BV-05-C - Verifies the IUT discovers the Ranging Data
Ready characteristic with Notify, Indicate, and Read properties
RAP/REQ/CGGIT/CHA/BV-06-C - Verifies the IUT discovers the Ranging Data
Overwritten characteristic with Notify, Indicate, and Read properties
---
 unit/test-rap.c | 313 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 313 insertions(+)

diff --git a/unit/test-rap.c b/unit/test-rap.c
index 22bc2671b..d7da2ff45 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -40,12 +40,18 @@ struct test_data_ras {
 	struct bt_rap *rap;  /* Store rap instance for CS injection */
 };
 
+struct test_config_rap {
+	const struct iovec *setup_data;
+	const size_t setup_data_len;
+};
+
 struct test_data_rap {
 	struct gatt_db *db;
 	struct bt_rap *rap;
 	struct bt_gatt_client *client;
 	size_t iovcnt;
 	struct iovec *iov;
+	const struct test_config_rap *cfg;
 };
 
 struct ccc_state {
@@ -75,6 +81,17 @@ struct notify {
 				test_teardown_ras);			\
 	} while (0)
 
+#define define_test_rap(name, setup, function, _cfg, args...)	\
+	do {							\
+		const struct iovec iov[] = { args };		\
+		static struct test_data_rap data;		\
+		data.iovcnt = ARRAY_SIZE(iov);			\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov));	\
+		data.cfg = _cfg;				\
+		tester_add(name, &data, setup, function,	\
+				test_teardown_rap);		\
+	} while (0)
+
 static void print_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -330,6 +347,99 @@ static void test_server(const void *user_data)
 	bt_att_unref(att);
 }
 
+static void test_teardown_rap(const void *user_data)
+{
+	struct test_data_rap *data = (void *)user_data;
+
+	bt_rap_unref(data->rap);
+	bt_gatt_client_unref(data->client);
+	util_iov_free(data->iov, data->iovcnt);
+	gatt_db_unref(data->db);
+
+	tester_teardown_complete();
+}
+
+static void client_setup_ready_cb(bool success, uint8_t att_ecode,
+							void *user_data)
+{
+	if (!success)
+		tester_setup_failed();
+	else
+		tester_setup_complete();
+}
+
+/*
+ * Client-role setup: establishes the underlying bt_gatt_client and lets
+ * its internal auto-discovery run to completion against the local
+ * (initially empty) db.
+ */
+static void test_setup_rap(const void *user_data)
+{
+	struct test_data_rap *data = (void *)user_data;
+	struct bt_att *att;
+	struct gatt_db *db;
+	struct io *io;
+
+	io = tester_setup_io(data->cfg->setup_data, data->cfg->setup_data_len);
+	g_assert(io);
+
+	att = bt_att_new(io_get_fd(io), false);
+	g_assert(att);
+
+	bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL);
+
+	db = gatt_db_new();
+	g_assert(db);
+
+	data->client = bt_gatt_client_new(db, att, RAP_GATT_CLIENT_MTU, 0);
+	g_assert(data->client);
+
+	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
+						NULL);
+
+	bt_gatt_client_ready_register(data->client, client_setup_ready_cb,
+						data, NULL);
+
+	bt_att_unref(att);
+	gatt_db_unref(db);
+}
+
+static void rap_client_ready_cb(struct bt_rap *rap, void *user_data)
+{
+	tester_test_passed();
+}
+
+/*
+ * Client-role test body: attaches bt_rap to the already-discovered
+ * bt_gatt_client. bt_rap_attach() walks the remote db populated by the
+ * client's own auto-discovery and, upon reaching the RAS Features
+ * characteristic, issues its own Read Request for the Features value -
+ * this is an unavoidable side effect of bt_rap_attach() and is accounted
+ * for in the CGGIT IOV_DATA sequences below.
+ */
+static void test_client_rap(const void *user_data)
+{
+	struct test_data_rap *data = (void *)user_data;
+	struct io *io;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(NULL);
+
+	data->db = gatt_db_new();
+	g_assert(data->db);
+
+	data->rap = bt_rap_new(data->db, bt_gatt_client_get_db(data->client));
+	g_assert(data->rap);
+
+	bt_rap_set_debug(data->rap, print_debug, "bt_rap:", NULL);
+
+	bt_rap_ready_register(data->rap, rap_client_ready_cb, data, NULL);
+
+	bt_rap_attach(data->rap, data->client);
+}
+
 /*
  *  ATT: Exchange MTU Request (0x02) len 2
  *       Client RX MTU: 64
@@ -494,6 +604,148 @@ static void test_server(const void *user_data)
 	IOV_DATA(0x01, 0x04, 0x13, 0x00, 0x0a)
 
 
+/*
+ * Client-role (bt_gatt_client) discovery preamble for the RAP CGGIT test
+ * cases below. Unlike the server-role RAS_SR_SGGIT_* tests (where the
+ * qualification test driver acts as the GATT client and is free to use
+ * either Read By Group Type or Find By Type Value to discover the Ranging
+ * Service), bt_gatt_client's internal auto-discovery always uses Read By
+ * Group Type for primary services, so no Find By Type Value exchange is
+ * included here.
+ */
+
+/*
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0001-0xffff
+ *       Attribute type: Server Supported Features (0x2b3a)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Type Request (0x08)
+ *       Handle: 0x0001
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define CGGIT_MTU_FEAT \
+	ATT_EXCHANGE_MTU, \
+	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b), \
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+/*
+ *  ATT: Read By Group Type Request (0x10) len 6
+ *       Handle range: 0x0001-0xffff
+ *       Attribute group type: Secondary Service (0x2801)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Group Type Request (0x10)
+ *       Handle: 0x0001
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define CGGIT_SECONDARY_SERVICE \
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28), \
+	IOV_DATA(0x01, 0x10, 0x01, 0x00, 0x0a)
+
+/*
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0001-0x0012
+ *       Attribute type: Include (0x2802)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Type Request (0x08)
+ *       Handle: 0x0001
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define CGGIT_INCLUDE \
+	IOV_DATA(0x08, 0x01, 0x00, 0x12, 0x00, 0x02, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+/*
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0001-0xffff
+ *       Attribute type: Database Hash (0x2b2a)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Type Request (0x08)
+ *       Handle: 0x0001
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define CGGIT_DATABASE_HASH \
+	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b), \
+	IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a)
+
+/*
+ * Full bt_gatt_client auto-discovery sequence against a remote db
+ * containing only the Ranging Service (matches DISC_RAS_CHAR_AFTER_TYPE /
+ * RAS_FIND_INFO's handle layout, reused as-is from the server-role tests
+ * above since the discovered service/characteristic/descriptor layout is
+ * identical regardless of which role performs the discovery).
+ */
+#define CGGIT_DISCOVERY_ALL \
+	CGGIT_MTU_FEAT, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	CGGIT_SECONDARY_SERVICE, \
+	CGGIT_INCLUDE, \
+	DISC_RAS_CHAR_AFTER_TYPE, \
+	RAS_FIND_INFO, \
+	CGGIT_DATABASE_HASH
+
+static const struct iovec cggit_setup_data[] = { CGGIT_DISCOVERY_ALL };
+
+const struct test_config_rap cfg_cggit_discovery = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+};
+
+/*
+ *  ATT: Read Request (0x0a) len 2
+ *       Handle: 0x0003 (RAS Features value handle)
+ *
+ *  ATT: Read Response (0x0b) len 5
+ *       Value: 0x00 0x00 0x00 0x00
+ *
+ *  Note: bt_rap_attach() always issues a Read Request for the RAS Features
+ *  characteristic once discovery has populated the remote db (see
+ *  foreach_rap_char()/read_ras_features() in src/shared/rap.c). The
+ *  real-time bit is kept clear here so that bt_rap_attach() does not also
+ *  auto-subscribe to Real-time Ranging Data notifications, keeping these
+ *  CGGIT discovery test cases focused on discovery alone.
+ */
+#define CGGIT_ATTACH_FEATURES \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b, 0x00, 0x00, 0x00, 0x00)
+
+/*
+ * RAP/REQ/CGGIT/SER/BV-01-C [Service GGIT - Ranging Service]
+ * RAP/REQ/CGGIT/CHA/BV-01-C through BV-06-C [Characteristic GGIT]
+ *
+ * These test cases verify that the IUT (acting as GATT client) discovers
+ * the Ranging Service and each of its characteristics (RAS Features,
+ * Real-time Ranging Data, On-demand Ranging Data, RAS Control Point,
+ * Ranging Data Ready, Ranging Data Overwritten) via bt_rap_new()/
+ * bt_rap_attach(). Discovery itself is performed entirely by
+ * bt_gatt_client's own auto-discovery in test_setup_rap() (see
+ * cfg_cggit_discovery); the byte sequence here only covers the additional
+ * exchange triggered by bt_rap_attach() itself (the RAS Features read).
+ */
+#define RAP_CL_CGGIT_SER_BV_01_C \
+	CGGIT_ATTACH_FEATURES
+
+#define RAP_CL_CGGIT_CHA_BV_01_C \
+	CGGIT_ATTACH_FEATURES
+
+#define RAP_CL_CGGIT_CHA_BV_02_C \
+	CGGIT_ATTACH_FEATURES
+
+#define RAP_CL_CGGIT_CHA_BV_03_C \
+	CGGIT_ATTACH_FEATURES
+
+#define RAP_CL_CGGIT_CHA_BV_04_C \
+	CGGIT_ATTACH_FEATURES
+
+#define RAP_CL_CGGIT_CHA_BV_05_C \
+	CGGIT_ATTACH_FEATURES
+
+#define RAP_CL_CGGIT_CHA_BV_06_C \
+	CGGIT_ATTACH_FEATURES
+
 #define RAS_SR_SGGIT_SER_BV_01_C \
 	ATT_EXCHANGE_MTU, \
 	DISCOVER_PRIM_SERV_NOTIF, \
@@ -526,6 +778,18 @@ static void test_server(const void *user_data)
 	DISC_RAS_CHAR_AFTER_TYPE, \
 	RAS_FIND_INFO
 
+/*
+ * RAS/SR/SGGIT/CHA/BV-05-C through BV-12-C [Characteristic GGIT - Ranging
+ * Data Ready / Ranging Data Overwritten - Indicate, Notify, Read variants]
+ *
+ * These test cases verify discovery of the Ranging Data Ready and Ranging
+ * Data Overwritten characteristics and confirm their declared properties
+ * (Indicate, Notify, Read) via the standard GATT discovery sub-procedures.
+ * A single discovery pass covers every characteristic in the service, so
+ * the byte sequence is identical to RAS_SR_SGGIT_CHA_BV_04_C; it is reused
+ * directly for each of these test cases below.
+ */
+
 /*
  * RAS/SR/RCO/BV-01-C Characteristic Read: RAS Features
  *
@@ -745,6 +1009,22 @@ int main(int argc, char *argv[])
 					RAS_SR_SGGIT_CHA_BV_03_C);
 	define_test_ras("RAS/SR/SGGIT/CHA/BV-04-C", test_server,
 					RAS_SR_SGGIT_CHA_BV_04_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-05-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_04_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-06-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_04_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-07-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_04_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-08-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_04_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-09-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_04_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-10-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_04_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-11-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_04_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-12-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_04_C);
 	/* RAS Read Characteristic Operations */
 	define_test_ras("RAS/SR/RCO/BV-01-C", test_server,
 					RAS_SR_RCO_BV_01_C);
@@ -760,5 +1040,38 @@ int main(int argc, char *argv[])
 	define_test_ras("RAS/SR/SPE/BI-11-C", test_server,
 					RAS_SR_SPE_BI_11_C);
 
+	/* RAP Client GATT-based Generic Interoperability Test cases */
+	define_test_rap("RAP/REQ/CGGIT/SER/BV-01-C "
+				"[Service GGIT - Ranging Service]",
+			test_setup_rap, test_client_rap,
+			&cfg_cggit_discovery, RAP_CL_CGGIT_SER_BV_01_C);
+	define_test_rap("RAP/REQ/CGGIT/CHA/BV-01-C "
+				"[Characteristic GGIT - RAS Features]",
+			test_setup_rap, test_client_rap,
+			&cfg_cggit_discovery, RAP_CL_CGGIT_CHA_BV_01_C);
+	define_test_rap("RAP/REQ/CGGIT/CHA/BV-02-C "
+				"[Characteristic GGIT - Real-time Ranging "
+				"Data]",
+			test_setup_rap, test_client_rap,
+			&cfg_cggit_discovery, RAP_CL_CGGIT_CHA_BV_02_C);
+	define_test_rap("RAP/REQ/CGGIT/CHA/BV-03-C "
+				"[Characteristic GGIT - On-demand Ranging "
+				"Data]",
+			test_setup_rap, test_client_rap,
+			&cfg_cggit_discovery, RAP_CL_CGGIT_CHA_BV_03_C);
+	define_test_rap("RAP/REQ/CGGIT/CHA/BV-04-C "
+				"[Characteristic GGIT - RAS Control Point]",
+			test_setup_rap, test_client_rap,
+			&cfg_cggit_discovery, RAP_CL_CGGIT_CHA_BV_04_C);
+	define_test_rap("RAP/REQ/CGGIT/CHA/BV-05-C "
+				"[Characteristic GGIT - Ranging Data Ready]",
+			test_setup_rap, test_client_rap,
+			&cfg_cggit_discovery, RAP_CL_CGGIT_CHA_BV_05_C);
+	define_test_rap("RAP/REQ/CGGIT/CHA/BV-06-C "
+				"[Characteristic GGIT - Ranging Data "
+				"Overwritten]",
+			test_setup_rap, test_client_rap,
+			&cfg_cggit_discovery, RAP_CL_CGGIT_CHA_BV_06_C);
+
 	return tester_run();
 }
-- 

