Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40C29D29B
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201679; cv=none; b=DLf4roh1FrxCDHZjvbLvPzgJwV0+Lq1pZp1HbU9SOB27meSZGDIwNSfWEGs8B0VHcAQA2XMpg7wUDcDqyr3naoXjKNEoNJrTgVZWvGxusJS3HrG17V+v5/DYKiGKDu6Y0RZl4K/5sQ6Q00Sww/Xx/kQ+muSyU7CzzbJql33uQ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201679; c=relaxed/simple;
	bh=tay2nClDN5u0dLBH48Nigw6h2YuZIfWBwzRI6S1sBDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBBBzuunI7mmJFT+bxkH7VkDbOgyiynw1zk/vf37VlgtPWcLvOA5yEsBBu2GJ5oc3yUmzXSVgKaowH2NFcja36YqXp0OmadKQsR52EVCpQnmuyXYbXuQ3mTvicZ4fFa0WIJ82M1MGMzW6gQpxz4VkyzA2+arVp0vsCuMgiQKyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l26DDjCm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=COeLelaB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l26DDjCm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="COeLelaB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BVCgwhB3241473
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 17:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dQHya+Foqa5xy7dPJRKV+36g
	WEP2/Y+pPWS79C24TpY=; b=l26DDjCmDJdDv1YGpSnPc1QNc9O768t6rQXulBaK
	RCDnHrX6vvN8GkKyu4mR5kn2QZA+ABa9AuK7vicm6KmopTGQkLqQJI/ASYMeQ4fm
	zfZ5IFz2n3KdOzdZt6GY4R7Ij0zwNyM/kIBe1pEJYvkj7kp6yUyLOx/Ms9Fc3JiR
	0wmiTOaYW5qhngkjz6bOn7HqXvoKqxD0AhLV03+wPbiFMnVPJj331dUFSzWoCKkQ
	m6Y4Vvww6iD+3ppvOCY5ek7l/Yu+OhguT7Uw2EUN+Cr8ITKjDj0VReZQvHBuQifO
	hdEPl+KeolblAvOyJ1niFxquKbRbMPpIj/qOS74UOT4Q6Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd3v8rfdp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 17:21:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee09693109so221351471cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 09:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767201676; x=1767806476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQHya+Foqa5xy7dPJRKV+36gWEP2/Y+pPWS79C24TpY=;
        b=COeLelaBYDvCZnbQMqSy0DRhEUMXwYFIvFDNy5K/W7Qxg1rtTQ6nN03cr3IUpje4mr
         FG5YGix6jx228fJR4i+oUpsLoLT5h3Tw+w81pAM+FNnxkcbtNDNn5gUjgvwDK5eHrB0Q
         Z+mNjO0v2M4b+pS8MfCqlnvhobrsB+UFM7f6CYfFxdIyNYjl90TuuG+vfaRbofVCBvUX
         j3TjXFDCdJKjLwawQhb8QaL5RavN/kJhvnj1m0r0vNaW6h3PYYQtmAxwKYOwQ4TWOw8A
         RkQoO7VINdbaV5XRKxUwDAah58K5SaNYOcMv/cF2R5xxHxS3mNf3GM/ZQ9RtjIilrwrW
         7LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767201676; x=1767806476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQHya+Foqa5xy7dPJRKV+36gWEP2/Y+pPWS79C24TpY=;
        b=TfvYWIzmQ/go59fqrAZ7ZEniCCgo2/uUcYWlgim5eB57xXkYZqSVVN2s2nzfoh8nTt
         BNPWX2JAEEPXrLyfXbwfggiRMph+GmvblR7sOzpbEJCM2sNtvU8gNxYk4ZAuEP7k498E
         mkAvn+JiST2bXPX1Z7b9HdB3Fk4jSmNGJoKrQfmeylMonIAwX8EOiGV8exfsJDNpaWPd
         nqpwOpF8nt/o9A0Fq/ItAREHtP59UZ+2Ku11uOLl8Jv1wL6JNZF1ZHduadO/7WrRybh0
         NUFifhrwnNR5CzBAfRRCFhfbmzoyqqYjSeQvxOf9KKsVPQjA73x4JvADac+KpLeVuCNc
         Griw==
X-Forwarded-Encrypted: i=1; AJvYcCVYnOu1ltID6zHjQ53uKhnhODazxzLUN21LGqgeOq7QJZrxue4LOZa3fpcNsXdt3LYO96jKveEAO62PuK+tf5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItugaQLMujRlGOonQGnsPFh5wWH/bd4vKI1T3C7Tp6MMeOL5a
	I4MwAoY043C3N45d13AKdUJiB7HeuPrFyOHlOuAPRh0QozGw5W2uL62yPM1vqIr015PGyOFiTAK
	mhpcwn2Wii+z32PwicTAFHaxTGDweaJaAu3doTnL/J1kT8Vd6LO3twQ3zh8Vemw7n2hTlh/Y=
