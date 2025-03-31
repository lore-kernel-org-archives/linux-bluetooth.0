Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773A13D521
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743404027; cv=none; b=g77C9EgFdVBbx997NlvXxiRx7ZPBRQDRLUlnr0MZbuEeZR0N+7Y/1cxKbYMolty2IOP93rMGlUYt83U8q8dHzWMB13kpNwF6J2tNz676EA/xPST/bcpITAJUne6OkU/b0lRKkto942CXLcyXBx4cU8zoSVzWhG0+B+yw9jcwUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743404027; c=relaxed/simple;
	bh=f2mCC6NMDoWYEE5R16uQt6kxvUVZkcDV9JlUUAzLz2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JbSmn5CXBGKnBDpP+JC3TRoDfuEL7a1Lk5W9kyCjxYuLg5oUmpsoJLPFOGPX4a4NF7EVADBkYdePJTN0PmSXHveAi5/tL2LO1nsIGBDZQMwyWZeap+2y1GxWS2F5bLcFqsmx4ivuUlH7Jy3ajNGfQBQxM7WTldYXEQ/xyNBjlTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=blrTva+u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="blrTva+u"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V6klZR028092;
	Mon, 31 Mar 2025 06:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVwDgdd2VemErrYW7dy7a8VmW2/aix2I54BNxMeAp7o=; b=blrTva+uKyqThaoF
	7ZU9IHCG0uIXaW78mXa/v9LDvO5ZKwBZb72GU51hWBrR6Lf/Li08Bg/bCV/Hy5Fh
	W0i3S3wkd8D3F6h8lrSn+s/oLrqwjACC0JgVeyFm6TT32WdIi1m0qLSkbqa9hVAE
	zeQiuI29BDlCWlpzuCMjuHpaSBGrcbilg7QxyhF1SJ9+rBEB7pHOZaKQqBmfMn1J
	tIWsztkxtgZbcbhIJ9ikRSRYHEXJieHVLGjCqGE9J0HIFLDQLglLFd502sacXn0I
	OKzpFTXF4JWD4U4ygI2cKDmLqWkhzLNDfU26dKj5BX0lO5kPbojqNDu86yJCJP9Y
	TBDn+Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p86kksp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 06:53:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52V6rfGM007735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 06:53:41 GMT
Received: from [10.253.78.63] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 30 Mar
 2025 23:53:39 -0700
Message-ID: <03742dd2-43ec-4911-a821-741d3e8106df@quicinc.com>
Date: Mon, 31 Mar 2025 14:53:37 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dbus: Fix add invalid memory during interface removal
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_chejiang@quicinc.com>,
        <quic_jiaymao@quicinc.com>, <quic_chezhou@quicinc.com>,
        <quic_zijuhu@quicinc.com>, <quic_mohamull@quicinc.com>
References: <20250327084128.3315736-1-quic_shuaz@quicinc.com>
 <CABBYNZLkwH=8TztnGnuzGy7FJ+iugp3sKT_cS0dsRoo1aV_hrw@mail.gmail.com>
 <CABBYNZLZfuEXS7YzANUrkuD59oWWyctLU9wPWsyOLO6LNG7oxA@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <quic_shuaz@quicinc.com>
In-Reply-To: <CABBYNZLZfuEXS7YzANUrkuD59oWWyctLU9wPWsyOLO6LNG7oxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=W8g4VQWk c=1 sm=1 tr=0 ts=67ea3bf6 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8
 a=_3-blLh4wLk4toAw60wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 63dTkRv0Fu1RcjI6dniyxLlLeXbofh6C
X-Proofpoint-ORIG-GUID: 63dTkRv0Fu1RcjI6dniyxLlLeXbofh6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310047

Hi Luiz

On 3/27/2025 11:10 PM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
> 
> On Thu, Mar 27, 2025 at 10:58 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Shuai,
>>
>> On Thu, Mar 27, 2025 at 4:41 AM Shuai Zhang <quic_shuaz@quicinc.com> wrote:
>>>
>>> test setp
>>> register_service <uuid>
>>> register_application <uuid>
>>> unregister_service <uuid>
>>> unregister_application
>>> register_service <uuid>
>>> register_application <uuid>
>>> core dump
>>
>> Ok, what exactly are you talking about above, you are not referring to
>> D-Bus api it seems, are these bluetoothctl commands?
> 
> Tried this with bluetoothctl, doesn't seem to trigger any errors:
> 
> https://gist.github.com/Vudentz/7b20ff8b59e3122606a2239e1b63aa8a
> 

This error is a probabilistic issue, and the frequency of reproduction is 
quite high. I have left the reproduction commit in your GitHub glist.

>>
>>> invalidate_parent_data is called to add the service to the application's
>>> glist when unregister_service. However, this service has already been
>>> added to the glist of root object in register_service. This results in
>>> services existing in both queues,but only the services in the
>>> application's glist are freed upon removal. A null address is stored
>>> in root object's glist, a crash dump will occur when get_object is called.
>>>
>>> Add a check for the parent pointer to avoid adding the service again.
>>>
>>> 0  0x0000007ff7df6058 in dbus_message_iter_append_basic ()
>>>    from /usr/lib/libdbus-1.so.3
>>> 1  0x00000055555a3780 in append_object (data=0x31306666,
>>>   user_data=0x7ffffff760) at /usr/src/debug/bluez5/5.72/gdbus/object.c:1117
>>> 2  0x0000007ff7ece0cc in g_slist_foreach () from /usr/lib/libglib-2.0.so.0
>>> 3  0x00000055555a37ac in append_object (data=0x5555642cf0,
>>>   user_data=0x7ffffff760) at /usr/src/debug/bluez5/5.72/gdbus/object.c:1122
>>> 4  0x0000007ff7ece0cc in g_slist_foreach () from /usr/lib/libglib-2.0.so.0
>>> 5  0x00000055555a3630 in get_objects (connection=<optimized out>,
>>>     message=<optimized out>, user_data=0x555563b390)
>>>     at /usr/src/debug/bluez5/5.72/gdbus/object.c:1154
>>> 6  0x00000055555a51d0 in process_message (
>>>     connection=connection@entry=0x5555639310,
>>>     message=message@entry=0x5555649ac0,
>>>     method=method@entry=0x55555facf8 <manager_methods>,
>>>     iface_user_data=<optimized out>)
>>>     at /usr/src/debug/bluez5/5.72/gdbus/object.c:246
>>> 7  0x00000055555a575c in generic_message (connection=0x5555639310,
>>>     message=0x5555649ac0, user_data=<optimized out>)
>>>
>>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>>> ---
>>>  gdbus/object.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/gdbus/object.c b/gdbus/object.c
>>> index 7b0476f1a..d87a81160 100644
>>> --- a/gdbus/object.c
>>> +++ b/gdbus/object.c
>>> @@ -809,7 +809,8 @@ static struct generic_data *invalidate_parent_data(DBusConnection *conn,
>>>
>>>         if (child == NULL || g_slist_find(data->objects, child) != NULL)
>>>                 goto done;
>>> -
>>> +       if(g_slist_find(parent->objects, child) != NULL)
>>> +               goto done;
>>
>> Use empty lines after if statements, and keep the one you are removing.
>>
>>
>>>         data->objects = g_slist_prepend(data->objects, child);
>>>         child->parent = data;
>>>
>>> --
>>> 2.34.1
>>>
>>>
>>
>>
>> --
>> Luiz Augusto von Dentz
> 
> 
> 

