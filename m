Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09829B78F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774531; cv=pass; b=XOzo5nyInHXBHe2fvSN5nOg7K5sw1koJQxVszI5ne2LJRboizs+8+PdFbmuGsL3LiLlTbEdccz1ZysojZK/IRnUJfIz9ivkRCxUvqEy1fv8Y/ssTFXOJtl2AoGrBXh8mW8B9KeUBJgNu3vrMr30PA0S0t/u1/eDHNNztV+bHowA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774531; c=relaxed/simple;
	bh=xSGeYmave0IMZ0SkXbSK3JzZpiVmg9C8P170/PXGWPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNrvcibrsgUmJm6+D/iBV7g19C4p8d9g6npbK1ER8bp0eNH/KIowghrVaofCEFiX4u6dD+EnBnlGyhhC9FLv2ua09sp7lzuj74sqQau3MBt1hVdIB+fGqQDZ0EQj45NBhkUKLK57U7dcy81HtuAvvIcXa45y/ZRQhA/kRc0wWv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fwGmUgjz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RzuGOxwg; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fwGmUgjz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RzuGOxwg"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AHFLSo2396794
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 01:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EBuYjZ6aifGkd1dAhK++qfqm
	5kl2DiQXlBUEgL/t//Y=; b=fwGmUgjzmRMwoYf1nUK2e1gsG0x1q/7axC9G1d/o
	SaQKNu/YQ+QzxOUsrbCsXbiUGaLdCx/qnzMX5iWyDlQAZ+dzTH0a4Dke+L79hCUC
	Dqe3ddE18USs0bSYjFB8w9E163NOMR6AFGc+UijVhis0AOcsDozykwDz7n7XnhTw
	5rI9i+Fe7/2ST9BhStUfzp7S5fC1LoLhvZOLF31Leg37tpP8DuIakBI5hfxvv0G4
	B7edLcFEpRuIHfvQhSjqF/cZTrAiNAPr7VJMNqcuVtVMLSjPHMpzDgoX0AiDLH0V
	qnn2AlwZkAAnZy5MY4WReynLC1EU9PNwSqH+BXRqhqPPEg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c88wqhg1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 01:48:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354bee18a62so3602138a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 17:48:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770774528; cv=none;
        d=google.com; s=arc-20240605;
        b=DZ1KFm+ks79Vutohy00AH9efW6MxTj4FOE3E4Cskco/N+LHHwkuv+bwRxW/I2sEWCY
         5WAUFhkNskeIiMEikEYG9BZpFcJ6vTwNGVPmNRVcj+CZfiTD3aLW3AQfxU+SN02lvnDU
         QPNstXpXIsK10VzBvgIKIVjgno6xnGJfkkKNkSVK4JrIxX/E/F7tidrrs0rUmSWhR7Vh
         pLtOQXZZEQAeNIgNYps3YxkZJQB/YzEohwDakuxMS6hCIRcqG61stnQl4dipk7PK+Oj7
         gKPmlEhsqX0jvRGW75XQHTTLB+ItEpagymJgwxNrYYZVxbVLRDBojKC3cx175G8fsxBQ
         JzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EBuYjZ6aifGkd1dAhK++qfqm5kl2DiQXlBUEgL/t//Y=;
        fh=NnP4mcTL51yTkiE6ibr0eSmXShyQlF+hJ7Ag89GY610=;
        b=OzyuASvRKp2gooShe8/rseyzVvm44NLHu7H18DUMRd4z4P3SGzttETHBuHFMJkjtxh
         ueD2g9U+mGNkyK/J/4zsENam7SNc04O3bJm5j6cRAeuAT+7E3YiECuvqj0a6LyqKq5Dt
         14/qs2pKalc/eFMSEv7tS2QjWiBrunCevmeFr/gPe2burzRg4TaDhiLwIE84FgyL+X30
         0ObcD/+KzVazCHSOsGGZZTfCClUFzAJktpS8IDpPsY+0RcNz3ey2bCeEfeFcu0BdMKjT
         4aq+a/ZJMIWtQthoHuj1A8lMvp9gp0RqTDC4Nc41W4iLEoCW+hNTSD9CgM3w+t4mtrkc
         1RuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770774528; x=1771379328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EBuYjZ6aifGkd1dAhK++qfqm5kl2DiQXlBUEgL/t//Y=;
        b=RzuGOxwgWi78utb++D/twBmVneUIv1b4zzpvOc9+IG51A1ho9KCNSUvUdvvpGmyOgU
         phPNDY8K+72Uliim2w08E57AhKI6GsSFt2/wT1UV5cX/G1LpryEH5d7Hh0bh3pMZc3et
         4QJNlX3/I+VruCgVX6PaLla9EyDWtYRbANxzpXkvHkVsG7SzjwddCD4AJhOFQ63VvO8D
         rH8gtXIp/L1At/YWQ4qW5k0cO83LC7QvoxNXbvpryU4GzM2JO/nAQxme3Us6ogJ8WRwm
         sWcdPtmhHaRATcXUEmjC1jIwSO7+NoGwEB/ze6Q0PyieFcKSua8hn++Lpm6y1yi271ce
         x0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774528; x=1771379328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBuYjZ6aifGkd1dAhK++qfqm5kl2DiQXlBUEgL/t//Y=;
        b=X7aQo6dMvHxTNxigZ+H5Ynw3xTzCCFAEhwARWEZe4cp1yOSFXdwjjdo6oxlgzU9P7M
         AixykuIvd2xul4xJjMDP/o7fNLiQMq6a0fDrzduAFi19wZxPUI8V53H28+fyU90Y7QRr
         11VGr5OObWAZx063o7UzQkLCMaMPKdhWJeMTB5PF/GNCb1/7kWxlVoaSIyrw/L0dhJZa
         FFOwcg8bb/tQSWYR5wRx0+zr97iLLSnAJf9Ph9SpLxQ3rO3zywq7lrSKaBx03wbGCey/
         nMzmNiZ7UeNVljMVSJ9/h5PKYP7TiOG+gKAWvsL0xeEEu5pb3NwueCGRIMlgeeeWBQVN
         pPuA==
