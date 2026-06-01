Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78F33C52F
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306955; cv=none; b=Bc+Je5OiXPA26ZHCqFkt7dNQ+D4+WRT8PAY9/NobgbWDFinj10uiEHD8a/hUVf4cSjhMFSsI80eHUXlsy1kWi9fbDSjmBT523JbAIQ9Rk3+HJvIKxTc4Vu+SgSO46WyfRhyNmNVLMagFnq9C9GsBVGuEG4t7cvT5x8MFKCKF47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306955; c=relaxed/simple;
	bh=GJdFHNbd24vHcHpJljwueSqIzVPfc/WEbuiOwFgJpts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRMjxV1eBmMkGIU5E49NiR5s9hXGYbgzDANzZv/y4ml/H99DSWfOiJC0rIQnHTMVx8IBESxyvbbXvyYJeZdIFhR9JIsAZemllk+vvEdOZpmyQASXlHl6jXSoFDXSYo/IMVlVSbDcAY3155Waxs4JNnn0ex/h4Tkd48QtQMZCaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ew2pxJmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RYtatS3q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ew2pxJmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RYtatS3q"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6514fHZV1641315
	for <linux-bluetooth@vger.kernel.org>; Mon, 1 Jun 2026 09:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3SGiO+kxsDx6DwtO9BxKEerL+bbS9WThv2hNXn8BiyI=; b=Ew2pxJmGwa3YvmSH
	w0oDOjUPL/Fz7snMtECVftPwaZ6ByhVBvahSKl4v4akRAfmnKOf29lqeW/mOE5YS
	KBtS6oRebHw7XiUb0k7iNxbLX/wPaboyMS3eelp5htBLVorDNzw+d/8+Lj0omRwk
	HGakgcg4WvOJRd2NrnS8J9NVfZRwCPf+c0+58cJBLud+oEJXoXs93Fj4RUtPY7tp
	gvLr9gUzi+kVfEqkuqpdo89chQC/6GKkfCkATVdzm+AugaFOcvXU7FJuk/MtxyXr
	hdUeUPkUnouot9RAITeNaHlMm00SyfSVgBte81bATvQVpb3bsCh3FeGsU9hiWrst
	Xi18ZQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7ff0cf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 09:42:32 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423899d6f8so983227b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780306952; x=1780911752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SGiO+kxsDx6DwtO9BxKEerL+bbS9WThv2hNXn8BiyI=;
        b=RYtatS3qxWbdbnHwKQkKGqKqlH9TnAcqmmBGT8Md4Ss6VQi9ri6LKq92noCDqoUbM6
         3GyYTbShd4kJrUC9N4LysOaHRVMpRg6968wzR/tKfStQOD71c4N+EBwt97/JyTQSxdYe
         RIBQtu2AG2vw1OMAjeX4krcA5GOlzg4tf2VtnXBd6oR6WgBsFaUHXN6oFDemVkD6F3Fs
         NY2NpMsmJzKCbOVW0bYCYbg8wPPWBYGWBrZ4o/MuNodrt5H6MEVqVnrlaomFHiA1ITkK
         0VU8SQQrOTIPO+032gI1HBKisvxSy2yj/SrFN3eQdAV5J8wvWS0vIVLA8ZNuAk2v0d4L
         Z4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780306952; x=1780911752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SGiO+kxsDx6DwtO9BxKEerL+bbS9WThv2hNXn8BiyI=;
        b=Sl2BruwDL6iNeh8DQjYfwE+ZOKYVSkaFlv0/Ge9i6xPK2Lk2CsIEiW/S6k3gMiNAlh
         eG2T3zj1mWbbMtenk1KpHETvRUsirfXZDuvLLKbhGKvTd1NjmONOTeJdL/48RCYP8SWJ
         aZZSmeOlmEYA/0CwIQs+s6H8pzU1sREYpK56fgS3B7G80f/nHxdiWv9bUIoX/twVWkdu
         +fOe6REotALUvVEikGDQmyEvBPnPnuiAnw3Dum7CSktyI04hQ7utAHAqRMkYxe5nfD60
         JrwLbBPZ52djBSRlWzULC8mljmAZeVI8nj40DbzD1iIDgZLtYr76KtTa7Yp9NCzRPDHe
         XdhA==
