Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF330EF80
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783858690; cv=none; b=kR+OzlNk/CT27vgPPhStYLeYAPZwKNPkSXMwjPL7Z0wgFo45V9kM4d6yPh6kWA6DoAonRT/v1eWjtdWtBjOB+5hxGPdEz2B9jTp9dIjlm9nieA7uef+ZyTJ1trO+JZxK6kteGL7nnrUbjJ684uNP09DVGQNL+QQUyakJDb8rLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783858690; c=relaxed/simple;
	bh=j3LduURT8rxCJTYKDubd5erHUPOZL38qD+c/lSTjo2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/dsIqAM76OoOkB7EjUebktcRHghiuepgFeqqg38TRX59A6WX+sne7Bvm2T0FVReWqbjjJWJfSfD0EEpJZ+sSfAX4zqxA6Nizgjezh6CknozbfjwetbU/jVldWzqREtz67wGDYSLyULtgqTZ11bxNM0QaFFt7PfJJl2WwGezY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LaxfXnhC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=We5Wi9/e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LaxfXnhC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="We5Wi9/e"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CActl92196146
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t+IPsUAtIa1
	TLrb+NRl9jeu80hXf3Er7HQgBYa3TXUE=; b=LaxfXnhC1p8sC5C/VCG5CVJXm04
	8hemH4cXtzbPnAqoYjvQ4a+bR/13Fs+0oCFa2v6QoIZhtTaeLJGJHm+Z3h4cwca1
	l7RxackVPlcQwjfsuZVWFBLu5bZnSy9/DWFP7YBTSdzwavsZTUjoLr7XqQfuxQsV
	vG4K1PyWseCRnnEd9DRqM+OyeAzAWpTY765yVY1RhsGKZG1cUD+nnEqPECut3v8X
	7ZAe1dtdK5bapBAzMF5ld83hw0CwNqPm9+tDdtxcMwQCRZ8bF11sX2Sq9bu9e4NS
	tKXZCXS+zSEAHCtCpanIuGROb8thsYRqXEve86wzb25kr0N6ufw7X5hFkZQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9jsp7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848568a6f62so4039998b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 05:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783858687; x=1784463487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+IPsUAtIa1TLrb+NRl9jeu80hXf3Er7HQgBYa3TXUE=;
        b=We5Wi9/eCEkr1e9ftXyw76VS1zSnFcSPWUH7mkjk3igceLuOU/vh/rvd3lmdUfMgGb
         HSlGpLmj+BAAf/5U0gxEgSsiVLhWY4vmgLnWh0bvzI8kYivuI9q9MIAuXS+2MdSpztmQ
         Vy9FVg9Uqb1EBLFXIf3nxJCjJHpbB0kJv8e+LP+kt0A7Un3liMVIqVlGPuHVO+/ZQxiV
         kmonsuOQvvvVnWgTW/7TzcakL5TClpyQIlWtmhvOkxQP5Wu4LNci2MJB4Raec/KhxN38
         O/WjiJJ67NQOAjpv5kmEpsYzTQSgSY1YqwLm5/DFRNtG5He386YzwTQqdqZbLxsTZYrb
         xxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783858687; x=1784463487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+IPsUAtIa1TLrb+NRl9jeu80hXf3Er7HQgBYa3TXUE=;
        b=LQNzDRbEKxNsVKBX2Jf0+omC2Ed2SsoK9ph8RYEHsBF23xzCR6o2wI24Yh/92FldrU
         MHORNziPrIhlK9PGTdL8wAIbE2MG9/Xk3RAwODyO2kD1v6R/jm7TW4oeVKlczzUZ8hgo
         /fBGsowk2h4V3zxSCHH1lQ/kPUp+7u6VKkqQbT1vwsD9Lz3caFRB076JvfZb/52C4Mxp
         Z7ZnIEl63cM6pgFTTv/kp4xEyTj/8Bz/UN9jU2WjVjp+LUH0arPTZUQGVFR9DscwnNL1
         cI7IFTMWDtQrkW3hYpvOaFz9J+3de+tj0lGCzRO990UhuZg4hr9bF0pIvrjADNBCjH9n
         77lQ==
X-Gm-Message-State: AOJu0YxJhW/t2eGP+VYFcuasGJK8JtYYnqaNfPJDVn/YCaJoPfneaZ5X
	r+4+wdugNnXyckVKocJwqrij/4hXap2RA2thE/67thkidEwvyLD0eXNuQGfnOKAM6mOFnuxb16u
	R2CIOdxRVbsS3s3F4rj+M904Juv0kOi23D2QJMj4B34nGj741fBX6j2nSggCUh8qrmveooI7F3w
	E/CvM=
