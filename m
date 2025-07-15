Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47512746A;
	Tue, 15 Jul 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589644; cv=none; b=WrWOmbSvM4vRKcshvt44zznRylbh+QS7xrJOhxQ1UFHb9q8/G0S4xO5CILIYRF4+sxseUAGaNB/RkwiMsrU+ApRRDB2wMV9/UZHGyxZ42W7JzgwfPl+0jzkF1eWuwxNfzezGUI0HbE2w+v3dq5TrUgaUBVMDAoMfLYrTk8yXqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589644; c=relaxed/simple;
	bh=ABF4Se5kUB5/AFESK4h3LRLl61nsbEKMWVWCIUTaQW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=anMpTauZMkE1rT5Sd5dJdI0tzzuHFLtS5bfK10fcx+E9xSpz5zLCscVL3drIbsTZxPUWzHDPJ4T1GjB2kdjIDwiQ0BX4E2L8jXAH3ZVhA7W4kHI5QqlsufaH7nRBQVPCcmkRMSbvykgPeoTjgniK+dOak3gagJMVYtUOebVogJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=krUd8iZs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="krUd8iZs"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FAk4jg008837;
	Tue, 15 Jul 2025 14:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4WcniRTQ9IvEg3okRjavzFgKcZ/VDqwbi4Qcccj2Vtw=; b=krUd8iZstHSbxk04
	5P6vndwiPfdhamEpCmFNQn16tx2Hz22GwTghDBbOewgrO8ifaGxYrYTAaevp0K6G
	rFQUzuWYTzs7XxwfWeUhaDjsDiMgIHtLk93oBv4PpkCmEYBNhhv5gC8oVkE97MCD
	G9MO9TffnR/ZLpQiaGxb6k50+6Z6kG+Eb7GP6i8w03Y4a92KkvC5INoz/I1nTG0P
	ddPADaEWvfeEYWw+FdLamqlhKPIlAE8UYP3puFXP3ahpQktxt9P+Qf4sLtLl8fjJ
	D+jjM/G9F5o2CzsZePq9QX5cGXbLcA4ewek6toOFRNklb+hZulxLzPSiCbUqWeVl
	FgEGWw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5rp74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 14:27:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56FERBEv031353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 14:27:11 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 07:27:11 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Tue, 15 Jul 2025 07:27:08 -0700
Subject: [PATCH 2/2] Bluetooth: btusb: Add one more ID 0x28de:0x1401 for
 Qualcomm WCN6855
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250715-q_newid-v1-2-8a1120c61fc9@oss.qualcomm.com>
References: <20250715-q_newid-v1-0-8a1120c61fc9@oss.qualcomm.com>
In-Reply-To: <20250715-q_newid-v1-0-8a1120c61fc9@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zijun Hu <Zijun.Hu@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=68766540 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=3H110R4YSZwA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8
 a=RlpWWMhsgPB50yRnBgUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P5tIpehFnhDIPBsPiN3eAB1byOErwbzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMiBTYWx0ZWRfX30GIgJNWEbCB
 +SqqM5qwgjZVKnSmMi1if4U69uE7beJd5mbk1NtgcH4NezlEbcB+1Q/B7Yuuplxz98f7QrPlYHt
 xgp7iDmJ36dDoQVrtXSbomnrb4+HAcROHGoztNMnA7O9nXW5PiUB82wO11uGppNS29kH+KlN1Zd
 CddSUc3GRFllsYRe5OfYrtTrDYDgcUSY9kIocL2YRpo9THmKP6mrSyX3NGk6P/Z20sAhbTARpsO
 jHCfFDwfukRpma/D3yw/j9bMQG+3GUCgogZ/+GPGwCEiBmQlTvA43YegLQmnhjrfb05iiW1W/9R
 77aMe+eq0O8uZPKoi6apIeEDRSSagvxlFMg8Q9016GLWyHjSL1fjefXX7gdz5PZ223vbSjpBMsI
 UjmekgSB/l2YVYUjRwxaPmKt+PApoxt6KHXRKGbLncl0zU4RZmupLB2bcXpmoetrH6FlGM1k
X-Proofpoint-ORIG-GUID: P5tIpehFnhDIPBsPiN3eAB1byOErwbzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 mlxlogscore=964 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150132

From: Zijun Hu <Zijun.Hu@oss.qualcomm.com>

Add one more part with ID (0x28de, 0x1401) to usb_device_id table for
Qualcomm WCN6855, and its device info from /sys/kernel/debug/usb/devices
is shown below:

T:  Bus=03 Lev=01 Prnt=01 Port=09 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=28de ProdID=1401 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:  If#= 1 Alt= 7 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  65 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  65 Ivl=1ms

Signed-off-by: Zijun Hu <Zijun.Hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1b7458f3ad74..ed2a97b3e2bb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -368,6 +368,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9f09), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x28de, 0x1401), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* QCA WCN785x chipset */
 	{ USB_DEVICE(0x0cf3, 0xe700), .driver_info = BTUSB_QCA_WCN6855 |

-- 
2.34.1

