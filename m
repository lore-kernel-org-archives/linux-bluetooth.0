Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6A4C67F6
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446866; cv=none; b=IOdiLf2mIPZwyLv7jqY7dOPq3ihqKvyiyWTNdFWjzXQhzcfJ0s0TkSRFYbsVkx88zoVV1icxNZ/9u384ASyHcPlL8Go91LQwxWgqBKGdmA65IiVIPjp2vZkoM3s2ZPcGun6eyGbyaG/uQ248VuZynW2Uh1xrfUNCmc2xLIfVwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446866; c=relaxed/simple;
	bh=rIj+rXMbNle9x/hv0I6GrGhaxrw73gzbPIHQlRRMxz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kY62/SENPwvj+VTf6SN2GaJKMZ79Ob+5gs80qfvzzO5cwvIJKV+zQjLkzbsbzAhfJrANPrp1Ih3CkF6soWE98rZ+3mD76WC2w5AYivOFcmvaHy6/X6SDdW2PzsngPGuZH+FIS20ymIaARvTY89QCCGf2kUUXfd/EMYJ8v1oLIvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntO0Qjza; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FDhgnNoj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntO0Qjza";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FDhgnNoj"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DALNQ539077
	for <linux-bluetooth@vger.kernel.org>; Thu, 3 Sep 2026 14:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JIUg5dqKmUx3gOnDsfnMRHvli1hg47iHrMdwpyv7Yns=; b=ntO0QjzaouxT57Fd
	w7THpr4Rvr2Qv1aXCDvt1OxE47qf/mdMfDHSXN2Uk+CGguqB5H8hXte3t0IfVNLc
	P5asGmZFaa50jBWk6nlmnd/Y7MZA9CIzY94GpUhgfvTLYqReDvesdYYU4IS/skiW
	FYIgaNUN6YjkluBFzdaxRZMQjtIudP/rNY124tqpbHjhP84YBOIRNKxqvlv0/ExX
	Yj6qOjxk0jdY7TXcpUlKvf8H5ggRrJ9EVhgRuqLEUGrPHd7szjDmoj+5TXDh2DjN
	OyWxHDNmt9BMUx/VD5fdUeBtQPhyFxkhO5WOaGK4cgTaqLjCXO4ClC40MBWMNDBm
	vU69fQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx13fe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 14:47:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-394f8176688so562855a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788446862; x=1789051662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIUg5dqKmUx3gOnDsfnMRHvli1hg47iHrMdwpyv7Yns=;
        b=FDhgnNoj5KdZe12AjMVCTcc6x5sQa2EzwQYF2yA2pBvHGyTdiNoOzen96SSw7ffOYy
         mCbpcqrRRhPsb0sIBoEsek77BY16xop8TMQgWS6WcecqCQThzm2qzQcWSeLKkytqtMss
         ZdPb5gbi8nOM2Atw85OXoMUgCV7dYNou2pPKFVnJs+S5wtOYFFEVf/VjaisowqqLJU9w
         TqBDPuTPu58CCGSGdprqTRJkCuk1xNcaYhQ0/iq/OFzmgqB+lw31xv1rvEmmJS9+MBMz
         tj30Xm8KxFxXhidIW+yS4BhafGh3Ncg/fU7W48nbvUmdmnBa57BLFoK2tQgHeIb8WDpI
         eEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446862; x=1789051662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JIUg5dqKmUx3gOnDsfnMRHvli1hg47iHrMdwpyv7Yns=;
        b=KVYpS859jaKVQvDLwVI7m6793nHlAnUUj4hzzrQab1a4bKnK/VTf5Knxp6HWFz36t+
         Mldn0VJV6PpAMF4kx14sMWiQVP+T8MH4Lor6w7KSPLbXPnHR+n63xvkzNRSzujF/Ro9b
         nj3+jsYXiAHcrCa7RlpmeJ/5YZYW7Ugaj3YR0KRnt89//4rnjmlRTyYooZrJ40lHRmOI
         J6Y2kAB6JmIswSdBmS4WH4j3X3bJ7Dmamndm4OhuS50w7KxOqRFeDIgcR5Qujx8/EPrq
         +o/wi18E3FXDIhmL9egckDWwXK5EdGHx74KVoAcyep4PpvNFDW8btMqiL7ZxoTL5bEsy
         lrpQ==
X-Forwarded-Encrypted: i=1; AKwUvByFLSMuIrQ0M0CW7JakUSFR1eX9FRTPx/OUJswxnarxpa9Dc24kl0hBS83G9SC/Xx8dckp5RUaqbnpFnEbp+/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kvkXlEjAf3TVq7GEc+2bAWJNd+pfLPYWYOY7cfnllzatbG+O1U
	z7ZQIXk4BHlq7LA5HOLX850WdaHsT8F2i1OJ3rxE8oUq58hicgZmqXbYur19ync0X21xRCW/QIS
	VI//Lr5GHLdPG+JO8GXaZxVgkVxQ5Jyx9acGtByHBJRlwmfB6wXWq2UErZTLvLoNM37bp2PY=
