Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F6303A04
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652322; cv=none; b=H4KLEGch+wb92qiJB7NX62E56rHQgBXXbYikaKr56t/fGOPnKqBRHmEXrBhrmVVv9f7MVxvi90TEIs3rW/DaXXDb5BT6TYJt4smvqV6+pqMohZRtg98sjQWk4394YfIkPIrzUa7BvURb0Mvg/j9ing9mgLVzUmrSbfPyxG8Azsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652322; c=relaxed/simple;
	bh=kxutCMtWPZ8I/oFqkiHyPup95KPTQ5v97RYSM4jiO+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E06JmuP0IC/3UCHfwuIX3d/U+lDP25CmgrcH1i5vMmq1v9Jf47HZQd/8iJCqWS84d08PWG9TlmdJfRZ9DZB6h8yjwvJ5RRBxbR6vpVpnWJV6LUywPtFXvisCt3TlqOtwzfgHuAKxA/tainiJ1IMTVDKKz1s7dqT8td5xGaEQV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hN1csOw/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LzBDdcZM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hN1csOw/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LzBDdcZM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6724aW2j489879
	for <linux-bluetooth@vger.kernel.org>; Sun, 2 Aug 2026 06:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LSmNIm7/Z2iieOdVjenT53YbH0uk3Y8PUFU/NhW22Ok=; b=hN1csOw/A4RDnCZ1
	+DEKrjDxijxvpDxp2op2A4lgm44DN4JxZMPQM62talHfMIUdZsoQ10jCoA5y/kDw
	13psgIB/uCw7nVtolwilOWyQs9pFy4CDYqmLtOpbkZt9rfdc81yviwF7kXpE3axg
	6E7yWdOVFex7pCKSAwPROjMzXfDjm6gWGRKmNPANVybpCISG/F0S4XZ1zDjdBJNs
	uecGhbANve1zheFAgFoH84QJsDkqo+ELH05UMstdLr6/KD6LJmA5cGNNtCAVaDzh
	WWVfw4p2O7ezO7XlHdEMnGvXQGM2KvR1qJES2SXIIp2JZ3D8EyYObGjtHuyypfZu
	+I4pLw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fsa3826j6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 06:31:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38de4c60f0eso596310a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 23:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785652319; x=1786257119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LSmNIm7/Z2iieOdVjenT53YbH0uk3Y8PUFU/NhW22Ok=;
        b=LzBDdcZMrxwzk8Ov+3VtfTURWoMSz4LRRfsIlkYNAcCQqHICWms7Qj6DfSr56vvvZ1
         cS5R/cVC/R8d9QgsHMAVnkQHXRrT1GZ/uBzUDG+JW3NxGBeuFWCFWSBdzoz0hCCAP2zK
         phyeNrIvY+ahbtdevTp42uCBm33GNZGwpQ3XQWpfblRGQwqOblzx7KEodk/Nw6bxez1R
         4lRRVVNfN+mLB2aGu4n63OtNacdG2hFEObNK3oY/rjvyVNEDBd2xa6R9g+8SAPI3lBPa
         rCB5elQfoFWj0fJNp+D3UQ/B6Ad504orv0stoBqlGOsIgPntSzN6VsTr9hP/xHCjld7d
         qhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785652319; x=1786257119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LSmNIm7/Z2iieOdVjenT53YbH0uk3Y8PUFU/NhW22Ok=;
        b=YbI4wJOizJJJXNH8sLjMphXQfxpsOEP31puctJFlFTU2pCq4nafWh7NMxG30+qvBxu
         AFdLcPqaiXZKFl8slNjsVtUzzZCmjxcFgC4NDocPATPRyZtkWL7zoUsf9Ll8v2AhFw0p
         F2YCGHSL6dK4ObU0bD4eWEvm9yOEdo/UEl/kN0bgImhkKVFBpdEKAvezrnTOPSoMGJ0d
         1j4Wapv5edMloMU1MqjIb5tePZfzaYLwMHqjD4aOKQOEGCWJ6HK94mGcKooB66r5Dn/n
         1ETrnyipbwcb+Iz6Vob9rKRuUAMnNjC/O6e4g9W36GwpVUU+jAICl4urypJjDTf9NWd0
         MrXw==
