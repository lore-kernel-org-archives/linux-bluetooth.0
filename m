Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21138D019
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969705; cv=none; b=pebt1oTL2XpKvtG5LsYEbIClHZwPQzPna5C4oKeS7Bhje85GCnTJMEficoyfCJYz9w1sVj7kGFBbDi5MBOP4Ph5542IAh8doHzmmAIZJPwbQxxWxJ0ZhMTixuHl+2yDm3DQtqg0vzEaIszMuuDMNOIph2mhHdq1GkEm1C5OjA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969705; c=relaxed/simple;
	bh=BWXDVDoPR0A1la0zg2TOQ8VIPkKZLxjz6BMXZy8fd+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgTK47ecJxZkLoVL/zzyAfYJ5wQ0RKqtRBsfk0HYDhyGPpRMKGvfyHtVATPFKh4w5Ci9H9P1dapCIXUNr2UiB2tz0s6n95vAIaLK22qoajz8KHCrbpzfPu0WzigK72dz2wHJc+/qKhiTuaaXIKXRjVWWMxDyVFtnyx5eUXyalzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eiCtRWT3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UafK5TTS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eiCtRWT3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UafK5TTS"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4lnXv1114238
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o5gbS6sopGQSWW4bTAzQQi7PcjaZyHS8M12dHv+F32A=; b=eiCtRWT3tLtMKVzb
	Iq1tYcD6siVrqXbNfhbSgr/KEc+B/uTjCU0qjqVUSElDO4JnrgZ3Tf9qLPD7JZnt
	SAq2EHbg0c27zviqWCtRO575no86aEU2VbOT7ul88xxk1KweEDVuomH8dcwlpHE1
	cYTTgt66tkd5psgNKzdItOkD7mm1LQeVqGlBWSIv41t0BpwYZrF2FUIvM/XTaIMb
	9844AbmenDGwRzBktfrkmg9/EzK6i16nFSjaISXCirMekqQvvhm0/ZEK/dCtG8/y
	jjCVAIVJxGmBxmNMDVhiAAsurBjFtVS95hiGcUIqebgCHOl22KxjRwqIHmBm1ZNz
	W5T3vA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmnc3ghme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:00 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84c2c8f0a54so280310b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969700; x=1785574500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o5gbS6sopGQSWW4bTAzQQi7PcjaZyHS8M12dHv+F32A=;
        b=UafK5TTS5Lv+G1Cm4YLuaXiVqHd90+QSPcR7CEYpEGPLVQ7tvIzp/1QGalupws8j6c
         Qq9E5t6amnr3cyIFwt5xrPDwt0tT71CNf1o1uyIcHyGD0Rh+EqZM/BKqBzRTyXz0xiUv
         oVTNMwmJAo+TG6y0uASP2vt1ITYyYaBGrBFNwSPvXR81uUFLgWMZa4YRDqbEI47LWoqK
         c/Vs2rgf/3X/dmYIMVAmzUYjZKmejrGrr0KOmAxWk6UmTpiA5+r6cmeWhD0Sf4d1SHRb
         M6WIKMwwHSvLThiBqeG1rcaXsEg1gCQ9fXaG8ikmZohU3Q2gCvbyMBBUU4C46V7aibTW
         N8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969700; x=1785574500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5gbS6sopGQSWW4bTAzQQi7PcjaZyHS8M12dHv+F32A=;
        b=VXYBZYPhcxeBdTxHqvg7p2jLcKrJo0Q+blZqaaWaoDinEWF/cYGLsByIG+OjpTnEAc
         zh0ZHe97Et1sZd+PlmHgwK0XYHiYULcFet7KndMxmzRxigfPsxZibX3tMzloVp3YsO29
         c0utetXSy7b8gP2DsgbfjP6PXb5uUCMRJ1Kn/66EAijeVzkb6mxr/ldKT3hc/O7sexYn
         b/CRxcBEYmncV3CoK5FpROBho6+WNS1H0svx8rFnnBXOAVmZMy9RF9l7PuAVTpPfJmFa
         TVlUj92pW/zpBaJcPL06laayZTnD1+LD4uMOeSVQIt3br3AqTuNjuls5yGu0CnI7Zl2h
         kl5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqcTA9jpUs+IR5RA9go14GG2elt0hetIlUFr4CC6HIPY1yyfsfBb0wP8A8uBNRmE7IRsZWgsYEU9NlgA3aOZOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiaBpD+7vx7vgeW39du9AucNMaGtD+qfc7/lE657OpGbA/u6A
	eGH5oJCwvKrpLNMY4PAT6oG5HJ90s0bQDaulVIYNwE9EoRTH+Iap6mWhSEP1vaRGP4D6OC2Wy4g
	0gPS3/6NeGtZ0EOzT+pmtgyNHsNhTdVFnHdss9hTi6MZh5T++XH9hduRBoBNJBZWQFsj4Xf0=
