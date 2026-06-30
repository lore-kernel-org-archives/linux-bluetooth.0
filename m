Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DFD3EC2CD
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814351; cv=none; b=goqqB9kVWh4sIz0gdLckcLmDIquHftSXzUCbqYzr4Qi9pg1kBpATn8pDze8mtTbFsu7IgiRwRp4YruNXrOgBb8JjIXOe+QhTJNVdiF1Vk8z4IIvzB9pv5wz8hDKHjFs7euZqSNzyLryat1q3SPiBKPqi2YZuKHZupjIjqGnPCbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814351; c=relaxed/simple;
	bh=dusiXwkpDFpI8rEIOTjyKOAI/kssglyu8CgbShvDG1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=byd6HGm7uyZuOXTJpdFAX08EHX5eGytspUE8IcQaiEdpq9REypg8S9u9Qx++FwV+gEjqo4ynBHmohYfUajKiIr256dSZOoLaCvPvJW1KCUG5BF2XskXQUeZk9wi3sb2iEu+Nuuk7U0m+NmaVLhHKdfHbuL6azP7SDEFQvPOxkOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RerrG6a2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZgeX7cLA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RerrG6a2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZgeX7cLA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mt8F1522283
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uLHdOI14XkM
	A43Ysz8N+0eoflaFdx8af1KMI4QbKec0=; b=RerrG6a2ct6gMrPT4b0AI0JQtR9
	sI4ybKhkqPBFJbAOsslH0ucFgaHNKL/pTetoae0wykzWQHZdR1bqXSjBe5poke8c
	QZgtvL8DxCEL8FCleMnW/AkfYQatSdfDAbNkbBc2OTGzEYy+sacVUYew7M/zc8HE
	ePoavZlq4DQZ2GxMCCrBC5HSQcypnxgNGbhL5znup8CfdsZgIVf47BMx0w2uAzOg
	B47Zw3Ka/wM5LTlMRMAwKs/nXQr040pKx40WfisuvJJ/c9NOC0vlEU3368bdAxyG
	52TxiSHWFiYeWQf8N5opgMFP7JQaW0YvK0BU85X34FkkjxgBUiJTygT2DyQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3yw92s9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:29 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1384427c3efso13999356c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782814349; x=1783419149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLHdOI14XkMA43Ysz8N+0eoflaFdx8af1KMI4QbKec0=;
        b=ZgeX7cLAqHh8w3BF5nXRglVRlMM4rbYmCx8ipr1kd2vvxoDHmpBUpWkXuts6kC4cm6
         4qIc360FaDDUf6l0jhUrD00CUj5xf3WfTHqk91XlNhfMcqpwHPjKvLYAKbYNxmx336KP
         KsMjR69tYYPHu/NZPdbQh2PLALo9C6Ct92a63Xf0pFv9vcLDzI+HrF+KLgRVOPv4eePb
         VkjiKCHx/imQq/m0yx6O7MYF+DmXQyqBpEIeS3ibHUZVPP+B0Mp6ZKYsU4UXcnKuYhKI
         CuFNOHHJzrBZEi8j4vkvf6tSxqW4ofHpXcDtUBKQqTMp6s/zFw2gsCisFWSsa2L9kKFV
         SRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814349; x=1783419149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uLHdOI14XkMA43Ysz8N+0eoflaFdx8af1KMI4QbKec0=;
        b=SYILqYbrNlTMarTMOfyGjMltfGsLDT2kF5uJl8iJneraY8xmtDMciaH32ROFMHs+es
         IqVsmMo/VKZxp8PMm5y2G8aPxHvbKHhUXDdEEHQkXiNXNdJv6+l6dmMg1p1ymF9ghm4b
         ZJnYAyDEKxr8Ya9CLlt/XKTIdAijNd8RJMGyuO5MqrBY60Wu0UeSpYxeEW5lvd2ypR5L
         0btD26EHTByjCcyiaW9wSgur1EnrjV57mVW/9ws8fgRpIWBH3C0o/XKtm2+D6+XbO15R
         iiHgkeAj2J1z1wmJg1HUMz97k5WbLFOCeaVh3v32qzj9Iu8UPBtigO4AXgJvd6ACxZ30
         Yapw==
X-Gm-Message-State: AOJu0Yy3U0veLMnWFNsH4/YIU0+WrKrCrerxv0FXBsOtRBZ7fiJ6MDj8
	67gMiDOni0DtolpTP+AKaZp/R1DGJyvFrwt6L/ugxKnAkIGu2eZhnVep9tCNhczeRphGgyPwOiK
	wYvZK/bXj14rJmVqgYWA4Nusz6X7PWGnnWX3E/Q6EzuPDyF3eX368UN0L3US9liv/kvN9UCSBZZ
	9yMcQ=
