Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39D21C194
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941232; cv=none; b=SOZApkArsD4uYZTUXaoA0fuHpZl4t/PohpdJqOjwiXvzvY6cK+d/roUERLcmPr5LbqC4l9o2X7ESV8jbQhdQiirx+ITLuWSNW+gc2IOl04I89UKNi8YDWU571NDik1T1L0+PVCLPLTW1+kAp1t4SEJ8Zsc/UWiwtHRgYg0F55to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941232; c=relaxed/simple;
	bh=TgvD0GubU8kF5Dfy3yLeHAPf74ErAVmKpBp9wpxBJv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ozu8hQW330gA4lSzRI5iPaWdFQBiNVJHaL8xS/oTZ4YXbqZ7jgVzWFdnMtT1Pwml+s0h0rqcvCMs/xWlXCDWcNdxy2dKflovKD1jKl2b1qbHBSMqX2hYHywKlOYYTrYk4MuutNaiRoxdUBIbE6HcMsfYOELM55idxWC3b3nbHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RPC0Lukz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cEyYM2Fr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RPC0Lukz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cEyYM2Fr"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9X9l91001869
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 09:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/KzO6isyjPn2hyAKKNSXVgFgpCnyrIGaSRJ+1HYcQtk=; b=RPC0Lukz8Vjp4c5b
	YZxpkhFV9UNCzerc/gqcKh3Blepepc14LZGA3v8ZVzUWggPa2MFnPF2q+jsP5BB0
	VOUfKD+HKGtyedbtiMZQtalRJuBgrO0tBulbx7inwN2FhyybZjqISnoy2WAFn8rC
	ijFSrPM/VGCtfIKUUW6isAfKeQCAarZ4+m0BuWHq/S+ShuAT2MEJTVcL/fGbMSqH
	yt3ibZh6QREEFtw7uDaF48gkqhWeZ1SxfzY1tS3TWFgvl5Gi1F6uaIU1kKbUPlQB
	ljv9pfKpS800leAC7SQDKrVAmc45cVmfkFUOHD8qUddOKlOIXIIM/0G8pf0/z/cP
	VsRsgA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqq20515-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 09:53:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6a906c52so1603301cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 01:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762941229; x=1763546029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KzO6isyjPn2hyAKKNSXVgFgpCnyrIGaSRJ+1HYcQtk=;
        b=cEyYM2FrOQLdhfyAYpU+jh7lyIP4FVOMvw1AejNwyowukFQcS2/QR4v0mFBKj3OvbA
         55kHFbPIY/lYKUKm0Itx/ht5wSt6uwlRsBDZLl6kz+Lw5ghM4DaetPYAYUzNG7EecG9H
         PldpHmwAxFzfA8A9h9m1tWuub3dEtpABJdwU9pEeoT72ik8+TsdFmxTuTW1yoNFtTr3w
         drEQDHaumQ3gmq/C7BR4gsvNWHxhOLaP2LA2wua1IBp/4BNlUANsSv+f8mAEDjWcNQTc
         +4FC6GQNqxiE+haxv+XAWEtIVHXxGmeFOdFXieO83mo4kWYpsWC+oEHUygUBty3s+zsk
         rBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762941229; x=1763546029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KzO6isyjPn2hyAKKNSXVgFgpCnyrIGaSRJ+1HYcQtk=;
        b=IpyY6eB6AFhmKMz3oBQLGEy1/qW7OHA22CuNMQL9ZpI3z37ENtMXLjI2MP+sR7PxOy
         7Q3RVK2GzMV9hB8+OYi8MX4rz8CdlxY2zEBnCB+pnLFIsAqjDw2awlrVuVJqSljIxbcr
         BJ3G7pWdeMsOdCz++TXMOJc1Wcf8J5oJU4m9tbOcgJvQRbAUgGPVtLdMTUBjRMXxS9F1
         niroqedyaH1123TTdBckpnqLtbsQzwwKlmDlLCbgIcjeN/2or9AmYgR6YF+vA9stWnVf
         imusai1Rwod+H9pzh2Xa2brM2YTzpTBO7o4a7aBvtlzExcKLmXiAtsU0of0UBUKy5Rem
         D2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWYfyb+F/Fx0h8IELAOYHrOhj4mxZIs3jCNXhO1GZ5uu4LIwGFpMVnS5NgsNPC+rFwzQ0A341qPNYdJmInWfRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx25WV3mQe6tpcclR1zhknZDHiyV0gsVpAGUjeN2ApP7yLgnVh+
	2W6t14cZLpCoC/Ypg1r0g3ZMiwE2WmNTeIy7szzc2C4SRW7oQ/iCTFLhQUAKArYTkecJeTRXSvY
	SRs41enA31tiXowfPAS2kHcCjZTEo1eo9DNCurfkKyxu3TEXaaZ6U7ypRY12bMd2XdbsVx1c=
