Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418624BBEB
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782109760; cv=none; b=MVms5ZwGRU/wJWsUL80M/GdB0+jsex04+pDMonlQNX23XjpXEKMBg9LWk1yBCHw6k72uGOz2vHCBnyx2plTcgsNzrsYMto2qMfpVkBKpGRlmArtL+CYRc75WXFkI7Q01rCkwYSdJbY6mRvdKPZ3/9dooYA21wl1bwfVuTzaOIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782109760; c=relaxed/simple;
	bh=thfTyMRmUxxdPd9lydYTNlXByELVjAbnILGLpsESX6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WH17tqe5A7SMQ94IHCNUTQkWRXxHq8yrkUdh1jOEEVNw9T6Rgp1l3ptJIGo/uzAWuMAIOaQmNJdb+mRs96bApthh5f9t6mFXAeNsoDc+EcYnsbYhpowZUwjEDjHNZGwdoTkY0huHVTMWTZ8C5w5nO5OifgbMOwMYotumEEnlWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K6j2mry9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TBp5EKPj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K6j2mry9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TBp5EKPj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M59BAc3850438
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 06:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+Ufgwpz6Tiw4aXb5FHnDfrGmSuMEX+hkTM5
	Dw7AWLSg=; b=K6j2mry9WbamqRFOpS+R6vUBBpt2hu0MD9M35KGsHDKwc6a7VBj
	NR8DcV2j7kkWkqAXg4p/a6si4/uNsYdh/tXie5t7bKVRyf9Hb9Wms8GWQpLpwkT1
	2b5n4mzilMMU/7xCRsVQqsuGz0yIUmVCPt/ljgKs/aGgL6ihlQqWX36bF5poaCc+
	Lu73r1fxKEkUfFLnF2eU3eFk5VnnIa1BtXelg7NRBISsCy2yjYuS+nhGzcagNC6u
	jcO3Px68s29jvikLnSv2Kyz4xYzGBswa6Z7up5MHBpkXVFB/svcCb8NNyspzM0wW
	MArlUhwA4ynlSGlJNuhOtJw14TBzLUj2r3Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewm584vp5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 06:29:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8454912a507so5680310b3a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 23:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782109758; x=1782714558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ufgwpz6Tiw4aXb5FHnDfrGmSuMEX+hkTM5Dw7AWLSg=;
        b=TBp5EKPj92NCaR6CUbJawTBxeSIG9yEP02mgSMNmCcnIc7qelvqpNzQJsC5QPKbDT2
         i+bkzYR/DyoC92rrAYzBpJ9AJyiPJvCjAl7nAKEcHQ8c3kFnbGaau925RU0qaFcFtbc4
         vt0oLqMhzvkkuDra7xH4aqddlz+OvKgvjHGDcLWJLO+vj5YDqvLLCdleluZgeXgLf9xu
         oiQVWGaUG3DQfvoj4MRtlWkynoxdZ9o2BqS0mY5fyzAdq8rP6ll7LZBQ1jl/aiKgZPmX
         Wxe28+IrO0M6ai2DI/LlWjP1UrASB6GgMYUXIch0qBYS7Ou5L+DUBJ6F/izT5F9EB11e
         0iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782109758; x=1782714558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ufgwpz6Tiw4aXb5FHnDfrGmSuMEX+hkTM5Dw7AWLSg=;
        b=mz3AdP0dFozDv376IoGd8rn4H7IwDPEbKLDjv9yLV/NyCbHTMqcYGfXXBNT7sqBnF1
         FgR4j/cz5oZju9jyQR1cviZ4OW8LYSyM1s6tj+gPhbYhWZTnt7H+eHzxfb8PUX1eHwNq
         eNP9UnPcC6PDCzbfCrx3VcIW3PrdWoaEuUkJnKPpHO+xN77wNEeYQ5eOupgNDoFRLbro
         +ldN2YVNaSgrYQnxLQ8QDIxtzPFlKUImJ+Ak0aJ9foSIU1HDgVlszXJUzyzjKF/ODN+q
         DAC9gQ75NAiqNDcQAuG8R+mbi5kxnY9PozNbkpLno39pf1MyEp/KYEeRBZUuQTHADJaB
         iBrA==
