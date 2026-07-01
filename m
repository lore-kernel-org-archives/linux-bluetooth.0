Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F41367B88
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902453; cv=none; b=bwpgtz66WIjFXyOun0sAZkWKrzRV+lQ/OrOAXtk9j86snFHOq8JwKZcT0f2hdk7Z8qSgZauR/duzciB+Pg5mrLGyYCdGOoj5kqE+wY8R5iipRp3FmCeO/YEYwjA1UTXIrPsqrcNBW7xrEyzZU1YqG7TSKGWqZT6uxhSaJfUOk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902453; c=relaxed/simple;
	bh=HOn0CaCePfNgAAG9q0s3jJIiPvvFTH5KrOgQqhOkSqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d02GlFfgCDR8pPlqAN3C7GAuEr2YpwYTNLaqJUsTNVSyAHrImyV5N7Eo4mX31Ay022lsIlU/BTZfDNGfVoc2pZebH6yZAW9p2eiCHlH2rnk+gL9AuPL899KPyvkV+h0hmYbI2Lxg9SZCwnTVqDuZtd4F3DgknELZad85UXx+vHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nsg+7PGS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GyL4FosQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nsg+7PGS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GyL4FosQ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A9EDB756540
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 10:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=; b=nsg+7PGSN9LMaaHb
	vP7qwVAt0LvmfNhpwCNGGrHCO3fVvstLF7mT3Di+sWTZork4SslT9bHt26h9Mi92
	IaYhXfMfqJWclBMkqxErZVX/sXvQ1vvohbsCRngPa0TuPp5VB+JOzvndmxfZnSkJ
	ieUI1piKVL7WKls80+Aju0hIxcycUnroOorlyO/9M8hEMVrMg9Pyrww7Lxd0qWPN
	ZqzULmqFpA7/z9kemgHxgGkpVUbrJUSJzUqeFMWkqUtdHdrWDrwwRvgol4kD4Mps
	FMcvtl/2AdFVVCEzWSJDZwHSG2iEjIVD+UGCQ4/eUewg5ouFQT6h713Po8G7SAkB
	+O7xfA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqr5ky-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 10:40:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfd1772d8so997041cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782902448; x=1783507248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=;
        b=GyL4FosQWSFeMIENYzn5k8JSIEfI2ZrGYNpC1fKjjmS6BTMlrw4rxicSfTG4qjXnIS
         9+CZ3gwlOkhoeRZcwnQ0b6/iEy4VFcwtGAfWMcCC6SddQdXl7UZc862VOOwZn/5Y34Mw
         FA59JJ+0GbiFvCry5GBqdGRKHBNyXTjoCEPdFTN7jrt7Tp1GF/CsiBad/vFQWNmP2Q8U
         +6JzkSpZsT3BOUv9RqiZzOYkPZcdR0S+7Odk37PqsVEGPqI1rCzZfz6VT5Don0LtgZen
         rSOTEplzWuWhvChXWd4lm9B0fx0lROoKOZLkV5qzDxDiADLi6Fy0zCPvHzltp3aRKxnt
         rscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782902448; x=1783507248;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=;
        b=JJpwGCj4itnEn6EAd8QD4ysWKnsn12d+8InyyNci4MTcZTTy3rv+pe1ZF0WSSAbeXE
         QT1bSnZ/m3EToOHDX4XtQYL6vTubv24K3M9A/lr/czOv3w/PgWoNdohCTTq7hDDGWw4Y
         EA9TkN18TUoPMvV1+k0ygVq01tOgDe0N6IsRqtHrFJUJVR952WgcJRyQh1z2LPlfn0Wi
         0p4xjlo736kLie4pfsAtAhR+VoEqgzwIjmLYQpbHSWI+qNncwXQnUhCDgn2SYzJX1FEs
         CT5Q02pA7a5SKfbMGBWpXooBUsuWD0AAy3KapXHJkmRShVIKQzyZYolpAp9nVHqllVaA
         xLIQ==
X-Forwarded-Encrypted: i=1; AFNElJ837uLyXX/881II55xsuE7PK+kY1gz1GvcnAmTVGXbfpmfy/nDDbotBA+v2d0u9Kxx29kZjkzOIIZMHSafBsiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5PiD/0aEeWdjB2rYKecrYDCS6EbF02iEF85eKm9iiejwTAaih
	YPQW+M7Ht8SuX9VK+ZfPp2bhYpbtadJjmY/4V/CMePVBthnYlTco6D2XvcEZHVPqMHArv9YTbpm
	N5qNNoNEr1SIWyE8+wPb4Ex0AdMafNl6LDU0NhkWpnZ00e9RY+gh4DPCAWJXIdEWNGJ2FOuk=