X-Gm-Gg: AY/fxX5xV6w8230FxlKXLbuGA530vTGshEchpqFjbLRSoIpeQsVNODZ6JuAkxr7fT9A
	XHBOaw3C+xND5qIg6yru+ICv95+QbXFjmNbnTOgFHns6jW46Ve/b29otjiV9gTtV4PfquJ3I82/
	UdjXiD22y9RbkJQrht6hMbwDVsicMUJkTzOgC7sfCHqLceNhuO31uVAhPWy6Eo27DtpWgUFMreP
	3pXiBO/0wiqclUXegSzCYO7gYd6ofYkv4cnfvDvnaCq5M1YXBQwg+Y1DCROlPLyuU+sQhi5b42/
	L/9VH+qprznYFwdNktjrF9p44xuxMgF8x8X7GhwQYV7h8nbO+Xq3MVzsNPvDspyk8DwgJEC7Qrv
	YFpRdKcE/qr1aXcpLFmkM4XX5YyMyyedhBcTRGg9X57rLGgwtj7GeghMsIl5mNYr87w1vq6N+b/
	UAIgQm3EEkhklF1lc7N1Tjgm0=
X-Received: by 2002:a05:622a:1aaa:b0:4f1:cce1:fc0 with SMTP id d75a77b69052e-4f4abd2b121mr651869521cf.37.1767201675809;
        Wed, 31 Dec 2025 09:21:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElxxqfxXmWosBcceluFnwcdalenFNVAKYDkaw7p2gGeASm2qh7jN/6til5XY6taRDl8/EVmQ==
X-Received: by 2002:a05:622a:1aaa:b0:4f1:cce1:fc0 with SMTP id d75a77b69052e-4f4abd2b121mr651868991cf.37.1767201675295;
        Wed, 31 Dec 2025 09:21:15 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5d37sm11125027e87.7.2025.12.31.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:21:14 -0800 (PST)
Date: Wed, 31 Dec 2025 19:21:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v5 1/2] Bluetooth: btqca: move WCN7850 workaround to the
 caller
Message-ID: <p6lbkyrdtmd6r3hglcyvmwnh4g4p57utfu2vk7ht3wedwj5ltf@auvclksstmjd>
References: <20251231075817.2611848-1-shuai.zhang@oss.qualcomm.com>
 <20251231075817.2611848-2-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231075817.2611848-2-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDE1MiBTYWx0ZWRfX76chPYIlmeMa
 xZAtb/0O3BlJ0+jVyKaRcMkr5wGgcxY4LYuyZVBdGQLLKnY8TrovzEz9/Xkp/ARLa7s9oIQKHGt
 Vp4jgtV6+mdvtGpK2daM2qB43QdlJ62Wa8H+/r2YVGsIhyG2MkYr+RVFNdvK0vpxcRqj+Xol/Yo
 odi6FjhSMN+0+kzMnGly+Xw/R4EK9wA7Ty0ws62Sk4ODy/n8nkSTMPMv6mVvOerTYlZW0c9moy/
 l33QgDHFHaFQjmltFxTr/4Ve7FxBUGGwrxoONYvzbpR8FuOht678bC8FIb0oLt70R7Ca0oR5XF7
 o9Jq/xiEVm5i7mY/nv/A6cN0lMNic7T89ivTVC6qts9oAyGErvR6ECgeJg39YP0pc6MkH46AM5O
 QKZGRtMm9j0k4CQlcQmmG8fia6+U4mXpSJMLgkfD87qvPy49SNwZwLbpvr4+5OC4bbqDnXpwYnT
 eun1xqtVyHQvfyZ9wRQ==
X-Authority-Analysis: v=2.4 cv=JdOxbEKV c=1 sm=1 tr=0 ts=69555b8c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=sTNL8exjfK1nApysl9AA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: ogtMcA66A5jBl_5NPln2NjLTcdM14yOv
X-Proofpoint-ORIG-GUID: ogtMcA66A5jBl_5NPln2NjLTcdM14yOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310152

On Wed, Dec 31, 2025 at 03:58:16PM +0800, Shuai Zhang wrote:
> To code uniformity, move WCN7850 workaround to the caller.
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 41 +++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> @@ -862,8 +845,24 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  
>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>  	if (err < 0) {
> -		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
> -		return err;
> +		/* For WCN6750, if mbn file is not present then check for
> +		 * tlv file.
> +		 */
> +		if (soc_type == QCA_WCN6750) {

You can move this one level up:

	if (soc_type == QCA_WCN6750 && err) {
		try TLV
	}
	if (err) {
		bt_dev_err();
		return err;
	}


> +			bt_dev_dbg(hdev, "QCA Failed to request file: %s (%d)",
> +				   config.fwname, err);
> +			config.type = TLV_TYPE_PATCH;
> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/msbtfw%02x.tlv", rom_ver);
> +			bt_dev_info(hdev, "QCA Downloading %s", config.fwname);
> +			err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +		}
> +
> +		if (err) {
> +			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> +				   config.fwname, err);
> +			return err;
> +		}
>  	}
>  
>  	/* Give the controller some time to get ready to receive the NVM */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
