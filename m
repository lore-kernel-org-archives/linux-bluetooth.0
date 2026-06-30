Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF413ED126
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814341; cv=none; b=dUwdT8lMKS1TRPk6rglw1IC78++J+9w2+32Bq6WCV4Xvja/IxoTf25p70vuxjNj2z9T6P6ek8vPSdS+tcPEk/j9lPQhbNdJJgvhJMOtALk3djAUQvgPV6rRWpoaKhgMGxqF3bfDhzU8L8d57ZXBA9inRL2qPuJJLk64ybRpFcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814341; c=relaxed/simple;
	bh=ZQieYxCxvF1f9LFqEfvuLNcj11i5IgUkrgyErOjkyzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GezL2JeHY8vOfUriQLDsqAHjbK72NnTiHolNYyH9GVwLuZIpRXuYXyQqVt8HFRLQCQiSjyk2BeN1D9XCMwR0KMr4QuRd4G9MRMsdihCND76KdsgRzZcjJVamEYeBMP+a+w69rHWS5yLWUBW84YhoGubTqbTnoydZWeAUNXMuiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FPmSPEPT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=em5eCOfH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FPmSPEPT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="em5eCOfH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n4uj1508636
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PNIeuTYr/JM74BvSU0WVTQAfXao+yyfZnUy99q5r0o=; b=FPmSPEPT8ca6KPab
	793cq+rY6MMlpA97UhKuyW8iJo7jorQKlx4Q5NSpgsKa5dPPYRhcsyhZb9NwhXm7
	6ZHxKgEyMlQbVjw86/6FkNiQEk4elEjIOkUMt3C6Vw9GPXQtSB/Iu3SMCEJXUeM1
	0+1VnbMaZlXwX5qGd7tEaO6LEV9EsMMxUMjTaiQA7LV6SMp/wrjPjozYeHMoadus
	cKTpiLVZwzuSpBlwgoIfB0d3pi3K3ovAgf46TTKFPfu/ksy4tw0w4wgS8nbACiqr
	a9WU+mYOCPUWGDTDEDDrHMF6YDX8RjKj9PARMBoa0guj7kA7OpziXaZJrpZYGr5k
	R8c17g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9j2wn9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:19 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-137f3465368so6330634c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 03:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782814339; x=1783419139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PNIeuTYr/JM74BvSU0WVTQAfXao+yyfZnUy99q5r0o=;
        b=em5eCOfHnE4OkWbu/hQ4CZLY8CyjtEKcm0BU3z87X0I49ObSIFTjZB0VQpqO6cZjVE
         qoNfZtyolWKp28Rn5JSlp1WjHn9Hx4peJdwa9SHbXi5KaoVA8xuesygJj294OYxdlUA2
         xGvu9MqEeYwnjuSaEydvfqFGRkMsEhQFdgqfniq/uuhL5VMrLXUZmYAUzEA6VLmIX8We
         q+hvNVNIYEaMxVMtsjFE8+1hW0EazCnhe5EH1m6CHFod3aNDxlC1a0dp7XrtXho2socB
         fu4IpmlEVNulBjsUFrb6RI36QEdEHUhEQ5uw4O+jeXZcF4ArsRlz+FzIWPhClnrk+WaL
         /MJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814339; x=1783419139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PNIeuTYr/JM74BvSU0WVTQAfXao+yyfZnUy99q5r0o=;
        b=jaZYMXuNzjExoCftjZVPDt/kfJdlwUT53LKccgZB7/FfltPcunvxsG59HmIfCLOriF
         FL1UQnDBcwwbEioVfOunEAsqX56lvHtTY787LZIalwWE0wTyrex79XxRR4QsiczFfuTh
         clHBWhmp0NeeLY6zGUPrEgxX8/bMyHAVjdvpQ3t1ehvnovODTU9t3PsX8FxxWbZukEVg
         MfotB02xKW/n3vzALItypv6LXrSAP0NNWZy7gCebxOGa1lCYA4zFnn+UOTkY8enT/LdZ
         EagKBoSihGK+JSvwhTU+8ygg6ZpWwK/uAEfday/2o2JupbOpdSBpKKC5oFbuzOk+mkK3
         mFZQ==
