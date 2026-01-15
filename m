Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182263101B4
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768518745; cv=none; b=ZFH58OMsEAPmiN1eTRwcqa9PGXEyJh7QeAK857VQNP50+pRlAwcVw3lDdZYxqiWHo2iuW/SioeGsGl+gYJrrzVA+KZo53+8WWjM6Bk4U881Auf/4mE8FJlHd4+jSW5ygIzoV01PYgLgPbNmCkmg6ChOXEhYq+JcVshMhnSXArdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768518745; c=relaxed/simple;
	bh=+vYCoxBlHCmIb9+N8+clsz4ZqJCKn++evp7F1k1dWwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUVCr86zQhu4BsE9Et+FXZbvddZyUH37ruFcBnsgbf+R0ANqTj/movHsn4lum84CLRnYvi1qhd6L5oWhsC4ZBs+ZofXuj8kZ20sa/qwcAVOaj2FHPo8qtmRLCEXkaDQonK8B+oQBIU98x13Uh4OwM4Zh20XHf7mkOoRn+zS/pHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TbrH8Ljd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HPOsb2ep; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TbrH8Ljd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HPOsb2ep"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMgS224015934
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 23:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cvaa1/tuwQc8fuxNHVmVUCj7wH35/l4L0WpGJwMFaIs=; b=TbrH8LjdaYzw0BDP
	zBbrhF2vk9OHDMhRmgjMH97zr937MTa1+gKzwgIdPHILykOje2irunIABizwcvtp
	5kZiV4+YfjaUrewFjX5y/SVy6IyiTIKzmZaa09i1LKptaQLVTO15Rk1K2vTP3Cd+
	YzCwAdXM6rW1gwSKEmch7TmfiA6Q3pGY4enuAJlm3gj58Y0qjSdy2OIl2x6XCnmY
	SkGSTi+72sVkBW5fvWbRVjAlWijccbPjq21BMPx5EQyvYJj7JnMW0DYdjVuzDur3
	/Em8/WEmwDq9Lj2x/GdIUOZ4PB2tZugDAdxRpaGZQhCvKzN7RPYsktkjyXul4gzs
	TFx9EQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq98y81w3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 23:12:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b0588c6719so1751440eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768518742; x=1769123542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvaa1/tuwQc8fuxNHVmVUCj7wH35/l4L0WpGJwMFaIs=;
        b=HPOsb2epS1NzQWw/DQym7HtHS+OY2bFR6SZZYp8/uXNFObtM4kiIqwWQG5UFyikJ+U
         x/h3x+GpUf+fUtEaZm8s34B1IK4Y3t2zglTkkl4KqFRqkWPBf8/dY9U61BWR2t5AlCET
         V1MM4SbtknVfFAt0J8j8xLzn8FcSqfkmryO4MkdLiKIQhuVL6yOoT950sK/3ujLOcJ7J
         th1epjyrAK67cXzeA3xoyqxv/HuxgiZzu1kTsmeV0dAO9l8pxdBYv5FzDUdgu7fzUBNj
         VxsqqIefu1LIEEicv3V0Zv3eJMs+LoAJrMZSppYmicW54ov7l77jEHtxkWTJ5sAlYbkh
         fWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768518742; x=1769123542;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvaa1/tuwQc8fuxNHVmVUCj7wH35/l4L0WpGJwMFaIs=;
        b=e4566pw+v+ERu+9TpxrFp3TaOpusgzMmMtyO9FbV+n6vQ0K1z40plFBOGpZqVnso63
         Ki802QZBTvhzvQ+JlGF/8yOJg+x2cj8iapPEyZTBZiSQm4LoQKacWHaSnoLn/O8mTBNM
         4YsdSoJVcJ1To/NAWJFWWPOX0RLTBohZUCIwQGrUtlHGT2JO+mzoxhiZ4bHOibTTrHI2
         /FE+JwnaEnRzvwppelNBa7VQ+ohPElBo2nClSCCnas6hlQH4Nu2zjAQ0JYtVg5DMst/I
         /3t7jnBtT9AVgccRjLhAzCgb+9QgBry0qTLfGmOYzHIGuYSYYcwBMuLG2CclLN4Ku6Ky
         SmFw==
X-Forwarded-Encrypted: i=1; AJvYcCWjZruQZUnrQTUJre2myhFrdq57dR5n0rFNQQnzymp/WOz6KhTczl4jB0e86PaftsJAz0j6IpqDlt2Y9JfnMEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcA7dYeI65XMqTVjhgUJ4UTzD9glie1wgH/21hcPD/57q741z
	5G68PbweYERRqknk7DqRB5tM7m11qVCrQ8AiJeEbwU2TImtsHMo0ji0it2GN4pdL0S27UOCD3+o
	x1+RiX/RM5nZX0I1ilrfQTEaMEhiasBt7aTMhRvMxtgGk28AGRsEnsi55R+JkSSzgCscIHrc=
