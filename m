Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F53930FA
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889694; cv=none; b=bpky+dav3xi/U+W8O+VCH8NFDLTbI+GmWsFBl3C+WcjDWk8np/8NgjN2FUiX5QFtK290x4dEwpsU0hwYQBjR+MKkdmv2jlNZx7i/xZSUFpH3JAgMGBLLlrwpyayVLKFPbxeXkC+O44DzY/PWefIym7vb9MLKGh91KlBGOvX/LA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889694; c=relaxed/simple;
	bh=SSqR88fpb9ksBZbpfRf3fRZQS2LXTpBbW1Tf4Fp1hmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxXsXHwbjgfpW7fwq/qhv8OMnwy2vOfA2l1KTYewJGMywA9NG4sjOrvT2UbwMZHN6f3ivEmpRjdeoqkmdPn+5+/dS14mVaz3owDka01k38CUqK4IzdebzndsF+w80im/VXCgNxESb2nMsFQTDbOqpUTd/t2NBMqDcvun9JmNPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fAXtGcPz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T67HATNN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fAXtGcPz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T67HATNN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGAXUUs3598127
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 12:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M9SWB05If3zXHAGVb92TBbx8PB+hF1CMn/2pbWH8pQQ=; b=fAXtGcPzt+TNyEG7
	vefIl6Rpe+ELeQj6tqsu03IlpxVyQIWbPxx0q4wLu1CiSJuix82W/2O+3O9zdm7g
	BMVSwHozs+EBsK6vBo4PKv+Cu1Vw4oFsjFBSmrVhOacVv3QQxpxmHw0lkz7hkVZK
	Zq9nQtI5bMgHLsbJw3dD1JOt/l+KMSYm8XUe0kGKMNIgkFbTREfDSmP098lvLqcc
	lV/H7ekTGuR7J3LP95AnO+JxzG2F4p2i4dfq0T/bcJXN0uy6kQw7M2BCK73cCIDt
	1R6uc5spekDeMDpVaTbxRuw09qpsHob020TsanvgjWO/w1T7I1Y2V4jRrtSGL8oK
	2cD45w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b35se0fbx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 12:54:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bde2e654286so4102570a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 04:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765889691; x=1766494491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9SWB05If3zXHAGVb92TBbx8PB+hF1CMn/2pbWH8pQQ=;
        b=T67HATNNdSsFkxraYpzYRhoMKsO5JmAT45v1wmMEiF72eFDboo44gEE3XLYnSzCdwy
         892hopgl5Yx2IP/11kQsV4Km9BD2wUJmBjzHj1UQ9L9NxAv+0vHtWlNeKitKi5HoTmU5
         yp8t8Hhc8hIotAoAC/29MpGrYnMQI0eIRgH+72EXb+nQhjyb9Cblo+5Gfe6uKVB6H6XV
         vi9byPVADP2Uz4OkqvEh6BGT09Lf/BO0eFOcF/igXYYXWUQc/2FiSsodmeB6uqtyxNy9
         KAf8zSqFC2KQzf2PKggTcJP6mfxP1UyjlLPrMr01wT3SYFKq8mbRV8TLjK9R3f49zG7l
         pFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765889691; x=1766494491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9SWB05If3zXHAGVb92TBbx8PB+hF1CMn/2pbWH8pQQ=;
        b=MTj3ElLobMMokbM3xnUfekCqqyT6Ppw+XH4PDRi5lz3dDugjz3h8WAx/76zY0dg+Ia
         rsC1WmXh9ARXn24hFe1z8SLa9lmUwa/Tmssi5n3WMP7nnD6xl0UDH9aLJT6HxNXGV/Sd
         y9/Vt940qGAMcO6F9cqqN9cj/bPNh5ICCdqiJn5z6InQU9yuyVujUWFOsi6kWbrKE1kx
         cHgSwOy1wjrL4cwJrMybjCARvwwvM+9yEZFvlt96bzlfzKLLM8mqR01HR+exJQ4Vdbjx
         AsxQh5FgsqvUEdSUD3uQuJr5dARGIAGlTJTvb3C/8a2yq9brfJaO+EBgImnw+SbPnEaB
         SD/g==
