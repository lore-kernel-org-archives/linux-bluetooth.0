Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2E236A73
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801150; cv=none; b=EtzuYGik2zFsRdDCzGZpjlyLtkpi7ObZL311r6iipRGufPc5kb6BkRtnf0QsAQcHx0m/Cn8kp8NhICrVUvD1TeFHg4YV7+lUq8xGMKA3DbeR9kIJM7XiA0sb3e+Sv90ih+5odvsmYpTPsjTV8wtEhFGsdDqd2VQ889ze3ddzPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801150; c=relaxed/simple;
	bh=lxAhaEWs2+FmdG3YfbK8rEImBbT05jrDevjZ7VkfczY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kxm7gdudDdlCMMLLSAeQH6lgDsmPtAIJeytF6bE5vtBnWgcnUuit9s4MINd7ZSmDzWzBXv5bbu0ZDQTtQjqUJ1vvD4xBrGJEObbcJ3mGlVI/BecMcHv86iXv2OAmOEne0l4Wo1fpDqLB+Zzgi6SmroN1raUaBdSKAtyG0GX+HLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LTt6cFAQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bl8yO27H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LTt6cFAQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bl8yO27H"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIJrUh1261167
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 02:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yyq/oFXi4JPQu7LG9ZwWWGPlqaxWoh2Asw+MKRbmFns=; b=LTt6cFAQ875Urp3Z
	nQ+tzlJ3ggMqhvXBJGapEdIVmwXMp5a4rMiD/rjQLkYmfIWNzCZPjy7I5nUs7BiW
	ITRQidVx+2wr8Ui4cOik2qKGwDPuoMm01UXNJt3JASZ9w10TwjJiR5ZlQWgmZro7
	t8q+xOzrR2Sc0nCYEiWDLYXm0viV55aCQiyGF7vfDMKr9mTPbfNJc5Z0HrGrtRWU
	qx2xg2UZ2pIaBHAV/lwiem+Xr8l+fX3QWfIEhdSGOzSfLR8W2GB98GrCX1dIBFxU
	R2fmEINZGnjJITD7UuSX10Eu7Wq9qXKfnX3jdhwMUhcYreap+JYkWBGIfCLM8q0t
	8+OFIw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy5g8ka9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 02:32:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso7397774a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 19:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773801146; x=1774405946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyq/oFXi4JPQu7LG9ZwWWGPlqaxWoh2Asw+MKRbmFns=;
        b=Bl8yO27HyJ48Z3ZubiFbe69t3ai8ja86ko8rd1cbl42919TT7Y8BvczqCaBlq509Lv
         P1scyUZdbe5qrJCaOuxmQL0P7WAcguqoudlwcjmtuNLpyDGdHwDyA5GIO/VKfdG33NbP
         Xm8IdfNhfgNw7EvkAN4aTagspMZXuyInufe1joiu+/RPv20pihg38M2VSsQ5d+fiVFBi
         ozc2ZC3aNWcJ0eV6jpbhx7OKo625V1cS64lQoOFruWcq/PVPsqzeHs/6p8E0v7gXe2eb
         ssI4x4ks2B/ASZ9cnDsihPz13VPtz8BJStJC9gbeZgWNROd+5KyqnbZGvqc16OEX0Vy2
         u68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773801146; x=1774405946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yyq/oFXi4JPQu7LG9ZwWWGPlqaxWoh2Asw+MKRbmFns=;
        b=AyfDvgrUGSvFR0s/5rCjxmK6u7iPRz2AyBuPeYwoZ/+CWEO2bxDGtBY+81zW0vCVID
         kJy8ndVhx79fu6wuuBcId53LKdF2TPtZ6JZQLX9tih8yPUfOwNyvRLge6QDlbZ1g3N5N
         J0q6aS9cwKaDFDLTdXufosf6m1kWCRIyQwJRGBkiRkVa9SVrDNug7vSHMrrgLQnABBjO
         pc12NkKVJZAi/OKQr7lyQ0cHgObQeYbIWreJYaH7YIxQycRiJU2RBdJGx44O2T2c3wEk
         4lEE939+yDOjGAzFKvtbKDgTCfb/Mm5gAsukImzlH4QHB28Mhyqm1QrdWGxzcbcTdUNi
         cTHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5RNBhqfcrTPSaq3OphBqtLnc5q+hfh4oexBwKN39WuzJesZB3VQ7r701HqX4XpRlo62051BJ214/S7EFkeq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdoF5vmPLGHF/RegQLcbZIj2n86ofRQu5bfB7U/DQnOM3L+t7b
	NqjuvY3wupFRxPbhENSvc4ibUO68Qg0RPaN5tuYOtPtipcaj6RcOIGz403VxDNw/JPqISoSR1T2
	OlLi1qvoA5uVs5loh5Eyq+HvQaQ8dNjaAyo6xcvZDNVIO/zmZLHZQzReDx7eGYqAG8YyD1rOlDc
	tCes0=
