Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26F4314A6
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354589; cv=none; b=VDnrg6VRAan5hxZAtC7KTqOnEfkvzfGsXZrEQ+ogkeGT6zMrgEL8Lm0DCJIFgPZNXLmT6aHfJhUMjAzYqujrOyWggy79vOCnDSSFUl8IyTXMQR4FEtZpZs+6hOrP+9Mzxy0czIQjsqWUeQdz8/UJMpOY79Z4CMdMgPENyCQZNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354589; c=relaxed/simple;
	bh=29Db2sWEridAxtc5T+NOpClqoY69sIIRLCG7v5gCLm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mq88XJaLWrSctVc5nfAcM0CSPi3NzjxbyvRBE0R4yPlLRxWr90bFNuZk94Npk2fxrX6vpWKoI+d5vNinRrNNScaTA6Sed0XvlvG7LbgkMFV9WfFWGuX7a+Lekm9w/9UHflj8fpAj6jhB9Pp5ZT+sAeZXjcp8QmwZEgLUSwg+SWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=om7W/NMi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b4TbMzGV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="om7W/NMi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b4TbMzGV"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF7Sj990240
	for <linux-bluetooth@vger.kernel.org>; Mon, 6 Jul 2026 16:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1C9Og5S3ipj
	X2wgzf11PfcuumtHLKQDz/GQ7rhtI/Gs=; b=om7W/NMivtagAp97KMcGJZvypDF
	vtSs2oePCweDLqjoXqX9wFEvLPoFDLacuhcl44U6rRR4HuvvqDp6cCrVlMhmRrZP
	d4+BPqzFJmWFdb35iPB97B7+JIj6x4qgNlmMOzdCYruRcZ33S0pl/vacnWT9tebq
	S4uxWBz8vPJCSUM0dJTxfGwKAlQy4V6fhsxqDJt+fULi9j+t42ZY0Cy2w9oy/SLj
	94sWpBN4wGtJKbqIK8WOnuDNaa7MNGtXKhl/Ja+g0+qnNUUoOyTn12Y6vH4SHwvf
	gTBvTh984qOZYYYeqm+8qAjL96PcoEPeofOivPN2Q68cfM/xe3heJDWTUZw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gsrke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 16:16:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-381120d6d62so5891394a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783354582; x=1783959382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C9Og5S3ipjX2wgzf11PfcuumtHLKQDz/GQ7rhtI/Gs=;
        b=b4TbMzGVy69Fpvg6N4gdUa9HMJdNwXHPKSjF/n+HNm9i73sQGj8D9z0TKEyKNoKKSI
         aXF+sZi0JaKRQWW06qhuzJFSZLcdpevtOwQBQ+umlVHUP99w48XYYJG+kXBfYfjCdsex
         KgLQ+qFDd1QuYyEo81Okipho66G1brA/A0VBFlJD2D6/ZETDBvsY2uJNuqpCMR82tRmu
         hqp7a/UNOAMrVsnvc+61YKqC2wkuJMrSEFTLP3/bEajIW1hbXq23/8tAFk91kucey8y/
         HxExOlsaVMPIgZF4D+qjIWAjQ/tj2jnPvui/KdjINi5p4dpXQyREoJmEyiIEx84YLAXX
         sB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354582; x=1783959382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1C9Og5S3ipjX2wgzf11PfcuumtHLKQDz/GQ7rhtI/Gs=;
        b=j1sA2Lk46zOd11tm197P4REaUiGQR1aR8x3+H3HsTyfexAHXokVBGBE/6zGP27CyCW
         5LUGQLAgd7H+xYxmgiR3glhalLRPpiFc0f3OV87SNJhW9WzDZ5jRoJQG8dneDvPF0joS
         qUpNz8/45VACQfZHxD78gN2vSb7tUsfm1pzBvTMryoCP4fPQFxCWE9lS1S44i75GKYBv
         2NrmaV30aJt/zDvZGqgVL2ReWbBnJZq1H3HQrWpw/Gq9FFlkJ9P7TlIPHNvfLClEveg2
         TGfTu5U1tqVqY9+r4WkA9xVftyJXetPOUDUcQj4gVBlkj5xzzNss2XaOopMCzYGah9ec
         lTEA==
