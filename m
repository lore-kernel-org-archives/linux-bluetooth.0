Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343677;
	b=CQgCmrMW1bRpPGJVEVde1nnC1p5R2P70aYDL7GUCYZcQCE0dVvEoxwK1HFTv0autIsRq
	 ViObYW2EchdsHqxkXFHxPOQdo+k9YIvwzEbdDUPg3kv3ac6qgkD8vjDKKdJxLP9uNMxZV
	 QdWNrqC46YzwX5YuYvV5wXQEnGE4MSoUfufj+/gc9pV1yRSC3O2f0fOVlSZKE6Kc5HA/h
	 9Hqt644QmyEQkayKj9e1QCTDdmnOYBDx8AQTtx6P+YmD8VYSHzdbL6pGwaGjXSoOlnhoa
	 5IFd77J6xXS1wvI+49UMCgNpGj/SPeselfMJWkPDr20poIAo3GF5Sny0OdG53vTVN+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fawW/RJ6p9WkDBO+22LM1YMSV+SsnB2qMUvTSZEmopY=;
	b=g9YJ2lFX+qNeKDCxb0DN80e7hJ+oEEb3rI73RBA6NpeMfUW9lzDO4Ke3rmnjwMOrkFq/
	 AohYNlSelSrosoLf6nM4q4Et0+zKS7de7dX0gW6qfdEggB/AOkQAUFccOtctjBNecmwGh
	 ipFrStF1RRpOHuEV4W/zFCGZvVlOBXfpuWubjWr98P6Fjv273DlrosRRzedfuDagBmrXO
	 RbMu/1IxX7QRPp2vLxjzioXPTi+/eX9Hj/6V52pO229fkHCHKJTDRqk86Njv/FQ8gNqo8
	 8q23Gy8pHTE8EWU/AiicgNMWABAb4h3aT06GipCUNj+Q7wlypURlBFmX+2GeD6PG6aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bo9aTVxb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LS2AcO2v;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EAA606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8EAA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bo9aTVxb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LS2AcO2v
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM877Ip365347
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fawW/RJ6p9WkDBO+22LM1Y
	MSV+SsnB2qMUvTSZEmopY=; b=bo9aTVxbpfuk945KrPY0XTihGHb46h78T+vviN
	/gwQyxw1gwhErw+WZfryDXoVgENPfNI7+0zjBK/Q2oPkd8yULnR3uLbHu3mYW9QY
	sHe4spT1XyhNxjysCcAdSu7LSGvW1LI7iB/5Sweb4zsMV9rLUHDZ3H7yqrowHzBQ
	q0cSAaoBECa3m53mQvTct6VksVYO2IxfDOkjFhaI/MR3J8UbrtxZxcrfqR+1Xmmq
	vmmi3s197/Ins33fsrabERihw5PhhWW+ohVYuldg5OhCmCCNt7f37QJRFLG8Qqua
	OFHDfNDVP5c7HcYeCJ6cqsJsn7aoKW0fNaorIZSb5PVkGgJQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32w037d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:35 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386a603517dso41687eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795343675; x=1795948475; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fawW/RJ6p9WkDBO+22LM1YMSV+SsnB2qMUvTSZEmopY=;
        b=LS2AcO2vdhW7siT+x9LO9O6NZ58wedfOAZuxlnqMmGuZSCO49S9vIsJpBAEGv2oHc2
         ZqUjf72efWD38VLFGofsCeGwihZW8+yipH9nfEVilv6Yp5Ne2dTnpdW27GGNz2pZSRAW
         5f5Jrm2SjKXQdVDNJ4RTxb/XP9O5G6tI5Ngp+sXBvIyebIf7j4r2FxxZB5Q4dYB6yu0D
         Tcqwtomsif+bWC7ks37GayzbrfjvSwSRa4DDOLl+O7tBBADAo9t8uQ/NSYbPQeNxIRz1
         4M2Dk5U2jpBJfaC3GCIREQjd8wDeOn/FEtMZKVin00j/ibWw30I6F7fsWnUCP+C7Giat
         jdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343675; x=1795948475;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fawW/RJ6p9WkDBO+22LM1YMSV+SsnB2qMUvTSZEmopY=;
        b=YAC1GA89T4qANF7t61bHZuAt/3tIuLs1NrvqWeaPF4/iwEe8EGvmCwI2emJXH+xqow
         CLdNlpn2DEYfsfwVki0B6P6b9pU1aHA/gXM/WoUG2PGFdFvt676q8Zor0/VrWQbcw80+
         9mahC4oBmdKlPtZTSMhWHI4i2z2fTDnMrLz8vxZFHhkl+ORwXWS+zmMcqQfo+d1W0Ekr
         Rh+if6Zl6QLnYktFAyuhaDw82OjL3UITS6q2XAgNk/cGOaVFQVolLdWBoam8TTouQRB2
         8kRfVxtrPAdH8JXDgp8DFm87kVuudIwJEUA64JjO1tGXUFg35+gnrumm4oPx97wa7+H7
         +11g==
