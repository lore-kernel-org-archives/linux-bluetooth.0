Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343677;
	b=NezuOFdYPf3lzg0sAFJ/EteI8wkC1aDdtHuLUipzDxpvt30/J3Xa5gY20XozdltBvZcK
	 hLkzRNgvKG1il6Ld/TYYXHtbnLS/9V6axk6fs2s+fLtZJmpQe4CKAq5kd3CflcOBSeEO3
	 1WD0dUDY//cFPWaIWQsXIKhwCZoEIT+ji/zQ0aHHz9LFn98lATLeRjBaZDVFuY2V3b4KZ
	 AgEBfo8Jjfa0j37aWHqLxzic08+6rq96SxpM6lOTxRtcdYYNjL7OJfP8TZ+uFx0jviwyZ
	 R03OrBbozf51AUjQhISOX2xVk57SjqgSubPB4eGYzxjsdqfmRmmjqzwT+/ZJsvUBoMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rUvLIEZGyA6UX6Mn1kh5h3coeoD/BV7D5iTLN2MHQ+g=;
	b=GFakcEWjmwPnCNQl8pPte0S/j2skwJXoG+IqT/Qh8eXc8co27Vf0S8FL41mcHrYdRdUU
	 RvWJcH1XKFG+iylXUzt2uBeHIPUO6keUD9VL5I056j1CQYOTVf85ig+As31unN/4jTJ2g
	 DnayXlYUUJqozcoi2EJDGI+kqo6L7PWLWJd0Eu6i6xc4rLadawbtJOaOpiaOxL2XdKX18
	 sC05A7+fMv0awEXGFNYC2H2PirGBFpCKvjuddlKlSuFSers1pugFHPh8Vf/o8aBMOZwCm
	 93zdMkrslVO3w37sE6DllczZ3qGVKZO8BNuiYc6oZ6I16oZzqgZf6yOBoEHt0DbYUfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eJlfz2UZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i+jF6I4X;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C63A606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C63A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eJlfz2UZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i+jF6I4X
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM860gw3865295
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rUvLIEZGyA6UX6Mn1kh5h3coeoD/BV7D5iTLN2MHQ+g=; b=eJlfz2UZPWgaB8xq
	nz22cOppxX2Sgd92QkjzFpHVQTIg1i32hXnChIeo5YarebytvOrhxpu7GEPJt8b5
	VqiIVMohGM7geTfK//BMTXOcq6f7obqJ6euZmkdQ77dQXFy15ga9YG/wCBDYcv1G
	zdHRcqvOUnCbGwxvi1gHNPNx1GqsukvWQ3kAnUb6ewD5lNS06YHmJ6XQ2Pl39MB8
	0PEOZXngBBE1Ss8H5tvZqWSUZGY4d96Kj7PsQu50/TJTfCP2keHqEI2lldvxYlf6
	H41JyEkdS+omY3+znGDH67ovzyPSPhBBYBYfwRMPiym/3iGNrj9+GkEdsu+0pueI
	i4Y5QQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j310fbfqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33bf1d17dfeso279763eec.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795343676; x=1795948476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUvLIEZGyA6UX6Mn1kh5h3coeoD/BV7D5iTLN2MHQ+g=;
        b=i+jF6I4XinN7Vogwg1ptpQejdCNQroR+8M3pOuIT0EYuDc/F7dVg65TiLhIrEl6vXa
         VbI7bjQ1jJE62QwXqAD3bX5zCiRPvxpFwg49ILbB3ednXEXKk+NiOV3UI6DwKB3lczTw
         TIdIVHs5LhJdlopV9vDGorhICHWl+JEle3yZL26AFqQBN3jKG8/tHIbfjdvs6wTAkVma
         CiktrEkU5IH2BFgjVqKC/SuJq+27h0cjpB09lUQOKQyxOHNwQ/50yL+JLJ3oPdI60hzL
         t0ylOZKmEOmvXgUfDVYzhIiCeYGZ1/S+lbi4fFl8KuBuxJ2DErb3vrzw3eMwOBbi4Kfm
         KXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343676; x=1795948476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUvLIEZGyA6UX6Mn1kh5h3coeoD/BV7D5iTLN2MHQ+g=;
        b=FWMzbqanxpvZZMEHGvvV9gSeGMTqTDopZ+LbYEigVAKeluty0Ejg1UJrBKoQe2m901
         QALVfcmgDyunrK3vQcoRn/lQRXGtafnehLWU2XQ7AShpF+n7c35QnxMmHaU1GB6wTStu
         CGCzsLCY3vTurVnfHJWWgE4vaH8gzsudHHHYJ7aQ9dj/xazz2Azy5/QoU473tMDpOFsp
         D0GTWt7S++y6ZSxNnYbdCFwN43Nxvum1Ig5aaAiAX5JCPNFOI/QvPJ81bswx5dVX+iRa
         cnKZYHnQsxrFpWjVOH9c7F06p2xcFpZvaqt8Xt0JMZihC/P+H+ghslWZF63mt0Li6ZzO
         5GIw==
