Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E71F949
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727576721; cv=none; b=ujd1ZRqvh4PzJkvCtc3msz9CZat8tF/RDRqxtqsrFentl/uErLv2aOnh5XoDKozO9z/aKC0n+dsHt43GKKIw2slW1ZYriYsgMSNV8HATDCTDMnTpwULThCmMZGOOnMHsdq6z6T+K7PeC1oTPaW3BBKIOBxJeyjfwJpf5wL3riak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727576721; c=relaxed/simple;
	bh=ctgQdBLI6G6hZEkUFgyvxgVCg7cJYEmUpET9IVjP/FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aBsUv8FRpegjSB7UtlsU3iUXmNlFSHxklmmVxfn+trHBkLJt8Ka+ASsY7y7fonLAdUlqehV5nNlQNFrpo/aFQ6tDmUccD/6GyFQ/Xm5jVUth5EadAJrtJRsuQsT7Uh23jgFinWN10XxpF7zbeRJocXBL7/eLJVfDevAgF8XHVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QUC9kekP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QUC9kekP"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48T0RGO3021716;
	Sun, 29 Sep 2024 02:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2J33+5+vsEJFo/UBsOSiJlgBqdc7r30iWIMcF4vHcmg=; b=QUC9kekPREjUftOq
	DZ97EaGItqF1GMYNyr21UctRnSqSDpx+foMLzY+xItHSHFEczM6r/Elc6+5AO1iW
	feYRRNwz2jqj+rWxA7GAKwBmNNpaNrEC8Wxgo5QfjwMlBOMvhw4RW0Jgg3LnQ02T
	9aByLd2H22twIp9vXrQrlTleVBMnKyXCTntSH/K57/O8cAVaVV8FRTawPR68bi9V
	Dyq3/bzKFhcNrF0ckA6ruW+41CIM+Ayxv2NRqHaaXZarSASK3gYRcSsH7FrJPHz0
	2uUwrwCwNnmlP6xFtaWkKj+pFub6C+Pm30RDch/zY86ZUj/8wWArBuLb78FnXYlb
	YYf/SQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x94h9k78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Sep 2024 02:25:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48T2PGgi010473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Sep 2024 02:25:16 GMT
Received: from [10.253.77.29] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 28 Sep
 2024 19:25:15 -0700
Message-ID: <0fec5aec-766b-456b-8d19-0adcc2d77faf@quicinc.com>
Date: Sun, 29 Sep 2024 10:25:12 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] device: Remove device after all bearers are
 disconnected
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_jiaymao@quicinc.com>
References: <20240927023854.2447283-1-quic_chejiang@quicinc.com>
 <CABBYNZKy191ztOWergLbA1B5O0f-E-e59XT4eQoEFebzxPW-iQ@mail.gmail.com>
Content-Language: en-US
From: Cheng Jiang <quic_chejiang@quicinc.com>
In-Reply-To: <CABBYNZKy191ztOWergLbA1B5O0f-E-e59XT4eQoEFebzxPW-iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dn0zxaVGRA8QEMnj7kficChM6smhpIUx
X-Proofpoint-ORIG-GUID: dn0zxaVGRA8QEMnj7kficChM6smhpIUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409290017

Hi Luiz,


On 9/27/2024 10:03 PM, Luiz Augusto von Dentz wrote:
> Hi Cheng,
> 
> On Thu, Sep 26, 2024 at 10:39 PM Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>>
>> For a combo mode remote, both BR/EDR and BLE may be connected.
>> RemoveDevice should be handled after all bearers are dropped,
>> otherwise, remove device is not performed in adapter_remove_connection.
>> ---
>>  src/device.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index f8f61e643..4efd755a0 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -3492,8 +3492,27 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>>                 DBusMessage *msg = device->disconnects->data;
>>
>>                 if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
>> -                                                               "RemoveDevice"))
>> +                                                       "RemoveDevice")) {
>> +
>> +                       /* Don't handle the RemoveDevice msg if device is
>> +                        * connected. For a dual-mode remote, both BR/EDR
>> +                        * and BLE may be connected, RemoveDevice should
>> +                        * be handled after all bearers are disconnects.
>> +                        * Otherwise, if msg is removed, but not all
>> +                        * connection are dropped, this function returns
>> +                        * before *remove is updated, then after all
>> +                        * connections are dropped, but device->disconnects
>> +                        * is NULL, remove_device is not updated. Consequently
>> +                        * *remove is not set to true. The device is not removed
>> +                        * for adapter in adapter_remove_connection. Need
>> +                        * to wait for temporary device timeout to remove
>> +                        * the device.
>> +                        */
> 
> I mean as git description, anyway Im having second thoughts about this
> change, see below.
> 
>> +                       if (device->bredr_state.connected ||
>> +                                       device->le_state.connected)
>> +                               break;
>>                         remove_device = true;
>> +               }
>>
>>                 g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
>>                 device->disconnects = g_slist_remove(device->disconnects, msg);
> 
> How we move the block checking for disconnect message after check all
> bearers have been disconnected:
> 
> diff --git a/src/device.c b/src/device.c
> index f8f61e64376c..76d2c859c747 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3488,18 +3488,6 @@ void device_remove_connection(struct btd_device
> *device, uint8_t bdaddr_type,
>                 device->connect = NULL;
>         }
> 
> -       while (device->disconnects) {
> -               DBusMessage *msg = device->disconnects->data;
> -
> -               if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
> -                                                               "RemoveDevice"))
> -                       remove_device = true;
> -
> -               g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
> -               device->disconnects = g_slist_remove(device->disconnects, msg);
> -               dbus_message_unref(msg);
> -       }
> -
>         /* Check paired status of both bearers since it's possible to be
>         /* Check paired status of both bearers since it's possible to be
>         /* Check paired status of both bearers since it's possible to be
>          * paired but not connected via link key to LTK conversion.
>          */
> @@ -3539,6 +3527,18 @@ void device_remove_connection(struct btd_device
> *device, uint8_t bdaddr_type,
>         g_dbus_emit_property_changed(dbus_conn, device->path,
>                                                 DEVICE_INTERFACE, "Connected");
> 
> +       while (device->disconnects) {
> +               DBusMessage *msg = device->disconnects->data;
> +
> +               if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
> +                                                               "RemoveDevice"))
> +                       remove_device = true;
> +
> +               g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
> +               device->disconnects = g_slist_remove(device->disconnects, msg);
> +               dbus_message_unref(msg);
> +       }
> +
>         if (remove_device)
>                 *remove = remove_device;
> 
> 
Agree with you. Update the patch (v5). Thank you! 
>> --
>> 2.25.1
>>
>>
> 
> 

