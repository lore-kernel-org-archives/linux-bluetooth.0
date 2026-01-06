Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE021018A
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664250; cv=none; b=fZ2HyGJLgzMFoTYbTKSZaIg09d/vYpxDKoovoEA6ktkK4vDFEavwLygCDasdUZVvipEUgB+H/ZvHnD2JRNpG5Ymg9QaD/wk6KJef72VPHbf4suMZFBalRfivxyFSjCwtzrISxP9JK7IegFD97SAi8njhKJ7EB+2yyKM5BXYWQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664250; c=relaxed/simple;
	bh=ByHSAaJCan7dPlFfpepmNmQMGoO6q56jHgskkYZI3bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQH8saH5KRwPaeMci5YZgoDmQ+f1WrxhgUHyRRIDk5u8fiApZkunHGJhEEGpEw5WFYX1z6UANYCn/MJ0n+309X6TFrnTQfXMaypjzxAuF5bErcQqHcXgbOgu/mbUhfeUKIp78nMcs/yGJVDscc3xPRRubYpEJRAY2prxhC/PGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fSjdlBFM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2jafe6t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fSjdlBFM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2jafe6t"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60617wih2784761
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 01:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SyxykO6/0B3Nk7/DjqCOGr/JkGil0YRSUPNFgnC+q14=; b=fSjdlBFMNSE1GiJP
	uNKNsVt4ZY2f9D9tQvBOFpT2l9gon1RoTY6GljxtkgCMj9l3kXckzGWgpK91VgEZ
	1MsV0kuUV3LfIaSU0MLcrTF9UbEd70S5NMpJuiyXBbUB1Jh+eNvWf73Ofc0aD3VY
	HOLVaUduk/qed8AlQTdwpXgIzJ+/EVUudTt85GELuPrEb36AtoMbZX8Kewu73SbW
	a08fUQSzBQm2RSwq88EnbtfDMPio+mYlKkX9ziGxMTQSSZV8+jdNaCJ7h9ynw6Uq
	LyC9n0MyuQItV/I8Nhkm/lVGzKuZZBsIe6mc3tjZNt8cPbdAnbpfTzuOuvPX4iI/
	S9Yfrw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgrf7g32v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 01:50:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c337375d953so827628a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 17:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767664247; x=1768269047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SyxykO6/0B3Nk7/DjqCOGr/JkGil0YRSUPNFgnC+q14=;
        b=K2jafe6tQMdCxXvNu2Sm1moW26k7K71VZe9CdjK8L8tkFyyAsw30KIpFffk4F7B7Qv
         k7089253jv8WXv+IkEzVcP9Gr2bpP5Uk6d+3qoyrV/uVpuTrkjX6ZsO4p57oKGIp34yB
         pTle2jUJx39YnFv3ctGqBnd2M3Zh4NPaSRAGBD80y9vPjLljKk4grHaORzO/KuRjADW3
         IMzT85ogNK4fEU4TeI6uOJEoEv9PMrwEJC3fG6dspGVi6tpnsIgctRIhhCsisGzmARPE
         Klvmn+zX6Au8P+F9brx0DsSPlowo4AB41TCE/OCs7P5UZGUqk45GjfuN8xxIF2Q6du1T
         aj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767664247; x=1768269047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyxykO6/0B3Nk7/DjqCOGr/JkGil0YRSUPNFgnC+q14=;
        b=JLW9f/mJmHtbl3cIWUd3THyAIGntKcnawKdmhmSa+sLGiv5NYbUx3L1cHV0BZH7ibz
         9kwS5Wbq3eBxd7OG8ZgU0tpryw48isEc6KfUxrlNI0CXuV4nsUKVk4T6p5r5S4XaO5yI
         aSNqU7sv8VhnboxDfn4vwYAOVpG/GxPmCS6/zsvn8PzV1CB/pAk+Vv4HH3WBPOBuVuGr
         46P6enCurCHvhV4lKHjsWDKttpGwBame6+vJrMVpXpQFwFLhYQqB7BPsnXj/mTG4+qPY
         eDKRbYm92CaMYJBEEZ1arvUjSti9v9IK8FoxF6nu1fTEW8BQwRhuGTFABMqA6PLBoUfE
         dlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFhz37Gfm1r7CnqLec3KKfUqpiQX7VlxgPxKe/OlOGyO5QLIgWmQOziEzKAbQiXox6cnwo4R34O+AYft+o6Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5M6BLQnFW97beWqldMN9bBsVtW6Js+fW4kTMgptN4Hd9Ivj/
	KVt1ZXEZHQrdA6ZaNvBfhUNtjuaSTgr8wVvVci6V4jCOlY5xQK2agTxLc37AB1+kJFIyHW9LZ7U
	IRIPhp773iprUQUfC9QCAZ2ZWyjKEjEP66pbV5rXZ02Bcw40mcO4ofnK4Ekc04pt0bT0qNhw/ZI
	6WVST0Iw==
