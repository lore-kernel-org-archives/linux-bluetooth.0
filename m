Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051BE23ABA7
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295326; cv=none; b=hwS3Zfvv/MuM+et44fLtEFp/IOvQl0AFX9ofNTWx59lE1NRpZNF5YZjxSpFYwFHVSqmegblfB0hswfCkJ/UN3PW7LdKtu03lWFmjAMq3IpIHkjBE9o3NRylP6CDjZg3xE1uiCT1K84l3B4CSvdlYPuBre7Uzz2xczZQKGU3Jnyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295326; c=relaxed/simple;
	bh=30YGUoGbvUPQ4crRj8U56VSWD78HXXaS2pnvRnmeE0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBSr+KE6+fx2x8saWOHcuYDUUItkeMXgs5VjwjBhMcBHVdtk1Kf9BfRsZTgofLTf2wvvLDneT4WzO24Ia0W6xybZV+9Oe0EgmwJcoPYCs8vsVw84OwnNtvudqomOMBi25sLCnl5HkkEHuo2Y262gH0JY53zxWP7gY2tH8kmRDd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MT0ZImIM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L5yUtxWH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MT0ZImIM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L5yUtxWH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCT04O1964567
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qKn/zt8XKSp
	iuXhFD+JzIr50HAeALbMHuQBYFPoZC6c=; b=MT0ZImIMjpib5t4LK9b6EfigDW+
	v6cef5ba6c8TTqvPezvlbBK+Wa/DS8dpL0Zap3HDVrP/6DMUHof6KdkqI1E7raqp
	R/3TeEeXLp2rQcUuTGpUeswwYEzjqMBHV4jTYBwC11B6Kilxmh2kUgWHOyMT1uKg
	UKSLxDi4VEuAuX/qw5Sh6JEbHjk+UYhphzgPZoeWFo6V3FWUQCEP6yB0U/NpHAo8
	Xw0cqhN1asdF0n0yT9XaUfOP3y81YIrnvOVTtblo3UCpi2IGOjBMXhxS/xuEo3YJ
	YvpQGNOYD7VjoGXc1xL2cUlhQeRlgpt6bsQbIup3au6dPYDS+0GlL/10A0A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3at0vk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c7f385887bso185122585ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784295323; x=1784900123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qKn/zt8XKSpiuXhFD+JzIr50HAeALbMHuQBYFPoZC6c=;
        b=L5yUtxWHdQIQjCQcyR027BL0RR1eJBBSW/sd9IpqDg2J/HYGNinu02BVbvVvgTcPXD
         yCYqJfwIbjPV6JctmEksjK+wCBi5AE0QI7S8OhM64X3KNnKzx+CMa39Lw6qnCT3etzY5
         p+4wzw93pFuiAkcIIBclxWx812ZiHr0JSj47ErqZWHmZAg+ljnJ1v7PpoU0rLKZpJaVV
         lI2900C6ktTX4rJWBgh9W+Ke32iq/5kMdB3uuy08nQ2FaOH7D4FfHOl0QrqKFnN9pPxq
         6jfqXvOVeuuAAEQ596BNAqip5UuCZ/Cd92DhkeJ2zVw+TRNRpsLU6rLvQsDyuJ4g8O37
         sptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295323; x=1784900123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qKn/zt8XKSpiuXhFD+JzIr50HAeALbMHuQBYFPoZC6c=;
        b=IdHH/EjYJprw5/1f9sD0JJrlsMpkDHf9pENSjIRhiJeI3Pjr5A8jU1dDjI4c7bumvY
         juxoLIokibA2DnKVl/Sop3FP4xo3h1ga/7QcD+ZBlV/01D2ObGUH4J4peTsQo+A9DhX6
         WSAbjU2WIvlS2D4uVfZsACycP1KbQyy7vmbUwUA8HoasfXMGJyUsBHbhewcFeKNkjAj2
         SoYgvhf6rF4BYymOiaqSyoCCLQ5gAz1lps9AXs0KXZeqTVUNY26XIankuxpaiKNrYS8O
         qmu2iB9TInGDw0ZGHfLq5QVN5fPLHiDIehsknbW+7S3s//Z8JOkTSWgk9Yj2NmIOHNFh
         RqGA==
