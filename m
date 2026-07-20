Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D83A9852
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784526078; cv=none; b=eOYeACUKYVKBuOZPDVDwxIG1wFA1VM1QJF6dHgS1AKuHnwIXcoRyYgV3VHhaUkG0r0qo2tFfXDFn0MHY6QtUCWgLLbgutfeXdW6OtrLaHLQsGYgBY2+0C3KzC0aSfemPx8SNjlxLAMhGyfr9VdvBS+N/hc69/jLcKUEifyEkjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784526078; c=relaxed/simple;
	bh=HMD5Cz/NvheA5S+JoFbambiFesebwbLr5YEMJv7CrRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isTtYbjvs1AHD3Nwgx0v7YoFV10yk2iMRiczfY+2PUAefTJTxbakCwn9nLbxXrvI7lBEn+cww6BTrGpWvYrq6eOmFO0Ntc/GZxtRieWK0QWJCpss6eFy2JHv/p7KK9JkO+ebgT3Z3+nEjxRi7fp0MtdZUNOCINLs6vr1zD9wIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TAugKyp1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZIiwzi2M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAugKyp1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZIiwzi2M"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsRJd657661
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qrg3YHOhhBArpXDG9IFdm+A3D6CKurJWzQZwbxvOflg=; b=TAugKyp14KUR0Amu
	B/RJZ2EmHN11yh0uy7VS0LEXdtr0si2PX5D7zDYeMnX3Mp3aQDZHgncstzeIq0/a
	xaBEqlwDRwxA03wZjRtJhGe0JkkKVbjVdOkNjVd87iDgG1cHRcg+KpVuOpUFMcdO
	82FgWPwLtzJhnZDyn877o6b+33fMWNcxLPY4zcKz/64GridWKpMRTHak+k+IBR0h
	xEVImCzRZDd9yuih12Ju+vyTWEL2ZqyUfTSIWHsHYEnlQ2lnS5sI1Ft3o1Fmr1oI
	7K3mxDV6zJ3PpAGuga26Virhah5ygZU2WKJ/881m8UWAHU0SfJGQjyzgcSu4Le5v
	JPyhNQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chmgqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c6a72d672aso32028215ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784526075; x=1785130875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qrg3YHOhhBArpXDG9IFdm+A3D6CKurJWzQZwbxvOflg=;
        b=ZIiwzi2MOp2mxg6Kdm3fc8O2b5QIyP6dBEHzqkpdxN5SbS8xYLKv1qly7Gx+ZxFqHs
         xmaqdnKV4zSXA+D1jOtcqPVn2SX9CP+YsvC1u5vIBHXq9A+PoUuaA9jzT7QSuo3Hk9r1
         pkjHkjnLND3MyBsdcfAIif7qHoC66KToAjNXm9fb0bpthM+hKclvfGB473bfSoHpeFxN
         EDFyYagJ4ot7eq7OTSQUZANBbq3KLvacaRwUSSJmW4YdXuosN5l1RQHZBjxVPcQe9PIF
         6q+knN88Yyw+r54vafYgBrEirfOlD0qQeVg+6qQz8Yfe3Hc27d768cq7QH6xamN2fz0Z
         SLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784526075; x=1785130875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrg3YHOhhBArpXDG9IFdm+A3D6CKurJWzQZwbxvOflg=;
        b=WM+8hG5WJ8FWVK3FmLcc/qM5g1tx5IOsfvGIKAFYpwpnZF8nhgCyJ1TPHvMnnsoyAf
         Sx/TWqd3yo8p32XCVbkx/f6yw8JYddfV59IpTbkVn4tIsX49XmEsXFiKOkEYwPbRNoXH
         0Ea/xJvrvKtq1uAsuFNcc1J+3xtK1HfeDVuTZx5XIPbWAnp/GKzfp4qrkvZ8kCsmyh4Y
         clhVhDoz2JUWOMCK+rkv17RnESl3Z5WyQoRxkSKBnxNW/Vx9DOLyTQ7JyLxs2w6Any45
         w3Cs1GnnYoBeWEcc19Uyip9hCn7Q9LbjXnPH8ReATK9ZqsMGC8dyRqM5GmcngRSyxCCj
         MeFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtPKgdF8xaavcW1p9nz5aBNQuybMMCpcL7th/iiVo+QNBpomTe//ulnnWfH0qe/YQNE4hNDdLwv3OoDeQ0bZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRWx64kkiaIYClwN0Ag7CKEM+Ktau/27C3fFgWbvZZAY6LBON
	G0dy+TrYUZr5GFB04Y3QbE06zE0TNeleHFn4pg55hgnAYxcHei4JM+/ThqFngBB/zk9rnA9zdDM
	MOPGvbRcPuG+RbmDiOGkO5bM1+Z51qX0Lqexm6luWgWELS+qjxHL9Nsl8NFjvqGjLMAm+uKo0jH
	G+l7w=