X-Gm-Message-State: AOJu0Yxu0eQ2AfXoxo2tPZNG8cy32iVea2JumpMnro4rM0CF/tIYZDGn
	hRfI1H5w3xTKqdx2vUJfSNx+t5Dt3BDiBDQ+0C5xLLDEFEM5tsNRFLBtpQMBwYST+QLJU4eof+n
	upKG2a8AwDalMT6NMqMkfjqnvJs39MYOfniN+NNwqwmnS9BBnLcq2AYYgMbj8m3tLQ1f6QTIpYx
	WQfVo=
X-Gm-Gg: AfdE7cndp00cPbrW/dhwGYdGFebXs396tG8zJ/fIdAgZaQvw9Hc0+eMafFeBhKYSnOX
	1NnrKiaDLioJUL/mXGmKSvbq16MAKca0OiOhW8J69erisL/zDwmG3t7cryX6dAqysq0QbO+lsLL
	ixuUF9fIOWzruAJ+c7YDAotSaI/63ACvnDEcCUywVI3R3U0aFWPlct8ajWuCgFjTpHJ64lEYtbK
	lWefaVHXao3FU8rxRzAN6BL+R/9FXXR/M9MmbrJyvJ+HpubZONG+qlCRCPBez761G5QS7KiwDyP
	T9Iicq/yWmOQcEZQuyxQ5CN7Nh50hpR/dvg/cFLHVcp2ZODUAaL3NGkwIliZvqD5nDhiwGjS9R2
	ey6EnUQEzwr8Rwex2d7Dq4ogxKsIG2yiC5HV2fsra
X-Received: by 2002:a05:7022:1e11:b0:139:ed5a:eeea with SMTP id a92af1059eb24-13b2a1bf0f1mr1875518c88.41.1782814338839;
        Tue, 30 Jun 2026 03:12:18 -0700 (PDT)
X-Received: by 2002:a05:7022:1e11:b0:139:ed5a:eeea with SMTP id a92af1059eb24-13b2a1bf0f1mr1875498c88.41.1782814338318;
        Tue, 30 Jun 2026 03:12:18 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba6fe2sm5670060c88.9.2026.06.30.03.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:12:18 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 2/6] profiles: update bt_rap_attach_hci call to drop default settings args
Date: Tue, 30 Jun 2026 15:41:54 +0530
Message-Id: <20260630101158.2239682-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
References: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XVlO0VVqY4Q5Qnyaty7bD6KMp9_nYi0i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX38GC5ntZPhtE
 CO0mTfPeOSDPTWZfDLNXph+RK2+TUOkGJQLwFhqOGtK84wSfkwJnVIZg8/MC/jPSPQ6GQKILdFX
 romlalAUfErvClk52rGrPln3M3z+HPviWWMxntvD9Mjkia3FLtGFIf7E2znPNL9OoISmTjCYVCm
 2w0VQtB9utFyU5Ec5g1sxO2LkshF49jDLOZqQ7l8mtQ2PlDiLWQMHPPxcb1QYcvNWc8rzlXQfdN
 O6JrQ+Py+MMN57vX+LpMU9YUFQi7eBiNso1P2N90UvsVncaeWeKGqFFBU7huf/aGOLVH1ZpbkGr
 OliJjisUwJfXs3V9devyBUVT3yGyi7oq7TNyCiNlg1oCCTEQDZpwcUJHV9hi+zink3GEGiRNhys
 iKlxhGHcu1TxBk0vvmo+3OSPA+Bqvf5lkauSHfxflewghiT0yl+TmcWjlmUS3VvurdJSYOX7SMw
 ihO50/9BAGN5P8PNCcw==
X-Proofpoint-GUID: XVlO0VVqY4Q5Qnyaty7bD6KMp9_nYi0i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX0iOIXZQEt4Lo
 389GyWvZPV15lxS0Q9v+hOiBIQyKsr/z8z+uy4dniX9Jd9FbA2D2eaujRioyMPuAX6qrCAZkyb/
 ZHjyg8FoLNCkzTIWA/6cRoXy5LWRpgk=
