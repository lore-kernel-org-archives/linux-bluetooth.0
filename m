Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989775231
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473891; cv=none; b=opeLxEfgYT8p+/6HiMhg84Af018v213T/pf/D8w04jy+qzHD6Wks6roBt2PVm9RCAlCmLAa2asiG6JA7LtdzNeeW3H7lNP6X31iNn/zJPr8nLEv+fG1f4NVo6sNmSecPpEGFi3kf/6vhkddAtstrZI4F3RH8HX2s15S6eHcjJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473891; c=relaxed/simple;
	bh=nLupr25MRAZ65ybje2x7oyJ4G5JSTtVUnGmjp+y8LlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDTgGtOoF/k7h0hwJodz3e2cmHYNsHuLZ2hZeHYR4czlakG8MfxxCUWxyWWFssJ2oO/262N+FQxPzlgFKJxGkv2sRYfRyo/W3zVMPrlEjxf5hM2ppWiW2/M2hPXcg43GnM/vPzBnKUy1CPNSqMUKj3caUANSXlPCwwCTpFwuxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kxIuYZs1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxIuYZs1"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so1443041b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713473889; x=1714078689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6w1AwsUFW9J6FKabv/Qc9yhtQLwMSDV+eKMBDKg3rbo=;
        b=kxIuYZs1kDQzyYjnxLgiAhWOIDtc3QVD/TAPE6tEJqsVRbPzjQald4PgO1CDjtlHu+
         lGtQSZO04M444157VIwz3U+TGs9tiVS7hVjIAue95T2mbDElLgL1n5pp0pAkB/ZR6UMy
         glPvD80kAMfCJ5UdaIouez4Pi/ANQRRPgQE/oKPZvISJiwNboFE0Kl5E3JYFF3Opjr/9
         ctzScOuIAewSyl9S5s8ehRJxYukZhqvu8d7PPjutLubtaL58cnArD5bCTHIveIOlVpO/
         kJdbBiembgoUVybOSVrfFGzVyRVg6YpAoZwIu9vHi7grEm7d327lA/usSZgDTYxO/jFx
         eR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473889; x=1714078689;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w1AwsUFW9J6FKabv/Qc9yhtQLwMSDV+eKMBDKg3rbo=;
        b=qh6sHvOkxEumROcchtZzbNp+6sFb3so+Eo1UJm4/egzLPGOzwpLDiejyWUk7X1TVEn
         RoElS7ybsvPcD54SoAobyv48ddSVoBDtMR2u2I2zCpIRnWZmVEteyvVGOhZVwxjxij4T
         AwzFvhafqYCfPINwkuYG/qdH4pgLe/FmSARDb5B45CY/vLwG0k7HawW1vZMP3rNJ5kH4
         VPs/dfSw+39XbH54G5eb5h7Ccp2FgQdqBlMskjGPy51Wf5AkYKrPYeCzCtIVoECY4z3f
         DEuCJWGTomSreQy9a2mk94Am+mC8TwR10Zv3cv8Gf7QHt/bxYF0ycug6+cqqn9hgsmNL
         z4AA==
X-Gm-Message-State: AOJu0YwJZGJ+BlQa51/HrIGPHSSRnwpY7hVlqrVo0HeALggma/qP1tqr
	xR1QPuuhoaewpb8tRE055ITcybTjrbvjch0Qn5Owp4dbZhQBwN2mIoDT3UbhNzk=
X-Google-Smtp-Source: AGHT+IHRQId49Ubi0nyBaD72lg9WmdAxq5viZMdM1oJbP5zwOI6DNWhxp1yqHKCO8x9/wr9Fafb/Rw==
X-Received: by 2002:a05:6a21:19e:b0:1aa:5993:88f7 with SMTP id le30-20020a056a21019e00b001aa599388f7mr460233pzb.3.1713473888877;
        Thu, 18 Apr 2024 13:58:08 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.146])
        by smtp.gmail.com with ESMTPSA id ei55-20020a056a0080f700b006ead47a65d1sm1928567pfb.109.2024.04.18.13.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 13:58:08 -0700 (PDT)
Message-ID: <93af3308-d70f-4423-a911-0f437f882462@linaro.org>
Date: Thu, 18 Apr 2024 22:58:08 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Bluetooth: qca: Fix BT enable failure for
 QCA_QCA6390 after disable then warm reboot
To: quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 bartosz.golaszewski@linaro.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-3-git-send-email-quic_zijuhu@quicinc.com>
 <7cd6f395-1f1b-4a73-840f-d70fff5da220@linaro.org>
 <8751981b-3063-4228-bbec-f36bd544e0fb@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8751981b-3063-4228-bbec-f36bd544e0fb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 22:34, quic_zijuhu wrote:
> On 4/19/2024 12:48 AM, Krzysztof Kozlowski wrote:
>> On 18/04/2024 16:06, Zijun Hu wrote:
>>> From: Zijun Hu <zijuhu@qti.qualcomm.com>
>>>
>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>> serdev") will cause regression issue for QCA_QCA6390 if BT reset pin is
>>> not configured by DT or ACPI, the regression issue is that BT can't be
>>> enabled after disable then warm reboot, fixed by correcting conditions
>>> for sending the VSC reset controller within qca_serdev_shutdown().
>>
>> I have trouble understanding what is the bug. Can you rephrase it?
>>
> Think about below sequences:
> cold reboot(power off then power on) -> Enable BT -> Disable BT -> Warm reboot -> Enable BT again ...
> BT is failed to be enabled after warm reboot.

Still not. Please get someone to help you rephrase it. One long sentence
is not good approach. Describe the problem, how it can be reproduced and
then come with brief explanation how you fixed it (because it is not
obvious to me).

>>>
>>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>> Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>> ---
>>>  drivers/bluetooth/hci_qca.c | 12 +++++++++---
>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index 160175a23a49..2a47a60ecc25 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -2437,15 +2437,21 @@ static void qca_serdev_shutdown(struct device *dev)
>>>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>>>  	struct hci_uart *hu = &qcadev->serdev_hu;
>>>  	struct hci_dev *hdev = hu->hdev;
>>> -	struct qca_data *qca = hu->priv;
>>>  	const u8 ibs_wake_cmd[] = { 0xFD };
>>>  	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>>>  
>>>  	if (qcadev->btsoc_type == QCA_QCA6390) {
>>> -		if (test_bit(QCA_BT_OFF, &qca->flags) ||
>>> -		    !test_bit(HCI_RUNNING, &hdev->flags))
>>> +		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>>> +			BT_INFO("QCA do not need to send EDL_RESET_REQ");
>>>  			return;
>>> +		}
>>> +
>>> +		if (hci_dev_test_flag(hdev, HCI_SETUP)) {
>>
>> Commit msg does not help me at all to understand why you are changing
>> the test bits.
> it is test bits not changing bits.

Previously we tested bits for BT off and HCI running. Now not, so you
changed the logic. Maybe it is correct, maybe not, I don't understand why.

>>
>>> +			BT_INFO("QCA do not send EDL_RESET_REQ");
>>> +			return;
>>> +		}
>>>  
>>> +		BT_INFO("QCA start to send EDL_RESET_REQ");
>>
>> Why debugging info is part of the fix?
>>
> they are reserved intentionally to print critical info.

No, it's downstream coding style. Please don't bring it upstream. Or
explain why this deserves informing user. Drivers should be quiet mostly.



Best regards,
Krzysztof