X-Forwarded-Encrypted: i=1; AHgh+Rrw+UMF1aGVC+6E7GlxHShgU0GguX0wIk80bqZkqaGW8QTZ3VvvxcTR0Mg6foP/v7SgvHZyxoN4Vi8g5WzWt8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycgb07ZqkmbsAr1628thB2d/zK4qs0+NElcdC/0UWQEZ7SlQFR
	WM0Zei16MzNsfxgkyji40Fd3B59U7KblVy8gVNQr16cGvidEQYSrdoPQcDqwwt7Eu9lBNYSusSS
	DdctLONIYnlD4Tg02MfsolmGgRCffr+D+Xkr+SINCtpq2jWKeH+SGDcgtqO+Nm75RnIoIGmA=
X-Gm-Gg: AR+sD13xJvi6e/U7EOA5xCRPSIta9L4eJgKi0MXvNavFg1DZcvRAfoRStNYhjR3wqjs
	xaK6C13uOmC/Cv8v4O0+iqmEzRJwi2NXeZW9mro5p0N6cUkIIxizdElyBGby5bq7nM/P/OcHlVE
	6aSUbBah69eZ6ItVJII7gve8NPbmyfNDWmO3NoYzsMyyxuPHTtHuh6UOlxT6FcuLITqoynf2Alo
	gFOpRxQk+1K4V0jQ/p46n6l9g8RXFHWNvoFZ0sknNyQgScpB8WPQtqzWjUH5QKutn3b6B/PmNuQ
	uhdaYra0hqrogFGunHhe17sMAGyHuz2m7DWPVRyipheXI0nIrgujVmvEnN9+Qif/Oz5BfDFkhuJ
	ORq4KC2ke1UKyiHxoghylQZ+jnOit3XXO9NU6jnds943jY1w=
X-Received: by 2002:a17:902:f78b:b0:2c9:e846:a582 with SMTP id d9443c01a7336-2d05206277emr76292295ad.0.1785652319380;
        Sat, 01 Aug 2026 23:31:59 -0700 (PDT)
X-Received: by 2002:a17:902:f78b:b0:2c9:e846:a582 with SMTP id d9443c01a7336-2d05206277emr76291975ad.0.1785652318936;
        Sat, 01 Aug 2026 23:31:58 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm24233304eec.8.2026.08.01.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:31:58 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 23:31:37 -0700
Subject: [PATCH v3 2/7] Bluetooth: btintel: Remove redundant (hdr->plen >
 0) in btintel_recv_event()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-generic_fix-v3-2-efdd8dcf3430@oss.qualcomm.com>
References: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
In-Reply-To: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=KezidwYD c=1 sm=1 tr=0 ts=6a6ee45f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=7TpkJ8Rp_0KA0x_Po7YA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfXyLCJx3WhvZeL
 JNYTAxAsxBfoHuH9XbQhK1zVXYdE4fYKI1Lvam/zi8O3y307pOTnjJYnkACQaC4fJ0e8YZbjOpA
 3hcGdSRTF4RWio8qWBQZ+uKVKJzprUM=
X-Proofpoint-ORIG-GUID: Jrh-YoO6CZiYOUk_Ki-jEjT5YG7DAQ3k
X-Proofpoint-GUID: Jrh-YoO6CZiYOUk_Ki-jEjT5YG7DAQ3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfXzshOCx1rxer5
 taDy+VTVOFEigCVV+jyIfpimnKbAN6wYGhZ9uiKP508QfKn2sFw44q/NKg1ryVjvGFW5FCEL0uk
 qFqStQ+OgsHbCDjNuc98yK46q6gr6KWkpQhjAVdICujlHypXxqGfpuIKI4FNdJQtb+lQu6S3Ox7
 Z0nLUrXdyEw81YDTl0ZiCg3GAqLUEGXTHH/bshITs00p0KlBHLxtj8he/yzBKuPSkmqzilYKQuf
 Q1S/2T2kXABT092teNZxPfrjyNX8VlT7588fp52CXO740yxCtQ7SIszscRZAdYjfS1OfDQPXwQj
 R2/KrniQW81v27C6bLg40Q/uMpOvOHB4lgfz80v+lES86CMrMDpzF5u9Y0Bt0bItpgq9SBBXEME
 1b0ArsGzEciriVjkytK0HyCFFIGVm+NADzbism1rwBr9+oo5KHTtDnPOmX4afYE5flESN8Di8rp
 zfP3T81R0dbKocQ3KQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020050

Drop the check since:
- it is already implied by the existing (skb->len > HCI_EVENT_HDR_SIZE)
- hdr->plen is then not used by the function at all

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btintel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d06a335ff1db..bcb2514b7bc0 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3986,18 +3986,17 @@ static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
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

