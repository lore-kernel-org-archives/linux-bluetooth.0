Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1E363C5E
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209775; cv=none; b=Sb6pL1q2yQeAvgY88lXtqr/cQmT3/BmNgkfZWP1XajFq6EmLOuHshZ4yZxtR7s/LD9alj67XvVofBIZJS0NBLt1Iz8/pR6JSKgbfv45yMqhrxgub9zyI9dqlBfBEUNbu0Wel2T1MTOEo7tSBC6eaPpY3LVk/1bMY/jCyoCuOkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209775; c=relaxed/simple;
	bh=fzMCN2hg3wLEBo4mLwH0xNUAGSvGhzfAzTQ2cWTZAWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsps5bax7YJAc+p7N3FB+FLDcwIKH/I44r9j0hirFVz7J+BXklriNkldqlhCBROv6N3Di6EfkLS+ljud8qZRN1I1GgfEcANWhxbzISVaAUWZayL7HzuGsGdcaI8z4qBPczjwUNAjFy3ZGrBChuUD932wnM+Adw6usNuXohK4Hy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E7r8FELl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y22CBpBw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E7r8FELl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y22CBpBw"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cb672992200
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NXRs6MrdoTrj0w0L0V/R18YY8MaNcJ8K6DztRAghKl4=; b=E7r8FELljUdqW/Fq
	xGYnWjBY/4rp8+UV7RcIe/89c96sD+D/AoieAjlDDAfY7CKfgjvwLDzT/R7/bOwb
	cZNyEs4FzEFinuL1pMU21ULJ7cRCD688E3oh8DBTlLBtw2+fvaJfZNw6+UH17SzS
	22axJcqLBy9aHPw6+6WoYSXPvkO1PMO98kS9/On709DH3vP8GNXLu1cpGxqvlaZg
	AOh07FcpqSVCNSA8xp91pUBmbCctvInYZqh7qwMf8D7+d5N0uByHbaDxomcZP9S3
	+DgwtSaFVRnjpLaQ9l78E+CGOJfrx1JheMZqHfnppeFrBZfQQFlVZWTK+v2Lx9Xu
	6Ehh7w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey729ux5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:16:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b9e886821so824133a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 03:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782209772; x=1782814572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXRs6MrdoTrj0w0L0V/R18YY8MaNcJ8K6DztRAghKl4=;
        b=Y22CBpBwE69JwvHVRRSUtZzHcqAuA1R1d60KATubWYFf7wyTis34sb7+wZ8GqFg1/V
         xhrZIlVq6cgRQau2YUizAWVJBrw60dOsX8cNromwInYJvYXmuHYkw5Zdy5YIabqltkGB
         twr+Em776z+KrRqGDc/OTF5BwMGooQwAo5zVrUzfexmRFBMD/zMYHGymkGvXALViy8Gk
         E0e+Ol9Q6WBbGPsge6pphU348xOqvvDGg1AfOamOxHv8R4oGMR24LeoX2ChhWrX4zVt3
         0IFhNYElAjssq5iXauwb8sOldV0ULvPNuVKwodN1sB3NhrJv0w7cRXa8FKsuRgPAQ8he
         GpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209772; x=1782814572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXRs6MrdoTrj0w0L0V/R18YY8MaNcJ8K6DztRAghKl4=;
        b=JZ2+uOeqv6tYuWHMTZvjcPWf0O+nHjlEwjDS16cl0gQ70hBX7AK93NwE4XUxxOyzcG
         s1mGsfrYzlFJbjfaafYiRpLZl1B7HJegMP8jIfpiFXK7BHhTvl2qPWsRG7xSWodtJ2Xi
         UcEZNPW1NmbLWrK/+j/Iggr/QQvHZIqZGO9yfJ9KFd/ZPwvAQAfCCq95NLOKt4SNz7uw
         XS9VigGhGTi8LIcE/AqAC815AHyEEo7EbIDQOvfUkrqOEOU/06wfaxslY+W2qr/sDXIL
         10I5jUgbAaq+ISBiKVEeDBA0g6R0QuWFmhnHdFNWakncbfacQeDWIGlEK4BtYaVfD/AM
         MzNQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNQEMu/OVG8heEB34l6f0SnaTwxnjKkdOkofTyX7u0djmnfZaA8uLwgUP5JGj2yG8O+/HoDNsmymAPUVKuHbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnaEvMYv9dmhRo+/3w9EzxN+MO1f6El/0UJM3q0xIBGEMY+trI
	xkLHfYJgeYQjnB6sDkxtjRMN90RHOvP5PARd9aMo6O4vqi12i5udG1F9IcKMsQnJrHCAOb9zKtj
	ot9M+viMuqKNN3exEULZwYuvD9X4kbtWCq8VtYLdXyDbAaW6RUjLiXWq0HfXAqP2oFGpHktA=