X-Gm-Message-State: APuU4Z/TuS+KSrBE/tTAYCSy0hwORI15UfHiLF0MyvLp7yUBF5KZGN2F
	PmNCp8OV5iZSSfujKEhGeM0Fi/nTaKqf/xS/aomp7+QovlylqjkiErH+U/ySUtpINjiPfrLz9NH
	22ZWAihEVpCpCwb9Gl0uFYn50t9JiH2sn7rwLwV1PohgcOhGsL7k3GBd860aM8q3EC7mU8Ko=
X-Gm-Gg: AZFdTZd4UQll0J0cNRyKv8wODrk41nCGU3rBDIZAfNoMI3hKCRIvLL2rnoCMoV5bAVk
	XWG361+6env3WY+8TfiHLcHoZmoHRr26HCA5hvWoIHDsZqGas/iS941iQAq5WXVzoTTJKLk/Hau
	59KfWmnUGnXyufk8Y2RjC5b2N/0B0ybStmMKtDTlMXMDVZ/mG19EE0KMQ/XHjxeiIWHeTnMnavX
	+dRaEOgXBPNVev2noiHVaO8Zdx42O6dfbuSrPE9NxI8dqXsVfKkkZhBFcsBatUkhGoHTMwoZO40
	LZQfsD9xgzMU4v4rvB6Jg2GAZwiuXal9r+vpPhPMu3tAvQ2QjlIKOGda8FuGn/b4j82Js8G7YKn
	N650YRg+A4CQa0ETgvJRgog8+QWH4SC/r0YuJiPmiGcvIxDY+6CG1HKFkObgAIL8mj4JShiQ2vm
	4CmXiFUcZfasLdIPWH2yK+
X-Received: by 2002:a05:7301:6187:10b0:386:a8e0:ac22 with SMTP id 5a478bee46e88-386a8e0b29dmr2146323eec.0.1795343675351;
        Sun, 22 Nov 2026 02:34:35 -0800 (PST)
X-Received: by 2002:a05:7301:6187:10b0:386:a8e0:ac22 with SMTP id 5a478bee46e88-386a8e0b29dmr2146290eec.0.1795343674794;
        Sun, 22 Nov 2026 02:34:34 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm23747204eec.16.2026.11.22.02.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:34:34 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 02:34:20 -0800
Subject: [PATCH bluez 1/3] doc/test-runner:
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
Message-Id: <20261122-tr_arm64-v1-1-4eccf35daeca@oss.qualcomm.com>
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
In-Reply-To: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA0MSBTYWx0ZWRfX9s/7Zn0BXcyG
 vEm3lxaqfgRSgU2hzIGkIJ1WIGdWXzqcvJ/w3AUNRmGYqYZ2MZbCV9saTxT+0Y1tIyulIRXjkGl
 GVGTH4bcm3H5ewnCLPbXCUXVBppl6SVC1u//rqHySW8cB+aoqhOBkrQgNVyNQOastBWB/2A7Io6
 kKmd83sfdCEmS34goqind01Ab9Qi098n73jzLRUSvITxSktk2w8Fsd1pkYQQt3RcGA0U+qDvr8n
 9AOJU5imSUGjEZ+dgd7wy9GawSB8MZue3fyd5DYJK5p8l60tiqXe2lTVRg2FXzaNTKFcTGnS02O
 EEDssT+0usmvC0la8LcpgMSK17CaHmMK/5wqfnIInqq800HfyiNJxkPfVv28VFY9RHCEj75ku0l
 C9cwhG2F/BFiqdsLcqZvtc6HKALuVKiKblophxSzpardc+zdDCkYok11NLIUeJzuxQVIs4q9kFC
 U/1S60ITkpk0BBK0+LA==
X-Proofpoint-ORIG-GUID: oj-cVxrjdWCIW9QKK4qJ0H1nBdnS4gHs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA0MSBTYWx0ZWRfXxy1tTm6qdZzt
 NtkPu1jbpx1+Ecai4HkcG/PbckzYl434u+1AiTJduYziCwBjLjXOmeeeDG3ZTnSeH/fbzlUQWu5
 A5ssMNGXfK/U0CKgkSk+ZK6/eO3yehk=
X-Proofpoint-GUID: oj-cVxrjdWCIW9QKK4qJ0H1nBdnS4gHs
X-Authority-Analysis: v=2.4 cv=UN1Ijyfy c=1 sm=1 tr=0 ts=6b02c53c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=hm5o9tMSPX04P4WYDNwA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220041

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

