Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB01A3166
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826800; cv=none; b=rpWxJ7WITkCBHaEXY2EsCjSdgsyWs3IyO5froHYlsK8B/NzG2vgIrO7yXSxQ8sydKLZOW0TrBKwetBn9hwLah/Zu3wouxCQWIJWcmLyaLbURN1YEyNz2W1iOx3Xy0nYKl0qqXCyiNzLIoUmhWlg7ZrkI6Qh4QzfCwS/UrtcqrIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826800; c=relaxed/simple;
	bh=ZQieYxCxvF1f9LFqEfvuLNcj11i5IgUkrgyErOjkyzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zx7S07UwLdMFGHKCeX9lb6RBxzP9IWzxr7LxJLNZKRzGkzvAf1HLmKIZn+SKt3TlmET3L1IJRBuNW/rg7tAh4WLofqFplgA+ZmF5avw3ZQAhuDp+bC1Ijq1YXtpb7fGvCaHjSDxzPjjKmPBcHVXVJgdVlWLqZfH5eoBX6XoACgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iT0niTEw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KrjWGkON; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iT0niTEw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KrjWGkON"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mueX1604531
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PNIeuTYr/JM74BvSU0WVTQAfXao+yyfZnUy99q5r0o=; b=iT0niTEwmassLnt5
	XrXzUnX+3G5k3kuV5WUwIXunMHvGeKaXcLX3hkbBR7SG5aav8yxQoNbsX9KgvzHj
	tN2blOKYYEhnZZeEv7zi8bDFBstLKekdXO2Oa9IlgsCa1qNdK/KUXUrWdB0DJbL6
	kUwP6kZOzu4tMpo+ji8UdvFZc6eMt3gevybjXurfpNIAmKdCRQXGdhn0VY4GsyHR
	VKjUCLFqSD+JoXnKEBaJt72idqAmOCv06AuM2+h3VEf9i8cOLcvmfqi/5O5APYdv
	V4oLnyxAJYibx+rVbKkOGZB88E0T9HmkEkgNlgYTqWmMIsADsLLslhxeyuJlYwHL
	M0Wufg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f462fjg00-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:39:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30cb5001ed8so4793120eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782826798; x=1783431598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PNIeuTYr/JM74BvSU0WVTQAfXao+yyfZnUy99q5r0o=;
        b=KrjWGkON7CVW58YcCaO3Th9oQB+0cTFUc/CTJ+GEdgJPGR0ThQ1/zMR/hiEghWYu85
         FuLq9k/LtjlExGVm75EUK289/PL3rxGKqB9Q1luILRRwtot+NFGBavl7/sZ9B4Dh9xLi
         ov3I8FHDKteGshOyOzAmmuPdQjPNmOCw0S2rPpU/kibopLHQllrgqvlxNGBEcA5W4Od7
         KyFoESYGsdGHQpkgImKhQvSTn2cDyBQVIy68+UOVj8IFCEyU51hE2kOhQ54GMYrSduJU
         RZlWiNLzZWAzjYPuzVTkjVn52cEyl/F4Etgax9zzPTn8QPMYoPimE/0EwjI2GHM1x8d5
         JgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826798; x=1783431598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PNIeuTYr/JM74BvSU0WVTQAfXao+yyfZnUy99q5r0o=;
        b=Qe1ysXjVpOOoZL32FFjSrL6Rak2+A+wOgmbo/Isug3pfW82iqyku3SMQB6UHwEBkb0
         pZdHusqdlpFYqdQjye2bZWCIlY0BnSnTPNL1l2jb/P/YH8/WqjOguVnSwSZ6op3qCTQP
         v5e4VWpifMF1Xe4CWbcpOdKWqiG8P9zQ0DNIMIcB380ES7Xgf/fFJ98ywuJbDF9mwX9P
         4UK1qgpBbjApwXIEV4gFwh5SEmZ+J1y3hkobf0d+A2b66dBLjjk3aPtEFn4Cwqzq1m31
         i4gVxUiHToGXiBTmOC7CSH3QEJkYprc6G7HLWuA1k7GrDJWkE6JTA6frLlNu+ppM0549
         TzhQ==
