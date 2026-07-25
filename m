Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C35A389460
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969704; cv=none; b=rTEEz/4JP6lSIdaCHoo8ebN/EZq8wNYnhTIBii/EKuRvjpYIM0DA4DUBtBdPud/EPFtLMYVeOlR+ovS505DPwkO44RH74oonrh08yD17Wr4xEFu3pKqMvyuv+XnSHoCXAshbhj5C6bxVh/OzvEt0fGul/4ZXrBUxe/KhkE4HSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969704; c=relaxed/simple;
	bh=DCEgJqIScSiX+4EObx2XdxobyUOizcvUxhcDL78HYxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhLufeMmgfa9ZkUjhw1TbydCqM/yrnjnxCmX+kp1vFpPRBHyLPVGDe00rXBFMPMxeT9yhok5MAC1M28ONaVPqhv1CSVBwmp2VIPcXwziboSgrJ5vQppTCnskcacTsXf/J3wZaBe3SaYCweKQzjMSIVn47SazjUpKh0pcNoEWm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6OdpPvs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e3hgHaW2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6OdpPvs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e3hgHaW2"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4n1vH1082225
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mcHZ6o7GsYMYo3/PQjDxlD1kUPAScIvFtKiC12U5tgE=; b=n6OdpPvsnTXmt913
	iedy0CUEvoO/NLur/fgWXMwslsEBnUrOgSkSfKOrGmx0Jrk/h1Xz1MlK4qFgW906
	E0pXcfFGVp9t7DfEZ/XR4xa/8EJeyIMm4GfZf0PRMRwSUW3hld5vuFQE+LvpgHt7
	5gLoOysCBL3NpAxBcDboJHXEKoWm10V65+VkRq889VFoGyL7YQK+Nh3IDVtzV0xe
	ASvBU9CkhrPg3QgDK16NNmxg42ffbWCGyJ49MqsxFz32AkPb0j+Jamr7UOjakCEh
	IfoiV/4N4DSqVQc41I8mdbYs52BdMkNN4mKuec42syyGGZyoR+1Kx0lEcXaHFT37
	GsUf7w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmn7v8he0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce756aa72eso4236555ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969698; x=1785574498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcHZ6o7GsYMYo3/PQjDxlD1kUPAScIvFtKiC12U5tgE=;
        b=e3hgHaW2OB3zvRVYK1UaiAXhLtdTIeJMsNxA4WXqZEbqI91/FwAb15NuQ9+/EtkfGa
         +t/ArEBDGWf3ih4ijg4tTP50usMd8EgSG7OZnczPRt70D+0uUUjyozkylCrTjTWxT0jo
         W/5w0OxYcmN+TbprmAYnWOOLn0StHW2Hsi6EBVTzmmD5Q9CjvDCuxK5rViG+tqylFkxC
         gIM5vKi7YZgOIc5kR0AbGO1fNmwsp08wvu+A8UB/lFIpycQ8/TCg7cex8GTIVzWKS2KZ
         WdSckLdqHZY7ojoc3DeeX8EO3du45AxOs5A6KoJgm18T5vOxKvvmLGwflxqvEvI0ihYk
         MIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969698; x=1785574498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcHZ6o7GsYMYo3/PQjDxlD1kUPAScIvFtKiC12U5tgE=;
        b=VbYsZb/S4Z4OU0KqyT3p6NNzi1UX4rZvEQmcFnwDEiJaZhCHCH0uEs/nP4aL3GR5n8
         rsWRi4aIIBNfDN8+KP3y4IF7DfVbRPbZiSPkBEdThDo10UneQFXNKZNc7r/ublVhfwdX
         zm+V8NNgRpl6566+9uKgNlTtmqk3/BCCB1oWt57YRu33WUXQaF/wyLbAxa8t0BJpz1jX
         8+QQH3xPOcG3VNqvoR93fUnGUkqYGMthlPfd3WwYkNAcHmOwGbnLdKZghJ5chLZRvidI
         3Pv0msa/M3Oy3US8lcfsYSbCA1Ea9Go+pH/+Xk16H5YahjqrQ8vVIVcugkXxZneWA7+o
         RJ3g==
X-Forwarded-Encrypted: i=1; AHgh+RoXCwOHeuJFTOyS8VeJjjJtlGQm0+TGnn5kkFVOmTNh4pCsyE4W6MZJhCvsTyuDh3Oq6b6HMj2Q8ZfKl6CCkrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwWIuEByPIyQB5GmlOQ1jWvk6rPyVZ/bTWkYLVTSN9WKGacpF
	2UUHk6kZTC77Ak9r6wu7xoNshwjHevhuVi7Jsm0+BOeA/JAlfINc5ss37zqbgpw7HBNkgmAj439
	aK+aMZdoxctHc1UiqLfF6YhKs6DEySFa9ronNuYktySKLHilxk/NXiMUdQgG3IwyAzUz/r3k=
