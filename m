Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CF2FFDDC
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621254; cv=none; b=UMXtCAIWYFaEQ5yyoSByub96WFEmb14JM4QnZKGotXifj5z1Yrs4KY7o+ucTJc4aAeo1RwGGCGkyuPp5HHerHAThcw3s302+OrY/tEk7hUs515rcDmHsRpVjWzqRobbdPp+4Vt0aw3GhdSlYddxeXhWskFD/uFg2LrNiNVaX3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621254; c=relaxed/simple;
	bh=JbP10Ll7jjO1BX4lS7SqsxzBWutkXxF4vlEKJmQwik4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhK1igFWkS4DSTr6NBxeKHSGdJpAuhxKevVS915qH3xsDD7quO6qj8MGp9jxSPHqAKUDUl5VPUSTHozyKf28t160vw3172HBidhDza3xUNvjJxOKGXVPgFsGAGT3JnWYhT8cKx0CsfcJ5w4r5ztcfQqVwUG+s6Tx6FukwVm5hy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VGwgBvvF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GO+nl4CR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VGwgBvvF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GO+nl4CR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618NSNxQ3111687
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Feb 2026 07:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LTrKUWGsHWKL4F+zsgbBdKHrJDXyVebCryhlKa0YcZA=; b=VGwgBvvFwf/gRjLu
	0VS90cNtGRJNOrcAYVTTpWrwqhSrc/s5lAZEH2QXgBw5aJ2gT6KaWSndhVGYGgUr
	And4D/NlwFTQRYkPxJZY6E8v5jH2qfwyay3IdNE6OP5eu14Jt32O9eUzHVvjRqv5
	9Or0Er8a421gd8hMAE3A3VXgXsJR+aemilA3kqEsec5ErNRrwAAXbNQLYckwcRSA
	eTZBKkdQx3dIuRVWbuFCzqRDHSDpwdHkSiVbVJSnUzKkmzbSmDvnSu0wQLucYFxl
	FBUEbEEB35OD1QmHdKD8g286LB1RQq+9cp89uHbsimM9MAwM2ZcnBvfU5u68KgmM
	p/ZaFA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c6g65af8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 07:14:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8243767ce2aso1448055b3a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Feb 2026 23:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770621252; x=1771226052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTrKUWGsHWKL4F+zsgbBdKHrJDXyVebCryhlKa0YcZA=;
        b=GO+nl4CRYscnbCgoTt5l3p8VyQyyzhjR+px07ral43JNK8T0bZzoM5YRvFE+1RXS5+
         gt8VjnPPGsYA3QbFrpj7X0fc9OUGZ+kt8VzZE9Pj4VZVn/36+1q/PQDYB5RDn6hBiTK4
         i2ekcLHFVJ8Ose6396CkFJAO+QVkBxmmZy/p5EdP5xyyUEqapr/TnSgNJU36NmJ6sJ2o
         nuNX6kC65OhYdUUj+p0aVtcEc9Nvsl5D187TPOsfCyw4pfjUSz6f0fh0lGRh0khml6Ul
         5TqJu6TyEc6ChOHwHmaPx6wy5RnueXIO7LQnCeBT1NSHmGAkpK7Q2C23ZdodpLHg/Lfi
         mjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770621252; x=1771226052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTrKUWGsHWKL4F+zsgbBdKHrJDXyVebCryhlKa0YcZA=;
        b=B9TmXqZQv+hrp+tT4/pkq1b0907BrmbaSE5biL2hkzgl7PF72n8wWm/c8MM9sTUSYv
         NWdrqLGmNxncQ+bflnNi72rq2WOksOERFByQj5lhMJzrHBTn1FxmqNiPB8gVRHHtGuBL
         CjzWhQ9T32BdnakO1eGq2cvNFX58bqo7ZuvHcJbWn9cWJlmJkSTmXgntkqx13atIUxqb
         LVCi7mNUp0KDy6vuGJKXDZfqsWhGSbEHrpDgvxo+9hcy1TuSC/pf6Fzl6xAc9iDJ+oQO
         zITy5ES2qM5KYKU0+FA1SmvlHyFZ3CQu1j3CUAkPgQmUDLSdR8saXwwuqiLWef+zh9oJ
         5jDw==
X-Forwarded-Encrypted: i=1; AJvYcCWSaem2DOmwjCdFfKCNpYHMnOPM8aBBgiImG0475turPt+P7NXD6i2akM2vwi/cPxfkipzesnFknWErdI0BaIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/zYrZw2LtV7eod6sJUY1/HG5mz8OToCddTPht4y8s8TLk3tu
	Ksygqo1AX35WQd8Eu2+CN69+y9P+ESRtQAHE3X1YznEdb/R1eL+mnGT/vzQ28nI+sz1PsYeyke3
	3eGi6TpEs3l+Yl3pb1CaAH2nzvxwqPKXx3iuvhMG10/II37FM1BPvRhVoYWVcRZUOpzRpON4=
