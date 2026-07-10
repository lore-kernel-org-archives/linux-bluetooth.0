Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6693F8714
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676981; cv=none; b=qnupBR26pzV1tXiPUi0FRkrYW5LhqeWgDzt6qLPOAhONAx4/4LSFpJTo9QhXjK1SB97ex+p//k/kjRxg9kayviR4SaUj7Y1KBbTNW3KSFq7cK7RaX22yXoAdult8YJlX9z7itT9uGDzkDhx51Oj2cYRzuk9cucC+g5NaxCivuAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676981; c=relaxed/simple;
	bh=j3LduURT8rxCJTYKDubd5erHUPOZL38qD+c/lSTjo2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvhN5MMRDLhcplYzlJr3kPQneaVS2hC8C8wt3GKJB4myQyuTcAObMrcrP/2RGHu3LngUrrSA7lC8Rry74GlpQ/Sw0p3F5j7l2/v1+T++Hg997Cfev/emAbNYIAQgZERusaMtCRFbP4nWH5y0Gdy1I1ODUsPhh4ti7P0q6bmIVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YRNZPNdb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KWRCRFcZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRNZPNdb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KWRCRFcZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A9TTeN291965
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t+IPsUAtIa1
	TLrb+NRl9jeu80hXf3Er7HQgBYa3TXUE=; b=YRNZPNdbn9Eh87ZY7UN5ahqeYD3
	E2eFXx91Lt+1OmrX51oplzi3+C9mxMKIA9uXEJH07OKhZnoczQleHNJb8yonXMjL
	D8KyT1CUtmQrUD6PNiLImP74HXly4T3oxKfTlEPQHiyF8julNwn0DUFxv9xqQZdg
	e6Sxxhfkc7Fhu2lc9HuCWXCJiziYqI+aHhy3N+oghHp3Y8LctozRA8Xv0oNkcClj
	w98dyHAmUY40oqacHrE3qWuceXgigIsIGMGjd+9aoHCWSHa2w5602T7nq0LS9R23
	m028KBzM0GP8VoQ/SQQ6I5KLgf0boOzhZUW78gICHVK3O2/qnaHkwdGRmlA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dg2sr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:49:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c891ed872ddso1152569a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783676977; x=1784281777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+IPsUAtIa1TLrb+NRl9jeu80hXf3Er7HQgBYa3TXUE=;
        b=KWRCRFcZK8N/xmQqjxLE/QktaPmCLcvtWrG4kYio9c692DoWCiz33fsBoCvFfR8vdw
         OpDbc8FF1OXzP3dgLiNG03cmoGirhgeDM50bx2zpieqKS3pn+9QrC5K8lj+vnupxSV+2
         6KXvJG6y/8EQwIv1BupgXTYjPRy1ITooj7HChaKHpp0QHg2CJ7dZUWvfjAAdr5mIzIwf
         4Y9kq6V0R8RcW1aCwZyrY1sqFpSbUag0HCYWcXpqPkxfaiIIJxD9RJ21iY5Zk5kyM84N
         R8ryJosY4zyWm8f+I0/76lAHikzkMNhlYzF7PVJzO2GCX5AWnXVzVjAv6mTwH2jI568U
         JfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676977; x=1784281777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+IPsUAtIa1TLrb+NRl9jeu80hXf3Er7HQgBYa3TXUE=;
        b=IFGTw14N2fSfIlhvJdB8g64gyThQ138+aKyrxac75jUXKJhVpUXwmryDbIZ11+fRQ3
         tdYXHmY5Ug69D3+TBuOO5vQl+PTjW0rKlP7222GQNdyAXAK1BIXKlrsRpnpW/lOUUEPi
         6wKVGbPayDYJaeJFlvKcpjVqKQmITnDKnNL0zjjluiOYFOrwd3svK7Th1+4d34qEh/fU
         0sKF3mmmTXyxblkaV9KA/HT00ua4+Uu1WPn1JjaMmdkDEgf+j5PD1pY8AO1C+QDlFgk9
         W9BIzS846qF7Ijs7n/Vl+ZUymdBjdhb5mn/8JR/aH59Lf2aqZ43y9hbe2+kLB//RrSLC
         +RyA==