X-Gm-Message-State: AOJu0Ywj1ZVcWFOn93HYNhLuf25tIyFBK5FMqaS24qFCUVHp3MAtlyxZ
	PV83kxHW1VKzM5xtrXfsXy7WQ2aIGW/nNEiERCumKkxptfs3F1jdxB3vhohQkfM0BtlFBP05pYY
	miWwO6HBzuK4YDgMxHWrE6lehCuLNahIa3yaK7HjUZhl0qmCYe6cA/jfpSPPncaa3/r4/+L20du
	ee2y8=
X-Gm-Gg: AfdE7ck0fkbZyJdXWc6rMRYaoNSTEEMczRQx64O1ZhW1/9GWojPNQ4IO37aPV8bwq5r
	gHIo61Yo7ZR6e8EQlg7OI+2Y/2E7/SHiGKhFdCOQ+9x6ev/fOomeFsgnKYo+EbgORCUyDK/mP9Y
	OrZIQqipaDUb3BdyEPvg3lM34kKywjgsAhuzKmCBwN0YR9mudfDoOqpZh8JyjIel+klVmAmOCFs
	/eqmVJc3IwC+H/iGpw40NmV4FzKh+kagr2K31pyBoXBeHzcbMEZygbJgBzuFATj7/bVPduK3+p5
	q/Ng/vN+aEePlAhPe+JWut6aCYGD6ZS7d2bych4d41gwX1rHmr5q57aVwRguASl4b8Y0evICNY1
	SZ5vccqu7fr+PmuNvXNT+QmQkb1397guEJKWuOVMS
X-Received: by 2002:a17:90a:d2cb:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-38756dd88f5mr1228218a91.14.1783354582555;
        Mon, 06 Jul 2026 09:16:22 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cb:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-38756dd88f5mr1228171a91.14.1783354581872;
        Mon, 06 Jul 2026 09:16:21 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f31e7a2a8sm40022434eec.25.2026.07.06.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:16:21 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 2/5] src: Register GATT profiles for Channel Sounding reflector
Date: Mon,  6 Jul 2026 21:46:00 +0530
Message-Id: <20260706161603.2744459-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
References: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Jjn-67xIPyADQ_bemefKStf6NWiDngTM
X-Proofpoint-ORIG-GUID: Jjn-67xIPyADQ_bemefKStf6NWiDngTM
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4bd4d7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=mucxSH6ds5ffYonggmIA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX8WasPq87u1nV
 QoHKTppqx2zmsOMkSAUJjl4h1zEQiba/jMxu0UGgIXXPhJlAdAzfBoNyxc1T0KR9MiyrvvhNsV4
 a4u/TI5ons/BXbrRcfWw/T6Q/G4vTWKo0JsVhq06pouIzlcjcoA2MCxTZRT36LLZDVybPtVjzG3
 C1vm1F+ue8Yd+4RAe5CQX1J1cjY1Y/BkGoQSse9663NnEyZRPtuKdG75xTuM8mCHPsiXZNl3E0Y
 S6OFWQljxv1YOOviRwO3jY7chNC+MY/w4jU4KzjUJzl3iybQBF5S4E/CJ9rVvj1Z0gPgDl8YEj0
 WM+otNJN4PV3uvpWoDaY70kQqGswWql6CLmZUhAz/rTb5Y8eVA4W80O8RHIudfxLbiSbOWZkU93
 1yIcQYbFX3JJcQ3blwa1VyJJAfkE1AG2RlxiUdEiyYceLBIksPCTVvprLCS/ZrgkhcaWgDOIYnA
 uIC2+Vqr4eXD8QQ2kCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX436CuO4rTVyh
 wfDMPLl+UtL9dEbhld+71JbTE5Yfx+R57t87uIt+ThXI780sToCrNctGakAPqynMTHJNKN3fFYS
 vXLYGzEwUzQEdr5BKs6HOeIehmJkwqw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060165

Probe and accept GATT_UUID profiles on non-initiator (reflector)
devices before gatt_client discovery checks,
ensuring RAP's org.bluez.ChannelSounding1 DBus interface is registered
even when GATT client discovery is skipped.
---
 src/device.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index 65d84be56..0227edb86 100644
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
+		uuid_list = g_slist_append(NULL, (char *) GATT_UUID);
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

