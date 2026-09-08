Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B1368D4F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841666; cv=none; b=Aag/VhS806tu9136zJUzMWtXxH+xUAkL7FK7EmWJgoEDnXjKRpY8VkjWf1cexF2NiFeOayeLkeqkI5euoaZihKcOqvyz8zUtbq0LMPZvITJfkNWm/p/6OFVJCmT5EtlhjCp8XtI4D+32iv9S6JrVmcFHXrWsvTNsCFlefZY/Ab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841666; c=relaxed/simple;
	bh=luj9Cjr1nD7xsRYvYFg5HjxUNMV95ikIVXtGTblX4I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CBROpJN/JFSws14EqSMLYUu0iWio9tnyfBgxxFQiYlHOJ0JHJRmA/2V9J9SFp1lns5ufIMZyTOP/0YAw0aYQXyOeO+bMCFTCS2OwT0T2ir7/0IwNFvjZJUZrNOBQF1ZZpGLNFEPiPJPCWjzyiBsAi9by3lCLpvWVPMxbJi5Piwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QwlVanVf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ehh+sIZG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QwlVanVf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ehh+sIZG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687NlKi51311817
	for <linux-bluetooth@vger.kernel.org>; Tue, 8 Sep 2026 04:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Gmk9CZzgHt2
	Ha7EWgnVw+4JGnn0siyt9ZZa9KkCEkOE=; b=QwlVanVfoJw7f+H/gOGvcu1gV2M
	3WuG44zMMCbCY19n/UVyQFfRK3PtKsWNm2U1v+tpD+38DBor5ivxkmKDYuSjlkLy
	NSAJBep3+cvOdrrkVPvE7pexAQef28X9M1y0EIKoLk6X+7fXGqINbknqnTmt/a0m
	PVpR2udYEd5d4GMwvdbYyK/uC4i+EWR7yjJGJyGzuhudofqY91IwnEBJP5ydELzm
	2jtuwDYdKDA7KnXwKK0T7CkpoXNdUUI7INR73iEQN71YUTJuqRGkmkX/6MqmkRyb
	mGqDe6p04uB8pg1ET5MGhLYgm7LVgBobzluSVDY5C7yAhm8jChTPm5quQCg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwhje4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 04:27:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso2957611a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 21:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788841663; x=1789446463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gmk9CZzgHt2Ha7EWgnVw+4JGnn0siyt9ZZa9KkCEkOE=;
        b=Ehh+sIZG7r+RLGYfZcwjsrRmrcemba5BuWcHr7i2OV4c9ofk6d/ns/wgOXuz1MqxAr
         fzi2ObWDcoMLsL1w1x2bJ/lPrlM6WTr5pOBUBmXg/0u0h3U0eSV6PJ7N/BWbTAcuA85J
         dGTA6ln8fjWvxXfuqo2rmGFD61peFpPY2nVBdvVReT+gk7nDg924YhTcrVe8lP0wmeja
         /8MqGGGU0flc/QyJYz0txFNjYZnO/z34YQA3pYXZlVXcl6+6JvwpmeLG1L0x1rDePi0A
         PYWZh8NuoNWcXMPItYnQGGfmWlwdOXRr4z0HHQo436fzljFumcMv0dav4/JVolSeb8MT
         u2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788841663; x=1789446463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gmk9CZzgHt2Ha7EWgnVw+4JGnn0siyt9ZZa9KkCEkOE=;
        b=sR27hFzlpr3j2/3pWGnpw08JQLUfJxbAnTav6c5fDMstosndWPa5zAQJe/fp24ZWdP
         Rhkb7k2rhq1u4PuUKtZioPNJfe9YipTg4Jy71ZN57utFy8g/hn0rRN+1H0Dtgc18Ig7a
         zKTNwwojKCgjakdjbLozOge2EeymQiF+oXmvHBB7blqpnY4exof0xC64AxPCt0gGcrwe
         a/wn6gdYqVlHkiqzcBU3sMwUR7Fza+Dp5UFx/fBjckwa1FCrmOon6REuYLCezOimy80J
         moCjcMrUCZZYvuYAMAdqqYPQ3CEePEhH+25kdMTMoXL0Ho0ptkNMRIDAIpZSJ3/gtT47
         br9A==
X-Gm-Message-State: AFuF++kFDtsHqYJjxW8bi+LMalp1GLjW9wk9ZA1xGaQNw1ejxVJ0Ttrr
	y5o5nya7RdgiSLV5oHBc0hN1HsUDS+RMrQPhm0+Z/UsyfpeJopJ8SdUd9wyIda31cJdnXrJI85C
	fs1UBdS7jcN9nXnZN9r7kY4ZBs1obfWk4AR/toA0K/tKrgQYFnvvfM1jZVvCkR4HF35opscXZUh
	VD8Bw=
X-Gm-Gg: AYBFou0tOD+my1dAWpGIAWAcV+apuAAO1fzBHR2el1Vzl8dNLhw5/IEpnUf6igNO6wm
	GsKxP5LwDp7PBlJBz27yFfjUs2mqCzJMtoWyCE89syjjpYXP2hlZL/HZNcdq0Arc2ma/pSc12e4
	zs2tCSMOdm/zKUKWPeKU4BNauxAdyT0/UYjn6E6nHv8/zhSeBoBy2O4+swdRLrwHLQZNnqqKyfm
	uZcoVcPbXQLxTNChesbMm4hlDoVvYRLTyKd7RD9j5HqGvxgPelctjNXYlpkhMJQyuua4yxkCLwJ
	CdbpFr7YlnY6l205yDgvL39FwyGbhztfROvbIEeC9Np5cWGdWpLtzo5RCMiDEB2bYD8B6TpydXV
	8/sIhPzfumjpGb1AQZLQMI1VbD7PD0A==
