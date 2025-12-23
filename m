Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142D1D63D1
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766455435; cv=none; b=JKchYYdm6XmmE9vGzfUNki8xWtzaRgfC1/K0/dPf6iwZVHW/3Lm1mlHr/Umxz8sb60qBcrETVduqPrLIIv2Lcnfkx90/isCA0afj8uknPhkkYKZw9/tyCw5fP02+eXb4UhQgdkvicB0dX+kH+6vQ17+Aeajgcxfqv6ZONuse5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766455435; c=relaxed/simple;
	bh=ADseQxITzdrPRi74F1RrzdY42wR82Wxi2IptvYdtVTw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KaoAU+k/Dz2RCUcAjc5a3aIV1qNgPG4HGyYCMPyxHxRF21DdPx5Yrr3j/W2WLlhCU9CFUJm1uc774jvmuWlcdksRe1XYOEMX+MfBhhkwX5hjlIIe61MfWzLGObCU79q+9CEdDkHnFh0ss7nfU/QqbGel1vQo97zqop9e+lVd0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C+vzCm0Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EO5F0l/u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C+vzCm0Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EO5F0l/u"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMECCQr2199150
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 02:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CYKI1cNRXDVOJTX7mQY2hnCGtOzpcksSTqchtZH0nzA=; b=C+vzCm0Yy9IGwVIs
	E7esW/2fhWkwhIEizPzPHpZAFBm4RV4WEpTs9raMhm3C9Z4kUKFtRStngpzApRsi
	J4e0z69hTqx/ya6v7PLZcfD6RZ+Z5rt8Iy8aYp76YLSuQuV6TFAo5GolTjiGd0q/
	mAL8Mxg2sFTIkhtj+3GhXHiARieXx6Qqv3nxA+KrDMMoEWDK9CkTDDlGTgxIjtj/
	V/yvX+FxoupoXO0e4BC901KE8cs+UJcl2x5Er0NEWkF9I/MIJIeAnVNUaCsxBUaK
	Rgw5yCBGRu3GbYm4tdZZFyxM2Lf85iNoTrMkC498pKFgqVjtP3wv9lhe6h+dqFfL
	PAcPHA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b73fwtawn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 02:03:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0d43fcb2fso145429165ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 18:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766455430; x=1767060230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CYKI1cNRXDVOJTX7mQY2hnCGtOzpcksSTqchtZH0nzA=;
        b=EO5F0l/uhvJVcnc+sVlImHgZzX2H/WpPyR0gXkqP+YZYE3TqTyO4MyIptbbFhJEe+x
         mur52YcM1pgz26uk4pHO4AsVnfeaGptvQXqI4CTWaZJTviNhIKQXyxz8gvKBnDkO/4t9
         POaYJe+b8BSzQNoiYv8ztujRPdUSQFdRJIqNWUDHpoNhqxGziknh27FVB992qtLzcjH8
         SU93ZpPygJOnOA7MwwpJzg/Hn5fp3G18bcDadU+AWFzfDHTSUh+2SXKM9Zu12A50jsj3
         t5dCgVYgxtUPhw5sJmlBHymx1p/ikTJKi73plAxD3FDyJArpAuuw1CrZ6Xm5WrU7kUpM
         BN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766455430; x=1767060230;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYKI1cNRXDVOJTX7mQY2hnCGtOzpcksSTqchtZH0nzA=;
        b=BD0SHV+4Q6rByBZy88c3gmMG1CVPbGtmhx0Cg3xhz3Uc+PMnzm4rk4+cfSQkXip9GC
         ngKnmql10+JjzHPHLTclbYa3k9BO6nb6zf38bwcnHW1cDIj0d8ykBOZfU/7MDxIMmJk6
         lPpNxf4w7fZQUYqndrjFID/hvKkPPby3Q+YFDJrlXo6yWoApSnlkqQnBuo6EVKF9Ubnq
         r31D6fHSQDkO92SnWJMozLNuMlaCju1V8ok31/VJboWM4GhilPWu4c8EzC9Jui00XZmV
         +ts2fy36zInVtSbexLT62IGu6b5bHceROtAHTjvHmJmVCH8kzkHgV0VKAn0pKAmg2a0W
         Pcow==
X-Forwarded-Encrypted: i=1; AJvYcCXBQW/h+62LdLFYV4X4YS1/D4JbRiuFd5FkTs6zR5Qu4JGvdg+pig06VgW2Fh47Jbl+3BAfbfj8pm3jtRFlSsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JJPXtwNHgDnqd3YDGnaHWygm9UG4W7vZBMXGg9L495lR+iEk
	k0tHRmn7rMGv2FpNC23qxOdbCC0RRRRvBb+snr6dJ1Eq9qGqdYOHyDNRlT9x4ol19+k19UWi3eX
	MzXhW9vRIZKlW6xpFqhn+XABVvf1fr5PHWtNksdqX8BVfqlkhjOte5Y/HWQqOHP9m7QBFmh4=