X-Gm-Gg: AY/fxX6xgK+H/CXLl1pkO1tqLtAW+W4ZMroFLEG0gXirvcv/YM8AqpdkXkhcQ8/bhCn
	AbWRnYIo2AeuC1wFfL57mEMn3qxEryS2zQgj7TsQoQFZratoQ4ZqrCGbLNax/kPB0fScK8deoiT
	516keDTL7ZtHtClzsCqpTQR/NqbQ0Dv2tYGwgg4iU+rQIcPWkRgQ4L0YBgtAcBz/AWxk4lmpFOI
	eBjaCdqsC2B3pe/555bUdykZCwC8M6Q2t1mCX3u2+c4Gs8Oqc1fWlqK/U3/CUI/IrzOYSrBADQp
	OFWx0qqw5Gh4urkxHtNNu0EmPhto3KLX5iZ9d25lattcWaiwZMa4HbEfy7mtusZBK/7QVhmP/q9
	264S4tpOyTzoglr1eqRtL4ta/TqmeMt2R9QDj9SeDG9xqYFKUaf7OfQIaxPEEZvA4kjJJI1iBr2
	Ea
X-Received: by 2002:a05:7022:6708:b0:11b:9386:a38f with SMTP id a92af1059eb24-1233d10f432mr4751886c88.22.1768518742029;
        Thu, 15 Jan 2026 15:12:22 -0800 (PST)
X-Received: by 2002:a05:7022:6708:b0:11b:9386:a38f with SMTP id a92af1059eb24-1233d10f432mr4751870c88.22.1768518741492;
        Thu, 15 Jan 2026 15:12:21 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm691860eec.14.2026.01.15.15.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 15:12:21 -0800 (PST)
Message-ID: <6db7a42e-7f12-499b-b36e-687ec93b2e62@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 15:12:19 -0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FscIPmrq c=1 sm=1 tr=0 ts=69697457 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=eymIdBAbIQs2YkQ4F90A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 7JHUJuMAvn8mHiJNrJQWhXAtU6pZ4-Cl
X-Proofpoint-GUID: 7JHUJuMAvn8mHiJNrJQWhXAtU6pZ4-Cl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE4MyBTYWx0ZWRfX9Wh8BdXHN3k0
 oF3VVTNDXtgtm1s64P4sX8Gmb3XWyrJHw4bu0SISaJ+1Pin+ES+djamx1LWMu2t0PTqvMP9Ocx/
 ZZsZa5o4HEQIJGOmHkQoPSeMpMf+JODr2aOI5t2iLkGXIdaHKvpnSB1g7HG4dixoocZiTfD/lBZ
 gjbEogczb19kd7YwLZqfFZQQtAr+t3zNla46ZzlUHaDo7/9v51RAZWZmw8MQbxTgIWVu6b22gNQ
 8UNxn9RaAovu7wShoYi6yzR8ui0yEKgDEfwkCWxuiBctZquVlYjaLREBjKy41NVm2adJ1BhyZH9
 C10Wj4SYaS9nDvUh9M1z2mz+vUZx5pcwFhRvKmK3eEcbKLbbV00IgtrlPVRMiJCX/pzh6aUn70L
 ShOeo4BeJZBev0nvsRWYdri3GEyKhLoccZBCP16uiyx80BI2qbjQWa+qGmCZE5izFFQJlDrGffX
 tI7mVDYqyQXBkhlvATw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601150183

On 1/5/2026 5:01 PM, Dmitry Baryshkov wrote:
> @@ -1023,9 +1024,15 @@ static int ath10k_hw_power_on(struct ath10k *ar)
>  
>  	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
>  
> +	if (ar_snoc->pwrseq) {
> +		ret = pwrseq_power_on(ar_snoc->pwrseq);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
>  	if (ret)
> -		return ret;
> +		goto pwrseq_off;
>  
>  	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
>  	if (ret)
> @@ -1035,18 +1042,28 @@ static int ath10k_hw_power_on(struct ath10k *ar)
>  
>  vreg_off:
>  	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> +pwrseq_off:
> +	pwrseq_power_off(ar_snoc->pwrseq);

in this function you conditionally call pwrseq_power_on()
but on error you unconditionally call pwrseq_power_off()

in the below function you conditionally call pwrseq_power_off()

so there is inconsistency.

note that both pwrseq_power_on() and pwrseq_power_off() handle a NULL
pwrseq_desc so is there any reason to not just call both both functions
unconditionally everywhere?

> +
>  	return ret;
>  }
>  
>  static int ath10k_hw_power_off(struct ath10k *ar)
>  {
>  	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
> +	int ret_seq = 0;
> +	int ret_vreg;
>  
>  	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power off\n");
>  
>  	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
>  
> -	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> +	ret_vreg = regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> +
> +	if (ar_snoc->pwrseq)
> +		ret_seq = pwrseq_power_off(ar_snoc->pwrseq);
> +
> +	return ret_vreg ? : ret_seq;
>  }
>  
>  static void ath10k_snoc_wlan_disable(struct ath10k *ar)
