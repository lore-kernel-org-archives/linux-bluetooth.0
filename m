Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FFB3A0EB8
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307946; cv=none; b=Co3trHOrOUos3Pb3hTwsoEqHZtRSslPfqCthn9rQD6IlQ/eXtddq/0gP8FD8CZb95ct+hyPj7BubX3xGc/CH1tl2uMNekqhehR59594KOFOhjXtWjdMlRAPP8xYhSV+v9UvIOV9Vic1NjeS+gS9mK3CzMhd5thw3h6RH8jBKaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307946; c=relaxed/simple;
	bh=3qd+bUcCRmxWQ6qq6HCzanIQQEG6RlxxdSZi1YMjlBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSew7aK3D9TBqPMMt4O1X9LUUhTFs74WnMR9RXXFABg5N2M3rDcROzVj0tWM6XYHXhNB7hxWmRFyisA/YQpOtafwNDw+bXyttChBAltQ9RXVbNAstcvkVQPDoj7NYHoq6SdSE3wsPssPlrg92cJ8vS7OwIE9zL/6XAHlBwU9yew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mnu6MEUu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GfGnOd+i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mnu6MEUu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GfGnOd+i"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518dnZG4110823
	for <linux-bluetooth@vger.kernel.org>; Mon, 1 Jun 2026 09:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HrzQqPLPz1VqcZr5wP1UufzSV6HxJFnkF9CggHs5h7U=; b=mnu6MEUuU+ymQj+z
	aYoDcRsmvMGvkid9qInkqsSDE9FgEEKxvm+YxxCs1TDbOLNRFNOKT7R4J64p2AKs
	OYVIjdn+IdLprxHhpgjCH9oMvJIwDzcWrOnG7fQvHvLXYnClx4nvSwZu1XJNPbYH
	iVSTYGfXtACaYmd49+Vu3CEkHq70Fv/AB+C5eYV8NxbYp8qrgvPY0NH0QnmY9V2C
	4xqH4v5OCjOvM/1wthlu9IJsJDdDwwdqWtK1sslcGl50Cyydy0at5noLAjpTTMmt
	kGsjMkvOc79B/ZJkRm4+WzRN6QXLEQCVSI+IW984qv3Kj7QzQZacxyR9jc+V+4wA
	XQ9LFA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s3rarm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 09:58:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0bf6904a6so24110155ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307934; x=1780912734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrzQqPLPz1VqcZr5wP1UufzSV6HxJFnkF9CggHs5h7U=;
        b=GfGnOd+iHqSwZocbpRDSEyv2M0rSyvRKGYoQrpOlfi7IjTd6LdH6Q7wzrCPrWXndeC
         gwvWkt8Nj8I2fFf+6ufkaIn9PQGYx0uRUpMjUeYBQAjQzNlnzN8T48ndFyLmZNRmJCns
         HgM88AtUR+QgwoN/HsO1Ey3AsayWiErXE8O3O2duYo6jmZuA4Ucd8e0tVy2FacX3ck0E
         SVRJtHrGn0ZxQHba3GJJQiYHrzu6MeC23G+71stXGrqjAxdIBG19WiNBpvSy9UOB8F35
         adIilynTDnXQ8Dsa0ZK7hG2wEkLrd4+KJo2Z65A3mGPPSUPPJ41f46MwpZrqeINRpDva
         MSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307934; x=1780912734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrzQqPLPz1VqcZr5wP1UufzSV6HxJFnkF9CggHs5h7U=;
        b=Ay/tT4TdV6g+T/3I929Nd/T0QNWhaNG114piS+oOe1TnxawI0KB8tMrfxh6d8bX2iJ
         E8JjBV5aYF8hufx2ciyZv3wRMeSfUZOs8EDxUdVNk8OvdTUDcyUAaxjUkuUYGj2VMJTH
         6BgVd8mLPLav9CHt3YTDF7L3BtE2n5KpQr0bAYNAU16QSnoOsoLy0QnZb1OXNKioQk3a
         Ia4sWRXFADEJeQYqXtoOkXoVfk8TwO3Xkatju6l6MkkgywKuUA2Yl774ABfiaVleC/nO
         umn/nCthvtYkJN20CLBHzeQvvk/XEMYxZw/Qa3KNOaXKBOHpCGA3q+B6EBGMv6/Uou6G
         67fQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vE1nQfROGn3Ce0uG1Dibn/IkhHC25zLYxk7jPQEdiBgdxhUj+/28Tnvau0Q3KHWpExRCsMlVnt6ziq/6VLdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4smRrfWPB0I74Zy0MELGcSriuBein9nN252/0xV55nl9n3bZe
	IedXUVDB5SOMWKNRW6eB5yTRLnu5uf8fBH6LdHEMNvtQ4KdgxswnD7v7ZMJRVudfms9fA/+7nYf
	4cEGs6eQr/GqNtFHnWEohrRxgGPkChYfjUM/v5jHeDGxPMKyVQNPmRfTXx4BMVOJ7Kaq9dYQ=