X-Gm-Message-State: APuU4Z9xrwuRfDN2LxzO/dMQyLFnLJ2EVy8idritr49fgYlhTQLmPU0U
	L77BBMqu2IseNblqj54Q48hwse9fpE/6xRCS+q0TDGfnz0njNrGIgWY1i2E8PZlPN6MJyyZhGX+
	+Mm21s4yuz5sANExlg9yaCLJjUIJcmLo7K5ahg+d93682EOvvF/XGGe53yxN/6fSHWj2uXjT04G
	IQEhg=
X-Gm-Gg: AZFdTZfSRqNRtrNBzqftNEd0liidlHBU17UB0OFWmnL3wmv6i0vbJnGyObRc/X2rw4T
	YBViuNaNaZshAWSRdweYR/0mdbzpuBuuvuNQC+JZTp2gwSUQtb5FTimnsK1Tpq8AHdCex5NDWpX
	JYfx5tlhMFuExbkK7X4kWqnJnV2Mp6Uv5YciRFZV3BSlf3pGn73oqUIiXYMmSZaoiGMALVrZttp
	7bqYHU12xnaLz2L6I57yeFv1NOZJCjpzT2fwYGfs40IT8zmWKjfK2tkjcoZtnNw+4oUKKq5soEl
	j7veAgl8BMBl9Sexh4MaGje3DL0z4jVmgb+ukWDzeItSbz6smo7phWY2DAdnXEbv+4pPneS3hjW
	YhiAvKlGb0ye8gFWZZrtdiHg17brGgDL1P/iFZu6IouvX/1fPabRbeD6vMWK34udZLJjuBR/cAj
	u2hVcNNI1qzKTrBUc1DjkL
X-Received: by 2002:a05:7300:caa:b0:385:4627:bd5e with SMTP id 5a478bee46e88-3856ec46bccmr17816154eec.2.1795343674471;
        Sun, 22 Nov 2026 02:34:34 -0800 (PST)
X-Received: by 2002:a05:7300:caa:b0:385:4627:bd5e with SMTP id 5a478bee46e88-3856ec46bccmr17816125eec.2.1795343673962;
        Sun, 22 Nov 2026 02:34:33 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm23747204eec.16.2026.11.22.02.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:34:33 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH bluez 0/3] tools/test-runner: Add arm64 host support
Date: Sun, 22 Nov 2026 02:34:19 -0800
Message-Id: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIACvFAmsC/yWM4QqCQBAGX0W+3x24S57gq0TEea25UhZ7GpH47
 p32c4ZhFiQxlYSmWGDy1qTPMQMdCsQ+jDdxes0MLtkTMbvJLsEe/uiirysKVexKJuT8ZdLpZ1+
 d0N5n+eL812luB4nTtsG6/gDzft13cwAAAA==
X-Change-ID: 20261122-tr_arm64-c6751a5cf021
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA0MSBTYWx0ZWRfX39wE/LkGwg9i
 zydYR1ZERGAIt7x5yW1KgBhctd24ZUU/rR+qoQjjxjVIMmgqDgTtrx5ugLT7yeK2+NXNP/nJK/r
 43R43x5hNlyXElGV5tBivmzStOl9QHAgbY9Bc1mLO+P/9X0c89qmjLjuA9ye+63fwJLYS7PIPR/
 fymmGxoMVi8iedjt0DjsINZZgPepsyVp8nMbI8UN5hOTCtnginGUWj5wdXOTIWFx1Ol6zYKSokM
 Eq40PD57yp8wCMENpQECI3ZRgfsA9t6cWCBd5BoSj9nJJaKewwvkLCoTtFm+Ey4+WT4QKgMLWO7
 DhXrXXFIE4vQA44pfNrUHvKlSwRZLJjX6hdKkgFwE9CKhCbTh+pekZQkBJasW73dryi24TdYK4T
 ED/Fr7q/pUSInt8hNSApGUG0WQvTZ0bs2ft6UaAg11a5Aqb1C6Dl+OOkkIgTDXIDT8T0ZN+FcDh
 xPUQe62CuUnOY/GWDxA==
X-Proofpoint-ORIG-GUID: OhcRgnEWtxals9e8-7R433FmKsJWQqUu
X-Proofpoint-GUID: OhcRgnEWtxals9e8-7R433FmKsJWQqUu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA0MSBTYWx0ZWRfX58hPQZ0xbv5U
 7p9oTWoaHozsksGczwZHs/WfjEGEBSjxmSwgARSeToTj111WII1RPQg99KrHKzuVMVIiRTFU6Pe
 Sdz93d29uzosG212F35OjPIupNYx8Hk=
X-Authority-Analysis: v=2.4 cv=S+dMU4sP c=1 sm=1 tr=0 ts=6b02c53b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=o5ry4vc4ejVyEOvdZuMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220041

This series mainly:
- Adds support for running test-runner on arm64 hosts
- Allows starting bluetoothd without debug output

---
Zijun Hu (3):
      doc/test-runner: s/CONFIG_BT_HCIBTINTEL_PCIE/CONFIG_BT_INTEL_PCIE/
      tools/test-runner: Support running on arm64 hosts
      tools/test-runner: Allow suppressing noisy bluetoothd debug output

 doc/test-runner.rst |  26 ++++++++++--
 tools/test-runner.c | 114 +++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 112 insertions(+), 28 deletions(-)
---
base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
change-id: 20261122-tr_arm64-c6751a5cf021

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