X-Gm-Gg: AY/fxX5UGoXcOt2Pl6vvCiFJTYLtrnoEb9iQK5PHpqlv6OzQ6Ffm6wLUtCY4J6Uz2ge
	LWBnkH+evzxeDKy8XzDI6N4c7wgMZTmYBOMxObJCN/DE9XdlJTPTJuMpumNDmzGff3cxOGWvxlV
	xOjhxg2XhhYSIJqtShADhCE2D8aG5kpqxBAqXb9b8Ych5zJSJ5EwPnyErMuHbpPQYDN4nQxXbjx
	GUY87XQ/qs4//6o0CcuDfAlHUZ6n99I8UI6vxFmiAadp2U4rFgSR0DxSTTuyMdcYH24VQcXmSFG
	fgkY7r9SpKO74Ny8/M8WkPeE/EjmwNEl9EcBh4uoiEOpWF1aZ2LCBFF5CuQeYfiWK2SD50Q2Hc5
	HkV5pklSjkGTW+hQNUzu+r0v/s5Vpqz/eH6x6F/xbZsqSJGiky0399P6haUh3PsgABw==
X-Received: by 2002:a05:7300:22cb:b0:2b0:57ec:d1a6 with SMTP id 5a478bee46e88-2b16f84a0ecmr897736eec.8.1767664247382;
        Mon, 05 Jan 2026 17:50:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk5OKtpjhRtSLU1Wn2rQLQM81jrIUexFiagC2jiAaCqm2bm0DRCsxTZwA0gfSxCTP7NTIRZw==
X-Received: by 2002:a05:7300:22cb:b0:2b0:57ec:d1a6 with SMTP id 5a478bee46e88-2b16f84a0ecmr897721eec.8.1767664246829;
        Mon, 05 Jan 2026 17:50:46 -0800 (PST)
Received: from [10.110.58.110] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078cddasm1189294eec.22.2026.01.05.17.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 17:50:46 -0800 (PST)
Message-ID: <812fb2ed-439e-4007-92e5-5d159c84b5cc@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 09:50:40 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: btqca: move WCN7850 workaround to the
 caller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260105055646.3816296-1-shuai.zhang@oss.qualcomm.com>
 <20260105055646.3816296-2-shuai.zhang@oss.qualcomm.com>
 <tzul6msdqknv57jgw672bl5xvavmnkrrwbajpc3xh3sto6sm2t@v4nvhsa7zoel>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <tzul6msdqknv57jgw672bl5xvavmnkrrwbajpc3xh3sto6sm2t@v4nvhsa7zoel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HSm1IkyiD6aZFAu8FX3YDuzCZMkscAwc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAxNCBTYWx0ZWRfX7HUL9QAv1NXR
 sGJtcqc3VeMbrJ2xnqXTq4d0hbXSlFd7awWe7Ob8g1bnGhUUJGxzo33gM1sLb63hLQgbMy2AfAa
 j8kfIYY2uxEnMYyDvDerYJ2d4NB9cHAUwmd1gz9n423WlK+eWYlSskPPx1vlrA2CHI6jOoB+8Q/
 HYWIWfi02Qtx3uTrxdTDLTjrU47i+jN0/ddo1ilVRDHdHgY/nMvhKoaE6upvO/yqKlDyQO8qIzq
 37UDC0mMJwxdKfWZIR0nHHqBO+TyAsIZ06LhB5DzY4T3caPAxEX5bbwLCBY1S6qOJ8nR41cvUxj
 iCDSdxUDxX2Fg1Wh9u5z6ww+92zs9EORPcEKGOeWVFQYkzEKszzT5c2h2goHXlcTI+HIuXF3ZGq
 vZi2E7zewBb17GQnusNgn+1wE+L+bXqGyTch3Fff/DlqNkfhR6o59+9eu8HY9Guf79OnyKy2iO1
 hX1Gx+dHmv7NpG0Jgrw==