X-Gm-Gg: AR+sD12oLJrLJlwFM7u7GBr+1WbSPHC5To/fB2NJHaZDy2iRpITrVj0+YYMgpIXsSxh
	80c1hPaemqR2TC/T0kSTMSe3aUx1De9vr3Yr8hw6hp1xe+b+lnzQC/DejmTsLGWJ5yjIoZy9CGp
	Zq8sXQv6V3W5Q4+RRSjAGyyB88+ETlqjd3R6nZRaC4B+Ed/aFa3pd2H0z8OC8Wdgl+DcvueQh8Z
	oteTXUEkZvzRIri8DnMGbKVvvapHifA8t0DNE0CjpvSY8H8wnyIqx4yE0c32sjR4N2abIEBtkzL
	yRpq+JA07bS6wWqhyOfX9sPidPEnOmlXiJ+AfSi43RIY4NUJ2BIpk8eLDbZ/wK8CZnsCsLxrSam
	Zis4vLq6DzLBngRKZCB8T3WRHsAvPzRsPnO7jS7qlxC7MEoQ=
X-Received: by 2002:a17:902:fda5:b0:2ca:d344:7752 with SMTP id d9443c01a7336-2cfde8c90d9mr12638685ad.8.1784969698149;
        Sat, 25 Jul 2026 01:54:58 -0700 (PDT)
X-Received: by 2002:a17:902:fda5:b0:2ca:d344:7752 with SMTP id d9443c01a7336-2cfde8c90d9mr12638555ad.8.1784969697721;
        Sat, 25 Jul 2026 01:54:57 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:54:57 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:44 -0700
Subject: [PATCH 06/11] Bluetooth: hci: Introduce hci_acl_handle() and
 hci_acl_dlen() helpers
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-6-305aec261a19@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GKk41ONK c=1 sm=1 tr=0 ts=6a6479e3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=zvSapM-TluQMHEIATDwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: WFBgiOeoUprwIziQaV9UW7APDCvT1Vrg
X-Proofpoint-ORIG-GUID: WFBgiOeoUprwIziQaV9UW7APDCvT1Vrg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfXzfUvMWqeAvyM
 jzwT2pQ84MyO5pViZ3+j6BBf1fByP5t16LFAEO/G78+KcaEqEnNNj5ReSRlAwJeZA3bOk5Wiazc
 B7QISGuPHx+KioB+gurWvNLYrc5q8MM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX5GiF9gxgSZdu
 o/XWbrRGPFqxL3TRJp+uEDM7Tx3g3bpxb0YjbisfgqQDwqauXfisGw2Tk8KGO+zpFAZS0ZV7dgr
 pBXSHv/bZbZ7k71iuEL/8zVqHrljgtOeC3/p4NyobIzB5Tw8iQeClNESqzQCK9I0BALV248z9TE
 inN9H2oC0v7kiwqjpewZGqLdYm76H70mJL+am9/D93yBHuxdclPktA8tzYzomimR/PzCD8LngoN
 RSNnFpmZe0DQ9x/csjCxYCDpzuKC1MnsYbxjEDdY1ITwrZDnjiV87Imi9Gt/IM3r0WcnctNRyr5
 EyDv7CksAy2Trk1PrE55LwtyZFlgPOh0cfr9OW84tgKinbXwwatfERFhtziIbT113hR7O+07Mvi
 NItToMDyvKAVsYR0YOlJ3hwZ1hGdpo69Agr38GPuPA/1vAgVx7spuR4Tn9MkPx8QPHf9scZFnaM
 6MO6+aqJPm38QboANdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

Introduce both helpers for ACL packet since:

both core and transport drivers extract the handle and data length
from its header in several places.

Both will be used later.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 50f0eef71fb1..d557bdf9ae57 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -3402,16 +3402,26 @@ static inline struct hci_iso_hdr *hci_iso_hdr(const struct sk_buff *skb)
 #define hci_opcode_ogf(op)		(op >> 10)
 #define hci_opcode_ocf(op)		(op & 0x03ff)
 
 /* ACL handle and flags pack/unpack */
 #define hci_handle_pack(h, f)	((__u16) ((h & 0x0fff)|(f << 12)))
 #define hci_handle(h)		(h & 0x0fff)
 #define hci_flags(h)		(h >> 12)
 
+static inline __u16 hci_acl_handle(const struct sk_buff *skb)
+{
+	return hci_handle(__le16_to_cpu(hci_acl_hdr(skb)->handle));
+}
+
+static inline __u16 hci_acl_dlen(const struct sk_buff *skb)
+{
+	return __le16_to_cpu(hci_acl_hdr(skb)->dlen);
+}
+
 /* ISO handle and flags pack/unpack */
 #define hci_iso_flags_pb(f)		(f & 0x0003)
 #define hci_iso_flags_ts(f)		((f >> 2) & 0x0001)
 #define hci_iso_flags_pack(pb, ts)	((pb & 0x03) | ((ts & 0x01) << 2))
 
 /* ISO data length and flags pack/unpack */
 #define hci_iso_data_len_pack(h, f)	((__u16) (((h) & 0x0fff) | \
 						  (((f) & 0x3) << 14)))

-- 
2.34.1