X-Gm-Gg: AfdE7cmaiWExd9KohYwi/DkFdZKILOkZgEj3MHqB84v6KIiJbga90w/+WiF3xMJc3eR
	23DT5kZVstuHAWdyYP1UQBCnnyEYJgjFuNJ+jY1vfaSzhvpg0YbvgictEEYkTHtZy9RLdkiyeMI
	Me7QzIqQ6q+ZPvaiQ4iHX9qtoj3bLJFhjv7IMKoBja7cpIYh8+hSpADw281YSke81Ec1v0f05rr
	Hvn+lOHcBwBwFjJ/5nWtUoyErYRtu2ElqFhzpSuf8FO2eJBtVWDQVb5zIqMelx04AGMp/8xD9rc
	jK93bu0rZGfSsYbQ1weuSmx5UJ32xaHtBTgN3cmXMmW/yR0BWn1zzhHqHh6n43cjH085alWH0SN
	aoJiTj3EkaBJXhOjuNX1H3ITLEDsakhZeMFN61W21
X-Received: by 2002:a05:6a21:e097:b0:3bf:9795:ac0a with SMTP id adf61e73a8af0-3c1109ecb93mr5969284637.4.1783858687300;
        Sun, 12 Jul 2026 05:18:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:e097:b0:3bf:9795:ac0a with SMTP id adf61e73a8af0-3c1109ecb93mr5969269637.4.1783858686877;
        Sun, 12 Jul 2026 05:18:06 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm29061040c88.1.2026.07.12.05.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:18:06 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 2/4] src: Register GATT profiles for Channel Sounding reflector
Date: Sun, 12 Jul 2026 17:47:41 +0530
Message-Id: <20260712121743.2842547-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com>
References: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEyOSBTYWx0ZWRfX1UQ7DIltC6c8
 cKo5O3fuzESV7H75Un59eNhbnkLP0s5c9x2OTYo/7G1ep4d4voprioK6G+5/fn5HQxsKonYAYVB
 2xKWSaRaDOLvcyty7Nu1KQlvjGI2/X8=
X-Proofpoint-GUID: 797oiMxyj7HzmpvjDXgKI9HJl-X8_GaX
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a538600 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=mucxSH6ds5ffYonggmIA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEyOSBTYWx0ZWRfX9zUhLT48UbRf
 wBqk4PDolkAn86zB9dvK37PhLfS+uItWdDfK9JvA4ZgnegnHM4/B+PA3ZvPUhnLTQD13zkYdqpm
 lgAtVcKENUgsssA8iITRZZhy91wuuxELFoFdCJE/MplWc6iP5Y+8FwWzY/2CWTKte46Vhjbe/aT
 darSh5Jjy/LyUlXKD2j3k7daN3XNuIP1xn6lxm0jzorVwp0LX3lp90ETxrFL0CiBtCvnY+IlVS4
 rmhLCpBnldSOqdIuhEAoczt1fkccOsuskSHQ6nGZUTkV0BPVlRDFbIXNPqfSMjVRic1MORzKEZR
 LmIoP45x6rdvIq8Yay59aowPIucKXquNv3mEvX+Kzf7BMPtinW/ipFrqpwauApoikf9Q9DbTpDa
 qphGfDSjQHXJcd/rg4TBtIWQeOGWJesMQTz4VJEsHKq/SZV2iYDxIsciufL8WVVpZ/0M+YWCY7y
 /hfMgCDIcZr53vaabkg==
X-Proofpoint-ORIG-GUID: 797oiMxyj7HzmpvjDXgKI9HJl-X8_GaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120129

Probe and accept GATT_UUID profiles on non-initiator (reflector)
devices before gatt_client discovery checks,
ensuring RAP's org.bluez.ChannelSounding1 DBus interface is registered
even when GATT client discovery is skipped.
---
 src/device.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index 65d84be56..cedfe3a20 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6301,17 +6301,31 @@ static void gatt_debug(const char *str, void *user_data)
 static void gatt_client_init(struct btd_device *device)
 {
 	uint8_t features;
+	GSList *uuid_list;
 
 	gatt_client_cleanup(device);
 
-	if (!btd_device_is_initiator(device) && !btd_opts.reverse_discovery) {
-		DBG("Reverse service discovery disabled: skipping GATT client");
-		return;
-	}
+	if (!btd_device_is_initiator(device)) {
+		/*
+		 * For the reflector role GATT client discovery is skipped, but
+		 * profiles that match GATT_UUID still need to be probed and
+		 * accepted so they can register their D-Bus interfaces (e.g.
+		 * org.bluez.ChannelSounding1).
+		 */
+		uuid_list = g_slist_append(NULL, (char *)GATT_UUID);
+		device_probe_profiles(device, uuid_list);
+		g_slist_free(uuid_list);
+		device_accept_gatt_profiles(device);
 
-	if (!btd_device_is_initiator(device) && !btd_opts.gatt_client) {
-		DBG("GATT client disabled: skipping GATT client");
-		return;
+		if (!btd_opts.reverse_discovery) {
+			DBG("Reverse srvc disc disabled: skip GATT client");
+			return;
+		}
+
+		if (!btd_opts.gatt_client) {
+			DBG("GATT client disabled: skipping GATT client");
+			return;
+		}
 	}
 
 	features =  BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING
-- 

