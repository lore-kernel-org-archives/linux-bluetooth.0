Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86D3C0635
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221688; cv=none; b=W1D7rIVHR00AuwUxF/Tv55hBr9BBjWdTYBfmZuWq+j5gT6C/H/15L3/8B7TPYbdyOgtZsJtQNUtCe3kAuQAW1en9TMO2rfAbL9uiALJc28CU9Fh4HgWAfwQPj8PwwDR5GDaKojZufOXkdnl2c6xJ++VJXQCPgifTgl6+j6CpOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221688; c=relaxed/simple;
	bh=JkTm2YjGpHaAxYGPumzo398OfNBnTy9grI7XyIvWxoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sK258DlIoMD4dYdnKcGYSdaCsv1wat6mdzBvZagNFaJfpYo6HY0znIO1R11I4LjlBJ3rNxNKs3DLdlr243tnmjjkvDE9et/Z2IUkn4okMoJfJUgWXVZF06xyu8fOzQ+eltnTSKLzul3c70KpMHZ7UwpFqNiBmH7+l7poZdmnsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IVBlnfTr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PFUsEA2Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IVBlnfTr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PFUsEA2Z"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S46MaX1820947
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EJgx+VTaajeyRHXpkiq0/8017ZE/dm20Y1BaHDucPnk=; b=IVBlnfTrvP141cVJ
	W8HrvpvIvePH0gzVoYjC7LViZcZKKVXIDh7ibTgq17QgQ0XeT6CBIAvGJNdq9WUO
	NI6PCMiuxfg19ViWRUnOjMnRqpEzhdw7HBQhsQ/fzzBSMWgqNrBVQC4jN6V6dzO7
	EBiiA1jCWG6GznO1KiVwT1203+6Bo34th0O/6/+9YqhmKx/K7SNq+4vSDomtuQus
	pxhPARBT6qisS8IBSF1CHNBqraKLggEDJ8FA77zSnrGgBgeAxbaCb6X4gaERN5Ta
	WIG1/Y/j5DF6iJWqoU+JOpSD2Ji49Gtg8icXOJVq9Q81DO2N5+KOUcFSqtoBdvUF
	fRNpNg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y0jrg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce756aa72eso15047095ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785221685; x=1785826485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EJgx+VTaajeyRHXpkiq0/8017ZE/dm20Y1BaHDucPnk=;
        b=PFUsEA2ZFi99nijlxnU+6iN6kU2POWaJ1qsSqAJazQ1fr9QejipDeNvIlMoIM8mJGv
         pmt6CUd4qslctfqzcXd8nRBag+iqW2MnqMbFWzSGar9WdGDRaI+MSAiIg4rac9yYXlKk
         iZSW0fQ9DkmU1jlIcS7gEQUUcwrbv/IGl3BJKmV5wt2Uk9BrM1bP8iaeAb/t6i9J25kb
         Y2A2WDcO4J/seVT2TDLuPBlTkXqJ88wIMr5avW35H5EvMondGX8OSVu/IgzjsbLgDO1N
         A8SIMezt+1MFyq7w41Ghsgq7gepxT9GkjGvHt6pCb/8A93taTdZubU//WonHNb4+5PhA
         RYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785221685; x=1785826485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJgx+VTaajeyRHXpkiq0/8017ZE/dm20Y1BaHDucPnk=;
        b=XU5+2iVrqZIHhzxzD00Z3PFBkXj94b0Bj0lTiXB0c9ZXUiqKJoGTtFXbBW69BLtbVd
         0tgiBJ9Nnzy3TrYW26jHBUlbSzo9X/5T2uDBazHi7RI8qFX8UgmCSHyO6PdN8/apMzXI
         62nkdfes/KrNgTSLG6hMlydQK3juIU/uYF7597l9vW2o5Id6qo2gb8SJi+Vb6F3pEtPd
         U9RX6kObtV2j80xTIbPToo6/7KBjyho1k5VQXzSt7J8gnUn30P0gxVdzcxCvQbwR8R8K
         EyB6fz9wLdebV261SbAsasSHk3FBhv4XOGbdIoTxlWkxWo1wOxt+58rx1Kka1GgtoKdn
         Y21Q==
X-Forwarded-Encrypted: i=1; AHgh+Roi+tMe/w4/GWIXIqZpIx3MP0OfKacHTLelOCXWiWhuIjuYSJZfXIwqcJpYYPrL4gFxrj4ba/kzHqSbZvQBnr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPLc9TZGUShSThTux6PM2e9soXgPHkk+vk4QlC2TJ7eNOlPekG
	Bcz8nELs73MKPHfhq2xKQZEFA9JuP5Nm/NMYPv7wWgXkltfiVHPeLo2JN0s2qypqRogZeRGEzPl
	d0mu01Xdj6YUZE1CKnV26UaM4/8ma/oLl4E15/RgGJt6zGYysy8i27dXW9yu2/Cna9dskJW0=