X-Gm-Message-State: AOJu0YxerV1HxQfo/cgbhbuh4uFYOWRMTrp68zf1HTQaHaa9SX8Smk3w
	oCQ+zBMKEBvVqUDCqVAN/v2fLyG73ZXUMgVLW6DnXy/neEJ/d6JwYtgtjBq/7mfGyw74PnZWdlS
	JtMHvYns1459/bM0uHxBo/ieQ5up20/TJrUrZ4MaP96M2I080kYg99TCgC9nWdXaWuw89PGfZK9
	tSEE0=
X-Gm-Gg: AfdE7ckOmaeU4EegwMpkzX1bx5cWqg51Aim9MYSLzbyxy8iKM67EJ9OzVcPHPdzg9OP
	+VqLDZKuRcmK/Ka3+wwGtP0FkyNVewqTY9MASaDFkiCG3ViCwpZXLT9rlzqH3p0p6xtMmOK0iHE
	aRF7Iu6jAuIH3Daqdk1zYHKrUW9jAV7Q9JWm+AvcEC20k0r7KT277MKY570jUnsi8baLBEk+9xn
	tKWDaLPhsAeEiz3K3jZfQ0r7XW8mBf7JPVAsmWZGS8OjS7udVqvRRkTwYO1HN3dfcaSS39iZZnN
	FjLv+QEqgdfcNXMaVVP8e+uv7Tx53jZBaAfFR4e/vM6w+WAh5xsuXPjrehsbyNXhg6r1Hyu3j3m
	Li+x73FdDiLGeceXRwLsAZ82YGYZUYA==
X-Received: by 2002:a17:90b:52c4:b0:381:28e0:624d with SMTP id 98e67ed59e1d1-38e4b531e4bmr2919752a91.28.1784295323320;
        Fri, 17 Jul 2026 06:35:23 -0700 (PDT)
X-Received: by 2002:a17:90b:52c4:b0:381:28e0:624d with SMTP id 98e67ed59e1d1-38e4b531e4bmr2919707a91.28.1784295322839;
        Fri, 17 Jul 2026 06:35:22 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fe4677sm6648774eec.11.2026.07.17.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:35:22 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 2/4] profiles: Add create_context param as part of CS Create Config cmd
Date: Fri, 17 Jul 2026 19:05:01 +0530
Message-Id: <20260717133503.3711396-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
References: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzOCBTYWx0ZWRfX9+lIR7cF56kc
 MbPp+oCfnymj4vphMSVXcI/IBCZ0g4+3nXuIPtZiPDRdBr71rTZWchkdM/2dlkPH8CD5XmUmmcJ
 zHbd8YDtX/lVkcQxKJu1twjQ/60Kv40=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzOCBTYWx0ZWRfXxSY3w10ode6d
 xaq3FICMQDHWgqDyullWhBNWRHodeRYVDNkVcN4nA8hbCty4A6RwrKwtO1HVJ6EqWCOMPXvqpJK
 LPUbyqXPQVIoWBw2n4nTSBhvyAYiJdbzsFYOWN/GO3/VIvs8VckypVHQYV8Ep7KB0wQVLRWhKwH
 gKYRf0wTlNsm1qoqXogc/6+/InMX13iKgPnW30iwina3TmV3X6AbKKGSY2DVZorZQVyoBrQ6s44
 uoY/RA8XXmfgsfMlq1rAayaMQPx61ufifU6A48UuTCheuzJJMVkq3WFMm4EwJh36NiH4WuwB5C2
 rH5qfCyUuFm8qrBBsjm5UFzqboitfaubyoLcNysSX8byo2qcYdyoQoVyFp/Kym0DDE5EXJotAgz
 vG6piisHMsvzHDeOmYBimI6v3ShrMfXFKbHLYk4H2+xvZ0PwOp46yD9ca6a+OMrHhg5s5Szi5qE
 MfFUqoQ9UtwxRNZQoXA==