X-Forwarded-Encrypted: i=1; AJvYcCXZPUmi5Hccj62jN/Uf3Ao0lrmsHHyTQNfWX9JQzSLAZ4Jx82vWHU5CeaJruhTc563XRCm8ZTMezVavLNW0OLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiy17sTi8s0RTbuSeHhSTQ6stRmc/rdXyiWbEgL87UB3TafiEu
	isUHys6hSnzgsMzJECazsz5WThaa1A1tNicHrYgoAy7Y5C+DT0vWfAV4o5/HF4bFTzlE/00dcU7
	SjUSfKyFTZ+NGBbeoEuOyL09fJVULDKvuOIItlXIa/VstYta0OQd9yXcrqJ8bj3zm3QNBLDg=
X-Gm-Gg: AY/fxX6LmBgLVeHlj6F74Mitn7TOse1X6MFtDjVCNQHuL2Q+zc03I5UEp3eBWQuzyat
	9xPqpswISVMPOOrQYG3U04/Ek2sPmiVwTk1o4Gh+3NPmmmyi8HEkC0HdUc1QYxgSkjfpnOTjTnV
	0em/RS0UhAqoE5GEZSOH+3Zjoy4G4nGz9UZVxIqkzb8Enk1F1ril4owre+VFwYtgC7vFn8S4FLV
	f2gXZmyfY2Xq/qEg83FauMCJyKM8Wu0Cyg8uyoKvv7VdI7fWzCjjm67r+tDJYrk9FkZUiP+GHWA
	6/4TDwstW+86xPVc0eB+GwWDN97+L0+yd3+uVhXTj7Fm2PoGrkUivjcyDNjO/UkmYvAj8sEozPY
	Dap6S1Ahm/U3ANIhM9LtglzLzsfgTC9rAR7LV9xXRQPu6wIwEjNxJ4nbf0pqNtNWwyQ==
X-Received: by 2002:a05:7022:3b08:b0:11c:e661:2590 with SMTP id a92af1059eb24-11f34ac0107mr9164021c88.20.1765889690923;
        Tue, 16 Dec 2025 04:54:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnU0Stty4zuWHkD0ixupltQ2qJSohzYW1Zd+bRg/AdnN5oZOcXL6/wcmVQawVoq31/R88rrw==
X-Received: by 2002:a05:7022:3b08:b0:11c:e661:2590 with SMTP id a92af1059eb24-11f34ac0107mr9164003c88.20.1765889690312;
        Tue, 16 Dec 2025 04:54:50 -0800 (PST)
Received: from [10.110.94.105] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f446460c8sm16583927c88.10.2025.12.16.04.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 04:54:49 -0800 (PST)
Message-ID: <cee7d849-54ca-486b-b168-086e44f1762f@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 20:54:45 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com
References: <20251117021645.712753-1-shuai.zhang@oss.qualcomm.com>
 <20251117021645.712753-2-shuai.zhang@oss.qualcomm.com>
 <mtp3qxngbnlpzk2cdp45ndtecab2h56ocwm6cp5ia7butra55a@bevidj6vdwzj>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <mtp3qxngbnlpzk2cdp45ndtecab2h56ocwm6cp5ia7butra55a@bevidj6vdwzj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BSsXcaUVNhx8dJaAk9v2PVMphuDsq2ku
