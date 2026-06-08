Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55336C58F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919108; cv=pass; b=Zq+5xmeAnI+60FNEbyS+CsA6xyhQD+CPF1wLLXhuxMGgJzKsy1wad3lT2tjpEBHbTqiqcL7A6Izx5a/EMHoA/Fwq1gC4+HhZQsKGzrCSxdMQyggcyvPXkAnggiaxcQEk/ksjpqnAnv/giDKMVdcqVlqzsYqaE90X+Bf6lv8QEqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919108; c=relaxed/simple;
	bh=hhj8Vip6KRSgrU2uE5rO79Ldiak2Rlsg6Hs6C+XmYIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNTrfw5o7g13EwD4xnw5MKZkjITutcpETtntNGhEW4ACd+aHWj38na4cw3MDsBb3DhmBgqUEobzlU/R7lk+FWGXf64m1651aR5SYOPdX5onI939eUskI9H3tKXzbp5i7JMd85i9Ym6B1vRwlD3sZKELWmHJP2sI6Gr0vXtihItk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gyjq1X81; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RcO5O9lG; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gyjq1X81";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RcO5O9lG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9TEi2965423
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jun 2026 11:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=; b=gyjq1X81lQIRnvcO
	G1um2E6TV7hqmLL1Crrjwm5U2JX9LsLsEKMoBAB5r9dv+Re6mmmqF2N4BlWwnJWe
	WipwNPhnPDyTaQA1648cU+hTlv0M50/vvS6qQKzliDV+B0P+UasYAt4nGWww+/2V
	Jt2hVfesaJfjYeEx6LLpZB3Zd7kugW563Aw8AhYGU9FXuGT9sI2lmrgrxr4ipjYE
	RyrKH1rZFL3kTTJ+uQ3sF56wCseXRx5Ce/219eLO3wNRU5YKKduHHRQ7HWqC5dUT
	x7K2ybfU3hPnmKnk9GZzZSnL5s9fuvmjIHV2Ao63T44wc4jwbv7XlGhlcM4VQxJB
	Ow6dcA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrkrp1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 11:45:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9159bc52211so131283085a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780919105; cv=none;
        d=google.com; s=arc-20240605;
        b=KRevRMGSSO1JZqn4dYRmn7XdjDxnxOd1Oh4Q5RY+08KrVcZp5IrZK5EYqj4JkLnk5W
         DyiWaNoVIMc/3nAyJpgZxJpAJH5cRZKgBHe8YmdNzYHhYfTg1qhx0XnDGZL80+ajQ5bq
         lzOPoK/5gVvVpZgHT04iCH6XjSe6ohNKlUGm3/LOMoi1D/XAC6uiD9UL05+aMOWBgG0X
         LEOmsK2t+xEKj9vmTwtfs9vKDnHnsgUGRoPRecQgTvCauSjF0l92nVJ3MlNbQ1AmXN7O
         bZHryFrzbeh8hx3EjKsxr5Mculayc57wQig0fswBENr9AzjhzuX7RdI8antj/FOYct+c
         jJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        fh=H6yZeT+DPppB9F1eiA4g1gQspdeDZlP43AAhDy54jk8=;
        b=VQwOlJxCRVjKID2bjX+C9hZNVhhpO0mvDxfDnZtj6Xjn73Qch1hA9RVUuQVo37cSFD
         PU2Q8FdGbXcVz7wPdkxb1l+FwDdgK+boS/yT1MRQVVQT6g26WC4XXOCgUFcN4Q2XNRLW
         iUcLnZH9XQCHl4OhUkTt1RHFYzG9msVtRvs7Xg3Lms1KF5+gQoL6scWvazNJxpC7RLDa
         ELXnl4mte3egN4t8CoqA27qnvvamYEoekkRyvO7V0v1nMfa0jB+VuG489YwDNOZLciQv
         9Ch3u6GWAiJPT8iYf6jnUpT5SXPTujcODYSVHkdBUrJ8ahRgGR0x5jsk5sEssrDzBmv3
         ET1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780919105; x=1781523905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        b=RcO5O9lGigUkcWBwngH5Wfra4pY3AIg683iEjDPu8iUitQvGL7OQVoChTSxOluDdJe
         +hSAORC1TWMgyB8XsS3ZAQFY7KgTWS5iYMxlK62hFqYhjc0ndnX9EaRRkcQijTqkY1r0
         YV1xsL0aKD023FfuillwZ3qcB9MvSonhseaSsiLWkScBlOaCA2s3mdI2kBvKree7hBwS
         zTCuF66jImfhEkiGIUv8P1cjypl2ziR+x80fXyxoz0Zm/Up+no+yC+OJn8FmtDHjGTql
         H6yt7tI8DTvpoPd8hNE1eRpZEjButzMMQak0CD/iP05MOo3AbN8OlKXglp+S8XyTSvw4
         wztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919105; x=1781523905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        b=GRZTmb1yaVBqWZGxStCn2cE8TkAMe7RTPlTDZ/Kz+UZWLvf2VZKTsjsZaYnUeslUOp
         zSu4tMIIoxod5qM4VSpSpLDMKid7bISYJWVL9ETqI/oPO8qh5Hd7OZ1YO8GFc/mAMi4n
         ynn1mdJQtAxDwg/yjso9EWGCQnydVY1anwvnue1dJmcEN01187xgrV7uZ1HtebVbAEPc
         5NtTQU7fwTJzfDGetjZIv04ByCcRWVq/5j9XJD7it2/ivGlZlEveHlY7RlXvQaAYpz1h
         cq1l0M/13z9ywAz1UlbCU3WUUaiIKeB1H8fdoe0VF4k+BrYAvSHOnxwV4CEqbJvkZMgd
         dr/w==
