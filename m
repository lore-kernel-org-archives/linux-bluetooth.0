Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD9367B8A
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208244; cv=none; b=dB5RpKRJ/Ta6PEl1GF3470k9vBgxlODSW5KgaygCyiV//hnXja2nkgquZNgaKafsSmmC4NMwcfLygMwIpR66LQUqk/LBFrPnEXElk3g26pkbNlyR7vucbZifH5r7igfIGqawRlgP1hazfO9HhXyODxY9JQKBaWAbW/Uxd1gr0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208244; c=relaxed/simple;
	bh=RhUUx6BUaYkSBmMt0zOtLbS0iKXmm1tQVHlbLjfXbFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfPd2ZInFQPas6jR/Ng20o1GOybR6Nm9zu9oDB2PAiqSy44/clYZlV9/CiVVIV7p7NJdqKhYdGAG3rZiL1mKLhZF39AjucsXe/SLo/zgewDWEWCLE/+uPVveBwQENYK/1myL88DegvnxwB5tuDAuOOGSt50pEWhD7ShTTH7A1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QFvXQz95; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cEYPMiGw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QFvXQz95";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cEYPMiGw"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N9KVAk3919007
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ilriAldCns+2pBLaSJhYKfD8whI8LAAJ9S0Cr2Qrx10=; b=QFvXQz95eMIHgyRv
	MTFGIKxFs/PnBj+duiaDJtG6yz3FEDZZrPUHOW+lkPqzyVwObiFtvsBKkyEEicT8
	sBs/6bSth3QdcvuUWsOWMapUJts4mG3glyyT852FL6jxHauK8mpnU237FgfvTEUz
	xY8T6eikglZeUIWd4Kd646UljOsX12/bHMK2GdbMp3MNY0mzWqbSQMDiGPWKkvKj
	ljYEIOJ4LhA24F9+mBbuAE08FsIaahakvUOOIM9db1RJ1K7nI6eX4Jc2D4F2DA/S
	u78B179vaQk4DefYockmJccFXym10CteZaXHR0RIJv9N+Js5J40Djibfhb0bpf7N
	uD78ZQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe685gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:50:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8423ed642b5so167177b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 02:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782208241; x=1782813041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ilriAldCns+2pBLaSJhYKfD8whI8LAAJ9S0Cr2Qrx10=;
        b=cEYPMiGwRF95p002HVCMGeK+XPOHk2G1HwBXc7srj8RmUsqegP4qhydKOo3J4e4I01
         MK4+oPLz0A4hOxyGINQnwfXTlixbIOyZFtVg5zFaxBXzFRVsJpbYxl6B15TI8OiUR4dp
         r/W5cm0Wv3FLW+wDyZ5gM5rbL4JvYeFnpnyaMcdXKG5z+FG8pIpe2/4In9jM5j3JVOKJ
         ajel/f/17X4mMiairCOIISVo4wfSNYlYh8Uq+cICCzzaogeyrw9VxjDZANelPe6YNcO8
         IcDrWrWDFkFrFEjOpnn5ZI1XsmnqBTJzc3oit2dmQK1AJyQRT92M+oyWtnFPvqYesYJ3
         yHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208241; x=1782813041;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilriAldCns+2pBLaSJhYKfD8whI8LAAJ9S0Cr2Qrx10=;
        b=p/jAMTXugaHO2jIjj+KuQiq2y348s1AmQnG/pGOmw3TxtSwf8+AvAogF/lI3XhQnOr
         LWcyxjk0zHT2AWVDp/1hZEdzs6gdbgypsURbzYjvf6boMC/BQqDwVte/hDOzzBlcMOYE
         XYEXPBtSV5Ju4p13js4amaJzXBrYNK2HaX5WmZj4ljLwwCwE0GgBiElDSHtATg3/GO92
         R+0PwYql9cFOCFFUH6m4iaZqkfc+n5J0lYCKxGbyE1Hz/AVP4Wst/IjbBQvVsC2ZXQD/
         dG82uCnNX3Ar0QfsitZzikZFOqWMZc0nWc5xVhoQwURdZsTF7I1tRYAN3dtDKtcYWc0l
         YkWg==
X-Forwarded-Encrypted: i=1; AFNElJ+wFV75bPntvj7pTtcM2s8yviwukEnWJ+0DFQdp+c63uFN7n2VjZ5FmNFBWYFambj8/LrhSeURT6CFnkckGxqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84TGsEXW6eZlECC/992DSMB+6KCZgp5keP23KlOZr5AQL9Gfl
	1k3qQP6MvlokGbFVfj+L0U8/WnHu7w7FaW5cf+DDqDiCz6Ek/dvnhm1rLC2zuSHBUuikzSStoAC
	+KLGLx5rzu9l/qUYMLRpV5D+mAcg9CNCoD+8CJulnXpPNGJyRaYVw/LHY7GmGiOOxLSSdWIw=