X-Authority-Analysis: v=2.4 cv=ar2/yCZV c=1 sm=1 tr=0 ts=6941569c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1c6WF0r0LC7BQEIA1L0A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: BSsXcaUVNhx8dJaAk9v2PVMphuDsq2ku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwOSBTYWx0ZWRfX+TzYKHmVvKMF
 GabVTaoQhMXR75i7GWjDDpln1o53BYI6Up1KtbjbAJUS5hMsg7RWXwj3fy2ji/UbUnTGzKszb9Q
 DEbX13rrXPUa4EZYjsN2s0b5sPRdNP3gzqf/wODSTRWzoJwd+qiGdsQUOt4hmHEH4YSMyBAxtG9
 PLLI0FopsKUazPH4rvlmmn3g7Wz+PvbXFcQToPjH5Byzb4wdZ7ZCA/oG2pmoQXTjoo5GHrcpQ/K
 EUZlz1mrBYUW8jo9IhFD00qPgZ4eASbW1p8BTRN3oh+gWZlSK8FTqF3vaLWnc1QYET/NOY5NMKY
 eoEqPIYbMLesWc2bGvPIPDVwEEkHEmSuge9VZ6Y6o6YIBURArcIg3kIHPX4oe6CXTQqiJwpdjUz
 mL60QeOI7+dENv19IUjnUM72MtUE8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160109

Hi Dmitry

On 11/19/2025 3:59 PM, Dmitry Baryshkov wrote:
> On Mon, Nov 17, 2025 at 10:16:45AM +0800, Shuai Zhang wrote:
>> Historically, WCN685x and QCA2066 shared the same firmware files.
>> Now, changes are planned for the firmware that will make it incompatible
>> with QCA2066, so a new firmware name is required for WCN685x.
>>
>> Test Steps:
>>   - Boot device
>>   - Check the BTFW loading status via dmesg
>>
>> Sanity pass and Test Log:
>> QCA Downloading qca/wcnhpbftfw21.tlv
>> Direct firmware load for qca/wcnhpbftfw21.tlv failed with error -2
>> QCA Downloading qca/hpbftfw21.tlv
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/btqca.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 7c958d606..8e0004ef7 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -847,8 +847,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>   				 "qca/msbtfw%02x.mbn", rom_ver);
>>   			break;
>>   		case QCA_WCN6855:
>> +			/* Due to historical reasons, WCN685x chip has been using firmware
>> +			 * without the "wcn" prefix. The mapping between the chip and its
>> +			 * corresponding firmware has now been corrected.
>> +			 */
>>   			snprintf(config.fwname, sizeof(config.fwname),
>> -				 "qca/hpbtfw%02x.tlv", rom_ver);
>> +				 "qca/wcnhpbtfw%02x.tlv", rom_ver);
>>   			break;
>>   		case QCA_WCN7850:
>>   			snprintf(config.fwname, sizeof(config.fwname),
>> @@ -861,6 +865,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>   	}
>>   
>>   	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>> +
>> +	if (!rampatch_name && err < 0 && soc_type == QCA_WCN6855) {
>> +		snprintf(config.fwname, sizeof(config.fwname),
>> +			 "qca/hpbtfw%02x.tlv", rom_ver);
>> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>> +	}
> Is there a reason for ignoring how it was done already for other cases when
> we need a similar fallback? Please extend the existing code (or rewrite
> it) instead of adding a similar hook at a completely different place.

Sorry, I missed this email. I will resubmit the new changes using the 
existing callback mechanism.

>> +
>>   	if (err < 0) {
>>   		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
>>   		return err;
>> @@ -923,7 +934,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>   		case QCA_WCN6855:
>>   			qca_read_fw_board_id(hdev, &boardid);
>>   			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>> -						  "hpnv", soc_type, ver, rom_ver, boardid);
>> +						  "wcnhpnv", soc_type, ver, rom_ver, boardid);
>>   			break;
>>   		case QCA_WCN7850:
>>   			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>> @@ -936,6 +947,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>   	}
>>   
>>   	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>> +
>> +	if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
>> +		qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>> +					  "hpnv", soc_type, ver, rom_ver, boardid);
>> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>> +	}
>> +
>>   	if (err < 0) {
>>   		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
>>   		return err;
>> -- 
>> 2.34.1

Thanks,

Shuai

