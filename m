Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A793845B0
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969697; cv=none; b=l8DRrDuwvOs2uOaGVyp7kng6TTKpF+2EAEQu/y7/fuAntisdejqxbaCqxCS1R1L8SQdyLeBng6zFZxM7SmOLFSiJmeVYm+wN/xzhxhXLnM4F+C0JlshphkCxJ8lO99UWIO0CVrXv7H4K1bQw2Fcn+00yeHklUAULiPDA6hsIKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969697; c=relaxed/simple;
	bh=xiW/dPZnS98zYyoDoyUDAjW3pvFKrz5PgiyqhLjHMXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oU6YAPoQsd6CUov3lJQgYRTNpEt9llIrYm0swRUDnYJi1q/Xe//0ugo/EO3TUEzXYAArxZ8REkIexJS0BMlNurjxD/VorUO2B+oOpPq+tb6gUIQKv5pMTdnb2eKc6KpcAZfH42OQdGmcdqDhqqiaWML7FOvPpAoIScgSICqMj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NL6fQi02; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BHrdT7qG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NL6fQi02";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BHrdT7qG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4n3rI706655
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6MS8QdQp2SVXWBPY4VxZs1mNPKYNEyJucnvWMesmH7A=; b=NL6fQi02KehZdRDp
	y6HVKwYnq7P3f2XIBYQpaCXnaGEoZ83sYFlmJI4xVOKPEsPxOhYLJrSrDzd4SvRk
	A8uluKy/WBNhTrypEKyPe2hZxJIlVh5x1yBiIqmc9TqD9VEbNlG6W9YqmuMjVR2x
	sV7jrQvAR1X2q4R3UfTmAsB5CgulNIgwsqHCn/w/FI8nvaElf1Xg/7REaFfJM0Cx
	iYg4cBeIcjj6lahwqNLTvrMl1qiX/n5RTJqwo9NH3AL18YcQ0L+vO/dTzsvAaSfh
	MtfMHcHXx5hfa9gcqgZwcoZ1biqPpYE4IJXBQrA7Q7l++XYwcjLmkbzP5gQHcgyA
	3DiiOQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpee8d1j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-387087245e4so297744a91.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969694; x=1785574494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MS8QdQp2SVXWBPY4VxZs1mNPKYNEyJucnvWMesmH7A=;
        b=BHrdT7qGa+EjoPYFJnb3Y8qo9FUwU1SmnWAHi82z6BGTuaqoYnREFOlckvQYiE9MLB
         9uoBc+EZXHeVGqUDiqIG4WjRE9RoOyAptINBxUag4w7JQQW85w+Nowxog+sg3BYOChCX
         SfH6s+bt7o8HsIf91zq7Zaz1gr/hHEVzR3hXJ4pj2WW570vpvUGqWJc/XcjNyVCtxzOc
         m9iGZX0hGKMNtzC7HBj2hn9R/nzaILQv8CbqbTviQm2to6/ghg8zPFX7z22OqJkLXpeg
         tjdB1DZZrb3N8SCatQdaHBngXNxK6KpeuSNngHpvyvgQ0NZOQtF8qOfmgsSa4w0MrmOk
         3irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969694; x=1785574494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MS8QdQp2SVXWBPY4VxZs1mNPKYNEyJucnvWMesmH7A=;
        b=Kh6A7HMMiMYvc/wRZXQC5N1i2sH1W06DDPfdDRYgdim1+3nkCZhw3Ds8od5tbFJDEd
         3AR2AXfgLXBDIRJJ+Pvd0lwsaTiITZ836JQpSf7uVtWuupDotmR5/gZUe4q3evNXpHQS
         edl10q1A6Au1Ap1q3bZSgyUB4LXWtTeF77NvfbT/WDIbXNrRlMlK7k5UkF7t2kS9/1Hj
         LAn9wej3Z/kvbtZ4cToaxC4mMBD+E6ivw4vvhLAIiRcRi3ponogdmgng6t5dJPJ9FPkx
         XoFWrnb15fxeRU/yiCrmDqq/obJQ24N43zcLYi3JkWbLx8yTGMSTc36z2Fs0JiqcgVN4
         xSAA==
X-Forwarded-Encrypted: i=1; AHgh+RoezsmYe/rQmvUb5HytlX4BDlt5QeCOZ9SQ3f4Z4gY6R+uUY1cvwOcM9h3PgshyObvWtYOpezJSteyD+DOWJSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVQhU+erNdQmJCgVrrfwcRfyh4shFbRLsCa5oRF4w1whdyg85
	QA9Q1wYYHujxYWXl9Jvtm4GUjfeaee3cxO1YSPFi0xn6WuvP3Qj7ghznYUSUfy8lS8mTTRMNHXf
	4XqcWeSRvRt6xQDG0mhPjE1ymM9W5gKiGjeE/0nlwMrpnJ81P+V1CRg+2yuYYkFXGQXmz6Xc=
