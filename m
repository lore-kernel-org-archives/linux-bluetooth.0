Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC3492E2F
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983232; cv=none; b=NZ8C6hrnqIT3Su9SxQAE8x5/M+Ye7Z7GQXMHiefb546LeQHvitHEQXWVKIv34ZJXr6+McyvIPEB0CVZjzsVEOYIbA8PVOUiF4MQjQUSX+GKJKTJRWdyGynfGFGgn1fumBguKSDe6Fu+fwc5HtQ6iE9QBN/rk6LP6+0ikxE4Wcts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983232; c=relaxed/simple;
	bh=bxGi3O7g0n4gi408RRPokrlqezhGm8IEGKb+goXMloE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOcVSXW/ILHCYKT7cZzEdkOg44fZdur3zMjuzWzal+TV4cFGj2zV2xx0K3obKgGzEnaSGG7auW+YC7tkfT8Vh6IUDiizIfHr6HrDGK6Ugy/JN4+XoMgvxc4h1GgKdSZqup6Nbt4R1fifSIx/6GPcz7X4KswKjSN9jIcOg4TIEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OreewTWu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B5JHMM9A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OreewTWu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B5JHMM9A"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L84TLA4135090
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 09:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1aTWT1xLatBKrObX/CyhxZ94bvJdVzT+iByE8YXSyq0=; b=OreewTWuXTwsAWNF
	nHGPADDjGpeEGMeZbRGRx0iJW2/OW72/opmE/w5M3l8ppSdw3JSNvmc4N+8yclAC
	ZCllJjaFisct61LwFdTpMCV2xSvOTudC4Lh0PXU5ZZdevrLs5NVnE8qYJuHOXXV8
	pF7FdIb/fU4T58x6G2MEpLczjHx+l33WhTcKxGBRzWKn8i57gW2jG8JzDwMDVs78
	pqI7G+X2cYANEvtpAx/YN1vee1nW/kAnLmccRPNJ1wvsNslKz1zLScgNDVPtoIBo
	4p+QC/Nt2jK70KVjXB90cDovdUcEALEG+dbLwD0qQYMdISKPoTRsw2yK40/p8RpC
	RCGhwQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj0cre-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 09:33:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93bf4c0af4eso290877385a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789983228; x=1790588028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1aTWT1xLatBKrObX/CyhxZ94bvJdVzT+iByE8YXSyq0=;
        b=B5JHMM9AvlWHB4ArDNPupTkVhMkFGGMLf5n5xIZnYP2YLQkG4RM5cSpyMhJbLmeGfT
         cLOsaKRFHjf4/Kmw/j/o0USNGitozNW4efYA8wNj7/Y+ExiXr6MWvduAgvH9e1XXki3h
         S2oy9RKrusC9CsxBCBYxgX7VIiLCwHVc01dKov7XrrQeEfJ299fDLl19I7sBiF+NWprl
         Fn/sCjBrmxGCEf6OXgfGj0F4EAJbP/SmDE5z+8jzoVxn1214p06JF49VJWwa6MNa5fZB
         4HSKxLO/Z0Ad45U26oFVpB2WaRqMaXhAKkR61ShWfATXrEKeT1X8UHrSSKxmhOK6I/wW
         FRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983228; x=1790588028;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1aTWT1xLatBKrObX/CyhxZ94bvJdVzT+iByE8YXSyq0=;
        b=a30kpoT1xBOmGyVbcRmjNz3tGQprWY+aCgYezHGC0gzhgZXw2UFYNvJyhJb8tRgnoD
         RNq/+OktJ+RDftNaAz/SO633rODLfDzVrrRqDIDZZHTRB1ng8TNCeiV/3qOqxmdvJJgX
         X/kTzgYdLsLbGFLuO2IUFcwai24+s230lPLS/M32yNicJy09Lh2gaYAk/IuAwyOYbr9C
         bb18IpzU4K2cM2f8NZsbrjXfaK9fGHo1P0mAXlSmMWWVnVJSVQZdqfHVsD1bLWG2ClJE
         ZhTttsEhAUPdA+2LceZsseimloffgKxTuH8CpiK6mH4DMe0uSMLPW6kbivJoK5vSv3Tm
         wIEA==
X-Forwarded-Encrypted: i=1; AKwUvBzgKW0RsmJp5ZYSqVOS9yrz8HPDmjmAWWUNajHbxLxdcMp8tEQOC743WvCG/aSr0D+v4z6raS/WImrPpZL6Kvo=@vger.kernel.org
X-Gm-Message-State: AFuF++nZExY7sTDkTreucUimZwGzPaikitE224r6gR5BrGD6IQTXxj2K
	sCH4ZVhVeYTqH73HCkw5iDsEgH5wd/Elypgolx6qrMvuO1eQCpQj3GHR1h0avLCshcYdkS48eya
	eRwcbhp6ZeUsZ9qWfjlmZdugHjl3gFZuGcKgughpGcMKrdg984UZ1XNIZWrcEvEHMfVUtMkM=