X-Gm-Message-State: AOJu0YyTD5Res2zJ8xrlEv7iFHiCip5mRD0M6ULQnx0Ico0r710t02CG
	Qu/tPOr7vmQjqtpToOLQ6VJJmrlm9D5SFYxnCfAhYvCMX+IFgtTGWm+yTcgpkiH11qL+FOhIGbH
	HVOmC9S1VBR5jj2t1wXAM7gwOzy3lefcUN7CKCtuAsuVFuoIjJQZqrqLhKVSZlQRqaIYJ2h2uSH
	OMlx0=
X-Gm-Gg: AfdE7cnWXmNN4AE7wj5HxbFAHzpMHZ5ztr4WhOM2Q/eA2aQx9EBKCeNs/z7HnRVi/4e
	j+CIdj0o6wV7XqDs7n29+GBHNd/yBMj5QaYysew7yTmeMUpLJ6kfVTjuRkCGa4vULGSFEU9ZJ18
	dT5b6GyyaLm9GC5RmfWJ25HSMMTmN3G4+NCeBWr0SdwZDe7IAbanIyGdP3bKf837vULkLayFHob
	HWA9XA18sLKrsUICfsZKbR9rqVpaMZ83Qrc45+SAj1IuxCw1P4ZminXGNoQWolwjWL43ySIRLSf
	373z40TAabbtXirzzMwvDV+zJEch6QFxpnNQ9slP8X8EtvRjWtFbpaIKx2Gnq/etcBgK+3R69sS
	ch29zqZlqGfd8xJVu+ACg7GY1QpNjAemX4RZWr4Y3
X-Received: by 2002:a05:6a20:9c9b:b0:3b3:1c7b:ffb with SMTP id adf61e73a8af0-3c0bca8e5femr13791004637.34.1783676977314;
        Fri, 10 Jul 2026 02:49:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:9c9b:b0:3b3:1c7b:ffb with SMTP id adf61e73a8af0-3c0bca8e5femr13790968637.34.1783676976832;
        Fri, 10 Jul 2026 02:49:36 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b3206aaasm4106526eec.13.2026.07.10.02.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:49:36 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 2/4] src: Register GATT profiles for Channel Sounding reflector
Date: Fri, 10 Jul 2026 15:19:17 +0530
Message-Id: <20260710094919.4047204-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710094919.4047204-1-naga.akella@oss.qualcomm.com>
References: <20260710094919.4047204-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NiBTYWx0ZWRfXxeXlQu4Dycgx
 4BSEZ2IroqmTe4rxz/FHAfxwjRBBYa8vUJVsufLFlPMopc88MvvBd43PWwKd9OWUJoXY9rI8qOh
 aVDZ7zGyS70+jwQSsdaKTWbY1A2jHYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NiBTYWx0ZWRfX4xXvxyOcR4tp
 1MrgR3Xg6wUlwd9zpCTEVUMl52btV/stJ+gC+aRIWlfHhM+umS/X6OlaTTInHbd9oTFygeYYe48
 YOLx+abJ8ziieCZpu+sbqjRONX6Zj8L6Rf8ZumUqpkb6z9ziFXfV+icwYDMf3aumgUSpyhxrzJy
 k+dr8M+2gWis/X3WmyWSQVcmo87NASRek+fCt6YXUC5pIacCc5lnxY1OQ584Nfmu69KzoPz9DDv
 5e84Yo1SDeK23XoNkfEsPXIWDbKvRZSfeoArLZFqFr8MlXpIS3yq0gI+ViWQwIVt+VbpKhf9HJ1
 M4Yq/ksR+7R6Yg2/9bnHo+TXZSBPPLYVGMul2XLZcv68n/Nx+YN6W7jfWZfxPWVhTjrHn9YucBJ
 s7R6rxKre9hrXBLC6JiZjiYPHF7ohRFvnuHkPROsmmelXEc/qBOKk2eS2Uo1BWHvrnO7vaxBC7L
 bYCR8YhPQteBsj2/ALA==
X-Proofpoint-GUID: hSR8o7l20XJOHjod6ZIifZ0JgN27kuFL
X-Proofpoint-ORIG-GUID: hSR8o7l20XJOHjod6ZIifZ0JgN27kuFL
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a50c032 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=mucxSH6ds5ffYonggmIA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100096

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