X-Gm-Message-State: AOJu0Yzh2Zp/L0NFDzSOeUxnHSuzz+iaqJT3McUNuB7ocFPrL2xo6quB
	gDNX5s8rb/2s9droPQfC3kglIGGsKYKQrpA3CzQngBG9hcwop04RmVj2U6eTlUUQh9vgR+AbwE8
	BHpe94ljuIEaBEN/c7LQccrhWIQs3z7bEMJ548IqaqEJfFVSQUJdNM0NrETgFSwflgsp+9j/8cd
	T5bgA=
X-Gm-Gg: AfdE7cmmM0XMjBVNfFcBVLAJQ+tYsm16CGl5IfEWYKP1XTEXqxfqKhQOR3EecK4hw/d
	tlY7oaN7/p4cqiAO4jL69/gJHbcrjS886dERF6DQDIwJNpzjfTfUKrbX9+4/foCCZp3GB68i9PB
	f8bX2CFs6YjCM2uOVWgJKNvvXfpXRTz6eCrR+hmtJyRseeneqI0WxUFkXRg9fJTRIN8dJFuKxId
	W0X5bBnvFKfUnBqEzcdRF6gNW863r3E80kPD6juGlQNdGRv12AsLGQ5pvHkuHhocSHYfi95JXGv
	xYHIJ8bd0tjSEwitC9UNrUi/Dctl+eYywxBIrdweDkq6xADHWGvkIBkNahDLUohpP6WSJQLW74Z
	5kLOE6mj+133QDLkSecT9a0qFWa42sViUBq3dKC7q
X-Received: by 2002:a05:6a00:4206:b0:845:4d71:8d15 with SMTP id d2e1a72fcca58-845508a31b5mr14659647b3a.37.1782109758028;
        Sun, 21 Jun 2026 23:29:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:4206:b0:845:4d71:8d15 with SMTP id d2e1a72fcca58-845508a31b5mr14659621b3a.37.1782109757644;
        Sun, 21 Jun 2026 23:29:17 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ecd784sm6585716b3a.54.2026.06.21.23.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:29:17 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1] shared: rap: Defer CS Event registration until  connection setup
Date: Mon, 22 Jun 2026 11:59:05 +0530
Message-Id: <20260622062905.3525480-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bbRknyXVCreBKqcXSTsEA49KnGePIxL0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA2MSBTYWx0ZWRfXzka10BhJjwHT
 MRpUCoYd+QYL40K5fg3B8E1Ywrh7uWHY86nOAe063VjS8MtJ5BdijcXGffPxp+LZ5AUwlBvI0mV
 Eae9JnvNpqV3qAC6yyVKG2QyrIq/+Zc=
X-Proofpoint-GUID: bbRknyXVCreBKqcXSTsEA49KnGePIxL0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA2MSBTYWx0ZWRfX4GGJq0162hTd
 hPskejBcEAPhsRfbaMi15bGHH2bZvPdBXrErN3pc437tBY2B+HJ/aqVpdajh2hMMZMpHXGct2N6
 lGk+KGTI57hFz6H79PbtNhO9c6CZJXzXSOSa9hAGOcojz69FwMQf9ZPjNPoNlOPkBMIlPB2PI4R
 /+i4KpidfmZc/GjHtOOPuNsKgjkcM4+gl3lD0kphRoxk15XMhCkEBQnKZ0YiAMGdeGtP7+6mnCg
 uJxbPqaPyJVw56sZO4C6EOt8fZsKYH9Z9Mr9drh2I6XxjQz5P9sJYYFaXHmHvT1NpDrd8QcC4iu
 p/z4CKUFVrXe6yyLmw8Oi2Pq+kp06N6AQsqU7vhjlVLpImp7pAfZuePw5HtQGg6bLR3gBfOc4gj
 UhvWgXH0VT+UtCA+42zUTA9Z0JEMD2/BtHwOrihcFB+JGMUcwz+DXskxAZRQM0hYawW3KVqL17s
 nuodISybbB+B4b+91ug==
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a38d63e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=rFCxpR0ieje3pdpa7SIA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220061