X-Gm-Gg: AYBFou1UAjv7t/HRQwFpZJq0Yv+ne//Zpa8v1DcpHfQr+v//geDuaMqTyIBuwGvsYPd
	J+lG8f2fxVQtPfc88QJtCoHHDj0VZbKOIjdI+qAmVuO87jewwLbBO73YC/VwtOOhDmdMsy+Z648
	6t0IpiSU7dcHOrbqTJMZr60dPv6Qmc+NrfxfIB9E0HxqRQVML8TR7MeT4EF/lo4Rcad/okldY+f
	tLQr984e2v/yiCEZhe26qa8qGkNgk8B5BuhsAvmjDQRMvTuOkgkcyPUGMd6iOIMD+pGraMG3yEX
	yfppgroadZ2qHg8cbJj4S6vRqczNTDA9cGa0BJw7Tn4QbGRSeHX2mEOWxU30Irs87QPaB1gNo1G
	4/KjR3R/QHbUZW8cTylP/JW+tKbJmnNubbSc3pjSE8zJSffQ=
X-Received: by 2002:a17:90b:5828:b0:390:af7c:fe5e with SMTP id 98e67ed59e1d1-39aedf2714amr12351080a91.2.1788446862414;
        Thu, 03 Sep 2026 07:47:42 -0700 (PDT)
X-Received: by 2002:a17:90b:5828:b0:390:af7c:fe5e with SMTP id 98e67ed59e1d1-39aedf2714amr12351015a91.2.1788446861823;
        Thu, 03 Sep 2026 07:47:41 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm25794c88.11.2026.09.03.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:47:40 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 07:47:15 -0700
Subject: [PATCH BlueZ v3 3/4] doc/hci-protocol: Add BT_RECV_VENDOR_PKT
 socket option for HCI_CHANNEL_USER
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-vendor_hci-v3-3-015d62a57c91@oss.qualcomm.com>
References: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
In-Reply-To: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: _Fu6r_JSsCY8YEOlqbc5og1QvnEuqIWa
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a99888f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=wa7QpaTpAAAA:8 a=Ydnp389x0cl5jbVLM_IA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-ORIG-GUID: _Fu6r_JSsCY8YEOlqbc5og1QvnEuqIWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyOCBTYWx0ZWRfXywUmzhXfIxdD
 ilwGeJaPsIimp+5Ir0gUxXiEmvhitJeR5LpeFDiSEIr9JDEZwF3g+V/hdiKcisU24x+BRBlLU7q
 99wBXTT828/bVKhM0k4/7UOzZ11l4eUBxhLiIm0D8noirTjv+3nkPUp+BopNXJ4sUkB7B9lyO6o
 4c+nz9nL5g0IocHM2hhz3Fx4X6w1ouBdVk/DZBw4A5TYHDgiNDDFOKdQj7yuyUvtuVgVqUtyNgD
 vCDAcm25AQKpWH9tPQIpfJza3VxKgBd/nMKcighzQ+nbEGYFF8TTStA//zsI384ZOmpERDf3yFW
 tH0bbmIjVluJsH/O6WgCxQY4xuYVXObEq68oQzkTVakBB4LFHyKNafs4k8xOn0awbrd2bcIuaDw
 1kjYDeb7jw1YWmwIc2hjCrcIGGj8GqwyNq/NmBlajFOkw/4HByvsMcr1k7Gj+HiHKhh5tZZf4AN
 J9NGshdv/HyS6XCbruQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyOCBTYWx0ZWRfXyC8xHp0i/Z75
 gmcn9DchGrZHlFfLCtElEkil5SqcWanI0JCL+2/LecoRtFm2p3r3ml8MNxd/9XAz6eE4VHJ9Ea6
 0sX0f9rcVvzckS6KsBuZX08bNmBVvWs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030128

BT_RECV_VENDOR_PKT controls receiving vendor packets over HCI_CHANNEL_USER.

Disabled by default to avoid regressions for existing applications.
---
 doc/hci-protocol.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/hci-protocol.rst b/doc/hci-protocol.rst
index db10b35df736..53734a0037a9 100644
--- a/doc/hci-protocol.rst
+++ b/doc/hci-protocol.rst
@@ -131,16 +131,34 @@ Example:
 
     uint16_t mtu;
     socklen_t len;
     int err;
 
     len = sizeof(mtu);
     err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, &mtu, &len);
 
+BT_RECV_VENDOR_PKT (since Linux 7.3)
+------------------------------------
+
+Control receiving vendor packets, requires hci_channel to be set to
+HCI_CHANNEL_USER.
+
+Default is disabled.
+
+Example:
+
+.. code-block::
+
+    uint32_t enable = 1;
+    int err;
+
+    err = setsockopt(fd, SOL_BLUETOOTH, BT_RECV_VENDOR_PKT, &enable,
+                     sizeof(enable));
+
 RESOURCES
 =========
 
 http://www.bluez.org
 
 REPORTING BUGS
 ==============
 

-- 
2.34.1