X-Received: by 2002:a05:6a20:c91c:b0:3d0:8cbb:8c2d with SMTP id adf61e73a8af0-3da39d18686mr45030959637.4.1788841663076;
        Mon, 07 Sep 2026 21:27:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:c91c:b0:3d0:8cbb:8c2d with SMTP id adf61e73a8af0-3da39d18686mr45030909637.4.1788841662649;
        Mon, 07 Sep 2026 21:27:42 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f44d7sm31577301eec.22.2026.09.07.21.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:27:42 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/3] rap: Add OndemandRanging configuration option
Date: Tue,  8 Sep 2026 09:57:25 +0530
Message-Id: <20260908042727.1677501-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908042727.1677501-1-naga.akella@oss.qualcomm.com>
References: <20260908042727.1677501-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9f8ec0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=0HA1kYP0LkdLL_d7j9cA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA0NiBTYWx0ZWRfX73cRcSp1sjne
 RSyQcrNiNSDNY779WJZ2woVeaiHR0HV8BnSxDnHsBFdu+1OGy2sEEItAUojqSHP6HgOBlP54o8/
 q//wt8SpMwOTjMwR2l/gKwUUcVctilZNpqZahWnMI0CS+JcIqRnav+rQa/WGflxcJBHRRh+X7eE
 MOQcDzgAzDAxMvagtWoVVB27LVEU+Sj5w4HTbU6UvZC5HY38qeUFxZdHRy+pciTC9DPba/3gP25
 MpO32EjrSZiVYTRId61ucgl2pcI9c/xoqjV2bOw46X2LoN0A1RZepx0yj4EAITjXUHgOU4sN64x
 gOD2tIEkAWqDl/6UHTWlGbLXh3f3SFvNWISK0eeGAySgZ1FTay49k4pR7X8iSwEjV6yDklQzsJm
 ze2WGfTY42FKMN8vRGwJoLRr4sPgPxF5j6NBS1yRhlX/AzWIl6ye7TpTaLHDsQs9Oh9t5XEqCEa
 KIdAq2SAKVzEpCGAwMg==
X-Proofpoint-ORIG-GUID: 8n8V8p1pNrfRvrca7LGce8VR41wDMgKj
X-Proofpoint-GUID: 8n8V8p1pNrfRvrca7LGce8VR41wDMgKj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA0NiBTYWx0ZWRfX5TFQUnZ8/eLA
 Blv0MkfvelJMehMRshWxuEJEof8Cw+5HLvPUyXvYX0/Zw5ouWKsRelJPKJnQ9Hm78E63teTT4FL
 LEHhA9JkpLriHQgH8G+Obn1cwBgZIDo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080046

Add a per-adapter config knob under [ChannelSounding] to let the RAS
Initiator use on-demand Ranging Data delivery (Get_Ranging_Data/
ACK_Ranging_Data) instead of real-time notifications. Defaults to
false.

- src/btd.h: add bool ondemand_ranging to struct btd_le_bcs.
- src/main.c: parse "OndemandRanging" into
  btd_opts.defaults.bcs.ondemand_ranging.
- src/main.conf: document the new option.
---
 src/btd.h     | 1 +
 src/main.c    | 4 ++++
 src/main.conf | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/src/btd.h b/src/btd.h
index db2e81239..d70276b1d 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -98,6 +98,7 @@ struct btd_le_bcs {
 	uint8_t role;
 	uint8_t cs_sync_ant_sel;
 	int8_t max_tx_power;
+	bool ondemand_ranging;
 };
 
 struct btd_defaults {
diff --git a/src/main.c b/src/main.c
index 8aa19a3e3..c7a55d30f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -160,6 +160,7 @@ static const char *const bcs_options[] = {
 	"Role",
 	"CsSyncAntennaSel",
 	"MaxTxPower",
+	"OndemandRanging",
 	NULL
 };
 
@@ -1301,6 +1302,8 @@ static void parse_le_cs_config(GKeyFile *config)
 	parse_config_signed_int(config, "ChannelSounding",
 			"MaxTxPower", &btd_opts.defaults.bcs.max_tx_power,
 			INT8_MIN, INT8_MAX);
+	parse_config_bool(config, "ChannelSounding", "OndemandRanging",
+			&btd_opts.defaults.bcs.ondemand_ranging);
 }
 
 static void parse_avdtp_session_mode(GKeyFile *config)
@@ -1437,6 +1440,7 @@ static void init_defaults(void)
 	btd_opts.defaults.bcs.role = 0x03;
 	btd_opts.defaults.bcs.cs_sync_ant_sel = 0xFF;
 	btd_opts.defaults.bcs.max_tx_power = 0x14;
+	btd_opts.defaults.bcs.ondemand_ranging = false;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index 80f4a3a0c..1d8e97dc6 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -323,6 +323,14 @@
 # Default: 20 (Max Power possible)
 #MaxTxPower = 20
 
+# Enables on-demand Ranging Data delivery for the RAS Initiator role.
+# When true, the initiator subscribes to the On-demand Ranging Data,
+# Ranging Data Ready/Overwritten, and RAS Control Point characteristics
+# and fetches ranging data via Get_Ranging_Data/ACK_Ranging_Data instead
+# of the default real-time streaming path.
+# Default: false (use real-time streaming)
+#OndemandRanging = false
+
 [CSIS]
 # SIRK - Set Identification Resolution Key which is common for all the
 # sets. They SIRK key is used to identify its sets. This can be any
-- 

