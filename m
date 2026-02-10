Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045E327BF8
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725153; cv=none; b=G0YZ5uLj0R4fs8KNaI13hpBFXpzLtNRPbfRBl4Qz8VWWefqY8xAqe8+0oKyW2ic6YjpYnHuAHm8eJNa/zSD1r0hZeLJeW98aN/3NaqNywaNhEBEsxDgTy86qZDNEoGE3BIA2z2euhK+WpEbNDQABaNrD1eJgckVNyplQCu/h0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725153; c=relaxed/simple;
	bh=j8XtPUbxPDbIL3fYnxVnD/GJzwMyqA+fxQzBOFiPxds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sy3vEhsliYIbW2AXOFvc3YnPaDtEyvzEaoutOK7bBpX6fhQeEW7Yj3/8iHbfudW4i3tRqCKqhtMgndOUhlJdiF33YBN4Z2yUWtHkNiRrnK30gjNkz3KgllmD6YHEH9+RCNJUk4gkr2//0Vx1u1TcyqBwgg0bJIt1qvZI40euJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Grs3dDPe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wl2BH/88; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Grs3dDPe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wl2BH/88"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A6oPhW857026
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+NG8xNWloMlyuAlY2QzsKXbGKfasHTw3/zbGiFWKykU=; b=Grs3dDPeCwKZDXwu
	amxZ4zp0RTZ3vqpgdrIisa1LZ+NvPdS6Cdn5ND1jesQsXWwJtGnG6/8+YE89FWjz
	JJMuWkgDNKYlXEHiJ23Uh3y8PcevJJwp7kkDtalodASeasJ9vEg08YJJsv+NcK5o
	gVgDz4F3dzWUYIlCuSrOtxVVe5ErQyfxmKSFRbswMAkRSMzubP+uImjp1i5l9fWN
	j7v75PXedY4Se+jjejAAJBWSRIQylar3mwpWOMjW+oflwJKZKMHSXzb4S+phqlmw
	MUCk30juYzsq4uHK7OgbZc63YCmQdsYQBTWFkYz24krn518fbH5H99hmeaa7Jm8s
	en7Oig==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga643tr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:05:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b86381a107so21713161eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 04:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770725151; x=1771329951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NG8xNWloMlyuAlY2QzsKXbGKfasHTw3/zbGiFWKykU=;
        b=Wl2BH/88UczimIP60LPlFahVM/ld9UVSFISoC0LwJtlDrHyYEx2mM4c/xbRw8XWF1h
         BGIVsrqUNokD74MhCQBsteUZi25Bldx1sKjhKUpibenDftWmh0J1jYNCuhWUY8dcHahS
         RfLeo0GFc5XVl24N464GPDpLbnXFE/OBGCBRBkjkiZn3PwjOtDIxiexaUwiHPM0fZ9Vg
         yzMu0QNZzVFqRbYianXq1N9f48nBngr0zD7A/DUKiG8BMbxeU98m3tQGCD0Mz95v4spL
         /auZxFWg3dzz71C7l7Z2lNRsivFyuaeLlONFRo9MKxIPiLKExewj7wruG6hqL8FVXKct
         1hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770725151; x=1771329951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NG8xNWloMlyuAlY2QzsKXbGKfasHTw3/zbGiFWKykU=;
        b=iLzBVV9R9cg8NeI0u4zGeBMGvtD2AcBz8mAEeyWrQKIgVKIzcNdD0PB9cFTUINX7Ri
         DYntpq4fmW5DFL5Qxyvr0hBk4caNB4yPHeawlDrR1Sq9cyioVfqsV+ord5HxpGiroxx6
         jxVwTyIqyFOCIcDChUZ9lmvT7koC9a4AlrH8kWSvS3fQh70N9o6MR1T9BJnkAv67mhMf
         6mtDJ/tO354iAUirygzO4KJVzSk3nHNNMdCz/NopQXaOKgJpPdKpdsLiOp1ZnEKBEnIx
         99kwFRljo01ozqSQ11MawFXxPfeKwLAQLM5/nc4jm2YYEt9x/yVbd7QazIw4epdq6Sqc
         j5rA==
X-Forwarded-Encrypted: i=1; AJvYcCU8VT/wX8bOFa8GVCjfOHpYiDGLyQ2EFrNocGAxfAOd2w+f021B9NzjrezDvYAQrSFuExOR5Vcic8NlBQkxZxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGfHdshDsLLl7VlvrigSJ7oAG74w21Q62L0tkKxeC7LmRd8jn
	yH0thwks/vetMn2hlNfX0VsavfQ7KYmH78TUAjAiH211FjbPQyAU3EiRF/mzuEZDF8bX+zGEue/
	Z/MpFfBB10qIMd+1Zv/nvekIuDVxAk7SUburGpQLYhTwJPujTpw61ovo2RWalT68L6XIQQvQ=