Move LE CS event registration from rap_probe()
to rap_accept(). rap_probe() runs during service discovery
while no ACL connection or connection handle exists,
so connection-scoped CS events cannot be delivered or
associated with a device. rap_accept() is called
after the ACL link is established, when a valid
connection handle is available and the HCI layer
can route events correctly.
Registering events at this point ensures
proper handling of CS events.
---
 profiles/ranging/rap.c | 63 +++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index dc57eeda6..fa3e27328 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -322,35 +322,6 @@ static int rap_probe(struct btd_service *service)
 		return -EINVAL;
 	}
 
-	/* Get or create shared adapter-level HCI channel */
-	data->adapter_data = rap_adapter_data_ref(adapter);
-	if (!data->adapter_data) {
-		error("Failed to get adapter HCI channel");
-		bt_rap_unref(data->rap);
-		free(data);
-		return -EINVAL;
-	}
-
-	DBG("Using shared HCI channel for adapter (ref_count=%d)",
-		data->adapter_data->ref_count);
-
-	/* Create per-device HCI state machine with valid rap instance */
-	DBG("Attaching per-device HCI state machine");
-	data->hci_sm = bt_rap_attach_hci(data->rap, data->adapter_data->hci,
-					btd_opts.defaults.bcs.role,
-					btd_opts.defaults.bcs.cs_sync_ant_sel,
-					btd_opts.defaults.bcs.max_tx_power);
-
-	if (!data->hci_sm) {
-		error("Failed to attach HCI state machine for device");
-		rap_adapter_data_unref(data->adapter_data);
-		bt_rap_unref(data->rap);
-		free(data);
-		return -EINVAL;
-	}
-
-	DBG("HCI state machine attached successfully for device");
-
 	rap_data_add(data);
 
 	data->ready_id = bt_rap_ready_register(data->rap, rap_ready, service,
@@ -382,6 +353,7 @@ static void rap_remove(struct btd_service *service)
 static int rap_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
 	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
 	struct rap_data *data = btd_service_get_user_data(service);
 	struct bt_att *att;
@@ -398,6 +370,33 @@ static int rap_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	/* init shared adapter HCI channel */
+	if (!data->adapter_data) {
+		data->adapter_data = rap_adapter_data_ref(adapter);
+		if (!data->adapter_data) {
+			error("Failed to get adapter HCI channel");
+			return -EINVAL;
+		}
+		DBG("Using shared HCI channel for adapter (ref_count=%d)",
+			data->adapter_data->ref_count);
+	}
+
+	/* per-device HCI state machine */
+	if (!data->hci_sm) {
+		data->hci_sm = bt_rap_attach_hci(data->rap,
+					data->adapter_data->hci,
+					btd_opts.defaults.bcs.role,
+					btd_opts.defaults.bcs.cs_sync_ant_sel,
+					btd_opts.defaults.bcs.max_tx_power);
+		if (!data->hci_sm) {
+			error("Failed to attach HCI state machine for device");
+			rap_adapter_data_unref(data->adapter_data);
+			data->adapter_data = NULL;
+			return -EINVAL;
+		}
+		DBG("HCI state machine attached successfully for device");
+	}
+
 	if (!bt_rap_attach(data->rap, client)) {
 		error("RAP unable to attach");
 		return -EINVAL;
@@ -408,11 +407,7 @@ static int rap_accept(struct btd_service *service)
 	bdaddr = device_get_address(device);
 	bdaddr_type = device_get_le_address_type(device);
 
-	if (att && data->adapter_data && data->adapter_data->hci &&
-	    data->hci_sm) {
-		/* Use bt_hci_get_conn_handle to find the connection handle
-		 * by bdaddr using HCIGETCONNLIST ioctl
-		 */
+	if (att && data->adapter_data->hci && data->hci_sm) {
 		if (bt_hci_get_conn_handle(data->adapter_data->hci,
 					(const uint8_t *) bdaddr, &handle)) {
 			DBG("Found conn handle 0x%04X for %s", handle, addr);
-- 

