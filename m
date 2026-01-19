Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF33164C2
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823117; cv=none; b=Hl86t0VaNrezhKNT13n5U24S0JpQ/onK1bf0f1r2Mek/c8QuSI/Hxb/qu2j+23krYUdc5t4LeWEM7kcvZXwlzZTk4JK4+OAMBoc+rGnIroT9X8DVzL8SCmDB1dgx4CZ+t8znmbTPTcqRHpXinliFepyC3o2LwLUhaiEKwrBIZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823117; c=relaxed/simple;
	bh=umryTibXcEQwLZ01ZLSgmOnDPdofWJThj73ttFHadAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+9f2PriJno/M+JH/8ULaTTAa1Rt9T7jtFMANMonU6BfqdJ6JyLR441bq6du6HIeAOYAM8rWCd5QUKMRQ8q2nj6WZXKBqRZ6Rg/ltU82KA4qgCo+wSf+XPHXclNw0DN4xutIhhT25rLBu7SvCQ6+NtWtR54fPg12Nw5wNQfJhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZasSyb5P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DJpoQ/MB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZasSyb5P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DJpoQ/MB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDLut1440822
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/eXR7xA5LS0QTGw/FESYvmdD/IqbbhC/JHHaNFog5ho=; b=ZasSyb5P9baP6bMm
	QZyAsG7eOqPxRNO0n1+7OyzxTuJHEDJGdzalmOBMlWzwhvjyeWqC/q4zqdkB0GwE
	fOp0jw8o4qnMfatdTsLJFOtLMlvvRkGqJ7ctSF5Z+kIgvb1xaJIaTExGnTXM/vjr
	xNY0mwSdwRs0zcWK1tiBoMJAvSPU03sHEWLLXUNhyEzCiGMpQf+oT9W6GH7E9VsW
	yopMYoGEYNiXNgPDZUGKzEPTGmYlUOKTsOMJ5UuTkYKQni5Bggonz7qOK1Q+u1fA
	IXf1ACXWsnAb5dOYwXOYsOFXyX602KMFAhPYnbxMpn2vmjdTDf9ZJ4Mqj+aibiE8
	KK7lKA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bskj3g2nx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:45:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ec823527eso7459506a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 03:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768823115; x=1769427915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eXR7xA5LS0QTGw/FESYvmdD/IqbbhC/JHHaNFog5ho=;
        b=DJpoQ/MBTuMYll+RsGxYpXUpIgTNpphY8vCQs+nxsH5UxA+xUXP3ou55+WC7MElE3E
         7P5le0yfJa++/11vuzu4QWOV8RiiXgcmEkO9dFa9pwe4hSntPCx2Lraocd4b4YWyzHii
         sOBjwj2I6MFKA+GEQ+KSvywJ4cqcm87MMd0DLtjoYjOWl6o6tOl9FHPCROomvbKrnL7K
         lzWO1pbu+WtB1mk7DX1VVv9JSWElsaMRLDBxI+VS49jx9V2I2Xp4CWlSDhcJrq71Vfma
         4AjIqTj+A71/KYZTk6mfiKXAN8Xrs6d0/eh1coYTNy5ZPExV4wLCf0DlNbyNqCfU8eNC
         u7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823115; x=1769427915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eXR7xA5LS0QTGw/FESYvmdD/IqbbhC/JHHaNFog5ho=;
        b=dpkt3A+acfMJ2tKykDfxfL5supfAjGlA+ZwpHlT3QgtUdnS0gVf37huMF0KH/rnzk9
         Yoaj4NyIPfb8dYfcgiSGNjrFiq3Y7eSwYHlUwkUM2vJXvhaURO10E+fDMTobtRS5uXoN
         FS7/sNgge911crSicL1HYAA73Ii02kD+qV8YU6F0cvq9DloSiD8MRlMV1iCuj6SnN1rf
         GAXlA6u2FkG6JSDA+OxaUgoa8wuo8LiNHadvbCqcyi5RjcAMr6y0Gd+lQXq59UEeOIrn
         CsSuiFZ/9lmTniXxtvih2iTpgn1UWb6CrjGSPLoqR1RypC3qwWjOgf0UNvnL/Uer+rB3
         7lBQ==
X-Gm-Message-State: AOJu0Ywae18OyGpA0hXD5BBBLTcW1LAUq5be3KTpILqMr4Y2F8fzoPkX
	u/OJJqPmgAUe6pnt8BMBB/rlg1Qqk3RLuG3RKu+cK5bGttTFqaom0jEGrGydDh2SB9XQNRBdoXn
	48wiK7lN98I6kBs1SKQl1DsuRNGx6e0wWZ9EUVFX+wFd7GNPYbgWzL+FNI4jfmJPgHEXC9tY=