X-Gm-Gg: AfdE7cnDsBtDkwQOljCTMgUwmgODWs5yeOYFA6DKXyoNoiynk7no75bH8w5ZO7vJgqo
	pDiB6vtVMHm+ZDVsTz0EiPjeTfDI9acyY+RAN3UPpyBjXJWVqGhR01kDJhB4x1DdHMysMEIh7wS
	CZvHv3PoF3hQV6G08FyVVgeyC9vNHUQoAmvfN3PT73bGQxoeoIDyBNnlVmhsu13hhmAtgkSHsKq
	Xk/gVkzfuqJmQAifs39i01D175+EJ4NsL8Pd+SdkN/fri9bJCV3CVX1fXIMSse+JxvyZ7ZC9Iq9
	qA3qTX4wunNPKulvJMlP0fu2rMtaAXxGCVL7snvyX19l6bmyvhHdPIgxXNToF/UgxwTXQvE+2tS
	auFEGl6ONptYe+nstmxc9V5Qj8nxDxZoLP8p/wvNUq6isIE7qqi1yUnGQS2oM5Q8daixsngMhUE
	gKGw==
X-Received: by 2002:a17:90b:2e51:b0:35d:ab8b:abe6 with SMTP id 98e67ed59e1d1-37dc982598amr2168755a91.4.1782209771682;
        Tue, 23 Jun 2026 03:16:11 -0700 (PDT)
X-Received: by 2002:a17:90b:2e51:b0:35d:ab8b:abe6 with SMTP id 98e67ed59e1d1-37dc982598amr2168743a91.4.1782209771259;
        Tue, 23 Jun 2026 03:16:11 -0700 (PDT)
Received: from [10.133.33.161] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4ed88dbdsm9255568a91.0.2026.06.23.03.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 03:16:10 -0700 (PDT)
Message-ID: <5015726e-5e98-404d-9694-669a159ca71f@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:16:06 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] Bluetooth: btqca: Fix qca_set_bdaddr() using wrong
 HCI event type
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-13-11f936d84e72@oss.qualcomm.com>
 <CAMRc=Mc_hjCPe+aLQhK-ProNuh=4-43mPqqmQNQ81Lu4Do=fGA@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CAMRc=Mc_hjCPe+aLQhK-ProNuh=4-43mPqqmQNQ81Lu4Do=fGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfXwmvgi49CfAbk
 zllNp0Hh0t0NIMTTCSPm06Bxor7pMqK2FZRTKbOB3MCasT0Uu2xVSpxvX5QAKuD+L8jNmgPO5D4
 0Y0mWOSHlmefWYv4y0wCbmldV4zLEEk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfXxj8Enq8YsRde
 E7FO9zaSwwKeE1AGdnD91GRUKZveUzT22SeF9xQ4XKqen/CfHsUmSm9DbjYYfa1uInXCLz8Yq2r
 /7FGTmgG7tw0Ru//9t69PjdO/c2X75uASnf9xnpngGP8BFqNbQ0Y0nlnq2oH9FgqEaiX9X0wqrj
 NtpqM4adHFay4/IRFgvdI6L1tGHT4h9d8arw1x0j2fJuSSwAvnuzTWoI56Ba/eOiwL6xN9v9d1e
 sivMbX/oYN+hd8UwoWNt7iLiDb6f5iJ+DmHSkARNLQpNAOFfJ1gzsVWkn6kX5Cg2xVpUUzsNIQ+
 7qzVHQoFiPRrbq3n5+Kzi5DqB6bOp8pDiX3kXL5z5D4lL+hPik125AayQAjp6EF2ZeRFVeIkWnI
 thtH2eNqAEY3PYqcBXP0wxiMbpHzZI2n0CHVkp2vHmAGvaIcCQ3O07umz4wOWUpgjZnRxNndHIv
 6t/Z15jRIdGlg268lkA==
X-Proofpoint-ORIG-GUID: DAvDMb1bqJ8njwWXmK1ROUKs_vpxiSLg
X-Proofpoint-GUID: DAvDMb1bqJ8njwWXmK1ROUKs_vpxiSLg
X-Authority-Analysis: v=2.4 cv=eN0jSnp1 c=1 sm=1 tr=0 ts=6a3a5cec cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pH4rjQeYR1pnhOtVXTMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230083

On 6/23/2026 5:04 PM, Bartosz Golaszewski wrote:
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> Looks good but should go in the front of the series and land upstream earlier.

Thanks for the R-b. Will do it in v2.
