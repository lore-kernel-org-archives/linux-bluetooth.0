Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04035BDAA
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905439; cv=none; b=EVZhkW5NTthna1Ry0vCtdbTdTYxVKBEv+h9kn7IEP0lEfi2rYF1AvaB9Uj75gKKp81M41B8wVn39GTuGeRChUK1P3XshYIVtPC4fmaFWdrwpgVidfATcGTZmvHoy9GC1SKmnDeMq/ZUPp8Ia4Xt80M0kxbxU9S5XF72ODkhXkDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905439; c=relaxed/simple;
	bh=+ZFT5SSN2ILFuJzTHHHAp8/wqo+MvjOgY1kmQeZuIJE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GFpe7LvE5NbHfpt3OQoZhUY93Kx2/R/8xNaemkcUw5YINHpVN/sPTJdsKHjtl7EwgvcdR5qomcgg9UL1++uUVtNiO1F2YIiTLcybfzVE5kGKTAetinHvAbRfOLQ1BcTai9Rvr6Vs9TMQGgtdCGnY2n6/YrZyuYBWhrskVHIP5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NCldyK3+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aRkFyxpl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NCldyK3+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aRkFyxpl"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRhUc332302
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xtH8W6t0dLa/UkFV99BTBUrbjY5jNv2j/zaSGgqB05I=; b=NCldyK3+PEjNl9tO
	6dbebXkRl/8TJ5HUNwv90D07p252OpLsD+mZbmVC8tMwET8GmgAGxcKbobeSEBCc
	aBGkD7ykG9aADBKlL2mIBDBZ1PdupQeGtH09+UWZJEiOWOmGuikk3gFRxngEs1p0
	jpn2eX5Rbk4rUYMsUH6MXUoz58iq68/4XIqVNjzZmpRvLUIc/LIp6YJZyUhJImC4
	x0GH8eAdNuVZTrVlFJ955qJBnkQ5I+ildlpMbH1udMAXVjMgch0ynH5BW6uKLNvX
	vYHstHnbkXMqZCcx3nWSdbV2HuJLHPmekQpLJS5kWE6KYnaL27G2sbGFrFGdKbPw
	JnMacA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9cya8pq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:10:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb3b0d938dso86048185a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770905436; x=1771510236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xtH8W6t0dLa/UkFV99BTBUrbjY5jNv2j/zaSGgqB05I=;
        b=aRkFyxplAK79atvWS2ZZSndHPxwfN4D/YuX46R42UUTqfrwqTZdbi1cfExQ9u6fSTy
         MPZEAOBw8+tceF3K1twx3HqlDQqW+yj4KtosPgdYGoafs+JnrAd8YSv15XmCn319ir15
         Jus3CZJ93j5yiERZQLzQV8fMLX6gADHYOpKeAg0g5emhE5ej9I0/eyK69qaS3fJgxcxp
         iSR5YEpmjFPBVoaBG0PuBiB40DvLmbLjcFLgeGqBW0wcZrWuWyqBwFIvYcEhqyWngEav
         V7r0212KykYbEVkysmC7g9Q4Bm8/SNX2AIMgaMceXjtzhhUaDfez93Y+z98Lg9ePEBY1
         1bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770905436; x=1771510236;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtH8W6t0dLa/UkFV99BTBUrbjY5jNv2j/zaSGgqB05I=;
        b=pJz+tbKBQ6/uvFt7rF+vIqPtM96iTfaYq6FrSXm+sx1zcAaGIzvMOlPxwquexK5l4i
         4QEZIy7/z0Q5FoQUuS7oBy3TvM6Gq7KyxGrmVNc+dgOrpkrtEKH3BX1Sbj37BeXUAApI
         Hid4N4hANlN1J2OvGFpNVnshFqWO8lwiT2pM6eTC1BPd8kSm1oPodMDF61F2VCDMnfTb
         Dx18cBSa1cTUzkI7QTPp4ZoyKePUcuLMwX7IlZWtdvaV0SHi8lBx3C7tC4FL8nHrLFIo
         dzLy6BvhBJw5076Twua0u5K9XbmV1b86GjXm2jhNtsbAl7n1yErfJ9wVHCxEfREJShNc
         nwqg==