X-Gm-Gg: AR+sD13EQDTeFZhRjA0VWI5Gp0rJuKUunXEB/BIsaFKkscV4Fo2dF3ElZKZWsRy+DWJ
	DfIWfR6x+o7uzursWVBEiCH0TvGhO2VFSLSp0V3z7gyUnZ+5fnqV/EVuZjsdDAO7hvzdztN6p5m
	uo2M9qJQFCtV5zJcqol5+tCb5rVPWe7z7lSW01pRKSoASP/OPQX8hVuk5UvbqoSx88ByLCqHPiL
	yG/Vd9mhlvI+uiD398XpURWk1bSWAADfxMGP5Wa6LCicE+5OIOsUSl+n1QGkaT4L9FI+NL0GIYy
	a8xMyZ71y5c9bICCQxb0k0pxhdEyBH1YtblMeGNT6v+6J4I6HksY3ATC9aqX7lyQzVbZqyf4Swt
	w3Jr4GsP97YLNP6IgpjzIxfv5JyI5w1jRNhAr46MfPAXQwSc=
X-Received: by 2002:a17:903:2f84:b0:2ca:d803:5c8f with SMTP id d9443c01a7336-2cfde689443mr13623085ad.1.1784969693654;
        Sat, 25 Jul 2026 01:54:53 -0700 (PDT)
X-Received: by 2002:a17:903:2f84:b0:2ca:d803:5c8f with SMTP id d9443c01a7336-2cfde689443mr13622985ad.1.1784969693252;
        Sat, 25 Jul 2026 01:54:53 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:54:52 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:39 -0700
Subject: [PATCH 01/11] Bluetooth: btintel: Fix diagnostics event detection
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-1-305aec261a19@oss.qualcomm.com>
References: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
In-Reply-To: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=Jr3Bas4C c=1 sm=1 tr=0 ts=6a6479de cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=w585p4NK48lv-ZABhGUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfXyeyMWaVKQERn
 YjTaNpVKhsWW7N8GzZlqi34wsLXhkYWpRXwnhupHkpdhbourZYOpqap1COeiIZwFXWGD3t+1EEn
 c5m1KijlTJJaC0PrJPATQIxtXn+iTXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfXzkoanJh4qrgF
 jdUgaZZza32ihIMh/OfwI4PmW0Yvb7KzdNUAxJWrdzHuPS5eM5oaOC+jV609n3N9uNVHqZS9j/q
 rwh+U8n3k21ZiK97vu9fPTCgiHh8bI4irdAX1JXzORInIR+LrKJ7xIAasiLSTWI5mq1B7Jn+dSc
 OhW6IlVM9FGffa5B8sWJKUt1XWXffVZIu3cttKX35x8Ge9H/GIwAWf4tbV6kNiLiq1yk0r6SC4w
 1SZEZMjJvyQNnveWzwa9PodQolPW2PbU85OUBqYmeA4KNLczaNzB1rJzgYdQ7X6YeJWCiinaAkZ
 VEQmSTGjgwNc0iFetXODtskhG96H6bWv3TVK6gALGEWvR51O/DSfQEEEJRX3QOilhKfsZJYK75Q
 W3RbPXz93Qgl9rKXNimw+NKPdZ57llIjBAKkDNcVVKiDeJdapWBtysjA01+krKx7a1aPLsvodLe
 BsRD4KWsFFBnMY1UjAA==
X-Proofpoint-ORIG-GUID: hR8Qk9TQbGX7gmNKbSitZOt7zqvrqurS
X-Proofpoint-GUID: hR8Qk9TQbGX7gmNKbSitZOt7zqvrqurS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

For a diagnostics VSE, diagnostics_hdr[] sits at the start of the event
payload, skb->data[2], but btintel_recv_event() wrongly guards its
memcmp with @len, which is measured from skb->data[3] for the earlier
INTEL_BOOTLOADER check.

Fix by using @hdr->plen, which is the event payload length, instead.

Fixes: af395330abed ("Bluetooth: btintel: Add Intel devcoredump support")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e9cac090bd8..d7baf1b9d852 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3826,17 +3826,17 @@ int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 				kfree_skb(skb);
 				return 0;
 			}
 		}
 
 		/* Handle all diagnostics events separately. May still call
 		 * hci_recv_frame.
 		 */
-		if (len >= sizeof(diagnostics_hdr) &&
+		if (hdr->plen >= sizeof(diagnostics_hdr) &&
 		    memcmp(&skb->data[2], diagnostics_hdr,
 			   sizeof(diagnostics_hdr)) == 0) {
 			return btintel_diagnostics(hdev, skb);
 		}
 	}
 
 	return hci_recv_frame(hdev, skb);
 }

-- 
2.34.1

