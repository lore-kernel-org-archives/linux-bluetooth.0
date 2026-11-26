Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795654322;
	b=NJOPWMsOYVrENCrAsZxkdLANBzkvOuf3NTPYBjMchTburinagy71ROz8Oo3Lkc0wmvMX
	 +j4IPeR4ZDAn4QowObalGO7er9PrrABkYYxkY1fU6rznmGq3hWfWBhkbFeJHZfMhP2evR
	 1NT5roKMRbDfdlGLdWFc4HjTECSbjXScp8S2jrsVKUjWp2igDAoIIm9hgf2p67YLrDZYl
	 4za9oZXBFqImduvC8hfO4KGF+oSh2d0fnFVdlXGJ/VBOQ02/737Uz4p6qFplriz8Ka367
	 zacSAFxkhjb/igervTy9kQ32zgXq9gpHUogNZPMm/jMurlCmfPXjKWS+2hdYodAK2JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654322;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=45JWSX+Fng39s3lrT3Tm1SqXfxJ/BpeCnwOcdv05O14=;
	b=ywewF9DeqGn//5n7jmNxzsj+44kNPXzMm9bfbF3sjSLVeykOLgbajG81bWF7pxMw+szx
	 wQIzqJxMh8AiDRimFi3pm02LK6Nadt5QvRi6Qkl6w59RNtjADG2xGLZ+nq8Y9Kn4qyiK+
	 Ld5NPyvcwgOre3jjwoIewoyDTVfv3C9s7T7bZEiwzhFBJ3EHH7OOOwGi5w4H0obDIWDsl
	 DtT8d+xKK3qehbsJwWDG+TOPHIrBpen9CmPTusZQEcG56/yAc5+GREEwVqaedruC5+QeI
	 rREwYEVD+D0KI9N4HQh5C7sQcyY11GeZWN0MH2fi1v6Z52fajUfkMlPHbpBILfC2Hpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BieVWqu0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fA2zNKuK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B3606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 00:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BieVWqu0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fA2zNKuK
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJB1Dc1358012
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 00:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	45JWSX+Fng39s3lrT3Tm1SqXfxJ/BpeCnwOcdv05O14=; b=BieVWqu0TohhazCL
	dZGnIy2gPy8/Y4rCfwsOljr8c3pdpnXDAR5FLzMsHvoO2U5jUgD5Y26MXWPV09b8
	xo/R5kBsDHQM1xaUNSjD0F8aisR4GhattVUhNRYNE4JnC9DGgcBMUOwRR0y+pqE1
	FXtazPIhcbU4z1RsYRgah7cRrjio1L592wYxeOJK9/C+Y9tZSFYoY3iuvELwbRxQ
	AK18N2J2tjk+8XtnKoxVwXP7tCesgnRhXFB/QgZj0Igg80f4/ms2K0PzhuultGsr
	ULUQM34AlDh3NDX8CrZSZY7XfhS/QbQTTV9HJRH/Mkv92ZGUCZx7l6vmAGArx4TU
	Ad5weQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5yaxtkby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 00:52:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b3fcce67c4so1169975a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795654320; x=1796259120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45JWSX+Fng39s3lrT3Tm1SqXfxJ/BpeCnwOcdv05O14=;
        b=fA2zNKuKDB5wMBcrJ5MQf5klFN0kkGBnM5MHGcCMI+wDL/OKSMxmhUoCt+6Ufr28rb
         8tvlBIyXVS8QXIiyGtZJKq7OluXi+TjswC1AviZDzyTpqV0xUncX4rDJ21kUoaiACieK
         bbUY86H8W6RuURfXGkbqeGZwiw20jCM75PGlWm+XfEZSCey3UBr2G9utZm5l6IyynTnU
         Co4YbcuuxSPGzY73wvIL8YOFPiVBvG1MPPtAeVrI8+hysf0OMfyy95Rmz09l5TUSXjA7
         Wz+wFYUdxiIqDeKvLwYYsoEdZ6BfyBo4WOAP1eCltbWabFesIY28TRA+GvOEeHrBMsLC
         zjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654320; x=1796259120;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45JWSX+Fng39s3lrT3Tm1SqXfxJ/BpeCnwOcdv05O14=;
        b=W/vVMdUxJVAooYLCRQ5oIlv8aYsC2k+Dj/AqfQx1EHgBUPzBmG6J+0LnqbfZ2xcMm+
         c3KNFIhSF4f4/xazmKy5ZgDVoRE3Bb7Br8r0fy3CdTyqwSCsk++d6pOU2ZQgnLimt38x
         Vi9/MbaAhPo+cqdgyEZFgz5bPAhEcrxU6qzsy+Oo2ew9cHKWE3NJXf2DxZDBSLikb0bo
         gsENpMjgfV6Hp495qfPMSkuvnLy2QxBMlZlVTt8pvFb3PJ8hoLpdKAsM31ppcmzF9jFP
         344J4APyU8qopudymq1FLzdCLOYNL1/6w7DKh0DzUdHS7Umd+o/I2/GEDJrFfAy3t2yE
         l8XQ==
