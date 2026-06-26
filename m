Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC223EAC89
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472834; cv=none; b=crvctOwpBwR2fw3aXDUJaLiHPNhpktKtwijqMS5K42qYOdqgRH6cNdV7BlXsEbPwlviFvrEBrdYOOBVpEiFIig9lQwLd6wjpj7NIYsRY6RWCUqOBVxDg8OuZE4Upy5rAfIe4c9s9qVsSzJuIYX8BimCechlISvYOdImnWjMmOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472834; c=relaxed/simple;
	bh=AODr9g7jG0ahMDR1iDWx5Ha4Byxlb7oWkWpK+6uo/Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7wbuW0OIXWNVPFCor6czbDDzygRa3QwlOmQpk6F/SiRw1PUUPpwMsi9Rz7G5zQAQ+A4pIH+J5JSd/TUqAwtfs7b+Ot0Zxi+WQOEylLFYyL0PmnqQ00U0cmlufGYCWy9Rxq1vMRL+MzXI2hQW++6DEg+HXS9SRl5EBfKH+PLdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g1zAlDyz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jngTtTGh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g1zAlDyz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jngTtTGh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAcipr858269
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	efSmsLNw8E+yGzrU4i9rfMYqOeX4WnsvoEalewcGYnQ=; b=g1zAlDyz9+fjFEn1
	eSLwg5hGzrK6g6mloSVh46LugG7GsSngDqO0kgNgdgND6LIRSGZXWL+6k34xsLaa
	E0GaUP01R6u7FDeAt4tY85T8+QZC9Ph7N8Rei1xnQJsIR4Vaf0ua58e2H44b4Vh6
	zsRya1YcadyGXUZMluRvvhQ3xB43A6rLUrguZaV8685jFOP9gawXuLDp9oJ8QMW7
	OZ+84CuflpoD+EzVf5b1tTB+t28WxZTCyyJYKTn0OQHTifpEoRseAGg/nOsISOI3
	y0d18VYFI12DOixIFrZ37QjG1Eex9Dm9DVSgncvQo/ETUDKXO6Ar3QOaNKB6pKWH
	lA1LTg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1p2trhce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:20:31 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-734f236d7c2so34667137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782472831; x=1783077631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efSmsLNw8E+yGzrU4i9rfMYqOeX4WnsvoEalewcGYnQ=;
        b=jngTtTGh/QW48K6XX3v+hysyuC0lWG7i7XbvFodzJ6RQXMEwG8vU9VMJ4Xy/BXVo6f
         xCxLR6c+EsRhbo69q2Ci9HPbvLvSCIId8YEthagyCWaqIrY1G6lHlk1FIW2JWx+J2t2K
         Vb6zK9TO/HsLg8NzOPbewohurkuzvZUDkV7wm3G+avBk90kvUmZ/WPUcePtwJz1FK3ek
         hDxXDGWh0jcEFC1qDIVtBsF9/QRym5+xr6cGUErs3w1IBK3raav2YuQZXCAFFEfbUzCJ
         9OEp/yoLLUkAZ1W2jaIsnYzVT0jduRtYpPZQmHY2nRVBa47EdfbxA4wq/wsEP/0fg34l
         JLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472831; x=1783077631;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=efSmsLNw8E+yGzrU4i9rfMYqOeX4WnsvoEalewcGYnQ=;
        b=oAlakLIvNgwl7/O4ziUHsGp2PlFU96ZZCICDVdb1yCUAnVvdG6lwRDAXR+cuEUIpdY
         OQd1j7OwgP1VU9iPQsG458p9ZPVyLxV5APZNOMwAf/H6ocDikRzc8NsW3pFaa32wTO5z
         oADkhh9JAWu1MTkXc1XEvTnXAVUgE5yzY4cK3I1VuX0zeIicmy0cAYQeoxWypYSscpW/
         RROAeMJQwLaWQwFcNr6+5mYfXdPgzLmQiedCRPd6KkS+nigiKDVHepX03RblYGsblAos
         On6PW2TS28kYIJjTwwfe66sP7pNNscL3DnVc+BvKWj3lKzCoVJqLSkiyk5assfCIbvH6
         o6cw==