X-Gm-Gg: AfdE7cn4B1WsmF6dFZfT+/KstxptjfYFaKA8jW7299AX2o5E2K1jsGs8kAOgn6tkP1f
	9fxcJaXbAJ1hwzERdLQQAQ+ZnjZkc1NLfOeBw5ONXbAZqh5XAI2InxZZmH9VRFeZ3A4Mj7iMCCV
	qA9WQ9Xn4QQ+TmO6bGkcoF7CR/8DBTlXRZcnf4DCqOdSMSOYmQtI5HkdsLUwrlYafLDGhbd44N5
	yMlRCrdIAc2P60qJpWJXx7yZdJ/dKVtMkNV0/z6kg85oVMzayTcFQBjc2weiUJg8xgh+xmivHPx
	M9HeSEWQ5ymhPjYCzRB/ztQpnxeWvtsnAosTxvR6SXUm55Mjv0BYuiox/wNLPr8Zs0DFOc5qhht
	IpquNa3gbzw2FtNp6tBz7CJjsN0N3G/HDqX4=
X-Received: by 2002:ac8:590d:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c26b25d63mr7031571cf.9.1782902447973;
        Wed, 01 Jul 2026 03:40:47 -0700 (PDT)
X-Received: by 2002:ac8:590d:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c26b25d63mr7031251cf.9.1782902447419;
        Wed, 01 Jul 2026 03:40:47 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1296b1f9cesm165809466b.16.2026.07.01.03.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 03:40:45 -0700 (PDT)
Message-ID: <175f7835-df18-4bc6-8267-ceef35696af8@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 12:40:42 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
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
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3icLX0Neopq9d_hyAEbOhed145Rl28Hs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX/ZRnCvQQbOkg
 p8YD4kD5xNPfKR35RWcR0rPwMRslnSemI9ETfNTSMouFJNw7XUfzH5qTRelYsTgzqsRq0JOJirc
 twtvPUrQA/ECw0yc/lNnRadkUN/juQI=
X-Proofpoint-ORIG-GUID: 3icLX0Neopq9d_hyAEbOhed145Rl28Hs
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a44eeb0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=UqCG9HQmAAAA:8 a=506_Lbxh6H-Y4vAdgPkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX/SBC2BeBzKHb
 viRKSqGMfQaqYzgPlzogQbxGUHGM7D0Gg2O4NXuUbY/SJXHyuos7IinsHdLfvHD0+h8lHaGummT
 Y/ZPgyoA96/Evn2hudX6zUOO2lqvUSObMcnMYoedibjJ62HM5TBSvL9SDJP4dGvi3mp3jL3gRf4
 T4HKSkImtLZM6ydBEDgBLR3MtGZGNbg0QQZfXCv1ijGm2/iY21dHigIAxXsRnnAxQTGSlSfDkvc
 nedy4SbdZW1ECk7WqXkHQdO/EDE5F+Ux9Fn03POViWPdjAVnVM6AEFmyThltfzM9tdoZaDmCrI+
 HsgWY2MC5iPlXdE5ylWTlsGoKdPq/diN0z1+KHtD1R0R4IHel++KQRjZnkVfkADBYYUGqh1URBE
 7iXACzwT6Z8HuZincnqOJ/firXEVRt7foHE8qqT39alaMuts3Vwc4Ci2neEQy/wGLEzf5ZDzKri
 ha8FY4GyBFg8l7D7vAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010111

On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
> modes which are required to be configured through a Secure Channel
> Manager (SCM) call to TrustZone. However, not all Trusted Execution
> Environment (QSEE) images support this call, so first check if the call
> is available.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

I'm amazed changing this setting is a secure operation

[...]

> +/**
> + * qcom_scm_pas_set_bluetooth_power_mode() - Configure power optimization mode
> + *					     for the Bluetooth subsystem (BTSS)
> + * @pas_id:	peripheral authentication service id
> + * @val:	0x0 for normal operation, 0x4 for ECO mode

If there's just two values, maybe we should make this take a `bool eco_mode`?

> + *
> + * Return: 0 on success, negative errno on failure.
> + * Returns -EOPNOTSUPP if the firmware configuration call is unavailable.
> + */
> +int qcom_scm_pas_set_bluetooth_power_mode(u32 pas_id, u32 val)
> +{
> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
> +					  QCOM_SCM_PIL_PAS_BT_PWR_MODE))
> +		return -EOPNOTSUPP;
> +
> +	return __qcom_scm_pas_set_bluetooth_power_mode(pas_id, val);

Let's just inline the whole definition here - it's single-use anyway

Konrad