X-Forwarded-Encrypted: i=1; AL+hErHkBbSqf8DKgMp9ta4QAjqYqRbJOxZAkFc4w0iGlkaowVbDyAg53weI9ZpyO1lWZyZkIWHmEFkVox8muo4zpmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fjf6Q0ea/MpOrc6WhwjpK0mn/2cHTs0Sk/pGNBEQNTnhcZjmE
	OoWiXAQ5TX/LCA1yJZK/qYOhjpZLv1W3VuNA8Inz0S7JNrPe8dE4bQ917CvCxa6JQp+BqcWDg7Z
	FTfxJdIOp0vgzFPpijBc5LbhNDdfzfhFRORf0Xv4UnBMsOusBlFwGhQdeASQ983a3As1ap0M=
X-Gm-Gg: AZFdTZdSUD6q3ZJZ6cBOp95siV32P4NG3Lt7om5WmDsyNHI/qQ/9IAx3rNddY0ofGkp
	LyCIxylmkKq0PUBp6WD/AIBvnRXgYK0r9d0dQyzCxAnL47Mg5/G9qfoRARQUYb674bTxxtxqYCD
	xT7kypg3pf/Dnl/yDBocZiFezIQit3jlfRvqmKyF0pyg00fJzxGO6ij3hfhwvNxoe8ZfXDHWn5N
	Hi/2DB/Z3WyPpFwb3CwJPEfsTfQIt6dWdcoODxas+I58cs8omMmXEzIQ5hqzLsX4vjrR81a8hla
	uxnkMve0VZbvx//mdJtIKZ1zLYq7iru5udg0ZF7RPmdgiDZk7qOOnTxDUIPPcM4ahzvDy/QT/3p
	itw88uUDIpJw0wn/D6v6TAePD1QQPN2iUtigAv+FQuAMtBm+x5RA5fsXPhzNOynoXxYhifVHQMu
	RN2ObItoGgBCoE3skUlCDShjIpi3UI4LB/pcQcbx4=
X-Received: by 2002:a17:90b:1dcd:b0:3b3:bcc2:490 with SMTP id 98e67ed59e1d1-3b41c7c77f8mr31139924a91.1.1795654320085;
        Wed, 25 Nov 2026 16:52:00 -0800 (PST)
X-Received: by 2002:a17:90b:1dcd:b0:3b3:bcc2:490 with SMTP id 98e67ed59e1d1-3b41c7c77f8mr31139888a91.1.1795654319618;
        Wed, 25 Nov 2026 16:51:59 -0800 (PST)
Received: from [10.249.21.64] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7a8c64sm13359766a91.3.2026.11.25.16.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 16:51:59 -0800 (PST)
Message-ID: <b5219ca5-a8bb-4dd3-a4b1-692ab362d400@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 08:51:55 +0800
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
Subject: Re: [REPORT] btusb: QCA9377 13d3:3503 on ROM firmware: HCI hang
 during mSBC SCO