X-Forwarded-Encrypted: i=1; AFNElJ8U8Psza5xrwImiLVmFSSYHAt+RzVZyoZBVjoNcHUQes+JYMsGNVoOA9IOhDuCKvP7NK5/nkw8646CC/BFx/jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMyDmuEUb+FlVWe7+1NRzNWOKbgpiUKYhkLjuDPjv9tFEVkTMt
	/kWZH4tWOt8EWy+F8MP9XEEmow8DVrdvYleF8PqgNTMGG7QdrH+8v72ukOtBTRGHv1lfxWCiy6H
	IgvRz/Qm7Lm0/UH1dW74K2BdDgMyuaUp0EiROo3onVVDL1dBwvxt3t1mt6L37dguZxtxXT4w=
X-Gm-Gg: Acq92OH3wpb5gIwqXckAUUk6Gb7c7b7/SNdRvPcFk84ThhSLW7Wu+VB5pUno5EWc17G
	0YII/gBhiC4+imCDjsaMfMR5s1i0rUwCgbhPl6DHkJZWouJ/fROTSXZIl1fHAWad6MC5t9Dbros
	VUa3MkJYLY2KReHfZEGEPbXAHkiWm1j5ILcETbpmyWlQOhdV5g2bC4brPBcpy07U+sracznQnWL
	7yrxJ/ywbeluu3wFym/JSSij+5izVDpDdIU4nAdSoDrk/+hGg+pcUW/NmYJh0H8tptGKbTP3mhn
	uNaq40bhaTOq+0boVfG5fg1RNOBdnAujAt0YRPdRq18KdXdIP9rTQ1Q5/VJdhBYrjNgRa+TT6tA
	csV9aUgqmcGIgmWE9Kj3jIr7PQXhcWMzJ8vObPfvnng3goALJtVUGSOnTwflv
X-Received: by 2002:a05:6a00:1a94:b0:83b:b0c2:17ea with SMTP id d2e1a72fcca58-842255b4770mr9702275b3a.37.1780306951629;
        Mon, 01 Jun 2026 02:42:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a94:b0:83b:b0c2:17ea with SMTP id d2e1a72fcca58-842255b4770mr9702237b3a.37.1780306951172;
        Mon, 01 Jun 2026 02:42:31 -0700 (PDT)
Received: from [10.219.1.106] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214affce1sm9867516b3a.9.2026.06.01.02.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 02:42:30 -0700 (PDT)
Message-ID: <83c71ff0-bbc3-4a1f-b18f-ab31dbf3e19d@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 15:12:23 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Bluetooth: qca: combine NVM and calibration data for
 QCC2072
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        rahul.samana@oss.qualcomm.com, harshitha.reddy@oss.qualcomm.com,
        dishank.garg@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
References: <20260529180431.3373856-1-yepuri.siddu@oss.qualcomm.com>
 <CAMRc=MeMm2rmeMOg-HcFY4ONvNbrS7qN=ioyAezRhurL_9Vt1Q@mail.gmail.com>
Content-Language: en-US
From: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
In-Reply-To: <CAMRc=MeMm2rmeMOg-HcFY4ONvNbrS7qN=ioyAezRhurL_9Vt1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SF0Rs14a4DW1Xd_XQFF1UJGkt_SfR7cR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5NyBTYWx0ZWRfX/O1zB6Bl7Cff
 NgAKKhUQ19nZwXNis5Nys1f58xLwYYv2gDwaM6zExp2w7Djce3u2BVxuucyOvypR3D0frOdnIWa
 yDHLRyEur6R5XEY10d+O7Dcnj1L9uHpv1aTgTubid+a8tBHNoAkDbV10tNbDRUP9kPzPHuAkYH4
 lszg5rR8b78T6S6JVSS6MU3Yj6f27EByF4zbaT2D+7oeODk50ojFhCHnzmpyFZlAxmzTKpQw2Su
 d99f4H9yHyItJPlhyXpk0bi0VEAxBbtFhX2hR3SI8N9OxtrJTvG6OxyJJFQ8ojWLzNDgA8PrbDO
 kX7iLSQefQcRv234X4bxTCuTZ5QoATygun5/wcsIZmbmpOqZxhGO2ihzxU5mNkl11P9WhJnxNuB
 uo4XgPgB3D+s828uoHWaOO0z/QnMFjGat74oNCPFrLx6jgnFE2uIdbZJPUw2HTiSKHiIj/cP7my
 p6XLhRzRTXG31i/oYgw==
