Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661157;
	b=RZ6zu8aJV5UPIdFpFJ2gu/VS+M/44cCyx+nalSf1CUsivTVo83dI4ogrljbx60PVoCMR
	 n3wJMRzJp1c8droC5ZdcG/059EXoPHrm9DD2u6jLUB6mYlyQ24SpoHco4OiSzkWfclK0S
	 z3YjA4twzxX6mrGSPtMkfgbgGGrkDMz0i6wqyhi0wwFKJM8oL+b5DjR2ATYL8E903VJiG
	 TicW+hKLvuy7pRCsM8MFxCwjniQHD740cDG9PVQO3kDDwOeaamJx74nnJG3A+lPQD9PCO
	 jLBBGjUDr39d7mehegLJUDo9tqZPOcKo++2AA2zyf3BDv86HomdRKt9CzBi5TGLhDnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661157;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rUvLIEZGyA6UX6Mn1kh5h3coeoD/BV7D5iTLN2MHQ+g=;
	b=JtVNO4vBiDuo/TpYuhr6IMKhWsAGyb8+3qPmXVs9eGvhAoQ69HxOuBlj8sHPm/ni/UBZ
	 nHdLpTspAHR//gx41XB2Z02uz5B3Np27Bp9TmyV5CrrAnBuQcsvQC4JXpKJPbKHagcaKc
	 axWEb3uglmuShGQYviNF/Tr/2Lybnn7MonlBS9BP1gSbpj7CVjamAP7jdYTDHcVVTGmNQ
	 x5wOqNeMqK5zmBlJFshWnWgTGucoYMtCzikSvohQ6IyshBmIg0e+jD+ho4AIdBFjTWJiC
	 sj1QbU8FzL1Tf2SQlEDqAecEsOjw3OhhkGuEWMOLge4aYj+IOKi9JA/G7s4U1j5yI+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J0+RFN+7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rc4xAVCd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41B606A338
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD41B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J0+RFN+7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rc4xAVCd
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJAsvp648247
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rUvLIEZGyA6UX6Mn1kh5h3coeoD/BV7D5iTLN2MHQ+g=; b=J0+RFN+7FJpDHDIL
	/YVBUDx7j58KD5yy4mdo/c3CjnqkK4fswe4PeARXz83Z8k1Sl7ZhnDJkqQvRRwYE
	Hx9h0JYF0AYpnxI/17sk+bPAYqlyXacLS5EQegEIPxjKPMrGayZfvCL4PN6JMgg/
	KI5fBB5V2arXjm+FWoZJTDZAfWeAjkCZdIAXTcPkLZBSy9NySTC86lMs9Uzzl95L
	MptKd/UxjTu3XEjdk/49GZusdIZG5+BsxYyzIXZiumPQR7tmbjs+qirXwP6eRP5n
	A21YTOcgTICFPvfOikn1tL5/OaHpdckdCWmvlHg/7c0h+48d6GOAHrsPoQKwXgaK
	1ryn+A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahtd7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a6f57c066so668228eec.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795661155; x=1796265955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUvLIEZGyA6UX6Mn1kh5h3coeoD/BV7D5iTLN2MHQ+g=;
        b=Rc4xAVCdofCtUV+B+UMhJJqiDJLAZsg0y/Cu1xsrLVAVnbXbkj1UJ5wNV6ZBjgKiSP
         K0Jw2FElqGgJ3NG3a4lgkcX7NQ15J3TVa9JMr6HFEGlutE76iShfi7b/O27EGQEWrWbh
         CZAAyJgunD6siXYaAet9p8G3HB+EkQx69hNPXWqNkxMFlpkJzs+UD9oUURrMdYntxeSJ
         nw1wvGGK+cHpk3ytxOycQjOeOHjQNYhKe1QyJllLdnc94SVjYDWkz3UyBTrxsNo0em0D
         gcY7VmtZUc623Ukb+8p5QzL45gkZHcFCa/5BlfP6UZL91UKlo/4fjmRibZTlGTrPeWMm
         r1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661155; x=1796265955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUvLIEZGyA6UX6Mn1kh5h3coeoD/BV7D5iTLN2MHQ+g=;
        b=CXEVsBXRNhXy/TONfYjdN5DMl8e+y0c4d1MaOJv/foo2jk492k19l0fZXKeBnbqBoS
         cXtJQe/3eRRzfKdVffO2OlZvphrhCt7i/EvfoDJyWt5mXvyag9INzLKydyHhB7V9ifGb
         mlIn29bN+fbNe6OJlDz0dK10aO41RE2nZ8cByTT0nLXUyfcYjUPJhFIXwctkmV6Yh34f
         OhYgedjFNyjhv6RQkzrSaT9EvigYbAUizZNTgiQB9K27ZMzVK7mOHuLK/gDY7q/PQYSd
         +5rF7Ek2HLAMXv3YmGYzq5opCS6zgJsLmG7S1fT4TFn/f3zwSSuul6LG0AxgQRjFcDR9
         83qA==
X-Gm-Message-State: APuU4Z8a57y2xDTNbPZD2V6UmTiE1NjTQcC+bZvhzWW31wmqKX0JVh5y
	J/Gnn8aiJO1Wy3KroJzWzQhSBB8ebhLnG6zDVRDSYq8nqLt09pbwbbcGpBXBmGEJQsJIZa1tY2W
	8dM5U06oaCrrFOCy/7Ft12vfv9bX36z+BbYet/G4go54BLBgVGFoUAfHVjymWDnm2BhFoLveIFc
	ewvCIPCA==
