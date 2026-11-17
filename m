Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916434;
	b=AqsWiBLcmvIm2vrWNaMSB1x0w6glUp7oeAZdD+aCHOLDc+ymBkWs39QgKeEDSxeyfrKA
	 rp8l9vPs2CyDinYYaRaXOodYMGT+E1rEA+mVOPP8LiAf5RQ9niQ7GxJizcxomJk/AZHRz
	 Fvdt0FMJo3+wPbLLPz6bIzuAOIvZvXHbFccyf+txXG25y39uPM/5hc3pZKUsDgjckOWBn
	 4GS/zngqINv/UV6JWnWHTUpjdLGDb13RunljBlmwbUd7bT3CR2Y7jNtVUdItA8Xy8RlGb
	 rkP/F/IOmSLzSrSR/pAVKHGjpC33dcI+uV+oFQsKwZSbCgYh0Hv0aq5z/UaLm/MDqjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916434;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pyoaGYc/zLCBBYK4DvCqybaWB6ovkeca0je9ybglS6k=;
	b=JrhI3gVP1hwTJzKVuodlChnMQnxNc6Drujw8ku4AUjMqX1aP9CPtiMcHIYARy7t7RwJY
	 xQKXZW4QNA/XuX2S1yFm6am1+Yq2aIdCRdzK76ES5NFvTAdIoy18bBTRpX8uOU2UaMkZd
	 j73i3u8nUGOmZmWB0kJWbjLSq8ksWc7untOiVNhEjxsz+zru84snvEWmRh1QVcBs82d6g
	 gUXXUt02Qp6+Qk1OvxRgeS9PVkRhtqaDrZBUk6L1FhvHyBWup1gMEbBZJK9DzKyWE9nSB
	 Ttcy9DqNIb04D6p07NosymEz+pfVDCyZmDKXh18LAg9ivzK/qGkm2x+FG6UZz984PzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="W9Lzz9f/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SPw6eSga;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFFB606A893
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 11:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADFFB606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W9Lzz9f/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SPw6eSga
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH9qT7E1699694
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 11:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pyoaGYc/zLCBBYK4DvCqyb
	aWB6ovkeca0je9ybglS6k=; b=W9Lzz9f/pFTNtG8bvq+RuLZuFWqWMxp5Ow+tf/
	j1STzWYzIrItziv4ZK8cJYz86KYDyKU/L2vQCYHhK/izFtK2U75wA49OnfroZmq9
	gdD0Lbl+Xo9idDmssrr+zHaFWOY7FOXWVknRuDgebA2nr+g3IiP32IMcChtCL6QE
	XPX6vNCp4eRw2R53TSIVqERwpTzwd1BZULDccqak6KfTU6Rr4yNQ1pgXrLkKowER
	pljvE1UgTWFC4DoY8lPnB58oqdP3LSy49+oqxPfX6MNur3YGyBUhGBoVbkJiMUgS
	NV2Wka70Tn1WFU1sAubaLC5DBUG5RXjn0vgApxZ2vw1NVjqg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0fjuhqf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 11:53:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b18b69a018so1396917a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 03:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794916430; x=1795521230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pyoaGYc/zLCBBYK4DvCqybaWB6ovkeca0je9ybglS6k=;
        b=SPw6eSgaid3xuSVAKOWoVolFzMf0tTKO3hdrrtiS/nRKqHPLLmt04j2JKElkXlrymg
         ZtS4Ajrth5O7C2qQIxtxTaZPIBzLZGLV5wWGOjGRiqKsz3NmOvZRw0eEcsmnkFTWIXVG
         6pAgmSCc/cF8jZsWJGuX1Y0teuQPpI+epw2NIT/CzieSfR2kWIizLofONhr7wyF3StcR
         hfFV35/Gzw/+x2CeqvPIL10HYj5D1dTvQQabfBwtFjwse8JhMYcxz/N/oijBqWb3FSKw
         4+/caWabNRZc1biUYK4XRcLVHrgvoZYLRSKNbIjwlu1N/yWnQIvPVoUpGERAMkhE6hMX
         UrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794916430; x=1795521230;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pyoaGYc/zLCBBYK4DvCqybaWB6ovkeca0je9ybglS6k=;
        b=Q5ITtPhSgVYe2DFucV95vzRPzzd22pLjWIlJdmrYbkl3+1KXUchClryjyO5tQsxXt6
         yQRxp+KB63edz06gx0oHAFNGlGCMqNLMx1j74SbgloglBhFO+FT9W2X9Mni0A1UmoVIL
         kr2YTFWeVFRzOa0y5jiFlN2yA31TwwAKl8hmTvxdL2nk+AEFPtnMblgl4W2fLuArfiRj
         Xyww0IO59ocT3jCCBU+zXwhK0zEiFJpYqTLehrrWe/6yDn/nCYl+zZqifFa1bT/HcN0+
         YgtiybukgSzowilT3LSmF9dUvQsW9O4CP1AVT8V9xvMaWD0jJTKiT6OAfk/ejeP7L9og
         fuQA==
