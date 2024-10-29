Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99C203709
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189474; cv=none; b=KuZenAFJVUd48xF7/vhxDsuu1ppuB8pGYx6MQVFnoaJGUf6TZ6J5uLI16GEjUG3QQGwWWqfhu7AVjQ2cm+DWFxSVQhLL19QejwQZ4H4lwSNYaOmuM/6Y0Hz2abk6JiX8/0cLbezGGK2prL0RJ/IylX3xvvo3Gz9eeMzR83nuwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189474; c=relaxed/simple;
	bh=KnjFxhIil+EGhB9AwZWIMPV8+EAKopZI/0VKhXn2h+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FAodoVh/G2NUuYwiBRyrtXtOuEh+nQR5+v4XB6mdo2X0bC4ANXo+p9HJgV2MEn+O5w+D9ZgJWVVHQ52OopqP56P840oUcIYemTLZ2Bq4oeAhKQdsiVmqZTYmunEKNz4whzmfFzTQMpnR6oyYXkjKHxiIHqqV8Cf5hbnEi5m9uH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tyc2Lp3J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tyc2Lp3J"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SJ0NPr031602;
	Tue, 29 Oct 2024 08:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NPaY+yBjuBR6pyOcDpfzBERB8ruwo3zuuD8J/1Fdit8=; b=Tyc2Lp3J1IiBSibk
	VXsccrcO+0foDYfSd2BA1YH6t4LZHrNHLmE+hzOq0LwIUL+yu3rhQ9Ptsi8RJ/dY
	7twFZp66lCjng9+FvpXwDUuog8F+xWSeWqkSqjardef0babQhel+jLfwT2Cvmz1/
	Iz4xWiVIV6RhDRc3Iiwx8Yb0PTuWP8oGiY2Ri+mWgXixyQp+QGd3UUZOiG/W6Nq5
	ny26UulU24D559TOb8YECmbQoPsECGpXOoZDzgxcYc4oV7A1iZVn8uHExm0nMYwz
	Lx8ZJtidHrJUWV4+vpEfMyomP4jMJqJeU+QCuebFmA8r05GP/tnuGzpeJ2J7i8nm
	XO2TfQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8fpex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 08:11:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49T8B8vK023468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 08:11:08 GMT
Received: from [10.231.216.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 01:11:07 -0700
Message-ID: <dbef2274-d672-4fa1-a36c-4a1471b63db5@quicinc.com>
Date: Tue, 29 Oct 2024 16:11:04 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] device: only use the address type selection algorithm
 when remote device is a dual-mode device when pair device
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
References: <20241028113643.1012491-1-quic_chejiang@quicinc.com>
 <CABBYNZJC1WO1K_1USRFjh3CHP=3hzChwoKpQMkXN8v2i6i9CGA@mail.gmail.com>
Content-Language: en-US
From: Cheng Jiang <quic_chejiang@quicinc.com>
In-Reply-To: <CABBYNZJC1WO1K_1USRFjh3CHP=3hzChwoKpQMkXN8v2i6i9CGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CHiFxoV0mjizuUOLw0_pREe-jpUn2WTO
X-Proofpoint-ORIG-GUID: CHiFxoV0mjizuUOLw0_pREe-jpUn2WTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290065

Hi Luiz,

I update a new patchset with more info. 

In the current logic of pair_device (https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/device.c#n3080).

If a BLE-only device paired twice, in the second trial, it will select the bdaddr_type to BDADDR_BREDR
since device->le_state.bonded is set. We should only use the following logic for a dual-mode remote. 

	if (device->bredr_state.bonded)
		bdaddr_type = device->bdaddr_type;
	else if (device->le_state.bonded)
		bdaddr_type = BDADDR_BREDR;
	else
		bdaddr_type = select_conn_bearer(device);

	state = get_state(device, bdaddr_type);



On 10/28/2024 10:13 PM, Luiz Augusto von Dentz wrote:
> Hi Cheng,
> 
> On Mon, Oct 28, 2024 at 7:37 AM Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>>
>> ---
>>  src/device.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 7585184de..71fdbb145 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -3077,12 +3077,21 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
>>         if (device->bonding)
>>                 return btd_error_in_progress(msg);
>>
>> -       if (device->bredr_state.bonded)
>> +       /* Only use this selection algorithms when device is combo
>> +        * chip. Ohterwise, it will use the wrong bearer to establish
>> +        * a connection if the device is already paired. which will
>> +        * stall the pairing procedure.
>> +        */
>> +       if (device->bredr && device->le) {
>> +               if (device->bredr_state.bonded)
>> +                       bdaddr_type = device->bdaddr_type;
>> +               else if (device->le_state.bonded)
>> +                       bdaddr_type = BDADDR_BREDR;
>> +               else
>> +                       bdaddr_type = select_conn_bearer(device);
>> +       } else {
>>                 bdaddr_type = device->bdaddr_type;
>> -       else if (device->le_state.bonded)
>> -               bdaddr_type = BDADDR_BREDR;
>> -       else
>> -               bdaddr_type = select_conn_bearer(device);
>> +       }
> 
> This seems weird without there being a bug with the state itself, for
> instance how would it select the wrong bearer if it is not supported?
> Also the lack of proper explanation in the commit message doesn't help
> to grasp what is going on here, so please have backtrace or something
> attached since we need to understand why it would be selecting the
> wrong bearer, or perhaps the bearer is being advertised as supported
> when in fact it isn't?
> 
>>         state = get_state(device, bdaddr_type);
>>
>> --
>> 2.25.1
>>
>>
> 
> 

