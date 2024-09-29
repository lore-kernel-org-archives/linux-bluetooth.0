Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7CAD2F
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727578315; cv=none; b=Gtw0tzJ0UGYXNVG3m2pM/bUd0WLRBkpT/UUoRqi96IXRZZU3wua4Htb5PYORi+wPDpIDrKU/vg1rOwabeNIpKs4uwRiUNryLkCoyiqtmqu6Hjsb9/rPhvns3PEn/wug/DdL/sOBCa8yrskUk00iUVZV0gn1RrAlXI+8dGfnuP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727578315; c=relaxed/simple;
	bh=+fa+mrILMdmBXhTxm+8SaIY4uECQouuyxAwreXCaZmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jzIXtzhwXI6Rl39httxklbLpDQpbsVFlpdhKJi3VCbWm/QDDifm7S6i+mlVvYQ/pQH2HF4QoJZGGoTNprK001ZSfVfy196AkLRdYB9i2IGyoGeHsYhTVnAX+S/oa0qnuRUmECM6w7b2dpP5cu7fDqXmOjlt4daxUK4NdNWe3SFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dz14q7S+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dz14q7S+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48T10mwM015802;
	Sun, 29 Sep 2024 02:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xmrnmPGrZea2Az1MnNUkgcrEQ89AWXJp9WitROpO3uw=; b=dz14q7S+NFCgRZAq
	lhevvtWs8njV8s2SbOVYZukj7BgceGMosaqtwlLGejHJE/wWCRe36wgVp3HJBwip
	N3mCf3JXFYjGdf5artGRx+cNxRHPr/jXDrqM3uYmDJyczHLk4H0kERhTSBGnPbTE
	FJRu3v4K1R58RERByTErF+Rymk6jcHhXGrF0BCp6FQsC0+lpM4ZERHd/mHmsK0h3
	08AXpNM2iPfDT6qjIga08MZwTrnp/wI5yMmR0p1ta9jQvvmDPcdYvj2Wdoyi5j2O
	YUAJRXos+D9NXni0ZHBnLlLKXkTe/N65rP7Qsij+h3fjYH+vg3hhoYRVTyJ1NK+3
	iN2g1g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa671ha2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Sep 2024 02:51:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48T2pfR6006315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Sep 2024 02:51:41 GMT
Received: from [10.253.77.29] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 28 Sep
 2024 19:51:40 -0700
Message-ID: <fdaf49e9-5a93-42cc-8ae5-9691f4293145@quicinc.com>
Date: Sun, 29 Sep 2024 10:51:38 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Client: Fix the list_attributes command returning
 nothing for a dual-mode remote
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_jiaymao@quicinc.com>
References: <20240927131441.2617450-1-quic_chejiang@quicinc.com>
 <CABBYNZJVVTqw=rz3ndWvak6=9PaQe0H1uwzT5qT+BK5D0R+_yg@mail.gmail.com>
Content-Language: en-US
From: Cheng Jiang <quic_chejiang@quicinc.com>
In-Reply-To: <CABBYNZJVVTqw=rz3ndWvak6=9PaQe0H1uwzT5qT+BK5D0R+_yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F2r4MHI-63Z0urpjI8pIJex_UYPwUkJc
X-Proofpoint-ORIG-GUID: F2r4MHI-63Z0urpjI8pIJex_UYPwUkJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=926 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409290021

Hi Luiz,


On 9/27/2024 10:31 PM, Luiz Augusto von Dentz wrote:
> Hi Cheng,
> 
> On Fri, Sep 27, 2024 at 9:16 AM Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>>
>> When a dual-mode device is paired first on BR/EDR and
>> then on BLE through RPA, the RPA changes to a public
>> address after receiving the IRK. This results in two proxies
>> in default_ctrl->devices with the same public address.
>> In cmd_list_attributes, if the BR/EDR proxy is found first,
>> it prints no attributes.
> 
> This seems to be a bug then, if we resolve the address and there is
> already a device object for it then that shall be used instead of
> keeping 2 different objects paths, fixing bluetoothctl to allow
> multiple proxies with the same device won't do anything for other
> clients so this is just a workaround.
> 
> There seems to be some code for detecting and merging the objects:
> 
> /* It is possible that we have two device objects for the same device in
>  * case it has first been discovered over BR/EDR and has a private
>  * address when discovered over LE for the first time. In such a case we
>  * need to inherit critical values from the duplicate so that we don't
>  * ovewrite them when writing to storage. The next time bluetoothd
>  * starts the device will show up as a single instance.
>  */
> void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup)
> 
> But it doesn't seem to carry over the services, etc, as it seems we
> can't really just use one object at this point then both need to
> interact with each other, perhaps by storing the duplicate into
> btd_device so the right object can be used depending on the bearer,
> etc.
> 
Yes, this is just a workaround for the bluetoothctl client. The device_merge_duplicate
can't handle it. Actually, there are two different dbus interfaces created for the
two device objects. I didn't find a good way to merge these two dbus interface (I'm 
not familiar with dbus). 