X-Forwarded-Encrypted: i=1; AL+hErEnKYZ7vRInKVPiF9VtGhc3AYh6SvdfKRBNnBYVUz0Mo0xwbR6mIwol8FzhrNBGfFJ29bvCGxGrLQzcQgWF+2E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LFnM9J95h+bDhLQprG32LhNv8vF8nYStTqrKMktGSG6do2G0P
	pOaiP+7gr87vHtxomiAPiEOve7VjtVn8bzDvtrvBdBOBrw5oi26t7lOoiL7Dp3U+FLZR/hjz6v7
	wL5jsfYgrkzO7DLs6zORsUzlBRhPpyJno68MkJ6iVAvucj/t/SHYEQ3UYkz4eyp5WVLOLwBQ=
X-Gm-Gg: AZFdTZcK3rzvl2igfo3MxWLsFcQEOTdkoLJ7BYIRgg20pNU2UKAzHX+GzYYG92azb2/
	yqbwd4FE9/Si7QXi4sxWONU81zMrfh2oXpkhGEhijWz/uvl+/Sb4r5Z8sxDXwLRtuv3Iet9EP+1
	1IMvybqCD1f8woEbmD6Ke2JvyGjEG3s9U1nqfb9nMLOK+6ytmWy05LOJcBbqsCtNOMefcGLPRM3
	dOsh6iEPg/s4DVkAFASg+chNUDps9q6MWls4zaE65h7WcnFpvy0n0GtntT28efji9lJsmcB48gp
	/Wx5XJie1aRlKlJXNSvvKY5zK+b/+BwnLBv/AI5AkmrqbJmv+geXrzBgREp9ntkE4Q9f40HZE+3
	W/o3P//37A3ruVjP/Q9esr/TkOE2gX9cNJHwzbNEKUjCt3MwFtuQsqK0pdE8Qpw/IcTSFG9Uwjf
	LAfsgx2ncO58ftez+EA2cCESack+39cnrAt3H6RfWL
X-Received: by 2002:a17:90b:5844:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3b1b081cd6amr22487492a91.1.1794916430438;
        Tue, 17 Nov 2026 03:53:50 -0800 (PST)
X-Received: by 2002:a17:90b:5844:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3b1b081cd6amr22487466a91.1.1794916429886;
        Tue, 17 Nov 2026 03:53:49 -0800 (PST)
Received: from [10.249.21.135] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3f09b92sm10350568a91.4.2026.11.17.03.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 03:53:49 -0800 (PST)
Message-ID: <680aeb35-74d2-478a-a1da-4d70983b7431@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 19:53:46 +0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-firmware@kernel.org
Cc: Josh Boyer <jwboyer@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Zijun Hu <zijun_hu@icloud.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [GIT PULL v2] Bluetooth: btusb: Update Qualcomm QCC2072 and WCN685x
 2.0 firmware
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA0NyBTYWx0ZWRfX0XJef0hQANU4
 XTpuXTYxRwC1ov9YVkr/JyQraF9phmBteJzxnWSu4AcvZoH2PYK4CqaOK0G2z42zeOEPG52w9tu
 fv8d8Lr6jSXRdiNU+t4JWvPBpVKWvlUhOg9ZBZXw9VNYqFJD+vXgssaRzqGI69PjJRM4L8ogkRu
 moH57CKDvRLPdRoWVh2gy4pJNHj7O9h0ejSxwp8i8Vsp4A1vTBDz07Fh8WF7ZKmmJlOVYPwQ0NP
 EFR5Of/z230RvJXOMhC1C4mE5ceqJxQe0ZDJyCnujmC6Fw0/xpWL/vUBjdc6UcHmB6COYFAYW67
 Yb2vJsr5HNQKbWela9Gs1ZE7rhAzNcWFE5hfS/9O1WbZRcPUrwzX+/5/aWo+H6oUY6yfNWW/7Oz
 GP8moSunDorBGMcJu6l0c7f2hFtmFGXEslXo6g2m1QcHMGUIMQdI+juj0fs7u0HoFoeydB9PwH+
 ukbGR37BnUgIey2De7w==
