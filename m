Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84A250BF3
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285403; cv=none; b=aQ7Na3QpECKyh6JCebHpM4kqdNi+fFR5SBWOdcnxG3WBAjRa+dHZtxa4/eufAS9giDmmfVJZxg3CV+2OjvAGbxcrjXr6bb7NnIu5qC791h3nXg8CPYrOY7f8uK78mZfST0xR+LruSy8H6PMTxLzSJEehJmNjlB/ArJl9bjN40jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285403; c=relaxed/simple;
	bh=jdFTd4heaqF1waae3nF4Loe4e9NQVSskphOCed8h7lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2S/R3j9fEniYH9mDQ17scS0uARk8S2de0G0WqkxD251MR/NH63CgfPYkw7vUZUqnKrEUrzSXhTdRBvskfBQRVlkQNtN+29NCn49KB6QP/GMG4NkloNzVunjn+xkyj+00DPsT2xcQQJdtrXobwTMgRafMk1tLG31kqhG4GeWYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jp+6ziyI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jp+6ziyI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B8vDWm001448
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 14:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y9QQxW1CrdMOjnr/u7ZG72NR9gv+JDy1eoZ8KaTkW9A=; b=jp+6ziyIHb65iozh
	9RVFlMo/Pi+ZYkw+ukFV/65b+/w7nfKODthOo9qvUziQDjqlrrfUzoYNDdpZ2/im
	RtHMD/h1JF3f/9n09QehWXAnPrb5MSLLOdNBXb7JknzJeUCAEhRog9D/vKWL+LAT
	qz20fnFLPN5DieKa75sy6B16SFDbjsQCALbUjmGNWXg2GKjj4CUDvEAozpNwh+W3
	joP3vGfnfA3nB683zqvCAI9DbwaoFyJi1E1XAyMStJUr90z9Tk76fbYjgfcq4Jfv
	K059w/GChp4VWKRjA8cY+Z4TkTfd0Y5hVaZd1SKtL2Hj24ctVQoxbxmTPIk/TYNp
	6EYjfw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qepxmcr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 14:50:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e4287d04e4so15527336d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 06:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739285399; x=1739890199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9QQxW1CrdMOjnr/u7ZG72NR9gv+JDy1eoZ8KaTkW9A=;
        b=OKyEY1BIWCrJwppnmf9eQzjUeFw4Dg9dhI0AOPIxlivltsj0zklMxh57eoJk03d6bh
         5thmGO6qaOKdpR5y+j70vedZjYWJYoRLqqU2Fp60yvl5irfU8gY3TUf9wycan2hA9yNp
         zzM8CfELCNF6LZVlEgPrg8nci0MSTrOk5puCmnleP5orcuphAH1fMenQ/ta8kHdEpj3b
         a35Fas4loYvez0Hv9nKVZqPq/8KTVsmq/LJeDX9CGkHxZ/3b8V+nUYdsurdfRfzG0JCY
         VvQg614ugm5Qq4e697P0hd8aOQAfir3gGvWEp6FtWJXhIdTenOTNQ9m9fh2qBrZG/qo6
         355g==
X-Gm-Message-State: AOJu0YyWgc4gYFBaJuVob8WIe/T/DEFNLXty3r9AHh3VDSuuOVMnt5Dv
	IjiRq1KGUL88l6h4uKCTd1B8A4mqZCEHrWf/u3z1DbNOT38iR51y9T0UGpcIhIpyjiiyLnIV1JD
	HQUM4cgWXqzKn9mb72SY9YCubfEaV3nOpZfRXiGFVPGIIbR6SSAGHf9eyvZGNEDXvEBM=
X-Gm-Gg: ASbGncuSTHL17BnW4KHTMrrCnzWZE4K91gFwKGgJz+SQVNdLsoQwfCxbgR6UNXgf4Ih
	YwyVjjwNwgDmejipquEWYqApZra/gukFxtbhrfaGVpqPClaDJ/TnnpWCsZoQyxF8zv/kkFNysSu
	T3SGpoHE5jCqrEA4HKgRLo0K3yWPqIcYqf9duDaCffwA0rEYW/KpPmZ2pfK4djSsG4zihLr/JMQ
	ZThHq1fWO/PRM/nw7s1aRGFyjzpjFcrEt6ZWO7qWRLoA/CA+CQVQAIuIZCQoFHalBXnt4s3ff0y
	lCsJfWgGDbakg2YgE/cz9TjQkpuL/5bI5sRWuYVy945Kf1Hs7uFp42a/NDY=
X-Received: by 2002:a05:6214:19e5:b0:6d8:a67e:b2ff with SMTP id 6a1803df08f44-6e445715619mr91437516d6.8.1739285399564;
        Tue, 11 Feb 2025 06:49:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkk9DjPa3+ZeT3Nyflq6y5KlqeBXv7S25Hpw0rmBRomm62/VHebINsLa7PDQCcXTd8MmZyVg==
X-Received: by 2002:a05:6214:19e5:b0:6d8:a67e:b2ff with SMTP id 6a1803df08f44-6e445715619mr91437396d6.8.1739285399076;
        Tue, 11 Feb 2025 06:49:59 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7e2711937sm125092766b.25.2025.02.11.06.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 06:49:58 -0800 (PST)
Message-ID: <52d29b4f-7ae2-4f79-b09b-f0b2a4e3034d@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 15:49:56 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: qcm2290: add UART3 device
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250207-rb1-bt-v4-0-d810fc8c94a9@linaro.org>
 <20250207-rb1-bt-v4-5-d810fc8c94a9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250207-rb1-bt-v4-5-d810fc8c94a9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mdcBee7QySmUKGJSkhDX1zbkSmYO9Mc6
X-Proofpoint-ORIG-GUID: mdcBee7QySmUKGJSkhDX1zbkSmYO9Mc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=848 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110098

On 7.02.2025 9:41 PM, Dmitry Baryshkov wrote:
> On QCM2290-based devices the SE3 is used for the Bluetooth chips. Add
> corresponding device node.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