X-Forwarded-Encrypted: i=1; AJvYcCVJxQRLdGs71CL26hWqCJSwpOAJ9LfMoeSTO5z/OextgT5QhPaC3foLYFWyehfZePa4DYPR6OVNsVwxsTHjOnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1DGFm74eXp9fkbgTFG0kQPNskEplAM4Oo5zSdV3rZHMnWC10K
	hpwcAgr2KgzsVgWewljpmfjL+3kaS3YHCbhVrJ3Vxdjlgcj9T5uMhgWTqIxEMIfUeu5inuEzw5l
	1EVApKL1OTK1GuQijyhIR6O3dJzZI1itZO+Y7Ja3aNVMhzXLPh4NWkGVAxNU0YskjvVjUTR3iJe
	bsMtFYgNWCvOn9XY9GtoXLfzCf7T0m/AHuCvcijCE/NOczkg==
X-Gm-Gg: AZuq6aKfIBhHVa63KOYlDWDtkntiMujr72Kjbkvm1Ww+xB04O+45wQ+MR0fYQEIWt78
	V3W+sTxfYfjcjuEOcMkFg1YXdDT1RfZsGzrft7bbcIdKL3XZLTUj7i4+569o0KmoXMFT8R3ZTU0
	gWwNRZbhsIbtInIaY3ZT+9crjzPQyLDX57odJLeYTH44x/YzKr/b1QbdkPJe7VlHCjjaCc+3jkA
	HYt
X-Received: by 2002:a17:90b:3bc5:b0:34c:a29d:992a with SMTP id 98e67ed59e1d1-35667d72a8bmr3144203a91.34.1770774528468;
        Tue, 10 Feb 2026 17:48:48 -0800 (PST)
X-Received: by 2002:a17:90b:3bc5:b0:34c:a29d:992a with SMTP id
 98e67ed59e1d1-35667d72a8bmr3144179a91.34.1770774527960; Tue, 10 Feb 2026
 17:48:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com>
 <20260209080613.217578-3-vivek.sahu@oss.qualcomm.com> <CAMRc=MfT7ourMH+ShJpnBAjv_uOb_ds0rxJOYaz_HsoT45dJYA@mail.gmail.com>
 <cbc0b42d-fb5f-45b8-9074-d0bcc64a9de1@oss.qualcomm.com> <erc5u6hzofidlf54dsz7htta55o4xwgihgh4tu6mqkg2ijz3fo@6hd6q6iljrfq>
 <dada4a44-f464-4325-9082-50029d6a4555@oss.qualcomm.com>