X-Authority-Analysis: v=2.4 cv=JfIpPkKV c=1 sm=1 tr=0 ts=6afc404f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=Xd4WSqPWVs26j84-qGcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: UwtpH6EnzuRWAkmwmQ8M_-8qYc_EMsMg
X-Proofpoint-GUID: UwtpH6EnzuRWAkmwmQ8M_-8qYc_EMsMg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA0NyBTYWx0ZWRfX6OIEb3vefhok
 hGZymfpa810fKHSxPg/efQDVQb/ng+knAgmJuVzKwchqhkNrFe2/jsU1CjZ8QRDlD9aIWYhqeej
 gUFvVxqKcQvW3MiPFkivE72PUHu79ic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170047

Hi linux-firmware maintainers,

This is v2 of the pull request for Qualcomm USB Bluetooth firmware
updates for QCC2072 and WCN685x 2.0.

Changes since v1:
  - QCC2072 BT: keep the ORNE.1.1.0.c1 line and update to
    ORNE.1.1.0.c1-00038, instead of switching to ORNE.1.1.0-00391.
  - Pull from the new repository https://github.com/zijuhu/qcom_btfw.
    Please ignore v1.

QCC2072:
  PERI: COLOGNE.1.0.0-00054-PATCHZ-1 -> COLOGNE.1.0.0-00054-PATCH-1
  BT:   ORNE.1.1.0.c1-00037-PATCHZ-1 -> ORNE.1.1.0.c1-00038-PATCH-1

WCN685x 2.0:
  BT:   HSP.2.0.0-00609-USB_PATCHZ-1 -> HSP.2.0.0-00634-USB_PATCHZ-2

Thanks,
Zijun

The following changes since commit a5640716a85e8233275cda67e032b9b9d9631262:

  Merge branch 'amd-staging' into 'main' (2026-11-17 06:21:18 +0000)

are available in the Git repository at:

  https://github.com/zijuhu/qcom_btfw btusb_2072_685x_v2

for you to fetch changes up to 13e50e36fe79f7a955d92d48cb3fee388b825141:

  Bluetooth: btusb: Update Qualcomm WCN685x 2.0 firmware to 2.0.0-00634 (2026-11-17 03:28:05 -0800)

----------------------------------------------------------------
Zijun Hu (2):
      Bluetooth: btusb: Update Qualcomm QCC2072 firmware to ORNE.1.1.0.c1-00038
      Bluetooth: btusb: Update Qualcomm WCN685x 2.0 firmware to 2.0.0-00634

 WHENCE                                 |   6 +++---
 qca/QCC2072/nvm_usb_00200101.bin       | Bin 11006 -> 11006 bytes
 qca/QCC2072/nvm_usb_00200101_0021.bin  | Bin 11006 -> 11006 bytes
 qca/QCC2072/nvm_usb_00200101_0022.bin  | Bin 10990 -> 10990 bytes
 qca/QCC2072/perinvm_usb_00220100.bin   | Bin 498 -> 498 bytes
 qca/QCC2072/peripatch_usb_00220100.bin | Bin 7772 -> 7772 bytes
 qca/QCC2072/rampatch_usb_00200101.bin  | Bin 247475 -> 248003 bytes
 qca/nvm_usb_00130200.bin               | Bin 6332 -> 6352 bytes
 qca/nvm_usb_00130200_0104.bin          | Bin 6316 -> 6336 bytes
 qca/nvm_usb_00130200_0107.bin          | Bin 6400 -> 6420 bytes
 qca/rampatch_usb_00130200.bin          | Bin 197448 -> 188568 bytes
 11 files changed, 3 insertions(+), 3 deletions(-)