X-Gm-Gg: AR+sD11OewUJs83kUeiTTthyznWj2ZhSQ9kRepPPMwvINh5sX+ubwS0hBrN5Gt/75L+
	1adF/UwVg9v8MqN4Ia33IhXA3/Oq9pnDy09lgUc0fbP01a9ak/SvQbMSg7iNDXkygW16dJsLcmg
	NisBTI+ANUCd7c+Ln2gvQTFUQukjV+BRKXhW0SFQsBcLkS8U4243k4roG88a5w4dZp/Ql9ZX4Xk
	HNoUXJkQL05MA7ruGS3S2zPHdIe4AkGU92hrfpsaP/cFTtXP2oaOcLGC+SdymJjqG20Yjw6xg+7
	M4UiemkzFtj3E7UriNcAv2DcTKR0oQVtLCCM+B62eNOPBUk2EE0u8EpW9CAdb6uZdUe0w1IZ5Bh
	1xP6Nfi6nJSXgZ7h6qlvRXpJQM6mUoX5JWWaM/2zF8ZtowP8=
X-Received: by 2002:a17:902:e84e:b0:2ca:de3:15eb with SMTP id d9443c01a7336-2cfde559422mr13658905ad.0.1784969700035;
        Sat, 25 Jul 2026 01:55:00 -0700 (PDT)
X-Received: by 2002:a17:902:e84e:b0:2ca:de3:15eb with SMTP id d9443c01a7336-2cfde559422mr13658755ad.0.1784969699652;
        Sat, 25 Jul 2026 01:54:59 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:54:59 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:46 -0700
Subject: [PATCH 08/11] Bluetooth: btusb: Simplify btusb_recv_bulk() by
 hci_acl_dlen()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-8-305aec261a19@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfXy8EReh1143RA
 y6NhjOLOhXQoW19rGdX0RQGNi/7hiM/wCHbUbtdjrWVLPU9bl7WGb/cYERXuo90dtW1Pv7FM+s3
 M7obSQ43QdZI6m/FpdWqYU03TGpIq0Q74vBqFqXsZQGSyQmNVklG9Yc/VgspOJCvb8RA92wNhLa
 TQkZIDfddJvOgtnMbslD0AAjUamon1ihMduBJcAbjD3vCUFrKyTdhSLcyVTXyM8/BvJ6p6V76zx
 MPQvpYiW2bbxrpLFKl8mF+ltuHrHXZpQgDx5W0cH7XwmdnbqBiQ9QWRkeT5/5Qdr7WiAFAsvZB0
 T69l9U0QKkj5vqSIGPxEHBAlqOKgjALTSc187OgNZLZEcrT9zPRPVrZAPTVNFou3XMD40CW1t2a
 my/NycZbEhINWz1Q9Qk4UMffQzYNrpVHRBN7+FMmXA2rOWmMU1YMS/JK4pfhpQGJpPugSkoHL0i
 v6hIpwyhb1zc7X6O1SQ==
X-Proofpoint-GUID: O4CFXXgnMCObTtRJjY0s68-xtoKpSlqB
X-Authority-Analysis: v=2.4 cv=VcfH+lp9 c=1 sm=1 tr=0 ts=6a6479e4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=k-9T60deko6e8epjNngA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX8UgDb6CpL58s
 Gi/av40wCvR1kX3Lkfo++rspX0qvyjTChf7ZR1XHDLG2apMEZooFI9+Ik0K6ppyXfqP45qAaPs2
 Cki3Jr4ttvcpOVmDpWBRi/aKYi62i2Y=
X-Proofpoint-ORIG-GUID: O4CFXXgnMCObTtRJjY0s68-xtoKpSlqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

Simplify btusb_recv_bulk() by using hci_acl_dlen() instead of:

__le16 dlen = hci_acl_hdr(skb)->dlen;
... __le16_to_cpu(dlen) ...

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 90336dec59a2..70593842d20b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1374,20 +1374,18 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 		len = min_t(uint, hci_skb_expect(skb), count);
 		skb_put_data(skb, buffer, len);
 
 		count -= len;
 		buffer += len;
 		hci_skb_expect(skb) -= len;
 
 		if (skb->len == HCI_ACL_HDR_SIZE) {
-			__le16 dlen = hci_acl_hdr(skb)->dlen;
-
 			/* Complete ACL header */
-			hci_skb_expect(skb) = __le16_to_cpu(dlen);
+			hci_skb_expect(skb) = hci_acl_dlen(skb);
 
 			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
 				kfree_skb(skb);
 				skb = NULL;
 
 				err = -EILSEQ;
 				break;
 			}

-- 
2.34.1