X-Gm-Gg: Acq92OF0U7p64KK3tCyxLWWdYqX5XgTaHRz0K8S2iuOd90d5cWLGY33VQQNUAMrnN8J
	o0E0pvuU7CFiGArNPVUAwsMQkQ+HHUODDqOxVMC7Y9zFOpDIq4QBgG718SEgPDu/FztMF1GhGmi
	Zlc1nylMtbxVu7V1lIqowAZGCKaj6hymjAhHNndyGdmlS//OYpb8Er8JslsZpKjuJsP/cgjfn9V
	5bIhQS/wDaZbRpyMBylr0PQxqIfU8EIMGN1eeMSWrkcPbh03WmWJoQz8KgWRLeCwvHSBXN4KzpW
	pHCnR7W7Hnux+EeI1QDL6IP7qgk9orP+k9vsBnX640Jk6UHXDz8X5KZmdEWMnT0xIxnHsYgGO39
	62/uhm84crevilq+f6VutaUoIidzWd55YTX8kWMeDzM2CWEvSHLUJ89zPoo+M
X-Received: by 2002:a17:903:8d0:b0:2bd:c5f8:504f with SMTP id d9443c01a7336-2bf368d9ee5mr115095925ad.40.1780307934376;
        Mon, 01 Jun 2026 02:58:54 -0700 (PDT)
X-Received: by 2002:a17:903:8d0:b0:2bd:c5f8:504f with SMTP id d9443c01a7336-2bf368d9ee5mr115095655ad.40.1780307933972;
        Mon, 01 Jun 2026 02:58:53 -0700 (PDT)
Received: from [10.219.1.106] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd8dbsm104282145ad.21.2026.06.01.02.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 02:58:53 -0700 (PDT)
Message-ID: <0d6e3664-0293-431a-b498-17612f0dabde@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 15:28:46 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Bluetooth: qca: combine NVM and calibration data for
 QCC2072
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, rahul.samana@oss.qualcomm.com,
        harshitha.reddy@oss.qualcomm.com, dishank.garg@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260529180431.3373856-1-yepuri.siddu@oss.qualcomm.com>
 <ungiyrkfjmykhm65ttfchad7oxgx3d5mf6frj2xnq7mdudq6tw@hqwq5ms3553w>
Content-Language: en-US
From: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
In-Reply-To: <ungiyrkfjmykhm65ttfchad7oxgx3d5mf6frj2xnq7mdudq6tw@hqwq5ms3553w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AP3YypGC c=1 sm=1 tr=0 ts=6a1d57df cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=vznY6RU_P2PhIyVQoCEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OSBTYWx0ZWRfX+bKfN+GZ0rVa
 qHIXXWRZKsvrIoi2DkqqFw/Npt7Vqy3czsW/nMLaDXmvN7vnagKeL6A1vRGdGq5w3X1AW3xiVt/
 DuEmjD2xMIQbjCs8DnD7uunt8cbgCM/zIkwsaavVZxOAqKXrhE5V5lyU8xPrVJNhxmk+4+9bI+P
 SckIuT7hByiHDytyyTvvTJTJCoW6hKSi40/RLFL4a7G3buJ1ULyKUeBBpyyrvoiOpZNsOq0VSOY
 xrtcgV65044k0Zp2tQkuqeg/QqVjU6bMdUPGWPneVbF/C/h35QazVtidUzqktERuCK4lCz1RqoO
 15LbhSO5wE4/zWzjztEXjlSJejDVaDJcvOKZ5mZiMptg/8v56KYruTb0I5O0nt2T515sepwUCoI
 sRvk18EyI0/2GIQytbMQ8xXKBPKvLudquW/7xP0NOyUUHhpsFgjHhkxywqZg/DVisFobAvhRb6E
 6IFxTJ61VPlUSULHMMA==
X-Proofpoint-GUID: dhrT0cAsS-KBYgx666ZyeJDUvLlSIqGn
X-Proofpoint-ORIG-GUID: dhrT0cAsS-KBYgx666ZyeJDUvLlSIqGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010099



On 6/1/2026 3:20 PM, Dmitry Baryshkov wrote:
> On Fri, May 29, 2026 at 11:34:31PM +0530, Yepuri Siddu wrote:
>> QCC2072 requires the NVM and calibration data to be delivered to the
>> controller bundled together in an outer TLV of type 4. After loading
>> the NVM file, load the calibration file (qca/ornbcscal<ver>.bin) and
>> combine both into a single buffer with the outer TLV header before
>> passing it to qca_tlv_check_data().
>>
>> The outer TLV header encodes the combined payload length in the high
>> 24 bits and type 4 in the low 8 bits of the type_len field.
>>
>> If the calibration file is unavailable, fall back to downloading the
>> NVM alone.
>>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/btqca.c | 47 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
> 
> This is only patch 4/4. For the future submissions please make sure that
> you submit the whole set of patches as a single thread. Or, if it was
> really supposed to be a single patch, make sure that you generate your
> patches correctly. The general suggestion now is to use the b4 tool to
> maintain your patches as it significantly automates and simplifies the
> workflow.
> 
> 
Noted, will ensure all patches are submitted as a single thread in v2,
and will look into using the b4 tool to streamline the workflow.

--
Best regards,
Siddu