In-Reply-To: <dada4a44-f464-4325-9082-50029d6a4555@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 03:48:37 +0200
X-Gm-Features: AZwV_Qg2qm_Ag_s2JkmIG-Y77QYxnHbFnwvbLMtmQMEho97MeZnPXtM_u5rHzFo
Message-ID: <CAO9ioeWhNO1vYVvN46wNfr2NFAjD-oERLhMKTXyRkRDLtJTMqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: qca: add QCC2072 support
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDAxMyBTYWx0ZWRfX51Hx+mTQkW6o
 CJZy2mYUavXUkDct9DUf9lNmbtJMVTnE79iNsDaGRJIi8Ka8NjPYWnnpqNdzl6A8QO/zsiaKVyX
 TOLRo10e5e/DIOvvKnwq3fLNYnMfKYufpknHV+RYmjWczowdsJ091y2Ybx959RlBTkBldKjvAhd
 K9pP42k7EdSDT0watBkf5+JYb4qS3b4eSGlM9MCzaMJEeoZenB7Z8xXbWSs7yIzylj9e0DMkHH7
 BDinXMT7HQTf9kyt3kpfU1m+fFg7DfRjtG3stuPBMK1dfHhEk4cSAvOkjgw8z++Ce4n9bV1pY/9
 u6wLk7zPdr3/nDMhO7kPwSkJapOxUBWcYXVVa5Xgip1Kq7iK26twX86ehQqliwZIY5prNyeTqj1
 9uqUxqE1uWvCuuLgpESUhDcPbSodcIQZh92ZjWw3FwWm+9M7TSQhhJ5T4ecxG3SBdmzoURW7SZu
 inOrPr85bvu6u03FBbA==
X-Proofpoint-GUID: KJx97pSto8NSWwxUnjLHhXnMCVbHoPHp
X-Authority-Analysis: v=2.4 cv=W7Q1lBWk c=1 sm=1 tr=0 ts=698be001 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8 a=TCK52CFr6wQZEBS1tEMA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: KJx97pSto8NSWwxUnjLHhXnMCVbHoPHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110013

On Tue, 10 Feb 2026 at 15:53, Vivek Sahu <vivek.sahu@oss.qualcomm.com> wrote:
>
>
>
> On 2/10/2026 5:46 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 10, 2026 at 05:41:13PM +0530, Vivek Sahu wrote:
> >>
> >> On 2/9/2026 5:04 PM, Bartosz Golaszewski wrote:
> >>> On Mon, 9 Feb 2026 09:06:13 +0100, Vivek Sahu
> >>> <vivek.sahu@oss.qualcomm.com> said:
> >>>> QCC2072 is a family of WiFi/BT connectivity chip.
> >>>> It requires different firmware files and has different
> >>>> configurations , so add it as a separate SoC type.
> >>>>
> >>>> Correct the sorting of other chipsets for better readability.
> >>>>
> >>>> The firmware for these chips has been recently added to the
> >>>>       linux-firmware repository and will be a part of the upcoming
> >>>>       release.
> >>> Something is wrong with formatting here.
> >>>
> >>> I would personally split the sorting and support for the new model into two
> >>> patches - without and with functional changes respectively - for easier review.
> >>>
> >>> Bartosz
> >>
> >> Yes, I'm now splitting this patch into 2 parts, one for sorting another one
> >> for new model
> >>
> >> support. Please ignore this patch.
> >
> > Please stop adding extra empty lines between (or fix your email client).
> >
> >>
> >> Sorting change has been raised with tittle "[PATCH v1] Bluetooth: qca:
> >> Refactor code on
> >>
> >> the basis of chipset names". Please approve it at quickest so that we can
> >> raise new model
> >>
> >> addition code changes on top of that.
> >
> >
> > Why couldn't you send it as 2 patches in a single series?
> >
> this change includes driver change and yaml change. In recent
> bluetooth-next branch there is a new style of documentation of bindings
> comes as "Split to separate schema". I need to re-modify my patch again
> and compile. Splitting patch seems more convenient for code submission
> and addressing review comments.

It makes maintainer's life more complicated as they have to cope with
dependencies between patch series.

-- 
With best wishes
Dmitry