X-Gm-Gg: AfdE7cleZoEBSoGQgJ3+jKy2Gs3jpi81IEqRXlYg6BE86ZW1MMblRf18hZL/rib8kBK
	+lvkVWsnFWKfbMRer5MlOTOhr+F2B0HdqwGozzTarID9Y7x5TXIdmgpDQ/xaD7+L9Yn7vXq9FrF
	W0esEpRUgVs35T/l1pgbrXIrmAAHz7WrnCIA+WswOPQO5a5i5H+3S96rtlaSwc2JjlPbKhJ7sN/
	jyyFKDe4FVzs1uBoXzLHB646GeN7J4nBd9q8M5i5Ez9rHuxDsAqIS8O5NobUG3/hUrJ6Cwtqo9F
	WlJ0UHG8rIAPN4Hxna9D9cIxyWTgLVGHOcd0ZXrinHez7s+MOKbRm2qk2F99faRUFmIDY3KdjNh
	3d83iiRO8U9tSm9vLEPoYf5WYRQWZovG8zE9u66oy
X-Received: by 2002:a05:7022:6a6:b0:137:fec9:8ffb with SMTP id a92af1059eb24-13b2a1b005bmr2064300c88.25.1782814348708;
        Tue, 30 Jun 2026 03:12:28 -0700 (PDT)
X-Received: by 2002:a05:7022:6a6:b0:137:fec9:8ffb with SMTP id a92af1059eb24-13b2a1b005bmr2064281c88.25.1782814348215;
        Tue, 30 Jun 2026 03:12:28 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba6fe2sm5670060c88.9.2026.06.30.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:12:27 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 4/6] shared: replace the wrapper API
Date: Tue, 30 Jun 2026 15:41:56 +0530
Message-Id: <20260630101158.2239682-5-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
References: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX8mKCn2qo48Yd
 ukxOiIGiQ9MslQyrW4bwCq34jUmK9b4ppH69oFJGMtaOzRyaW9ItOMMuFfP1v/LXK4YYo/BORen
 nC89DwNmvi0HClMeuTfuqZz5yHdbwrk=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a43968d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=9GD1gmV-RyNpu4_TKacA:9
 a=zZCYzV9kfG8A:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: sVoFAoohvQGTSOuphnSrJizxbpbnR--Y
X-Proofpoint-ORIG-GUID: sVoFAoohvQGTSOuphnSrJizxbpbnR--Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX0DuPmIE8/qiv
 Gp2jQ1X5IhvPthoDqljmL2UhyiasEjfm7umHzp15RUT92Xy+d9/Pr4x+kExuUzHNZqH8UyjjW5t
 IXAi5rhKjjR5Cij2W8A+XJ6zMp4IyEV3N+e0vhP3yTh+vE/zqgDoCI66XYO8YXv+dE3KESKGS7T
 qwYBg9f6jm38/hoXr4k56eRtyt/ifnFYWRyJqgO8X4YvuFMZNIw3PORtxIM8DCoAhUATq6Le27l
 v2PTvUN6HCDKmsHvCge6h9eeMt5ZiaRj96p85uo2u83Big2I1lvgc/8IVWak7LcLS0nAGN3zS+R
 G+5lQAsSVXWIQnRqXShPbXlVIc2PSidBXXRAqAoS5VMwP/aKUADamu48+EFYt0KH5dxRMk3YkhR
 4XY1bv+X9gjUTferZHNRaxeU0DOeG5Yc/MR4YKfXxwtY8Qh3ZIXIUtyOjpjhTXk3pG16ptlrSs4
 bXtEDQGMTNOFISNT2rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300091

Replace API bt_rap_attach_hci_v2 with
bt_rap_attach_hci which has less parameters
to avoid compilation error for individual patches
---
 src/shared/rap.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index 45be14dde..b6fce8b54 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -206,11 +206,8 @@ void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
 						  const void *param,
 						  void *user_data);
 
-/* Wrapper to be removed */
-void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
-			uint8_t role, uint8_t cs_sync_ant_sel,
-			int8_t max_tx_power);
 void *bt_rap_attach_hci_v2(struct bt_rap *rap, struct bt_hci *hci);
+void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci);
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
 /* Connection handle mapping functions */
-- 