X-Proofpoint-GUID: VABoNsv4OkW91KzAI-BZ9SKtXtJLQwU7
X-Proofpoint-ORIG-GUID: VABoNsv4OkW91KzAI-BZ9SKtXtJLQwU7
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a2f9c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=nDC9wEv4f7NXtu49icMA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170138

- Add the create_context field to the CS Create Config command.
- Route HCI command-send failures and non-zero-status completion
events to CS_STATE_HOLD instead of CS_STATE_STOPPED.
reserving CS_STATE_STOPPED for the clean/expected
stop (Procedure Enable Complete with state == 0x00)
---
 profiles/ranging/rap.c     |  1 +
 profiles/ranging/rap_hci.c | 42 +++++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index 3ffc0da76..082c35558 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -337,6 +337,7 @@ struct cs_dict_param_desc {
 static const struct cs_dict_param_desc cs_dict_param_table[] = {
 	CS_SETTINGS_FIELD("role", role),
 	CS_SETTINGS_FIELD("sync_ant_sel", cs_sync_ant_sel),
+	CS_CFG_FIELD("create_context", create_context),
 	CS_CFG_FIELD("config_id", config_id),
 	CS_CFG_FIELD("main_mode_type", main_mode_type),
 	CS_CFG_FIELD("sub_mode_type", sub_mode_type),
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index e57f967a2..58ccf87bf 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -282,6 +282,7 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 	sm->cs_opt.max_tx_power    = max_tx_power;
 	sm->cs_opt.rtt_type        = 0;
 
+	sm->cs_config.create_context          = 0x01;
 	sm->cs_config.config_id              = 0;
 	sm->cs_config.main_mode_type         = 0x01;
 	sm->cs_config.sub_mode_type          = 0xFF;
@@ -459,7 +460,12 @@ static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = cpu_to_le16(handle);
-	cmd.create_context = 0x01; /* Initiates cs config procedure */
+
+	/* 0x00: write config to the local Controller only.
+	 * 0x01: write config to both local and remote Controllers using
+	 * the CS Configuration procedure.
+	 */
+	cmd.create_context = sm->cs_config.create_context;
 
 	cmd.config_id              = sm->cs_config.config_id;
 	cmd.main_mode_type         = sm->cs_config.main_mode_type;
@@ -483,7 +489,7 @@ static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
 
 	if (!status) {
 		error("Failed to send CS Create Config command");
-		cs_set_state(sm, CS_STATE_STOPPED);
+		cs_set_state(sm, CS_STATE_HOLD);
 		return;
 	}
 
@@ -530,10 +536,10 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 			DBG("Reflector role: Waiting for CS Config Completed");
 		}
 	} else {
-		/* Error - transition to stopped */
+		/* Error - transition to hold */
 		error("CS Set default setting failed with status 0x%02X",
 		rp->status);
-		cs_set_state(sm, CS_STATE_STOPPED);
+		cs_set_state(sm, CS_STATE_HOLD);
 	}
 }
 
@@ -559,7 +565,7 @@ static void rap_send_hci_cs_remove_config_command(struct cs_state_machine *sm,
 
 	if (!status) {
 		error("Failed to send CS Remove Config command");
-		cs_set_state(sm, CS_STATE_STOPPED);
+		cs_set_state(sm, CS_STATE_HOLD);
 		return;
 	}
 
@@ -587,7 +593,7 @@ static void rap_send_hci_cs_security_enable_command(
 
 	if (!status) {
 		error("Failed to send CS Security Enable command");
-		cs_set_state(sm, CS_STATE_STOPPED);
+		cs_set_state(sm, CS_STATE_HOLD);
 		return;
 	}
 
@@ -751,7 +757,7 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 		}
 		error("Remote FAE Table read failed with status 0x%02X",
 			evt->status);
-		cs_set_state(sm, CS_STATE_STOPPED);
+		cs_set_state(sm, CS_STATE_HOLD);
 		return;
 	}
 