X-Proofpoint-GUID: SF0Rs14a4DW1Xd_XQFF1UJGkt_SfR7cR
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1d5408 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=50n7NBc1zfqpnd1YZTIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010097



On 6/1/2026 1:59 PM, Bartosz Golaszewski wrote:
> On Fri, 29 May 2026 20:04:31 +0200, Yepuri Siddu
> <yepuri.siddu@oss.qualcomm.com> said:
>> QCC2072 requires the NVM and calibration data to be delivered to the
>> controller bundled together in an outer TLV of type 4. After loading
>> the NVM file, load the calibration file (qca/ornbcscal<ver>.bin) and
>> combine both into a single buffer with the outer TLV header before
>> passing it to qca_tlv_check_data().
>>
>> The outer TLV header encodes the combined payload length in the high
>> 24 bits and type 4 in the low 8 bits of the type_len field.
>>
>> If the calibration file is unavailable, fall back to downloading the
>> NVM alone.
>>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/btqca.c | 47 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 0ef7546e7c7a..37db1cd9e8cf 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -612,6 +612,53 @@ static int qca_download_firmware(struct hci_dev *hdev,
>>   	memcpy(data, fw->data, size);
>>   	release_firmware(fw);
>>
>> +	/* For QCC2072, combine the NVM (type 2) with the calibration file
>> +	 * into a single TLV of outer type 4.
>> +	 */
>> +	if (soc_type == QCA_QCC2072 && config->type == TLV_TYPE_NVM) {
>> +		const struct firmware *calib_fw = NULL;
>> +		char calib_name[32];
>> +		u8 *combined_data = NULL;
>> +		size_t inner_len, combined_size;
>> +		struct tlv_type_hdr *outer_hdr;
>> +		int err;
>> +
>> +		snprintf(calib_name, sizeof(calib_name),
>> +			 "qca/ornbcscal%02x.bin", rom_ver);
>> +		err = request_firmware(&calib_fw, calib_name, &hdev->dev);
>> +		if (err) {
>> +			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>> +				   calib_name, err);
>> +			goto skip_combination;
> 
> How about providing a separate function to handle it and avoiding the
> objectively ugly label?

Thank you for the suggestion. Will send a v2 with this addressed.
> 
>> +		}
>> +
>> +		bt_dev_info(hdev, "QCA Downloading %s", calib_name);
>> +
>> +		inner_len = size + calib_fw->size;
>> +		combined_size = sizeof(*outer_hdr) + inner_len;
>> +		combined_data = vmalloc(combined_size);
>> +		if (!combined_data) {
>> +			bt_dev_warn(hdev,
>> +				   "QCA Failed to allocate memory for file: %s",
>> +				   calib_name);
>> +			release_firmware(calib_fw);
>> +			goto skip_combination;
>> +		}
>> +
>> +		outer_hdr = (struct tlv_type_hdr *)combined_data;
>> +		/* high 24 bits = payload length, low 8 bits = type */
>> +		outer_hdr->type_len = cpu_to_le32((inner_len << 8) | 4);
>> +		memcpy(combined_data + sizeof(*outer_hdr), data, size);
>> +		memcpy(combined_data + sizeof(*outer_hdr) + size,
>> +		       calib_fw->data, calib_fw->size);
>> +		release_firmware(calib_fw);
>> +		vfree(data);
>> +		data = combined_data;
>> +		size = combined_size;
> 
> Otherwise it looks ok to me.
> 
> Bartosz
> 
>> +skip_combination:
>> +		;
>> +	}
>> +
>>   	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
>>   	if (ret)
>>   		goto out;
>> --
>> 2.34.1
>>
>>