X-Gm-Gg: AZuq6aKj8/LZlaxa9NhBwOKZ0KjI9gMtsnQ3vYL6ac+QdejrQj+79WMgZvjHRzIRc1x
	zISLJNqg06IwUzoMQKWdHsa9IdItL0mf8BkDoWC+36DfA+5qstW8ZmV8FES+jo9KQ2eCVcNbCBi
	089Afn9zattaAjrSmIp7QPNh9TMHAKNRdjm+thDeOhB6lkNk8+AYj3X1WknsfUs4YIXDa+vPZxz
	bWnNaReVe7BFSdryxmSeIJPw+4dAnA125eznT2AtKgzhWHcDivHUjyl2p9CoMHh6qMZauwJJU3F
	zENx8E/yQ9AlDBSD1Qs9olh5yQ3Gs6H9xHuFas2NkV+2kxc2QEyfbpGbSZS8a9eEkKaKq/4Xp3V
	3cAiBA7iukuAGpXA7DGXXBlm4hKqAGnOtOgMFVYnPRgyf8SlC
X-Received: by 2002:a05:7301:2b87:b0:2b7:1320:f280 with SMTP id 5a478bee46e88-2b8564037d7mr6638249eec.15.1770725151374;
        Tue, 10 Feb 2026 04:05:51 -0800 (PST)
X-Received: by 2002:a05:7301:2b87:b0:2b7:1320:f280 with SMTP id 5a478bee46e88-2b8564037d7mr6638231eec.15.1770725150752;
        Tue, 10 Feb 2026 04:05:50 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba93de9c9dsm136554eec.11.2026.02.10.04.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 04:05:50 -0800 (PST)
Message-ID: <4b049560-94b8-4a7a-a60e-c2e0c1e58683@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 17:35:43 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: qualcomm: add
 bindings for QCC2072
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
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
References: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com>
 <20260209080613.217578-2-vivek.sahu@oss.qualcomm.com>
 <7cb9a945-651c-426d-8cc7-1ec1174ac68b@kernel.org>
 <8fab20ba-9924-48a6-b417-5ebd28b77cd9@oss.qualcomm.com>
 <6def8756-f4c0-4b4d-a20a-205d548acf88@kernel.org>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <6def8756-f4c0-4b4d-a20a-205d548acf88@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YuIVtbsH-hglzjVgf--MbaDsk2Mg6U8N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwMiBTYWx0ZWRfX/cL2NwKhb+Fy
 JTD/hpoqKP5raZtFTrbUqtYjaaHFCWJYjXpjBoqUFN1cEKGQrtIHDALNz6XkSbyV3BRzGhUBoLq
 daOaqrmHSD7LDGsADng95QcMVH4CWS9x5ao9ci1bUJd7wbPvy+i6WeN4634Ttghe5ynxO/NQzae
 6EWg+O11rlJg8No/SPz03DqwVNSFubrte7RqMfilyFKqps5CDt5MvoHTZN+CHn6Qe09Gf6Fh5oY
 yeVhoZ9pt3kgFhkr6V6xHl/qSIbtliinNdsrNrwuaT9Ygrw28AjRgHmK2yHYh2G5UN6m6iuqexu
 i5F43XgAAOy7QGa1aWTjQdGTj/VRBDKWuBTSNuMkq9lM5jTbqm5jRQfi2uSKa4w/K3ddHI/Ovvi
 rMt/CU09nz37BHAeQNUn7TPIovoIsbwMa0Th9TLbWXXLwLqhq9Cb3zsw5bb/smmCbgqsUILnfpa
 jpXL6yrLnpvRHYFcvWQ==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=698b1f20 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=4EzAYdkXr_pH7v8aMFwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: YuIVtbsH-hglzjVgf--MbaDsk2Mg6U8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100102


On 2/9/2026 9:38 PM, Krzysztof Kozlowski wrote:
> On 09/02/2026 16:43, Vivek Sahu wrote:
>> On 2/9/2026 1:37 PM, Krzysztof Kozlowski wrote:
>>> On 09/02/2026 09:06, Vivek Sahu wrote:
>>>> QCC2072 is a WiFi/BT connectivity chip.
>>>> It requires different firmware, so document it as a new compat string.
>>>>
>>>> Correct the sorting of other chipsets for better readability.
>>>>
>>>> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
>>>> ---
>>>>    .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | 3 ++-
>>> There is no such file.
>>>
>>> Best regards,
>>> Krzysztof
>> The patch is updated on
>> "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git" repo
> This is not correct base. Why would you base on something old, without
> any in-flight accepted patches?
>
> You are supposed to work on maintainer's tree.
>
> Best regards,
> Krzysztof
Yes, I'm now raising patch on linux-next branch. Please ignore this commit.