@@ -838,7 +844,7 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 	if (evt->status != 0) {
 		error("Remote capabilities failed with status 0x%02X",
 			evt->status);
-		cs_set_state(sm, CS_STATE_STOPPED);
+		cs_set_state(sm, CS_STATE_HOLD);
 		return;
 	}
 
@@ -920,7 +926,7 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 			error("CS Config Remove failed with status 0x%02X",
 				evt->status);
 		}
-		cs_set_state(sm, CS_STATE_STOPPED);
+		cs_set_state(sm, CS_STATE_HOLD);
 		return;
 	}
 
@@ -977,14 +983,14 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 		mapping = find_mapping_by_handle(sm, evt->handle);
 		if (!mapping || !mapping->is_central) {
 			error("CS Security Enable skipped: not BLE Central");
-			cs_set_state(sm, CS_STATE_STOPPED);
+			cs_set_state(sm, CS_STATE_HOLD);
 			return;
 		}
 
 		if (bt_att_get_security(mapping->att, NULL) <
 						BT_ATT_SECURITY_MEDIUM) {
 			error("CS Security Enable skipped: not encrypted");
-			cs_set_state(sm, CS_STATE_STOPPED);
+			cs_set_state(sm, CS_STATE_HOLD);
 			return;
 		}
 
@@ -1052,7 +1058,7 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 			if (!rap_send_hci_cs_set_procedure_parameters(
 							sm, handle)) {
 				error("Failed to send CS Set Procedure Params");
-				cs_set_state(sm, CS_STATE_STOPPED);
+				cs_set_state(sm, CS_STATE_HOLD);
 				return;
 			}
 
@@ -1060,7 +1066,7 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 			if (!rap_send_hci_cs_procedure_enable(sm, handle,
 								      true)) {
 				error("Failed to send CS Procedure Enable");
-				cs_set_state(sm, CS_STATE_STOPPED);
+				cs_set_state(sm, CS_STATE_HOLD);
 				return;
 			}
 		} else {
@@ -1068,10 +1074,10 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 			DBG("Reflector role: Waiting for CS Proc compl event");
 		}
 	} else {
-		/* Error - transition to stopped */
+		/* Error - transition to hold */
 		error("Security enable failed with status 0x%02X",
 			rap_ev.status);
-		cs_set_state(sm, CS_STATE_STOPPED);
+		cs_set_state(sm, CS_STATE_HOLD);
 	}
 
 	/* Send callback to RAP Profile */
@@ -1097,7 +1103,8 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 	DBG("size=0x%02X", size);
 
 	if ((cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) &&
-		(cs_get_current_state(sm) != CS_STATE_STARTED)) {
+		(cs_get_current_state(sm) != CS_STATE_STARTED) &&
+		(cs_get_current_state(sm) != CS_STATE_STOPPED)) {
 		DBG("Event received in Wrong State!! ");
 		DBG("Expected : CS_STATE_WAIT_PROC_CMPLT");
 		return;
@@ -1116,7 +1123,7 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 	if (evt->status != 0) {
 		error("Procedure enable failed with status 0x%02X",
 			evt->status);
-		cs_set_state(sm, CS_STATE_STOPPED);
+		cs_set_state(sm, CS_STATE_HOLD);
 		sm->procedure_active = false;
 		if (sm->proc_active_func)
 			sm->proc_active_func(false, sm->proc_active_data);
@@ -1816,6 +1823,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	DBG("Clearing connection mapping: handle=0x%04X", handle);
 	remove_conn_mapping(sm, handle);
 	sm->procedure_active = false;
+	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
 bool bt_rap_is_procedure_active(void *hci_sm)
-- 

