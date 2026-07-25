Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5E38736C
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969704; cv=none; b=ucPLW/ux2u9x914IHHQk8myuUvCN7qu3Q2ls55Ex2+vYYT6ahUn/+jjT/bnkhErGpMgjNnQiHyf22ybZN+GW6iDuMkLa/C1nxqy10p0G/+6A0vtFjnxI7d83gPBcfzCnElAoRpS4/xsRV0K5qwGU2SAjBbqGwt2ZaykZncJ6xec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969704; c=relaxed/simple;
	bh=vpjbvfX28RWuLVOj1I8iwsYYruZ65x3CRffGIa1Mu0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrUF5kh8GXdoayvFJWxs+Uivb1IGMnFFAVOyfljzHHQjE0Yhf0e4qNmtes6id/OpBxAfUkORiplzn8iQJrJ8eIQvpvx8pRDiJjdYTSdLtMg6mOpkDVYgmpgH7TRTD9/RbfRqwWf+MNuXLToYhBuLFKUIKVuPWDuhEH2XENO+UU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i/wdhboK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DbMCBsm0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i/wdhboK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DbMCBsm0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4mT8d939997
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z5Gw37l99CangTh+HHRxAy+UIaoDXRFBKzuAzhXyHY4=; b=i/wdhboKjTKQrtbX
	DNIgqIFc8oKeXvzFudCa8a01/L1m6fWJ3f3pKINOEMClYqzIlCcIiQSF3XtPHEEu
	XzZ+e1REDFTFBUrfeuvQA01JCyk+MAztIdzUePvkFS1kaiPBIHDN0mrNI8+o42Q0
	eoU0WgkAO2rf6nXwUe1p964hBSJi9XmhefrjhbmNeR0uunfo4hnJg7KsK9409dIY
	I3YJVh46YA1Tz/xi5X7T3u7Is4bMU0JzoDF2+zdmmHPOdDaGMJt/g4wvYjJmu1tu
	NB2QS/awHj81dRs7t9hiBg6up8u5WILQ7Vee5GpO4xwL+XZENTfQDFaYirkutm+i
	OkAMTg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmjgn0xb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce756aa72eso4236595ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969699; x=1785574499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5Gw37l99CangTh+HHRxAy+UIaoDXRFBKzuAzhXyHY4=;
        b=DbMCBsm0jHSxwFYw033t72EXW9/VfOetp+RMjzE34YalOODzzCpGVOaDIGic2R6o3x
         FnA2mgUBsOVZQiEFcGtMFbeuDVq8+00jmleK1G/FDLix1r15YC76Yil1Wmv00M07vyv4
         298qnKN7B6rYIoaltT787nHd3fBGnoOFqz/jwSjlfPya5GdyC+TZ3+obhjksk8ufp+Km
         G1qZ3yWVx/AFLGArJTDLoufOQSTu4NtB0spFA4ffVsDeGNAxcNAofs84YEyWJZLGk2v1
         Von3UHsJ2/QilNXP1uROowERmOIuwz/Av4KS+Z0eip9aHrtLHin370wxU/9XIEmo9lyn
         qmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969699; x=1785574499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z5Gw37l99CangTh+HHRxAy+UIaoDXRFBKzuAzhXyHY4=;
        b=F10QKAYKdKrUNvr5uwxeB9/KbQrJYsTs4tUuVfe0OshEOGsC1ABpoqrjR12Db/yv3C
         zEFq+fm6leWZ3uuriOfEfSfUMz7x0G/EUAqV5hj1Zx5ekZJe7+wCcNLrx3iS5E1XzD38
         GUT+pnVdzQzRv8/DxYRQFq33KifXVVcyMrsxcqN6JHJwnNraMDz5dyOciMKkRcUZnrZe
         qHZAJVW6yk1OpeAlR//rD1E5wCsHc0c3LaL58evChSGuu2cCR4kKZyTULqVASmRlKNiE
         9z7w/aKWnC21wfmySFoRgK6OcDyEqQFNAgV0YQuvMfj6JjQZ1sVCFQrbm5NUke6ucR1K
         0bkQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0qjRSE5wU0eO6FtZU5hG0xKupwLYysgPDQZR+yBCTlFGB3v0vGrIWW1jBvtyfmutgv6IT2+qRwBoLrGgQedU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwemXxVOiOrSegJ68Rgm9+X7RxgnC1VMW5bs+S+Ye5dpdWCJDrV
	yM9iz7L5sPtUpPfq8uCLhIQuIcpGIASp3RGTXI8dyaLidhB5yvouaJc8xo5t0H6iPgDXq33yFOx
	s9nX8grgZX6LlXgnp6nYPJQjXg4EM9ibU/kOYCds5kdeYowBoBfB/CT9IvDWYgospkOK2qLM=