X-Forwarded-Encrypted: i=1; AHgh+RraEDDCv24X7QzJGAP6WJtBI/cEBTN16PBikZRNONMoISHZK45wPwEwhjln9jHKXNPlNSl28T9o0QNQCIw235U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzortw0C0tjpK4nvH9TZ/fNCEI66P7B21SS6MlA8BgpHOzGJVIn
	Crcf7isRQBujJKrUI4vBYHgsXYSo3v/akjTsEim2wpXsO0vgUU/z9h4La4BqnypCjuEu2IZc6Rw
	u2PpZuuEDgAUOWQn8TD6WBqY43SHl5OceI779hNGdW+MByW8HMhKdKB+y2oWdm5OSpe1xX2w=
X-Gm-Gg: AfdE7cmHB8sHX1bQzomiFpnEarUR4Fe7kskQTBzXhLmLuVchYBilqBuC3v6ndXiGNFv
	DGkRhmBVnGrOz63ybILsVWqQ4nHB/jFrIgQfRuOkVeA79gKrP/4raFi4hgBgniEsHTGF5q/o10y
	E4I7p+LDUp53XXVuUSDt2xgABjpH38Gx5XizJzrVJMbdmnpOwmTWEpnnQgTI8E1WLlJzfRypaZf
	b3tnb9LQGUcFYXG2wkLOaFVprCrei+8fKZI3Cb8ONouiancRW1xYR4Eb3wi+7BP2rKvArWU/ncP
	+3brOuH/MvZN8K7gPhYUIYtUSLEnsb9FJoeMm7o/FsL9SZDx+t13dTBIm3Cro+dNdD76WjXJME4
	qwAHIF3NXA6cpeeytYCasQrsAzuHjXzcbo9w=
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1071155137.1.1782472830787;
        Fri, 26 Jun 2026 04:20:30 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1071127137.1.1782472830410;
        Fri, 26 Jun 2026 04:20:30 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ade18esm2731485a12.7.2026.06.26.04.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 04:20:29 -0700 (PDT)
Message-ID: <38aceb33-b28e-4994-b277-de070b6dae2b@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 13:20:25 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] remoteproc: qcom: Add M0 BTSS secure PIL driver
To: george.moussalem@outlook.com, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-2-d999be0e04f7@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260625-ipq5018-bluetooth-v1-2-d999be0e04f7@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfX4+kAyGyfA3nB
 v137AymFnB2WWUqQ7vVuM3ifM5hz1tHAkQd52NlMDz7zvnzLM7UwrXyOvv3s5sQ3iw1kk8OPGD5
 PqLUzLioe2QkNNKMLlaYAHI+SqRh6Jg=
X-Proofpoint-GUID: tlpflD7PYodkWzc2WkbZdE802Lke9AgA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfX6/5+E/7BeVIk
 +qxwoo62r8LtX1FZgFUs7Q9rxN1wYMW0rYF7MBD3eAc4X76j7BuqTQpdVEux6lFOfLNPyW2k93e
 9rF4O5jwpZDOtsA+sO+7cHoM9Pz8EOwvuspTzZaiYWxp3XZXEDpxRaffrFOqLUA+O4brhh4+qVY
 X156uqHwX4RrCqitNK3/MNMkDKyP7mxbM3YMud/Y5zCEznWqxgCkcJrx+bESt8fWRtPsREsQ9Vk
 ZnunieXiDfZGKe6yiRLcACBqFJVc+DlcCbMSBfr1Ui7pgOZi3sPvk3IJRiwQ/kaTcfSrTNsqaJ1
 vuLDn00OKKh4+k5TM5X8Q+eoYQyTXY3003DQzDIvqZJqZ8hnaoRHB8hgXZxF+6VX/7MxmVKx/xs
 q9DLlnLfE1hwjR1kQeY7vkCp6GlBC4+C8ohTj3rqQavm7dOQEi5n12MSa4N6YkTVmAnF2Uh8GBH
 e1kQ16hFQyVvBDku7UQ==
X-Proofpoint-ORIG-GUID: tlpflD7PYodkWzc2WkbZdE802Lke9AgA
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a3e607f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=UqCG9HQmAAAA:8 a=sp8NEORZx8pkfp9qRiAA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260092

On 6/25/26 4:10 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add support to bring up the M0 core of the bluetooth subsystem found in
> the IPQ5018 SoC.
> 
> The signed firmware loaded is authenticated by TrustZone. If successful,
> the M0 core boots the firmware and the peripheral is taken out of reset
> using a Secure Channel Manager call to TrustZone.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Can this not fit inside the existing PAS driver?

Konrad