X-Forwarded-Encrypted: i=1; AJvYcCWW7AJkRvIKxu8eRM72TzxR46b2QmS+21mH+tsODmPLyWOA5YZGZMEEhUH86tB5fd4mBBvuwfu4OT80iDmutTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznmvjdUUg1eL97uHyKd01SQW4+lmFZMPug08gENlWiUDVzogb2
	JVOQC+ptm2sXYWH09HFJ6FxxOz9menT6UmtCmCQ63RJJVa1CiTNtQkMp6QvdTW1BhTua7N/s0YU
	bCyC+x4x3amVXhVqj1Nfm9pQ52kSQXpmO2E004jTB0jnkb9/Hgjkx3hKP6Gw5o8uizKOxXNL4JL
	LPWIc=
X-Gm-Gg: AZuq6aJDFKTWT1w9lvXVwej6LQlq0J6Yguw2SP1OsLXuyNSqkVH22a5IqGkUyZI0cCQ
	amTH4hExwXc+QWyflYaIu1anHfEyPY6GMcJXd/PWiDrGyFXqpplucNi/P/rApdgH9fkLonJgJz1
	yZ6NmawIANEj0DTXbUUzTW3nJyz3gWSXgknx8fY7OK1xmRiB/wrfw6QEwhHggkMtJKCHPbEbLLa
	lc+r1kbnRTOtXuW2GFXq3s7hlOVtO6tVmGd5Dy3WvCfBn2OXoaaopT8EgQOF0RLtUYPWpzATUbg
	9y4NbTmjo+s+T6sP/phUQAG2VkW7JbIi9ACHLg7FrtIbJHJEjjEKSYWJa6YkAwaR4cZPffanwNP
	448eLJFDKP2363zspb22EDCMei0AjPotxQ3leuxjZxvWG+HaV/9eqthOaqey8Va7MlS49lnzBah
	a+6C+Od+m0cAqinTFYjZF8Shdc+acPgVrkRfx1nItBA5GmO4Qi9YjgdAc9MLEMsq8TkFJl+v3T3
	ZiATFE82/L1qLr/
X-Received: by 2002:a05:620a:46ab:b0:8be:6733:92ab with SMTP id af79cd13be357-8cb34d528b3mr235214385a.0.1770905436491;
        Thu, 12 Feb 2026 06:10:36 -0800 (PST)
X-Received: by 2002:a05:620a:46ab:b0:8be:6733:92ab with SMTP id af79cd13be357-8cb34d528b3mr235209485a.0.1770905435983;
        Thu, 12 Feb 2026 06:10:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f79c79e12sm146344366b.48.2026.02.12.06.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 06:10:35 -0800 (PST)
Message-ID: <76689c15-141f-4726-a169-2cd6220f3ffe@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 15:10:34 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] driver core: Make deferred_probe_timeout default a
 Kconfig option
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
References: <20260212134646.66433-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260212134646.66433-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JqRIUsmBQrzI9d_9fJ0mKWlicQKJ8FNj
X-Authority-Analysis: v=2.4 cv=OrBCCi/t c=1 sm=1 tr=0 ts=698ddf5d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=5dsQtxWV2Z4VfSVEakkA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: JqRIUsmBQrzI9d_9fJ0mKWlicQKJ8FNj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEwNyBTYWx0ZWRfXxNbDK1TWjRSs
 4chO2+vw+nbrhnADLwczmqx7hD0SgCeTC/Wx8J+cXpWQhjOJEoFvl8VuhlYrbKGObfYSI31JgvO
 50twBtiDjCKHDX3+xstjXOxlZVxtftI7he6u/W5pU/uZ5RBF+8m48pgR4hsJVxRQpX/1cLIEAVS
 L9uVQv+XlkoFiqQTQvCugvtFXaK+a0vgVOPsnW/xqC/pYkubMpi7XhRcC5n7xN4h3UHQhtFXDom
 +qbguOO3AYSFG12oNNd1RYdg8UinVxy/9VLJ5AytoPzbPtOHShJ0EnqklOlyEv6lnfQIIhFPvNk
 dzoe+1rXCsgy34PeMe/Zt3tPH4umVBMecb3j9xStr6SWii03k2VTVKG0+FxL9iRpJiZHgqdhzW9
 Wr2W+uUHTZVgEQm8x1mIxhW+JntWgZZfnZ+HQj8GP59q+T9I2crDVjQxydI5lmJ21lkTYjPGndk
 80mFddOCMZyC2lYylRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120107