X-Gm-Gg: AR+sD13gWaANiaH9z173E/ebMrFm7b7hqcmMlAEHJzp3kgI3i0kDL9gCLP0qfJx9wII
	E6glxZdblZpn0qc0O2Wv2jshg0XYhXfuO5CMF1Ypbwu4KGyxejv4yVA8kVcmO6rHb8kjlt1AK8P
	dPSAln0OiumAhZvt7LnsqoP0JdJnMlZSQEGG1Nz4yuZQhzUwwQNkiNPDxSJSCRCgw3nNynCQ4TF
	AY5/W/40Ajbec2fS+kVxEYxPJyFfEQpu0+wVy6tMmDfrwlS7g8lOkxwpdw7yYWAR9OTtQ/Yplkt
	o5wy1WmYBbcRCCDtkWDPxNw7/vBz5wRfrZWhz0i2Y/BmRGbpDhtQdIX+SZNw8PrTcwbBJtu7Wfq
	pUmrLH/lstaUKe1nXMCi2Z2szfvtlPvid205/uwOqkUnN9Fc=
X-Received: by 2002:a17:902:d4cd:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2d0159840d8mr11705825ad.0.1785221685493;
        Mon, 27 Jul 2026 23:54:45 -0700 (PDT)
X-Received: by 2002:a17:902:d4cd:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2d0159840d8mr11705355ad.0.1785221684802;
        Mon, 27 Jul 2026 23:54:44 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2881sm46260245ad.25.2026.07.27.23.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 23:54:44 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 23:54:32 -0700
Subject: [PATCH v2 2/3] Bluetooth: btintel: Remove redundant (hdr->plen >
 0) in btintel_recv_event()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-generic_fix-v2-2-a57bdb81ac67@oss.qualcomm.com>
References: <20260727-generic_fix-v2-0-a57bdb81ac67@oss.qualcomm.com>
In-Reply-To: <20260727-generic_fix-v2-0-a57bdb81ac67@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a685236 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=7TpkJ8Rp_0KA0x_Po7YA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfXx8Pz4uiRmMAc
 UUsu/lZLQc7+9NgFo6gobQBJAowAzIwTaHQ3gW8sUh1e/MYjXSKo6C6YyY0w4wi9iKvJeR9yhk7
 k7LqdS4cOM5/gHS7k973jqYQ1Ri1U1U=
X-Proofpoint-ORIG-GUID: NKWo7fhU5SQUjI3GOWR1ecx4E1lYgNMg
X-Proofpoint-GUID: NKWo7fhU5SQUjI3GOWR1ecx4E1lYgNMg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfXyZyt4Tz+r2dW
 CShfRWZw+H47wcRT9ADfSWyuCC/pyIA5dMjq3W35w2zfElkYP+cjImoSFGaF7r2cmfqU3DMOLeh
 TUY13ANbsnm882qO8GSbLxaHgDM8cR+YAXiN+kBGSJquVHhOwJmty59e1o7hqOW/EEM04LV3EDn
 JKWNpmshPH6iqMDW53rlAd6novvgQAIh11TxDRSFjgq9GqUGKnZtt9nUEwkKKYtcIPRGb7KBY7b
 EaPDx8FebzYEzwR8bY4+C4Rk878Ual6xub4mZQ2DUR1uhT6K8C9XltljkjRdM/Vrn93ISWvhpHl
 pLf28JMpH2wC08Gr+v+m19WEMewZh77Hv7tU8jVN4t2Z06sha5GDVXSa+SkEweckgKagy368L2f
 Uc01PXrYVEsPnxq9JFhGYlPVLjxYhK/fHgmokzVxToL2cy2jFGabix0O64dsXf3OQwd1ckm2BDA
 CORJUMgi/EYSolKgbNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280060

Drop the check since:
- it is already implied by the existing (skb->len > HCI_EVENT_HDR_SIZE)
- hdr->plen is then not used by the function at all

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btintel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index b800379f91cf..6e61f1bb1871 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3797,18 +3797,17 @@ static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
 int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *)skb->data;
 	const char diagnostics_hdr[] = { 0x87, 0x80, 0x03 };
 
-	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
-	    hdr->plen > 0) {
+	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff) {
 		const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
 		unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
 
 		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
 			switch (skb->data[2]) {
 			case 0x02:
 				/* When switching to the operational firmware
 				 * the device sends a vendor specific event

-- 
2.34.1