X-Gm-Gg: AY/fxX41Zb2nCO38/8SR/0+MtqdaEiPEFfTql4iYrgvXsVnOK8T5RE9h+tzkYXHz2wO
	jUxCUW7wx6qkky292Fj3SiMPeUSnE2T/hutWDhK/CvpTRJApkF+hkTvAZF/Y3httmG7QPCNV7Oe
	9TZ5etI/k7KAT6jSlQx/jaXa6YSb7UdOi9HECOVWPFDljtVaAf+fwYK/367HnpqN/3chYhg19Xy
	LylWEN0kPZ4h8VZiaCrYJPEUqkAjC3U1+N1dMRY/6FBSzqFPqhHoFmSg3HVge/dag96iiE/XDn6
	gSHgDHdaUz+TYh/L16pmZRFZAXGZPEqh+x2w1ME0KpMGxOHrvNgbTPymoa8jxrKC/DWl2vNdnom
	lMCTpbE3cqS8lsQvIBsudl92UUCgmgPvujAwqyVV+Sj8IeeFFfTgwutEHuRhmN0s=
X-Received: by 2002:a05:7022:1a83:b0:11d:c049:2fa3 with SMTP id a92af1059eb24-121722e30eemr14591162c88.30.1766455430241;
        Mon, 22 Dec 2025 18:03:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFC2sVpQwO37dYMKZ4rtNjoVTCKHbyX8M4akAueTEpepfJTaA8nCAX9mdm4iKB+EFqyv3zjQ==
X-Received: by 2002:a05:7022:1a83:b0:11d:c049:2fa3 with SMTP id a92af1059eb24-121722e30eemr14591119c88.30.1766455429593;
        Mon, 22 Dec 2025 18:03:49 -0800 (PST)
Received: from [10.110.55.95] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm38259631c88.10.2025.12.22.18.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 18:03:49 -0800 (PST)
Message-ID: <e9190f33-de6d-41f6-88bc-1f90513bcb3a@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 10:03:44 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
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
 <c3526d32-6769-4681-bc54-90a4af082265@oss.qualcomm.com>
 <bvkfq2cg3nstegininpxjr2ldfv2kode3fy6ekv5vuwbh3lrv6@qnvxwsu7y4zl>
Content-Language: en-US
In-Reply-To: <bvkfq2cg3nstegininpxjr2ldfv2kode3fy6ekv5vuwbh3lrv6@qnvxwsu7y4zl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=6949f887 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=PFKM2LL8Qd6Ys6_6jnQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDAxNSBTYWx0ZWRfX6tdUTiwxZDUA
 vm2j+BtIpDwWS7wcC0Qnq3fahc0zWcsoWzvkXDZ1v9uXYJRCJ7EBU+B29ysp+w91BKFP7ZaUi8e
 XtgBRkHnIw7kTHGwoYL8QwkovvGzg0YNKuAb960bGpg363/GYSXnmu9eh5/7V9TmdV0n0LaOsCA
 LYEDFjGIUBD6sFumyH8jwL8ocR7GI3zaEP7qBfjPpxtLElouq4N2PyXzgzWr+HD5DZr4UakSiLf
 +/SArkYi/9qndhHm9ZklSq0jclLykNKYYk+v+2RIAlO1h9UdnGiBCnlqlms4QtRxivjvE3rIy5Z
 Afl/GrX6COfJAiR5KtclCpwDuNgIkPWBlS4hk3qTZC2ebyTF0JEMzeZ4zCKncbXEi5PNIsC6k6i
 ETs0FoEgRE6AzTnb7Q+7MgHBl2SxxuSD1++gPSryJCRPHXrosfUybdzvrFQNfe9WeadSqOl18nt
 s56dQ0j/WghbxvFik5A==
X-Proofpoint-GUID: axiym5CHlJg4DeXpw5vqDgWVPSgjuY_i
X-Proofpoint-ORIG-GUID: axiym5CHlJg4DeXpw5vqDgWVPSgjuY_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230015

Hi Dmitry