Another thought is use the AddressType property to distinguish the two device objects.
however, in current implementation, BR/EDR and BLE public address are both assumed as
"public". Can we add a new string type (like "le_public") in `property_get_address_type`
for BLE public address.

Do you have any idea to get the bearer info in client? 


>> Modify cmd_list_attributes to search all proxies in
>> default_ctrl->devices and display the related attributes.
>> ---
>>  client/main.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 51 insertions(+), 4 deletions(-)
>>
>> diff --git a/client/main.c b/client/main.c
>> index 50aa3e7a6..17c1fb278 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -768,6 +768,29 @@ static GDBusProxy *find_proxy_by_address(GList *source, const char *address)
>>         return NULL;
>>  }
>>
>> +static GList *find_all_proxy_by_address(GList *source, const char *address)
>> +{
>> +       GList *list;
>> +       GList *all_proxy = NULL;
>> +
>> +       for (list = g_list_first(source); list; list = g_list_next(list)) {
>> +               GDBusProxy *proxy = list->data;
>> +               DBusMessageIter iter;
>> +               const char *str;
>> +
>> +               if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
>> +                       continue;
>> +
>> +               dbus_message_iter_get_basic(&iter, &str);
>> +
>> +               if (!strcasecmp(str, address))
>> +                       all_proxy = g_list_append(all_proxy, proxy);
>> +       }
>> +
>> +       return all_proxy;
>> +}
>> +
>> +
>>  static gboolean check_default_ctrl(void)
>>  {
>>         if (!default_ctrl) {
>> @@ -2051,7 +2074,9 @@ static void cmd_disconn(int argc, char *argv[])
>>
>>  static void cmd_list_attributes(int argc, char *argv[])
>>  {
>> -       GDBusProxy *proxy;
>> +       GList *all_proxy = NULL;
>> +       GList *list;
>> +       GDBusProxy *proxy = NULL;
>>         const char *path;
>>
>>         if (argc > 1 && !strcmp(argv[1], "local")) {
>> @@ -2059,11 +2084,33 @@ static void cmd_list_attributes(int argc, char *argv[])
>>                 goto done;
>>         }
>>
>> -       proxy = find_device(argc, argv);
>> -       if (!proxy)
>> +       if (argc < 2 || !strlen(argv[1])) {
>> +               if (default_dev) {
>> +                       proxy = default_dev;
>> +                       path = g_dbus_proxy_get_path(proxy);
>> +                       goto done;
>> +               }
>> +               bt_shell_printf("Missing device address argument\n");
>>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       } else {
>> +               if (check_default_ctrl() == FALSE)
>> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE);
>>
>> -       path = g_dbus_proxy_get_path(proxy);
>> +               all_proxy = find_all_proxy_by_address(default_ctrl->devices,
>> +                                                               argv[1]);
>> +               if (!all_proxy) {
>> +                       bt_shell_printf("Device %s not available\n", argv[1]);
>> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +               }
>> +               for (list = g_list_first(all_proxy); list;
>> +                                               list = g_list_next(list)) {
>> +                       proxy = list->data;
>> +                       path = g_dbus_proxy_get_path(proxy);
>> +                       gatt_list_attributes(path);
>> +               }
>> +               g_list_free(all_proxy);
>> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +       }
>>
>>  done:
>>         gatt_list_attributes(path);
>> --
>> 2.25.1
>>
>>
> 
> 