Hi,

On 12-Feb-26 14:46, Hans de Goede wrote:
> Code using driver_deferred_probe_check_state() differs from most
> EPROBE_DEFER handling in the kernel. Where other EPROBE_DEFER handling
> (e.g. clks, gpios and regulators) waits indefinitely for suppliers to
> show up, code using driver_deferred_probe_check_state() will fail
> after the deferred_probe_timeout.
> 
> This is a problem for generic distro kernels which want to support many
> boards using a single kernel build. These kernels want as much drivers to
> be modular as possible. The initrd also should be as small as possible,
> so the initrd will *not* have drivers not needing to get the rootfs.
> 
> Combine this with waiting for a full-disk encryption password in
> the initrd and it is pretty much guaranteed that the default 10s timeout
> will be hit, causing probe() failures when drivers on the rootfs happen
> to get modprobe-d before other rootfs modules providing their suppliers.
> 
> Make the default timeout configurable from Kconfig to allow distro kernel
> configs where many of the supplier drivers are modules to set the default
> through Kconfig and allow using a value of -1 to disable the timeout
> (wait indefinitely).
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

I made a mistake and accidentally resend this old patch instead
of the patches which I actually tried to send. Please ignore.

Sorry for the noise.

Regards,

Hans



> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  drivers/base/Kconfig                            | 9 +++++++++
>  drivers/base/dd.c                               | 9 ++++-----
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1058f2a6d6a8..80d300c4e16b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1250,7 +1250,7 @@ Kernel parameters
>  			out hasn't expired, it'll be restarted by each
>  			successful driver registration. This option will also
>  			dump out devices still on the deferred probe list after
> -			retrying.
> +			retrying. Set to -1 to wait indefinitely.
>  
>  	delayacct	[KNL] Enable per-task delay accounting
>  
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 1786d87b29e2..f7d385cbd3ba 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -73,6 +73,15 @@ config DEVTMPFS_SAFE
>  	  with the PROT_EXEC flag. This can break, for example, non-KMS
>  	  video drivers.
>  
> +config DRIVER_DEFERRED_PROBE_TIMEOUT
> +	int "Default value for deferred_probe_timeout"
> +	default 0 if !MODULES
> +	default 10 if MODULES
> +	help
> +	  Set the default value for the deferred_probe_timeout kernel parameter.
> +	  See Documentation/admin-guide/kernel-parameters.txt for a description
> +	  of the deferred_probe_timeout kernel parameter.
> +
>  config STANDALONE
>  	bool "Select only drivers that don't need compile-time external firmware"
>  	default y
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index bea8da5f8a3a..e57144aa168d 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -257,11 +257,7 @@ static int deferred_devs_show(struct seq_file *s, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(deferred_devs);
>  
> -#ifdef CONFIG_MODULES
> -static int driver_deferred_probe_timeout = 10;
> -#else
> -static int driver_deferred_probe_timeout;
> -#endif
> +static int driver_deferred_probe_timeout = CONFIG_DRIVER_DEFERRED_PROBE_TIMEOUT;
>  
>  static int __init deferred_probe_timeout_setup(char *str)
>  {
> @@ -323,6 +319,9 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
>  
>  void deferred_probe_extend_timeout(void)
>  {
> +	if (driver_deferred_probe_timeout < 0)
> +		return;
> +
>  	/*
>  	 * If the work hasn't been queued yet or if the work expired, don't
>  	 * start a new one.