X-Gm-Gg: AZFdTZfpTTht+i7DiwI2x3HGkojYlrbra4ergctpfunjQlLf59xDLH1gA3Lgn84dpNB
	UPErnibNAfsuq9Rx4gIXZx/NdNrA7RfZohCFxb2evKM/F/1YNrMl8lVL9kxr7yM1lznk4SlGErV
	EQFTxjRov62N5XKcOIHKgmrepE1De/bsdldbcvE4RoR4O/w3XSSAAxMPB7x2qNyBLpO2zZnJ9/3
	W9O2Lg4psjbzrZPSvyWkCYXpdmdK5JfMUsAmehTlNTwRtlSQYSU1OxBNOmfEa0XKp1i7WMaKfLP
	uhlEQ0mlLVmzMupV2m+kqiPllLCoeKHkDpG8gcMvMBEVKzQ5D65umbR5mwpuY+GqT43nmyXr5/C
	jlyjx1rmlR8Mtf8jdfwDcI6tBXUcX8taJ3oG+SHk0xar1C9ljg75xKxuXdC7pUz/dRgmfpz8T+g
	4Wmt0bvJcqj+9BXig0UGO8
X-Received: by 2002:a05:693c:829b:10b0:386:c3c4:b914 with SMTP id 5a478bee46e88-386c3c4ba54mr11407124eec.0.1795661155353;
        Wed, 25 Nov 2026 18:45:55 -0800 (PST)
X-Received: by 2002:a05:693c:829b:10b0:386:c3c4:b914 with SMTP id 5a478bee46e88-386c3c4ba54mr11407084eec.0.1795661154849;
        Wed, 25 Nov 2026 18:45:54 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm16253220eec.17.2026.11.25.18.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:45:54 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 18:45:42 -0800
Subject: [PATCH bluez v2 3/7] doc/test-runner:
 s/CONFIG_BT_HCIBTINTEL_PCIE/CONFIG_BT_INTEL_PCIE/
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-tr_arm64-v2-3-4f02989f17ba@oss.qualcomm.com>
References: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
In-Reply-To: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: fBVnCD8CvsEyoR4I15tXWusjMCTNSndW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX/fzf2j2aWEkk
 /g2NYuSgdPQ2fQa8OKI9BBfeEJp9mQuCIju6Oa32h0oTs7EDgioyKR857MRIYs5oZAgFCZUr1Yy
 zIEVRi0szxyT4Jq3RLyU7RVEpbmEA9c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX88hGhScwGxbq
 kSj9eEs7+jVKC2UrnENfO/l/jOsgHk4PTfEGS673K2v++YequV4lwMyZ+RM03Yf8huqfg1IYsrp
 SYC9hdUauphRqvH1ZWiCYF1nDMn46NPUq7RJ6YM1G0DN0MhXrtoy7HMFrwIw6s/OG1p5cHaz0A8
 CPEAbYxDoyrqnMr7/kjKFxirwIg9gmNmvyCJCofZC/gpupHiapGwyifWv7w57P7gsAW2M5iDEgX
 wAfN9dF0hpHHz64kgQIqsarQeoHFjMmSfTFCod+nzsB40+bw6aQ5j0b5jtszCyjV5mZ1qmINhBZ
 tNsfYzd5dBB86uI6zHO1JDV3w2lEcnqALHJ1VmxM0y3fBmBbunVZv1WbqJJXeJuL/UKuzxhVa/M
 n2GhQMSzFtFYyEoTgBA7q7c4ux4edWWv2LA6Lo/2KTZ7sfjWQu2q1aP64doszbC1qjmLjYaZIxC
 2C0+P6cif2LVtzg2CSw==
X-Proofpoint-ORIG-GUID: fBVnCD8CvsEyoR4I15tXWusjMCTNSndW
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b079d64 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=hm5o9tMSPX04P4WYDNwA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260009

The btintel_pcie driver is enabled by CONFIG_BT_INTEL_PCIE, not
CONFIG_BT_HCIBTINTEL_PCIE, which does not exist.

Also split CONFIG_SERIAL_8250_PCI=yCONFIG_DEBUG_KERNEL=y into two lines.

Assisted-by: Claude:claude-opus-5-5
---
 doc/test-runner.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 220a2cec1c55..b5876e4f5108 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -190,17 +190,18 @@ option (like the Bluetooth subsystem) can be enabled on top of this.
 	CONFIG_NET_9P=y
 	CONFIG_NET_9P_VIRTIO=y
 
 	CONFIG_9P_FS=y
 	CONFIG_9P_FS_POSIX_ACL=y
 
 	CONFIG_SERIAL_8250=y
 	CONFIG_SERIAL_8250_CONSOLE=y
-	CONFIG_SERIAL_8250_PCI=yCONFIG_DEBUG_KERNEL=y
+	CONFIG_SERIAL_8250_PCI=y
+	CONFIG_DEBUG_KERNEL=y
 	CONFIG_SERIAL_8250_NR_UARTS=4
 
 	CONFIG_TMPFS=y
 	CONFIG_TMPFS_POSIX_ACL=y
 	CONFIG_TMPFS_XATTR=y
 
 	CONFIG_DEVTMPFS=y
 	CONFIG_DEBUG_FS=y
@@ -381,17 +382,17 @@ Running shell with host controller PCIe-passthrough
 
 In addition the above kernel config option the following is required:
 
 .. code-block::
 
 	CONFIG_PCI=y
 	CONFIG_PCI_MSI=y
 	CONFIG_ACPI=y
-	CONFIG_BT_HCIBTINTEL_PCIE=y
+	CONFIG_BT_INTEL_PCIE=y
 
 IOMMU and interrupt remapping, without which vfio-pci fails to allocate
 MSI-X vectors (-ENOSPC):
 
 .. code-block::
 
 	CONFIG_INTEL_IOMMU=y
 	CONFIG_INTEL_IOMMU_DEFAULT_ON=y

-- 
2.34.1