X-Gm-Gg: AZuq6aIUOaiylYAAMHLE0+YOXpJo0QHPmbeA7xsu6VvMy0ZydAJeHKi4SvcPy4Lokps
	JfJLblsEyJUOM/JkdfcVNvdPZi3h8rZeVy4t++zKuKwSYLCRQNO4EoTA6dkkTLk7k4bj5kd2XGx
	Pu0DszyPidjy8jeZBdU7dyoUOuCQUd1A6PRINqC/Q0nS1XF5kCjw30zeP9mH8KMcxH1ShwcPiSN
	JZljRtvhf39PoERXE23NGvahUlmRaKxabEeVGpofpjRdx+VECBxUWFysLR5QDjLkKGekgcoKzGP
	fo1ukCGiY7VVqdqj8i+Tzx4TqTXn0VAiHJSk9P9Eeh1oJvCVQ5SwsE68NxgIVVnuMLBP/hcJIBK
	JkHUP6wxaiJxoH5xYq2/aidRJbIAHYWIjjwAo
X-Received: by 2002:a05:6a00:2296:b0:81f:4cf5:f252 with SMTP id d2e1a72fcca58-82441631fe5mr9348724b3a.24.1770621252541;
        Sun, 08 Feb 2026 23:14:12 -0800 (PST)
X-Received: by 2002:a05:6a00:2296:b0:81f:4cf5:f252 with SMTP id d2e1a72fcca58-82441631fe5mr9348708b3a.24.1770621252081;
        Sun, 08 Feb 2026 23:14:12 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418812c5sm8755769b3a.41.2026.02.08.23.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 23:14:11 -0800 (PST)
Message-ID: <ede196b3-7ca1-40f0-98ac-010a56928b6d@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 12:44:05 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: qualcomm: add
 bindings for QCC2072
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260209070356.187301-1-vivek.sahu@oss.qualcomm.com>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <20260209070356.187301-1-vivek.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GqNPO01C c=1 sm=1 tr=0 ts=69898945 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=X13vrDU6G3zPuaSVdoIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 2wAnhYffQR2cC2L-GZuSy08DxQhFmGss
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA1OCBTYWx0ZWRfX6qejoubAaD7i
 fTSp/BLVPF09TE9g2uJvXjQZWOsWINe8oQxG4gQrky54oAe95hdhZmWiDEQe5/Xm5CszRsxl5XA
 i3ESnksraSeNRjUJZB+zLkyDtkoQWnk7pXCVi655AxAMcML3DEMJFw+guZd0ItwRd52G9w1arn5
 gec3F+UUwsSMaY0XoYytFX0R3Hwpvx5CUo4l2bhCVQi+sxqIRCAdWft/h0AvRiuSGEUqNU39rRT
 zMR0SWpGpke9jg/ldyE5cILstTPyPBXIBnwWsm2IqcIVwFww6igldmwRmBSla7ZLL1WlF5J9q+D
 2651RIhNt5v9ttvjxpH+/qPbaQ49LKYkFv9kJagB2nxydv30yBr+L7rKjfOKyK1DrM2wtC5R1J4
 wwuqwb5WjW1amFQTRHrk9SjCQVgM6Csaj0jbXXpXKQycas3uMJX0dmtuO0UvRbfV9tXFDk3h1NK
 Wvw+/u6dR8Z51gsL+tw==
X-Proofpoint-GUID: 2wAnhYffQR2cC2L-GZuSy08DxQhFmGss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090058


On 2/9/2026 12:33 PM, Vivek Sahu wrote:
> QCC2072 is a WiFi/BT connectivity chip.
> It requires different firmware, so document it as a new compat string.
>
> Correct the sorting of other chipsets for better readability.
>
> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> ---
>   .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> index 6353a336f382..1f47ad36aa61 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> @@ -18,13 +18,13 @@ properties:
>       enum:
>         - qcom,qca2066-bt
>         - qcom,qca6174-bt
> +      - qcom,qca6390-bt
>         - qcom,qca9377-bt
> -      - qcom,wcn3950-bt
> +      - qcom,qcc2072-bt
>         - qcom,wcn3988-bt
>         - qcom,wcn3990-bt
>         - qcom,wcn3991-bt
>         - qcom,wcn3998-bt
> -      - qcom,qca6390-bt
>         - qcom,wcn6750-bt
>         - qcom,wcn6855-bt
>         - qcom,wcn7850-bt
"qcom,wcn3950-bt" is deleted by mistake. Will correct it in next patch set.