X-Gm-Gg: AZuq6aLF0QFPHnvxzXxjsHUJ0qY6uzT4qib9xB8YKxmoEtqI9eI4M6nOZXhAenisNWn
	zKk+mCPgVd5sO4Q7tRevEtaRv7TMz2BMD3RDGU7Muo6zs8ItvAPs8DGGwKc6ZzGAddF8l4jzRkU
	Xwf0fVPaxxbzt+BlYjNXPd0iK2xMnkPgm4fBg/GC+IPomtTP2WEnVBhAlmtJw93rQHr2/gf7/Gx
	v6tuJDp47Wxbv2s7XFnAxvQELggmz3epmBZ+ZUosM2Y5OmRGA6WxMBh9GHx7QBaQskOT7OzBRvw
	tPEFk7chv3PojuXEuGj7TFzEnZOdfmdJmZmsJ9PW162l95mEft475tDPRCQa0RjbtKCgoANryWH
	pR83KsJYe7yZTLAKcOy7KNVMRfAs2NaXbTy8=
X-Received: by 2002:a17:90b:2750:b0:34a:adf1:6781 with SMTP id 98e67ed59e1d1-35272efa0dbmr9463644a91.9.1768823114534;
        Mon, 19 Jan 2026 03:45:14 -0800 (PST)
X-Received: by 2002:a17:90b:2750:b0:34a:adf1:6781 with SMTP id 98e67ed59e1d1-35272efa0dbmr9463624a91.9.1768823114080;
        Mon, 19 Jan 2026 03:45:14 -0800 (PST)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527306d61bsm5934443a91.7.2026.01.19.03.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:45:13 -0800 (PST)
Message-ID: <c8a3969b-696a-4a44-acac-eade9a4d79ab@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:45:05 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btusb: Allow firmware re-download when
 version matches
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ds7Wylg4 c=1 sm=1 tr=0 ts=696e194b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XLcW7MSiMK0kOx3OsRAA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5NyBTYWx0ZWRfXze2XtcCWUOtr
 eb0McgBPuIPEBSUhPvBMg8UCPJXZBJVG6hzchGf1LtGCD+fvGfms8kg1k7U6AXDvsTwDikggJQX
 JrMFt4PSovi2Em5qvC86fUPSESC+lFUd4XXlP8tdf/qyPDyndYZcUqrC6bFWJgOTZOE1nLbumNo
 qgAmp1t2z9iMgTXzBNBnzrhVEZpQRb1EGL5Hkd90rliIfIrYwL8NimV7BahEhaiV1yu/EoYiamO
 3Z651BkQbBLqUSDJLbh85c1g5A4nmFI7O4+TaMMv6Izw2Gjbjv80CRY6CJMD1CfJCRoZuBuZiqE
 ANYT6bkqC/CldNHUmAPbdlTNQIZbUxy3lqcTC0xpqAQqTYWWmMxBH+znOLzdjWn7KkSMhhXzzNg
 wPaguucp7/OmoSP1zfLHmpZmfKAdLum8y4OF4PpQutrghV42e660hg/3iH+AM23Z/wNAzLEQzUg
 jUa8/lXOxNXDH621yOg==
X-Proofpoint-ORIG-GUID: HBBiRftxOV_CM6CRNAsUdgh2E0aSpIWw
X-Proofpoint-GUID: HBBiRftxOV_CM6CRNAsUdgh2E0aSpIWw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190097

Hi

On 1/8/2026 3:43 PM, Shuai Zhang wrote:
> Since USB can disconnect at any time, if it disconnects during
> the BT firmware download, the BT controller firmware version may still
> be updated even without completing the download.
>
> When USB reconnects, the BT host detects the same version as in the
> firmware file, which prevents the firmware from being downloaded again.
>
> Therefore, remove the equality check to ensure that after
> USB reconnection, the BT host can still download the firmware.
>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>   drivers/bluetooth/btusb.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 646de80c7..991064a25 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3503,7 +3503,10 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>   		    "firmware rome 0x%x build 0x%x",
>   		    rver_rom, rver_patch, ver_rom, ver_patch);
>   
> -	if (rver_rom != ver_rom || rver_patch <= ver_patch) {
> +	/* Allow rampatch if version is greater than or equal to firmware version.
> +	 * Equal versions are acceptable for re-flashing or recovery scenarios.
> +	 */
> +	if (rver_rom != ver_rom || rver_patch < ver_patch) {
>   		bt_dev_err(hdev, "rampatch file version did not match with firmware");
>   		err = -EINVAL;
>   		goto done;


Kindly let me know if there are any updates.


Kindly, regard

Shuai