X-Proofpoint-GUID: HSm1IkyiD6aZFAu8FX3YDuzCZMkscAwc
X-Authority-Analysis: v=2.4 cv=FK0WBuos c=1 sm=1 tr=0 ts=695c6a78 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=f1bAvJBtiaARkzqOSqsA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060014


On 1/6/2026 8:21 AM, Dmitry Baryshkov wrote:
> On Mon, Jan 05, 2026 at 01:56:45PM +0800, Shuai Zhang wrote:
>> WCN7850 will first attempt to use ELF_TYPE_PATCH,
>> and if that fails, it will fall back to TLV_TYPE_PATCH.
>>
>> To code uniformity, move WCN7850 workaround to the caller.
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/btqca.c | 39 ++++++++++++++++++---------------------
>>   1 file changed, 18 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 7c958d606..561e51fa9 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -581,28 +581,11 @@ static int qca_download_firmware(struct hci_dev *hdev,
>>   
>>   	ret = request_firmware(&fw, config->fwname, &hdev->dev);
>>   	if (ret) {
>> -		/* For WCN6750, if mbn file is not present then check for
>> -		 * tlv file.
>> -		 */
>> -		if (soc_type == QCA_WCN6750 && config->type == ELF_TYPE_PATCH) {
>> -			bt_dev_dbg(hdev, "QCA Failed to request file: %s (%d)",
>> -				   config->fwname, ret);
>> -			config->type = TLV_TYPE_PATCH;
>> -			snprintf(config->fwname, sizeof(config->fwname),
>> -				 "qca/msbtfw%02x.tlv", rom_ver);
>> -			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
>> -			ret = request_firmware(&fw, config->fwname, &hdev->dev);
>> -			if (ret) {
>> -				bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>> -					   config->fwname, ret);
>> -				return ret;
>> -			}
>> -		}
>>   		/* If the board-specific file is missing, try loading the default
>>   		 * one, unless that was attempted already.
>>   		 */
>> -		else if (config->type == TLV_TYPE_NVM &&
>> -			 qca_get_alt_nvm_file(config->fwname, sizeof(config->fwname))) {
>> +		if (config->type == TLV_TYPE_NVM &&
>> +		    qca_get_alt_nvm_file(config->fwname, sizeof(config->fwname))) {
>>   			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
>>   			ret = request_firmware(&fw, config->fwname, &hdev->dev);
>>   			if (ret) {
>> @@ -861,8 +844,22 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>   	}
>>   
>>   	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>> -	if (err < 0) {
>> -		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
>> +	/* For WCN6750, if mbn file is not present then check for
>> +	 * tlv file.
>> +	 */
>> +	if (err < 0 && soc_type == QCA_WCN6750) {
>> +		bt_dev_dbg(hdev, "QCA Failed to request file: %s (%d)",
>> +			   config.fwname, err);
>> +		config.type = TLV_TYPE_PATCH;
>> +		snprintf(config.fwname, sizeof(config.fwname),
>> +			 "qca/msbtfw%02x.tlv", rom_ver);
>> +		bt_dev_info(hdev, "QCA Downloading %s", config.fwname);
>> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>> +	}
>> +
>> +	if (err) {
> You can keep the `if (err < 0) {` here.


I will update it.


>
>> +		bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>> +			   config.fwname, err);
>>   		return err;
>>   	}
>>   
>> -- 
>> 2.34.1
>>