X-Forwarded-Encrypted: i=1; AFNElJ/TnkoqKWBpZlhRWT0zMLyRjbmm7YMCrO7rKKSzev3VfOME7udSM8RXEnZqVLo8DWDE+H894D/NLAccSYtI3eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrFZnzfcGw4lOX6OhI9s7aodzgMOtGkyBpMmRllRX3Kd5uu5o
	QzUqCWbm6u8tJJdXp+ajgiNH0RQyEYwtnGlDcWotRVL7N1aDcW7+ukMtmEZUVQeRXctx4U39/eS
	EhXVVaYn+Zgd8V4IBCpClIfmXxDMUTh9L5AWvjDd3HBnWP0C32ym3QaLjOUSO5i47Fx8LH+kpUk
	qxB/BFO7JyD4LCUeR4HXsa7UP+CPNfYxP6VRojRwrZvagnwA==
X-Gm-Gg: Acq92OH7mp9Ro6rs9mISquVVQNfCnoJv0U4cxyl8GGIqMcy3sH7d1HGn4hibc3GLK9c
	DlzXHND1CI8ZYXJfTIzlfoOLt3bLx7mlWcDKD+qfG1xP+yknz/0K1LqrF6qIqv6msNKVBmlRcvM
	qzA1uB1moKpe2He7UzbgtF8osBK7RzdwE+zkLI8AEne+0Sz5CLRU97PBY0oLLwUpLMi+hR8950z
	5X9rxq31jCxt0u1Sgnf6yJK7LR3tFyiUWG9UVaRW7JYx/vvTPzt0Poqr06Gmbic6hslJfaZAME2
	cEy1s/dWS9iTq/10py45ctCAVJxE8nbC
X-Received: by 2002:a05:620a:170c:b0:915:8f76:8005 with SMTP id af79cd13be357-915a9dc9a4emr2367273885a.47.1780919104817;
        Mon, 08 Jun 2026 04:45:04 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:915:8f76:8005 with SMTP id
 af79cd13be357-915a9dc9a4emr2367267185a.47.1780919104401; Mon, 08 Jun 2026
 04:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-7-82681f50aa35@oss.qualcomm.com> <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
In-Reply-To: <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 13:44:53 +0200
X-Gm-Features: AVVi8CcIivK2P5dE8YRtSTP_9u8m9dGK-3gXU3su59C5FvR4dQPnW2soKiKG5MQ
Message-ID: <CAFEp6-0u1DBhXo9DCie5HCGTjcduWcHAiifVo88vFJwjYcjCog@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: R1veCcBA99uQYhV557SI9sBVZLn55Fl4
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a26ab41 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=4LeufcCx7mgyzPUJGOcA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: R1veCcBA99uQYhV557SI9sBVZLn55Fl4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExMCBTYWx0ZWRfX4sYL/SD/4FxJ
 8qDDZC5BK7X1BzpXhcPrwaCee4aJrM9DffP7p+TBFrOqgkLlfpKDXR4j6NO5QboWnJt6+uLVAcz
 0s76X3ffx2IHRDYtA5+Vx/e4YgbEIuoP0WnCuWLJiJ/KZeKBnmEyx3KVEL/psVpWQEWezCwb8qX
 8TpTwxiQZm2Pzap1ZCsn0N8+97qZMcIMLsEaWLhCOPI6FF1IhBQljk13KBQaDNUHGD3FspR7CQ4
 nLIuhQnD253Lcv92uVBRKytAky6kICTaUBTgMXUxd4rllybkGmY8P8CN5AKTq44tCM4WgeB1qCD
 JfpU2WXuRyrSCdNPq9MKXIXGJIjC6loDVkpljqC/xcvu4Iyeb0TWyrfXU9GRUtu2SFy2unPRMm9
 ZHyAwckWmiZHfCJ5OJm5iuy0LU/nI6NLQnoGeuujRc3kRNwcI/E+OJfqyx9gLrpZQWHulb/OsWZ
 AHCFjE0lh24nHOAo9Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080110

On Mon, Jun 8, 2026 at 1:29=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 6/8/26 12:50 PM, Loic Poulain wrote:
> > When the controller BD address is invalid (zero or default),
> > set the NVMEM quirks to allow retrieving the address from a
> > 'local-bd-address' NVMEM cell. The BD address is often stored
> > alongside the WiFi MAC address in big-endian format, so also
> > set the big-endian quirk.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++=
++++++++
> >  drivers/bluetooth/btqca.c                          |  5 ++-
>
> Squash mistake?

Indeed, thanks Konrad.