X-Gm-Gg: AYBFou13D9gEpJxZfbxqY6Y7buhAQARB/B4zfnoqgGddXvSvKp3P/2jBiTHyrU8xDQQ
	LLvE1CTqkTK3IkXJ8lysG3/q6vaRJn4GwfEl2tQ+iNHZDXRM41mGZWN4BIDp0oiBiksqob5z/Lb
	mAI8KnDYWyUp2DvDXSXWslIPncfNm3mCw1V0MFL9KD1G9aOW1ziHmY6IAylHo5myh5w0XI2Vlde
	GKsYQrRW0lzqa7T0i16yOYHiDmgfjCRthJoV+pCMe6j20O+doEAZ0DaTK/8cMzuM/cDgDbWEDUl
	GO4Hodmfyq7ZsbID5aqnwjGn64v0FSuo/IAiOLdT8lRYLtYWlmL3M8QSFt6efAKI4vRRqw0uXmJ
	fyszT/WNDdMpjA2+4C9WjTedlew==
X-Received: by 2002:a05:620a:2809:b0:939:b053:ce44 with SMTP id af79cd13be357-93bf56e71e9mr930990185a.22.1789983228345;
        Mon, 21 Sep 2026 02:33:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2809:b0:939:b053:ce44 with SMTP id af79cd13be357-93bf56e71e9mr930987285a.22.1789983227911;
        Mon, 21 Sep 2026 02:33:47 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcc1160a1sm173074265e9.4.2026.09.21.02.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:33:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v6 00/11] arm64: dts: monaco-arduino-monza: Add support for LGA WiFi/BT module
Date: Mon, 21 Sep 2026 11:33:44 +0200
Message-ID: <178998309639.45264.5601605234359872731.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfXyPj3LVg2nDCy
 Pc6Rmp59WN9s9mtnX9F3Y5Bab6Vq1FKG7nvbKn2j9wVX11hiNoIo8HjTvuNhoLg+SzbXPamFiFZ
 kK3CvTzTxwAVkgtfGY8U+OOym9wT2eI=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab0f9fc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tpGDb1b0ex05cYe8L-UA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 9i9cRCjIGQGeo0jOx_XDH43L1C27ficF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX5jOJCTmxJWYg
 YtRzorJ2roJZZYn5L4K6lt/K6DSrZBNlM0z0ylpqUoixJsz7rMQTakgmtLZyEmVK+MnA6NPAn5S
 8i55HvMBfiXofSlQ7fUC/lbZXWarZNTRf+8Lf7Ih7Ssye/cSIiUHAieMYw+eD4Eo8zC90626Zf8
 KjMSY8fMpEOsVX0iFPh2rdEUzA1eGuYUM9VEy8GYWPtRddCIXxmtIdG/95MJ42ZKpszX1IWD75W
 FF/9Kl+eDtoFF5Fh52zt5GXyWrf8AN0M7ZWBo2G4wpksOXAbtph9yVHZze4/fyfwZ2AVOlpvi/X
 rYMasSMZCAN0FonN7aO7hohIcHyqtCbqtTOTPrZ0z9KEytC2imsWa67O3gx8tNqxg6U0dvYm5+E
 EraL6H5Kv8odxUQzxi/3mWrLXUjYZwYKmfFUtshdzPzmuJN+ThpFqfXFN8Kg+zIWntkzbfyLTvn
 0kzw2rI++7kfGyHmJcg==
X-Proofpoint-ORIG-GUID: 9i9cRCjIGQGeo0jOx_XDH43L1C27ficF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210136


On Fri, 04 Sep 2026 17:42:15 +0200, Loic Poulain wrote:
> This series describes support for the onboard WiFi/Bluetooth module
> present on the Arduino VENTUNO Q (monaco) platform.
> 
> The board provides LGA pads for a wireless module. On the VENTUNO Q
> these pads are populated with an NFA725B module featuring the
> QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> the design is functionally compatible with the M.2 Key E.
> 
> [...]

Applied, thanks!

[03/11] power: sequencing: Add pwrseq_is_controllable() API
        https://git.kernel.org/brgl/c/bf544a7a60e9eb45f3e22bd1a5184ccc16d75cc8
[04/11] power: sequencing: pcie-m2: Report power controllability
        https://git.kernel.org/brgl/c/48925a1d5e569735031bcc2f2c19e6ce7a38e424
[05/11] power: sequencing: qcom-wcn: Report power controllability
        https://git.kernel.org/brgl/c/295eeaf2c6543f746c1c7d9871f6d2f71a7ed4cc

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