X-Authority-Analysis: v=2.4 cv=SINykuvH c=1 sm=1 tr=0 ts=6a439683 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=1xSUoluFets0lPgo31IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300091

role, cs_sync_ant_sel and max_tx_power are no longer passed at attach
time. They are applied via bt_rap_set_default_settings_params() in
start_measurement where they belong, alongside the other per-session
CS parameters
---
 profiles/ranging/rap.c     |  7 ++-----
 profiles/ranging/rap_hci.c | 27 ++++++++++-----------------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index fa3e27328..da6f1241b 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -383,11 +383,8 @@ static int rap_accept(struct btd_service *service)
 
 	/* per-device HCI state machine */
 	if (!data->hci_sm) {
-		data->hci_sm = bt_rap_attach_hci(data->rap,
-					data->adapter_data->hci,
-					btd_opts.defaults.bcs.role,
-					btd_opts.defaults.bcs.cs_sync_ant_sel,
-					btd_opts.defaults.bcs.max_tx_power);
+		data->hci_sm = bt_rap_attach_hci_v2(data->rap,
+					data->adapter_data->hci);
 		if (!data->hci_sm) {
 			error("Failed to attach HCI state machine for device");
 			rap_adapter_data_unref(data->adapter_data);
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 13f1365f3..8726ce824 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -169,9 +169,7 @@ static void remove_conn_mapping(struct cs_state_machine *sm, uint16_t handle)
 
 /*  State Machine Functions */
 static void cs_state_machine_init(struct cs_state_machine *sm,
-				struct bt_rap *rap, struct bt_hci *hci,
-				uint8_t role, uint8_t cs_sync_ant_sel,
-				int8_t max_tx_power)
+				struct bt_rap *rap, struct bt_hci *hci)
 {
 	if (!sm)
 		return;
@@ -183,16 +181,18 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 	sm->procedure_active = false;
 	sm->conn_mappings = queue_new();
 
-	/* Store role_enable for HCI commands (1, 2, or 3 from config) */
-	sm->role_enable = role;
+	/* Defaults — caller
+	 * should follow up with bt_rap_set_default_settings_params()
+	 */
+	sm->role_enable = 0x03;
 
 	/* Initialize per-instance CS options
 	 * Note: cs_opt.role will be overwritten with actual role (0x00 or 0x01)
 	 * from config complete event, but role_enable preserves the HCI value
 	 */
-	sm->cs_opt.role = role;
-	sm->cs_opt.cs_sync_ant_sel = cs_sync_ant_sel;
-	sm->cs_opt.max_tx_power = max_tx_power;
+	sm->cs_opt.role = 0x03;
+	sm->cs_opt.cs_sync_ant_sel = 0xFF;
+	sm->cs_opt.max_tx_power = 0x14;
 	sm->cs_opt.rtt_type = 0;  /* Will be set from config complete event */
 }
 
@@ -1533,9 +1533,7 @@ static void unregister_event_id(void *data, void *user_data)
 	bt_hci_unregister_subevent(hci, PTR_TO_UINT(data));
 }
 
-void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
-			uint8_t role, uint8_t cs_sync_ant_sel,
-			int8_t max_tx_power)
+void *bt_rap_attach_hci_v2(struct bt_rap *rap, struct bt_hci *hci)
 {
 	struct cs_state_machine *sm;
 	unsigned int id;
@@ -1552,9 +1550,7 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 		return NULL;
 	}
 
-	/* Initialize state machine with provided CS options */
-	cs_state_machine_init(sm, rap, hci, role, cs_sync_ant_sel,
-				max_tx_power);
+	cs_state_machine_init(sm, rap, hci);
 
 	sm->event_ids = queue_new();
 	if (!sm->event_ids) {
@@ -1621,9 +1617,6 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 
 	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
 
-	DBG("CS options: role=%u, cs_sync_ant_sel=%u, max_tx_power=%d",
-		role, cs_sync_ant_sel, max_tx_power);
-
 	/* place holder, need DBus API to be called */
 	bt_rap_read_local_supported_capabilities(sm);
 
-- 

