Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539F2CA9
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725262; cv=none; b=gMj3M7/5MXNYCxNMq4YeoaLi2FSPGmncAZBWyQi+bUzguAY1pzjq3zDsIU68SIyR49Xhv7rsjPTmwBWgPzuiXveQnW1vrGvu0BX3LqPtNwXqxpNaBrgsuEwrmWJplDMJbhEoUbRr7P7YA6tvx9EVAVP4NbW5qrm5Wzw9CtLBpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725262; c=relaxed/simple;
	bh=A+VzrP5R496E0fwt7b90F6R0ySRJJSigO8ILssxw6Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p+OFCbXlAoi4Sg4/3y8BXuHxkL5hCyysNKs7FXFOYnCIeedo3H+c8dQuKHSqge6NQz8Jx1Lmi/R/zW+mJOLOxwmx+zcYwr5Jx2USbx7znVQZ/5JY3IXLqU6oiyR6X3mCj4KtUa9qgQsLfg/AhzxPz8pFnktbiCaf7kce2MyBMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KgSdB8It; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KgSdB8It"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJH1Ml024061;
	Tue, 27 Aug 2024 02:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aSHcfHZNkUQOa2a4tMFd//8niKTMOKnjH798pFWkXDc=; b=KgSdB8ItYAC7WpYE
	6Js595HE2CxcJRNTHk7IzyqKjspwTu925yy2ZIJ1cN+fkMVAvvGz13oBNg007O37
	CILM+fCWjIo6wMhZZ9DxjvJAJrVXGoZEUF5piySzthEcHXXJY17RMxU+slld2bN8
	sHfXLdGqb1g8zhsaJUddvkIX38RbgwREHQaa0vOhgyZTBVYQoEV6WONX/nReV0wt
	21DJSsnzjnbZlywbzwGNhxjFkvy9tUsrec/Rv5CZc3iNTGZFX9lrJHZ2DLQBd+M+
	BECbRkz6cflVd0nS7U27grcrD6l0gUHqdrrc9Ra4Rvno17Z3OzLRDYRD0MluWHPY
	/EURHg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417980wejj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 02:20:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R2Kp6Z005643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 02:20:51 GMT
Received: from [10.231.216.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 26 Aug
 2024 19:20:50 -0700
Message-ID: <770d58c7-753b-435b-a98c-ed36ef23d275@quicinc.com>
Date: Tue, 27 Aug 2024 10:20:47 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] adapter: Manage device state of cross-transport SMP
 keys
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
References: <20240826070438.557107-1-quic_chejiang@quicinc.com>
 <CABBYNZL5A5SoDrthoyvwuauEnnyOzebHgtkqwptcHZ1em=dAjg@mail.gmail.com>
Content-Language: en-US
From: Cheng Jiang <quic_chejiang@quicinc.com>
In-Reply-To: <CABBYNZL5A5SoDrthoyvwuauEnnyOzebHgtkqwptcHZ1em=dAjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r3iUdmQlog8rqtnIHsm0qQW3aR4r8Pww
X-Proofpoint-ORIG-GUID: r3iUdmQlog8rqtnIHsm0qQW3aR4r8Pww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_18,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270015

Hi Luiz, Please check the comment inline, Please correct me if I'm wrong.