X-Gm-Gg: AfdE7clYKqGfGFLsVMPxVKx6c8te2yD565CjouERRJHAN8F/lYTkQ2AbgbLjdT9hbkE
	S2bUkEU37imXPj2GFdP3TyW4QxbEUrz5njqNaHBBuP+A0jU6cORXy3RMxnEAjbtrHXZ1K6tP+rK
	13K3u9pVnPyHydx0/WEoSPw6+qkWT0lm8Vwh3q5ehcRa1UcSRYW/oQx0/f/3D8sRn6dZA3/y0NB
	3FWmyWAkMU8lE/E4ZeuFyJpxG9ZeaiB2Zx0oZUTeb5vgjld9g7avbicqDZ8HL881b2bBw5JAbU5
	OOvs9FWT0qvSkZvnM8ftEIl01AHYS5c3Q385rqGL7qjuBRwV3ZESbO5EEhohuxXPlfSmKCQFVHK
	gcl1NJxYwzC550Lz4H0SQ4lWjEU8Ejx7Pnbyno/vAflO+eeY50gmmBJRMkdlJlbeJKwVWrlgvoK
	TiCA==
X-Received: by 2002:a05:6a00:13a3:b0:842:2d2c:2b58 with SMTP id d2e1a72fcca58-8455fb1481dmr9502018b3a.5.1782208241528;
        Tue, 23 Jun 2026 02:50:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:13a3:b0:842:2d2c:2b58 with SMTP id d2e1a72fcca58-8455fb1481dmr9501992b3a.5.1782208241070;
        Tue, 23 Jun 2026 02:50:41 -0700 (PDT)
Received: from [10.133.33.161] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d89bf2sm10016372b3a.16.2026.06.23.02.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 02:50:40 -0700 (PDT)
Message-ID: <b9e649ce-3306-42e1-99cd-02f86d77d200@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 17:50:36 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] Bluetooth: btusb: QCA: Do not populate devcoredump
 fields on ATH3012 or QCA_ROME
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-4-11f936d84e72@oss.qualcomm.com>
 <l2ri4yxwtxv3r2upconhgsblespvushzeaqcvwvqulracmvfr4@qsmzp36emi7x>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <l2ri4yxwtxv3r2upconhgsblespvushzeaqcvwvqulracmvfr4@qsmzp36emi7x>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KZMyyaGTp-mmYvrSOMw9hbzLFCG_n0lJ
X-Proofpoint-ORIG-GUID: KZMyyaGTp-mmYvrSOMw9hbzLFCG_n0lJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3OSBTYWx0ZWRfX9rOU/9LFZdf2
 99OaNMil3OJMIP6Iu4EhuWaG5M3PZniKf+EIs/iXZbL1/gJ5wsQhPyMTgVduF8grxK701AHouE8
 IjpvTpc7JosyxiU6nRfvm5Rgj3JmlYg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3OSBTYWx0ZWRfX0iRrVPLKaUiu
 PUDJ1cg5CHI0bU2iKJwG/v+xlPvuvSWqgnIN5G2m34c4pdmrCq8OwdSmj9DWunhS7pFDKyNC8v9
 ltVqr8mPo0rYQ/KRBga0nMS4PKnxEVHrxlqT5SSeuWdWSD7wHelAxS/gqunjFOHEDVK7yruW1aw
 p5AA3lNlaGuEr83L6fYzTnEfjmelD+cpTCeo6mKOZgUGkRHnd4hD8gfLZCTTbu+m1bmaXZwgzVO
 gGEL8UJl+uNXUZjxkmAXx1879edFootcsDJgF6xljGeVWozevnlgcmaoq+V+E+sj0umG5cYsly3
 Buz7bXjuuXtB18UiLFhl6vi0diUwFlI/VSdlaetATRiC4t1tp+2UoU9I119WMhOLa04nR5eUKfr
 szZlvetJbdg6y3vzoMw8gLdt0LwUHFG6jBocix7/A+QYh6S9QSw09a2QQqGtlhWTyejs3N0NOz5
 l7KWyrtuk6xnwerrPLA==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3a56f2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=r4DXEafDs6yR_N-SMUMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230079

On 6/22/2026 11:31 PM, Dmitry Baryshkov wrote:
>> Devcoredump is disabled on ATH3012 or QCA_ROME, but btusb_setup_qca()
>> used by both unconditionally populates those two devcoredump fields.
>>
>> Fix by populating devcoredump fields only for BTUSB_QCA_WCN6855 devices,
>> which are the only ones that enable devcoredump.
> Why? Wouldn't it be better to enable devcoredump for all platforms?

BTUSB_QCA_WCN6855 marks the first generation of QCA BT SoCs for which
devcoredump is enabled; all later generations are enabled too. ATH3012
and QCA_ROME are much older chips that predate devcoredump in the
Bluetooth core driver — there is no requirement to enable it for them
and it is not clear whether they even support it.

  Will optimize the commit message in v2.

