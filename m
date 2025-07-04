Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1518306DDF
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635840; cv=none; b=aUWtgOB9B1j7iwbsen82QjcF8ODmYrKV21wypm8PKxth9ZCrl9YoPkgzxPZ/C6fJ0nox3Z3sDX0VvdMdA6RPCGCP7oU1IaJOX73W0RzkZ/OhELXP96r+TSRvHffTd2caXrI2OQ3+R2EhnVU1GeavckuczO6VtfpvnyzJgO+vZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635840; c=relaxed/simple;
	bh=3BC7Kb+SQC4y8uWjdYgiCFVBT6/YzaEEAUgmGSP3xHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TqnsaCElDAHC3ncb4xt5yGkAGwHtu7/rH1MozhKH7p/JBfhXMIZgsR9MzRsvoEJen+2/LE9UxP9T7HQhhQPEDxZz8/VY4BUasH1P69jSiLwPWhncKyndZJycUhzgPNNk6o/+LNSWNNSt0U1OtlTf3rXu/WMk+5Bs/YJDZp8mdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KONpGnfb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KONpGnfb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5648fqLS025936;
	Fri, 4 Jul 2025 13:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IRNIze5u8JAXYGHFRIWd4OyjwDKnt4HnYZ2PLYpanNk=; b=KONpGnfbWPUXCxvb
	9Mg4uTu3ykpQVYUrQB0JT7PF/o0OZ0i4ChVcKZBG6ugXEnbf2kguiFiQfdCj7hy8
	V7dn2dr62ls6BSisdhlBrtAOEm0IN+4+HafpJTx4qZYqmYDf24gvnY7tqWVWZUUf
	R5p+FWmSR5x7MPQ4r5R/HiTBBuT/jP2JsghXOo8YS8JyxNyLCNRLgtG8h9qV3pXW
	AShPdP2H3iSLayYw7X6LWZppTRfKDmsDFn4uDXZibmqQORUc+U4nYDMUk6OOEVuG
	fN3tAuS7+O+4uvWBqhc1nTeADcWyCvsTr0iLNkNqT5LaS04whUmbSlYWKotmKXgJ
	bITsrg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kd6515k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 13:30:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 564DUXAU027954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Jul 2025 13:30:33 GMT
Received: from [10.253.77.97] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 4 Jul
 2025 06:30:32 -0700
Message-ID: <2dec984c-c6c1-4139-9e64-314942aad091@quicinc.com>
Date: Fri, 4 Jul 2025 21:30:30 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] driver: bluetooth: hci_qca:fix unable to load the BT
 driver
To: <brgl@bgdev.pl>
CC: <linux-bluetooth@vger.kernel.org>,
        Stephan Gerhold
	<stephan.gerhold@linaro.org>,
        Luiz Augusto von Dentz
	<luiz.von.dentz@intel.com>
References: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
 <CAMRc=MfF7d9+cJi12G1yxPpMoe8K5N8tEO9kfCRJejHWt2DkXw@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <quic_shuaz@quicinc.com>
In-Reply-To: <CAMRc=MfF7d9+cJi12G1yxPpMoe8K5N8tEO9kfCRJejHWt2DkXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Z+PsHGRA c=1 sm=1 tr=0 ts=6867d77a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=UQjBgCM3aO4ULV_0GCEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMyBTYWx0ZWRfX4vZBoOjK2C/D
 RX40XYO8Wp4UWJLSBiD2R7ZjKeOJHDg8g5VtBwDvMPQEuw3MtjA7W9qLoGfpD45z8FCyyZz7ec4
 rs+3CumyiGfOgp0/h8q3XZhCciJ03De1K3ZwErjYGRPukDmVPHwszzqJrTOps9i/U4oeexoOuLO
 gzUzM7qgEuhiLdLDuVkNegZk6X5JiYA0MiL0KYC4Azu0mcsGY4r+yxX++DxnNSKjxZT1u5Patlz
 Wd4HTzpMTl1zJAoG/SVcoMY/sL+QaIR/eRn9VGMupEzGbtzgSkOP5Pxpbgbd78jS+GTsKpOoOl6
 dRz0RHQA8e+OGzoNnrHRrlxiYKsLtBE9OM8j/1a7Go5n9IInS3/w7HrfdTtPQ6Iz01OkTcNKTZQ
 uaDXTMO42XcNqj0yH+JrhEJhhlIUNhMRvlrSfyh2/KAM7jLC7008vKmh9YHRSknVxHqAFNt9
X-Proofpoint-GUID: mYFZZCWSLoqZljnGLJ9FaV7B_sQgCfS4
X-Proofpoint-ORIG-GUID: mYFZZCWSLoqZljnGLJ9FaV7B_sQgCfS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040103



On 2025/7/2 18:23, brgl@bgdev.pl wrote:
> On Mon, 9 Jun 2025 18:55:00 +0800, Shuai Zhang <quic_shuaz@quicinc.com> wrote:
>>
>> Some modules have BT_EN enabled via a hardware pull-up,
>> meaning it is not defined in the DTS and is not controlled
>> through the power sequence. In such cases, fall through
>> to follow the legacy flow.
>>
> 
> Thanks Stephan for bringing this to my attention.
> 
> Shuai: you have not Cc'ed arm-msm or even linux-kernel and so didn't give us
> any chance to object. I will separately send a MAINTAINERS change to add
> arm-msm as the mailing list for this driver.
> 
> What is the problem you're seeing? The bt-enable GPIO is optional in the power
> sequencing driver and if it's not there, then there should be no difference in
> how this driver works. What are the offending platforms?
> 

The observed issue is that the Bluetooth driver fails to load, 
and bluetoothctl shows the message: "Waiting to connect to bluetoothd..."

The bt-enable GPIO is optional, but when the power sequence does 
not define "bluetooth", it results in an EPROBE_DEFER error, 
which causes the Bluetooth driver to be repeatedly reloaded.

On the Lemans platform, which uses the BT M.2 interface, the bt_en signal 
is pulled up via hardware, so it does not need to be defined in the DTS.

>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>> ---
>>  drivers/bluetooth/hci_qca.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index a2dc39c00..976ec88a0 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2392,10 +2392,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>  		 */
>>  			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
>>  								   "bluetooth");
>> -			if (IS_ERR(qcadev->bt_power->pwrseq))
>> -				return PTR_ERR(qcadev->bt_power->pwrseq);
>>
>> -			break;
>> +			/*
>> +			 * Some modules have BT_EN enabled via a hardware pull-up,
>> +			 * meaning it is not defined in the DTS and is not controlled
>> +			 * through the power sequence. In such cases, fall through
>> +			 * to follow the legacy flow.
>> +			 */
>> +			if (IS_ERR(qcadev->bt_power->pwrseq))
>> +				qcadev->bt_power->pwrseq = NULL;
>> +			else
>> +				break;
> 
> This is wrong. It just effectively ignores all errors - even -EPROBE_DEFER.
> This patch should be reverted as - depending on the run-time ordering of driver
> probing - it will surely break existing platforms.
>

Thank you for your reminder. I will update the patch to add handling for 
errors and retain the handling for undefined cases.

>>  		}
>>  		fallthrough;
>>  	case QCA_WCN3950:
>> --
>> 2.34.1
> 
> Bart