X-Gm-Gg: ATEYQzzpgx3fdUooiYFQGlA4E6nLz5fFTTh5Vwn/VuP15t/jN0Ygisxgs/vlFjQsYI6
	ru0XiAqdNod9YsNd8jTJCYADSYKULO57rJIw2FJIpM/b1g/HRFNeHdaBha0YXWTTA8esJ1vNtj6
	RqU9w5eohHgoE41sKm0XpwaKZQshLnUV6BK4pTXTarx1PIAkN/aMNOajZiHoYD/cxd0jtnGhJLL
	UU+LvFm2SDhibe3HZMqyiZBpZqQdUf7XfDiSHd6OwnC+beWkZbD7S3vRhoPFGdK+WD24HYysUX7
	3HjIg4aGP7T43yVi6L4SQBa6IQYELNwLIvA+GlPnjUarKrJ/rqa9O20Mt0RJcJkfXC9TvPgNEBX
	88uPXkuXtHM+arBMOxpkoFzcSSirzMJ1/C756+kJVcwmZccpE
X-Received: by 2002:a17:90b:50cb:b0:352:ccae:fe62 with SMTP id 98e67ed59e1d1-35bb9e5d7c1mr1333351a91.10.1773801146266;
        Tue, 17 Mar 2026 19:32:26 -0700 (PDT)
X-Received: by 2002:a17:90b:50cb:b0:352:ccae:fe62 with SMTP id 98e67ed59e1d1-35bb9e5d7c1mr1333326a91.10.1773801145730;
        Tue, 17 Mar 2026 19:32:25 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bba2175dfsm838821a91.0.2026.03.17.19.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 19:32:25 -0700 (PDT)
Message-ID: <4f0c351a-4268-4cbd-92dc-a5cc9845fb85@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 10:32:20 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btusb: Allow firmware re-download when
 version matches
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
 <zcn4iagkp4wtcg24obdhlv6pj6xyakcbezuzz6so3nvwneuybo@5bg3qjsuajqd>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <zcn4iagkp4wtcg24obdhlv6pj6xyakcbezuzz6so3nvwneuybo@5bg3qjsuajqd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nJHJGAVwy6FwuD2dDfURxWGAabcOpuad
X-Authority-Analysis: v=2.4 cv=EeTFgfmC c=1 sm=1 tr=0 ts=69ba0eba cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_LWKTQWFkmdMk6si93kA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: nJHJGAVwy6FwuD2dDfURxWGAabcOpuad
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDAyMCBTYWx0ZWRfX1AQccRiKtSxl
 1ePt6U8E1Qm9bw2lRBp06Cg2VRfcE0/2KlKntxNJHXG/hPUdAZBh3Xx1Wm40+UMa7cji3ezFhrm
 36KcZcmmnPB5Y/7cnfE76jX5toacMuDoxVSsWYPU3voHwGGYUkm+beEARNTegPAHp4mn7yoBY46
 Vz0IgMHbFT9kypuNGEa9xZ+7ZTmvTmIsXbwqrcRMgycxF63aMhOVfoweMLLNcRD+j8k0GataVo5
 GrPoTODqGZ9tK/G+rY0+9x4/Pbm6YIO5t4wl3eqpxeXPDoJg76oDpPBUyEF8+lOWJQEtoniLve1
 D3XjTMaS1Dpna1hAvR+QbmfUnfQZA6tR7GObZQrYvXYrgt7uoEK1qp6K03G6+z4O9Lv9wOqZcx1
 ib7plv3PXlQh7x89Ci0bX1e9U5RsQPFYubxM+kGNSsXwIBd5QGaPsd5Vkcflq8xDNE8EaNZ4mHc
 qn8qIUTNt60QTS8GsJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180020

Hi Dmitry

Thanks for the review.

On 3/14/2026 12:06 AM, Dmitry Baryshkov wrote:
> On Thu, Jan 08, 2026 at 03:43:53PM +0800, Shuai Zhang wrote:
>> Since USB can disconnect at any time, if it disconnects during
>> the BT firmware download, the BT controller firmware version may still
>> be updated even without completing the download.
> Does it not have any check for not completing firmware update if the
> download was not successful / complete?

Because of RAM limitations, the controller updates the firmware version 
during

the download process,even if the download does not complete.

Since btusb cannot power-cycle the controller, the only recovery after

an interrupted download is to retry the firmware download.

>
>> When USB reconnects, the BT host detects the same version as in the
>> firmware file, which prevents the firmware from being downloaded again.
>>
>> Therefore, remove the equality check to ensure that after
>> USB reconnection, the BT host can still download the firmware.
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/btusb.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 646de80c7..991064a25 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -3503,7 +3503,10 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>>   		    "firmware rome 0x%x build 0x%x",
>>   		    rver_rom, rver_patch, ver_rom, ver_patch);
>>   
>> -	if (rver_rom != ver_rom || rver_patch <= ver_patch) {
>> +	/* Allow rampatch if version is greater than or equal to firmware version.
>> +	 * Equal versions are acceptable for re-flashing or recovery scenarios.
>> +	 */
>> +	if (rver_rom != ver_rom || rver_patch < ver_patch) {
>>   		bt_dev_err(hdev, "rampatch file version did not match with firmware");
>>   		err = -EINVAL;
>>   		goto done;
>> -- 
>> 2.34.1
>>
Thanks,
Shuai