To: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Tibor Harcsa <silurust@gmail.com>
References: <20261029013350.360574-1-yaroslav.voytovych@gmail.com>
 <bf27c4e0-31ac-4ee6-b7ba-afc6744e5c0a@oss.qualcomm.com>
 <20261124043440.1206949-1-yaroslav.voytovych@gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <20261124043440.1206949-1-yaroslav.voytovych@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nXpaHBHx5wrSAgIxo5qRKAPp-wkFKHFZ
X-Proofpoint-ORIG-GUID: nXpaHBHx5wrSAgIxo5qRKAPp-wkFKHFZ
X-Authority-Analysis: v=2.4 cv=ULpIjyfy c=1 sm=1 tr=0 ts=6b0782b0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=DAFMqZBfVSRFwNYT9vAA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwMiBTYWx0ZWRfX3gCj/EMoHxNg
 2VrwJkMweXvD1Ytmsx3licIVoNZj5I+PFwEldw+ISAwZy2fAk4Cis95sD6WU5DxqbMRS1HCftca
 pqb8uF9CRllYnjSjp87L1GodYbroKKY1+QRE1HpA6pgrYuZNHNlpkiy/gFzIn6d6XjhshvDOCGJ
 6Apl6I1XFaifpOynptHJMzfghm9SNLmMyD2W8ELLp/QSeDfDEsqxGNeh7Kr7MSdnSPG2vrzyEGH
 Ms7q8vUY3MsY9MoEk3hm9XSmvSmuQ+TW5rkD5Bt30zbsRklvC2XeGZrvKkFcSQie3RuG87gd6EJ
 slDH1ZfY9S0U2jIkmwkuOfFDkw/htYXFjGgM993mJ2sBgHDnbn1RzRxR3JT+w7GlmSWyaUXTbIY
 Vnu8RUuLVBmJfJixMe9ypSFCpJoh4pxDU6+ZHcyyBf6Ldn4NpBIVlqgwjICM3p4C8SCWdM2yJAF
 m2/3hhACUShAC//Ef0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwMiBTYWx0ZWRfX95RhZPpnzMfU
 Vd38v+WjANDvMrOCifgqBF2OZlXTJ8BE22HgWP+cmQj/Pl361mseVrz5c0gz0P+75MVfpvfNRnD
 lXJFCYWQ50eaSYNXAYXwOn6LDQMt6+k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260002

On 11/24/2026 12:33 PM, Iaroslav Voitovych wrote:
> linux-firmware lists these two files for QCA61x4 USB chips. Whether
> they are the intended files for this module is what only Qualcomm
> can tell.
> 
> Three questions, and what each answer would change:
> 
> 1. Are the Rome 3.2 rampatch and NVM the intended files for the
>    Bluetooth controller of a QCA9377 module that reports ROM 0x302?
>    btusb has BTUSB_QCA_ROME for three IDs whose commits name QCA9377:
>    04ca:3015 (0a03f98b98c2), 0cf3:e500 (0324d19cb998) and 13d3:3503;
>    I have measured only the last. If yes, that would support using
>    the same setup for other matching IDs. If no, what should
>    13d3:3503 load instead?
> 

no, let me try to up-stream QCA9377 BTUSB firmware, you may override
the one loaded currently by QCA9377 as WAR
we will think about how to support it.

> 2. Is there a list of the USB IDs that need this setup, or a reliable
>    way to recognise them? This year, 13d3:3503, 0b05:1868 and
>    0b05:1825 were each added after a user reported BLE-scan errors.
>    A list would help add missing entries before users hit failures.
> 
> 3. Is this loss of HCI responses after mSBC link-up a known issue of
>    ROM 0x302 build 0x111? If so, is there an erratum, an affected ROM
>    range, or a rampatch or NVM revision known to address it? That
>    would help determine whether other modules with this ROM need the
>    same firmwar