On 12/21/2025 11:21 PM, Dmitry Baryshkov wrote:
> On Fri, Dec 19, 2025 at 05:19:30PM +0800, Shuai Zhang wrote:
>> Hi Dmitry
>>
>> On 11/19/2025 3:59 PM, Dmitry Baryshkov wrote:
>>> On Mon, Nov 17, 2025 at 10:16:45AM +0800, Shuai Zhang wrote:
>>>> Historically, WCN685x and QCA2066 shared the same firmware files.
>>>> Now, changes are planned for the firmware that will make it incompatible
>>>> with QCA2066, so a new firmware name is required for WCN685x.
>>>>
>>>> Test Steps:
>>>>    - Boot device
>>>>    - Check the BTFW loading status via dmesg
>>>>
>>>> Sanity pass and Test Log:
>>>> QCA Downloading qca/wcnhpbftfw21.tlv
>>>> Direct firmware load for qca/wcnhpbftfw21.tlv failed with error -2
>>>> QCA Downloading qca/hpbftfw21.tlv
>>>>
>>>> Signed-off-by: Shuai Zhang<shuai.zhang@oss.qualcomm.com>
>>>> ---
>>>>    drivers/bluetooth/btqca.c | 22 ++++++++++++++++++++--
>>>>    1 file changed, 20 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>>>> index 7c958d606..8e0004ef7 100644
>>>> --- a/drivers/bluetooth/btqca.c
>>>> +++ b/drivers/bluetooth/btqca.c
>>>> @@ -847,8 +847,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>>>    				 "qca/msbtfw%02x.mbn", rom_ver);
>>>>    			break;
>>>>    		case QCA_WCN6855:
>>>> +			/* Due to historical reasons, WCN685x chip has been using firmware
>>>> +			 * without the "wcn" prefix. The mapping between the chip and its
>>>> +			 * corresponding firmware has now been corrected.
>>>> +			 */
>>>>    			snprintf(config.fwname, sizeof(config.fwname),
>>>> -				 "qca/hpbtfw%02x.tlv", rom_ver);
>>>> +				 "qca/wcnhpbtfw%02x.tlv", rom_ver);
>>>>    			break;
>>>>    		case QCA_WCN7850:
>>>>    			snprintf(config.fwname, sizeof(config.fwname),
>>>> @@ -861,6 +865,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>>>    	}
>>>>    	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>>> +
>>>> +	if (!rampatch_name && err < 0 && soc_type == QCA_WCN6855) {
>>>> +		snprintf(config.fwname, sizeof(config.fwname),
>>>> +			 "qca/hpbtfw%02x.tlv", rom_ver);
>>>> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>>> +	}
>>> Is there a reason for ignoring how it was done already for other cases when
>>> we need a similar fallback? Please extend the existing code (or rewrite
>>> it) instead of adding a similar hook at a completely different place.
>> Current Strategy (when DTS does not specify rampatch and firmware):
>>      Rampatch: Load the rampatch based on soc_type.
>>      NVM:  Load the NVM with board_id based on soc_type.
>>                  If the file corresponding to board_id does not exist, then
>> load the NVM file ending with .bin.
>>      For HSP (new requirement):
>>          First, load the rampatch/NVM files wcnhpbtfw and wcnhpnv.
>>          If not found:
>>          Rampatch: Fall back to loading the hpbtfw rampatch file.
>>          NVM:  Starting from wcnhpnv.bxxx, load the NVM file ending with
>> .bin.
>>                      If still not found, look for hpnv.bxxx and then apply
>> the above NVM strategy again (soc_type(board_id)  to .bin).
>>
>> The current changes are based on the original implementation, which should
>> make them the clearest modifications.
>> Please review according to the existing strategy, and feel free to let me
>> know if you have any questions.
> qca_download_firmware() has workaround code for WCN6750, loading TLV
> file if MBN is not present. It doesn't make sense to have similar
> workardounds in two different places. Could you please unify code
> (either by moving existing code or by moving your workaround).
I tried to move the changes into |qca_download_firmware|, but it 
conflicts with the logic for
loading the default NVM. Specifically, when there is no NVM 
corresponding to the board_id,
it will not load the |.bin| NVM file. I’m not sure whether this 
limitation is within a controllable range.

https://github.com/shuaz-shuai/Add-WCN6855-firmware-priority-selection-feature

>>>> +
>>>>    	if (err < 0) {
>>>>    		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
>>>>    		return err;
>>>> @@ -923,7 +934,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>>>    		case QCA_WCN6855:
>>>>    			qca_read_fw_board_id(hdev, &boardid);
>>>>    			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>>>> -						  "hpnv", soc_type, ver, rom_ver, boardid);
>>>> +						  "wcnhpnv", soc_type, ver, rom_ver, boardid);
>>>>    			break;
>>>>    		case QCA_WCN7850:
>>>>    			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>>>> @@ -936,6 +947,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>>>    	}
>>>>    	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>>> +
>>>> +	if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
>>>> +		qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>>>> +					  "hpnv", soc_type, ver, rom_ver, boardid);
>>>> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>>> +	}
>>>> +
>>>>    	if (err < 0) {
>>>>    		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
>>>>    		return err;
>>>> -- 
>>>> 2.34.1
>>>>
>> Thanks,
>> Shuai