X-Gm-Message-State: AOJu0YwoxFd/csSgXUadSqX2xQ/eyKGpeK1vfBkvzCd9Ea5tmpdQKewh
	D5zBkBuH89FAq7S/li2WoGlATW4h/UzOQ06HOmfca52ngifjhcI3Z3IcFVRzHXdx/q90aXqqbbX
	WKrHVu+KuQ0b7NHdZt8zhUodFDO/3SghSy9UcDvl6drOidYkUqvE3K72SxizVOvBIgc3HA8nX6l
	SbRuc=
X-Gm-Gg: AfdE7clYqwQX3XJslLi+fGyKdvhC0tw9Bp0WzeewnAodNrZEUMZ+koR2+2hmZziCpFZ
	ROTJjJFtcKjWjSpPSSaZs8R3gF3Qrda7YzT4dIi7o4ZrYwYKxXzR/cIUKuH1rCu2aIAoV8cJTPj
	8gQP90kThqr30K5viNq1TCB+/jQyIeM3TAB9aNpXcGrZEyWDAnTD8IaZ6CpxKIw+q5uoXpLpU5+
	CCx2Nhu83IwUhKS76Dg6uI15/dfu9ZzAeMsWNV0sFgErQuCTkYMSkQd4NezUazMjgY8iA1KPy8m
	/Tyh3ElOwJ7I7EQtN0k5ASJApB1EvUfr/SR6qii6epAJRsNIuiLxhX0Dr7+FXRTwfsXmKVJohGt
	Phl3YKXKOERw4Qkd1hxD4IPoJa4NG3oT+AHmq982X
X-Received: by 2002:a05:7301:1e96:b0:30d:d98d:e44e with SMTP id 5a478bee46e88-30ef0821d5fmr400828eec.6.1782826797942;
        Tue, 30 Jun 2026 06:39:57 -0700 (PDT)
X-Received: by 2002:a05:7301:1e96:b0:30d:d98d:e44e with SMTP id 5a478bee46e88-30ef0821d5fmr400807eec.6.1782826797381;
        Tue, 30 Jun 2026 06:39:57 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5e4dcsm8704158eec.5.2026.06.30.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:39:57 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 2/6] profiles: update bt_rap_attach_hci call to drop def settings
Date: Tue, 30 Jun 2026 19:09:36 +0530
Message-Id: <20260630133940.2461816-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
References: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX/a53q485TyGD
 IXws+Yk6kiKqHuXflOO5MYNH16DltPmZenpYwuS1NlquLWddCwJwKYvu/IaILPvuUVJWX6zKhcJ
 UE6u2OD7Y7ZiW2SwJDi+NZByj1ypp1TB8sH5ewYfFTYpoPFBDHjhdXmQtJPuQIVMGBRrultETj6
 xNt/e8id45xdPM4cbia1eQwAqTSz4RI8HTOQVLufeCInluCe9g6/clxUwti+G1GeqKpzEfk3U3n
 IC65THmp4Y35fJ1rBsYxlMz47vOxmKA02Jpq1ORuqwvLm64Pn8QYhBIX/0t7V1HzKQIIlS5GCC0
 6OonfNQ0BHLskpwnABwvomojdP/ZKX3kdBYTeQ4vJIB0xX+tv0Oiw2kyBn7GfvApMhJ21z3SrH3
 ieqruiq8aogFn4VAW8X2p1XSoZsg0A8NrEHaV/vP5SePab3VTL68TRuBXTQpGwrGoI5/EdSXfY2
 VesQF3g9wS4GmO3zTCg==
X-Proofpoint-ORIG-GUID: 1BtqgfsYPimo4flwRz65Lg7WdqnzYSZG
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a43c72e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=1xSUoluFets0lPgo31IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 1BtqgfsYPimo4flwRz65Lg7WdqnzYSZG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX7aN0p6XWZ3FX
 fASnP/QoR4PpgcHR0wopJlCaCDjxWEjWSpBebnDZIG7FEamsZmRhFo5ncH6/DJzES4KqD37w0hJ
 oOcFIFmb9FCnXi0OT39wufRp9x4BHis=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300127

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