On 8/26/2024 9:56 PM, Luiz Augusto von Dentz wrote:
> Hi Cheng,
> 
> On Mon, Aug 26, 2024 at 3:05 AM Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>>
>> Cross-transport derived ltk/csrk/irk are reported to bluetoothd from
>> kernel with BR/EDR address type, and bluetoothd doesn't treat it as LE
>> paired/bonded. In this case, bluetoothd won't send remove bond operation
>> with LE address type to kernel when executing unpair, so SMP keys are
>> retained in kernel list. Then RPA is getting resolved since we still
>> have irk which was not deleted when unpair device is done because only
>> link key is deleted since addr type is bredr.
>>
>> What’s more, pair LE of the same address will always fail in kernel
>> for ltk existence, and send back AlreadyExists error, but device state
>> is still unpaired/unbonded in bluetoothd.
>>
>> So bluetoothd needs to consider LE paired/bonded when receiving SMP keys
>> even if they are cross-transport derived.
>> ---
>>  src/adapter.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 40 insertions(+), 13 deletions(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 245de4456..4e5af9579 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -8647,6 +8647,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
>>         struct btd_adapter *adapter = user_data;
>>         struct btd_device *device;
>>         char dst[18];
>> +       uint8_t addr_type;
>>
>>         if (length < sizeof(*ev)) {
>>                 btd_error(adapter->dev_id, "Too small new link key event");
>> @@ -8666,7 +8667,13 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
>>                 return;
>>         }
>>
>> -       device = btd_adapter_get_device(adapter, &addr->bdaddr, addr->type);
>> +       /*
>> +        * For LE public address, key here is cross-transport derived,
>> +        * so consider it as BR/EDR public address.
>> +        *
>> +        */
>> +       addr_type = addr->type == BDADDR_LE_PUBLIC ? BDADDR_BREDR : addr->type;
>> +       device = btd_adapter_get_device(adapter, &addr->bdaddr, addr_type);
>>         if (!device) {
>>                 btd_error(adapter->dev_id,
>>                                 "Unable to get device object for %s", dst);
>> @@ -8682,7 +8689,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
>>                 device_set_bonded(device, BDADDR_BREDR);
>>         }
>>
>> -       bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
>> +       bonding_complete(adapter, &addr->bdaddr, addr_type, 0);
>>  }
>>
>>  static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
>> @@ -8773,6 +8780,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
>>         struct btd_device *device;
>>         bool persistent;
>>         char dst[18];
>> +       uint8_t addr_type;
>>
>>         if (length < sizeof(*ev)) {
>>                 btd_error(adapter->dev_id, "Too small long term key event");
>> @@ -8784,7 +8792,13 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
>>         DBG("hci%u new LTK for %s type %u enc_size %u",
>>                 adapter->dev_id, dst, ev->key.type, ev->key.enc_size);
>>
>> -       device = btd_adapter_get_device(adapter, &addr->bdaddr, addr->type);
>> +       /*
>> +        * For BR/EDR public address, key here is cross-transport derived,
>> +        * so consider it as LE public address for SMP.
>> +        *
>> +        */
> 
> This is only the case if, an only if, the device is a dual-mode
> device, so this probably need to be checked that we don't attempt to
> do this regardless.
Only the dual-mode device supports Cross-transport derived Keys. From BLE keys to BR/EDR keys, vice versa. If
single mode device, the addr->type always is BDADDR_BREDR in link key callback. and BDADDR_LE_PUBLIC or
BDADDR_LE_RANDOM for LTK/CSRK/IRK callback. 

Link Key is for BR/EDR, so we check the address type is BDADDR_LE_PUBLIC or not, if yes, treated as BR/EDR,
it means the link key is derived from BLE bearer. Otherwise, use the original addr type. LTK, CSRK, IRK are
related to BLE, so checked the address type is BDADDR_BREDR or not, if yes, treated as BLE address, it means
the BLE related key are derived from BR/EDR bearer. 

The change seems not affect the current logic, could you please help to explain more what need to check? Thanks!
> 
>> +       addr_type = addr->type == BDADDR_BREDR ? BDADDR_LE_PUBLIC : addr->type;
>> +       device = btd_adapter_get_device(adapter, &addr->bdaddr, addr_type);
>>         if (!device) {
>>                 btd_error(adapter->dev_id,
>>                                 "Unable to get device object for %s", dst);
>> @@ -8802,8 +8816,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
>>          * be persistently stored.
>>          *
>>          */
>> -       if (addr->type == BDADDR_LE_RANDOM &&
>> -                               (addr->bdaddr.b[5] & 0xc0) != 0xc0)
>> +       if (addr_type == BDADDR_LE_RANDOM && (addr->bdaddr.b[5] & 0xc0) != 0xc0)
>>                 persistent = false;
>>         else
>>                 persistent = !!ev->store_hint;
>> @@ -8817,15 +8830,15 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
>>                 rand = le64_to_cpu(key->rand);
>>
>>                 store_longtermkey(adapter, &key->addr.bdaddr,
>> -                                       key->addr.type, key->val, key->central,
>> +                                       addr_type, key->val, key->central,
>>                                         key->type, key->enc_size, ediv, rand);
>>
>> -               device_set_bonded(device, addr->type);
>> +               device_set_bonded(device, addr_type);
>>         }
>>
>>         device_set_ltk(device, ev->key.val, ev->key.central, ev->key.enc_size);
>>
>> -       bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
>> +       bonding_complete(adapter, &addr->bdaddr, addr_type, 0);
>>  }
>>
>>  static void new_csrk_callback(uint16_t index, uint16_t length,
>> @@ -8837,6 +8850,7 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
>>         struct btd_adapter *adapter = user_data;
>>         struct btd_device *device;
>>         char dst[18];
>> +       uint8_t addr_type;
>>
>>         if (length < sizeof(*ev)) {
>>                 btd_error(adapter->dev_id, "Too small CSRK event");
>> @@ -8848,7 +8862,13 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
>>         DBG("hci%u new CSRK for %s type %u", adapter->dev_id, dst,
>>                                                                 ev->key.type);
>>
>> -       device = btd_adapter_get_device(adapter, &addr->bdaddr, addr->type);
>> +       /*
>> +        * For BR/EDR public address, key here is cross-transport derived,
>> +        * so consider it as LE public address for SMP.
>> +        *
>> +        */
>> +       addr_type = addr->type == BDADDR_BREDR ? BDADDR_LE_PUBLIC : addr->type;
> 
> Ditto.
> 
>> +       device = btd_adapter_get_device(adapter, &addr->bdaddr, addr_type);
>>         if (!device) {
>>                 btd_error(adapter->dev_id,
>>                                 "Unable to get device object for %s", dst);
>> @@ -8911,6 +8931,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
>>         struct btd_device *device, *duplicate;
>>         bool persistent;
>>         char dst[18], rpa[18];
>> +       uint8_t addr_type;
>>
>>         if (length < sizeof(*ev)) {
>>                 btd_error(adapter->dev_id, "Too small New IRK event");
>> @@ -8922,16 +8943,22 @@ static void new_irk_callback(uint16_t index, uint16_t length,
>>
>>         DBG("hci%u new IRK for %s RPA %s", adapter->dev_id, dst, rpa);
>>
>> +       /*
>> +        * For BR/EDR public address, key here is cross-transport derived,
>> +        * so consider it as LE public address for SMP.
>> +        *
>> +        */
>> +       addr_type = addr->type == BDADDR_BREDR ? BDADDR_LE_PUBLIC : addr->type;
> 
> Ditto.
> 
>>         if (bacmp(&ev->rpa, BDADDR_ANY)) {
>>                 device = btd_adapter_get_device(adapter, &ev->rpa,
>>                                                         BDADDR_LE_RANDOM);
>>                 duplicate = btd_adapter_find_device(adapter, &addr->bdaddr,
>> -                                                               addr->type);
>> +                                                               addr_type);
>>                 if (duplicate == device)
>>                         duplicate = NULL;
>>         } else {
>>                 device = btd_adapter_get_device(adapter, &addr->bdaddr,
>> -                                                               addr->type);
>> +                                                               addr_type);
>>                 duplicate = NULL;
>>         }
>>
>> @@ -8941,7 +8968,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
>>                 return;
>>         }
>>
>> -       device_update_addr(device, &addr->bdaddr, addr->type);
>> +       device_update_addr(device, &addr->bdaddr, addr_type);
>>
>>         if (duplicate)
>>                 device_merge_duplicate(device, duplicate);
>> @@ -8950,7 +8977,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
>>         if (!persistent)
>>                 return;
>>
>> -       store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
>> +       store_irk(adapter, &addr->bdaddr, addr_type, irk->val);
>>
>>         btd_device_set_temporary(device, false);
>>  }
>> --
>> 2.25.1
>>
>>
> 
> 