X-Gm-Gg: ASbGncsz9oYz4TtbttaeMJq9HsGksBvRLrYecoXTTgkzDm4h05GO9qXp5XP4t8UdoSo
	9TzhQioXAw3QB7VWw7AePFxgGVA2Hv60KQ33aWpFKRF/UFbkzKOu+09DqmOEmomb8qhqq3joOGq
	Kbj7WDpkLOQZn6TRGoxGzqZ72IN7v/1OCjW/GeLjbYGbjV4H90Ym85qmTYEyUDqtiPASrCf+zvK
	+10AUXWPSfJ761NFnvZMNwHRATCKhQrtvWdzlG523y6DqWghEzr52LWhcf97sHX1zt2WHAewVEq
	hb4mjB0a6AeQmRlEDo311Jk4a589f+38KdDjmRmW8zewbKFNlw6uRoS/8QoLe+bf90rmwdzg96w
	4CSZ8SrKu4ATOnutSs21AztunUbS84yr28BiXG/3JxHY7Iblw81Lgv1tO
X-Received: by 2002:a05:622a:14cc:b0:4eb:7dac:7b8d with SMTP id d75a77b69052e-4eddbc942a5mr18534471cf.6.1762941228826;
        Wed, 12 Nov 2025 01:53:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnd1F8QeBMdY8tN7HVPZ+812BJ4TBuAQZwB/mZkcDLFhNBaBtv8CdDSSmrvJaNNTNixuwdWQ==
X-Received: by 2002:a05:622a:14cc:b0:4eb:7dac:7b8d with SMTP id d75a77b69052e-4eddbc942a5mr18534321cf.6.1762941228171;
        Wed, 12 Nov 2025 01:53:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64179499189sm8534460a12.8.2025.11.12.01.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:53:47 -0800 (PST)
Message-ID: <0df692e3-7e39-4a7e-916a-c385015a2821@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
To: Shuai Zhang <quic_shuaz@quicinc.com>, Bartosz Golaszewski
 <brgl@bgdev.pl>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com
References: <20251112074638.1592864-1-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251112074638.1592864-1-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EbHFgfmC c=1 sm=1 tr=0 ts=6914592d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=bFTT718uMvuJoUpks6AA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: p9-jWRW-eSC7nsKlgOJtQHDfUe_CoGF8
X-Proofpoint-GUID: p9-jWRW-eSC7nsKlgOJtQHDfUe_CoGF8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3OCBTYWx0ZWRfX3rRpAfkgdvLR
 k9fMDsEvxiUKTGbKr2Z6YOoNtJVPDXlnLeGJMD20ghOigSC8bOu2h7iWCtkCdEDX0E1Nmt9Hth1
 4sgYEWBHnRLNY5Y5ayXMdGe4THkQUWj/xmCxSUdZcN5oDi28WARdk66n0i7nSWh/JuBul2th5n6
 p1/+yP/9E8q52LakiJMN+1k+Z+ERhHsdfEeYO4fU5TnqWEXrgxzeD9OjDla9+LHCuV8ugcGCisk
 6ej594bZ0m060bnfAtEWLhokUghjQYfBtDh09uPpF2tqGcauciZ1ttpDjQDkDTZakix3T3m2M7s
 nGLdx1VGK9tundz0ARcRFNWACmPWZ/NVri8ohp09Dp914L000qS6K3KJIKHnTsaqbLorObi1tK8
 HJOpraedknkYASQGL1W/KI0m+H/YeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120078

On 11/12/25 8:46 AM, Shuai Zhang wrote:
> For WCN6855: download wcnhpbtfwxx.tlv and wcnhpnvxx.xxx;
> if they do not exist, download hpbtfwxx.tlv and hpnvxx.xxx instead.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---

Would these files be fundamentally any different, or is it a workaround
for someone else being creative with filenames?

Konrad