X-Gm-Gg: AR+sD13qDn5gZ8Dwhd3ocYFx26yZNAj/5ZxfEkT+Oc51cV+mMMStFleGBi1p614RCFS
	jHlJxByQ5hDV86qx8ohUsrDCRVHscZY+1HrEj9X7EXMacBxCvEpyaiIgt0Zp+ihBJezf0IvqZPB
	zfuD/61Sto74Lexfz4EP7G7SRW86p/kBg8Bi/9pDpmjMC8wXGxh7eWSONYWTCegtqcXO0Bh8Fmy
	F0Tz1wJyrvw2dtiMuw7HKScgLukLCBXNpZpP2PMwL33P0Knt6gbtpnyvDshXa0WkYlkuTWGCGZa
	ordaDC8txtnA4KGWoVae8dpXILYVua4yp3Vm1MGS6PnpKKmonzTAJeiTJrQEKiKYnNEI0+t7GEv
	v/N3qKZybGIRVc3zMWf3hx7rMcdAUg7m311NgazPsWHdWkTs=
X-Received: by 2002:a17:903:388b:b0:2ca:6885:8a06 with SMTP id d9443c01a7336-2cfde89bce5mr12585875ad.5.1784969699268;
        Sat, 25 Jul 2026 01:54:59 -0700 (PDT)
X-Received: by 2002:a17:903:388b:b0:2ca:6885:8a06 with SMTP id d9443c01a7336-2cfde89bce5mr12585755ad.5.1784969698838;
        Sat, 25 Jul 2026 01:54:58 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:54:58 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:45 -0700
Subject: [PATCH 07/11] Bluetooth: hci_core: Simplify hci_recv_frame() by
 hci_acl_handle()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-7-305aec261a19@oss.qualcomm.com>
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
X-Proofpoint-GUID: f9fOWBgJTRm3NoF0KNISpGibhDZWi0ah
X-Authority-Analysis: v=2.4 cv=HMHz0Itv c=1 sm=1 tr=0 ts=6a6479e4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=d5IJtNZlpP-JYew8HYwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX1Uk/xcLTmogF
 HcWGN6WUa6OoyBa60ARm4F59d265mn5lEZOdOIRO4tCi2Y5b8A0GfERM3ILiht9jk7U+b2f+W/W
 VS2oEdDzFhku1TNPedUT5FAaJEWZPvMbgU0m2EjIyu2gaJ8ycjkWXURggdA3G23x7czEW5sCx/1
 OOce2PoSjlwa2dGLygpHicLEmKDJJn/C42p3xiy6pJb4GOp/PQaAXpebrCmFiAFl4ooj0xVBcbs
 aR1fbjDtbZL24tThbcboDvNWch5mZ68Dy0vqRK7jQqyvdzRcYI4qfRadMi4voLPYgCozt2ejwMz
 QX0UglBYimIsy9SL1hZGJt6mEFn8B6N9IFFyfDdysWgC0JEL3vVxhwIKOsAOsFFsiJzXZV6ZCwn
 ozBkq1VdXrTuoFjTQ2SzE/82psKk3hof7HJurkQ8OfPD0GEsJ/g7Jtxjt/w8y09U/vH6pAF5o6j
 gzHBMmAp38plsH2Ce4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfXy8MjxKfoPdRL
 iFy2ZerJDnMBAHDHJaL/vQuQ4Tzst9xvRpJA0cxiNerNPq8VKtLM36TTOP+R3/jRCaJwtWQTHD3
 jTcJo72tZT+zcfLPMbwCkTnQjfARyTc=
X-Proofpoint-ORIG-GUID: f9fOWBgJTRm3NoF0KNISpGibhDZWi0ah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

Simplify hci_recv_frame() by using hci_acl_handle() instead of:

__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
... hci_handle(handle) ...

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d1e78ae7728e..9d5adf882509 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2899,20 +2899,19 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_EVENT_PKT:
 		break;
 	case HCI_ACLDATA_PKT:
 		/* Detect if ISO packet has been sent as ACL */
 		if (hci_conn_num(hdev, CIS_LINK) ||
 		    hci_conn_num(hdev, BIS_LINK) ||
 			hci_conn_num(hdev, PA_LINK)) {
-			__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
 			__u8 type;
 
-			type = hci_conn_lookup_type(hdev, hci_handle(handle));
+			type = hci_conn_lookup_type(hdev, hci_acl_handle(skb));
 			if (type == CIS_LINK || type == BIS_LINK ||
 			    type == PA_LINK)
 				hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
 		}
 		break;
 	case HCI_SCODATA_PKT:
 		break;
 	case HCI_ISODATA_PKT:

-- 
2.34.1