X-Gm-Gg: AfdE7cmxwC1TDa0lub26B2QvCxfamB3VZN5PcNNiwvtFrT3nUGHRq6oiSgoL2Rczjci
	yLeGBpSXXIksdoY+/gPXSCKmbrm17sw3xYALspUgkhFp/N4kli7Xrg2nTq/bLkW4Vnah/GCNdwV
	u5BnWud+lSwpz0SEYbgQdB3reE9SXvPFrZUUmJ1Dp303lQtVm1Z2Gc0/BB8U+pLuXFpE+nxpeWY
	zDgp5W02hlwdogg6OxeZ8d4R4Xnqo8SIsf/VTTk3mFlEFndCW+vIh/h2IwLMu4t/6xGkmygtWr6
	sDrH1qu8UumTzTqQAxaURUTksTsQvrJ+OSxwNq7k+OGWAmAtjHkCXDCYCB2r6ZtCFMYdq0kT9mA
	GOvPfqY5Mta7EhFSE8IEhsMl/RC9g1Zl4u++j/ArBe0wBjLM=
X-Received: by 2002:a17:902:ccc9:b0:2ca:bca8:109b with SMTP id d9443c01a7336-2cf3497f5c8mr102012425ad.5.1784526075045;
        Sun, 19 Jul 2026 22:41:15 -0700 (PDT)
X-Received: by 2002:a17:902:ccc9:b0:2ca:bca8:109b with SMTP id d9443c01a7336-2cf3497f5c8mr102012255ad.5.1784526074563;
        Sun, 19 Jul 2026 22:41:14 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de301sm31907340eec.24.2026.07.19.22.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:41:14 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 19 Jul 2026 22:40:51 -0700
Subject: [PATCH bluez RFC 2/3] doc: hci-protocol: Add sock option
 BT_RCV_VENDOR_PKT for HCI_CHANNEL_USER
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-vendor_hci-v1-2-df2ac5a50117@oss.qualcomm.com>
References: <20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com>
In-Reply-To: <20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2MCBTYWx0ZWRfXzo5FgPk/SMal
 +cptyNimwBo6qilw/oUzjDjQQdiTeCd3hcl/c4mpl3UW/SqwEvtWoNxqwkPJsWJjFubR/LFNcIB
 eMZshzbhN1E7Lk0W3tNdOU4nyg21XeQ=
X-Proofpoint-GUID: PbwXwY4qt6j0kB_VkDB47aKfyXxcce_I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2MCBTYWx0ZWRfXxpF6NoEaeuaW
 cF0y6LNMJWvKmtlxaS7a2w+RBNetiH/uBNRMjQc6fu3G6RS8DrmherncMtFAyS8+Rg0dUBVd5AQ
 7uOps3tw2gYvWFHzgtZUhtlGlmFVPaYrkmYb9HANOfqFex+Wxzx0X1eV/9m/Cl8n/8iyoi5Bm8s
 KAaNQ9+qTOPD90mvriNQBn/F9bcE2BMBMaUwuGLA0w011qbUVp/7Wa27jsERK/OXyaGTKbduU5L
 ncHmrJ5v0IhOV+SlUlLUZO6EY5wiU+nmX9KdJKvB7Z3PyJGBpU69mKhUusWcTnpbDZdAQIYPzmR
 m6hNKyY8YTCHxw+vUPbbkgNfAQxBO0zSi5v+iH+CnPAuX2RjXGxYnl0rHMArUO8DAzPsKzz3sdH
 T3ycRVyLwdUI34HqhVAS1AJgKyIZ0kZatZKXdRvbMg2kSoGFKnbGqYDbLvtjZYlvyLAJkdzxdDP
 D4NTNjIwFKjsTPfFeCw==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5db4fb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=eFS8avIzZta6tC3nLOIA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: PbwXwY4qt6j0kB_VkDB47aKfyXxcce_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200060

BT_RCV_VENDOR_PKT was introduced to support vendor HCI frame.
---
 doc/hci-protocol.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/hci-protocol.rst b/doc/hci-protocol.rst
index db10b35df736..91cbc5b65a78 100644
--- a/doc/hci-protocol.rst
+++ b/doc/hci-protocol.rst
@@ -136,6 +136,24 @@ Example:
     len = sizeof(mtu);
     err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, &mtu, &len);
 
+BT_RCV_VENDOR_PKT (since Linux 7.3)
+-----------------------------------
+
+Enable receiving vendor HCI frames, requires hci_channel to be set to
+HCI_CHANNEL_USER.
+
+Default is disabled.
+
+Example:
+
+.. code-block::
+
+    int enable = 1;
+    int err;
+
+    err = setsockopt(fd, SOL_BLUETOOTH, BT_RCV_VENDOR_PKT, &enable,
+                                                    sizeof(enable));
+
 RESOURCES
 =========
 

-- 
2.34.1

