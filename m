Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050581A239D;
	Wed,  8 Jan 2025 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339970; cv=none; b=bOJBy0oj+DcBBPUNfzyQyHv1AZCkVPmWATYFiPTQdA8Od/o8Zs4u0IvjWyi4cBA+0QyTpwVhLgLX5DKGT04UY8t7zdWv9YXptVYj9bl3slQTTE7hi+Enj3ELl0TvGgba4CDh1hGe9TkiBRVjm3/z/cSb3kPfsK/sbIx4y/oxEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339970; c=relaxed/simple;
	bh=XH9IH6sC5U/ziFuIzuSImom6w0SlRKU/nrd277+5cok=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=dpvpgZ+dSFYzemvrBAd2HTvOQOik4ySSDjlLPoe5gV8Vje4zZPp9nISyuPHtJCbJwLk5sn5rI2NP+L/cE/br3DVdlpqKA0+RfmsrENyaBmHDS4uXfnCxMEflaMxqJ9MCUiyzK6vml1ASQZcRl6CelvqHQBeB5kHtt7OYFBjAUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=BmlC4van; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="BmlC4van"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id EC0B5120005;
	Wed,  8 Jan 2025 15:39:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EC0B5120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1736339951;
	bh=tj6wMZp0GAgUNNfdnRo+2iL01SARqXzeI+FblcEH2hs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:From;
	b=BmlC4vanP7+6Lup+wFyUGVUdVlNy9ZdLzMSsv3Uy0MBziDeqZnXu0ebGvg1z5HQzk
	 xFt6pSIGklc/q5RzX3ucZpBIr2PzfelRuUltYeFeANbYmNI1AUKH6J46CHOmADa1ir
	 Cw35lhRse8w6+B5Dtc3O3wRrnsm2bhdTsWR9wTBWkYGd8aSkccMQgjl28wIT5ToKHU
	 AXMflDwmwviIaMSYeWv4ZPVis0nFgIuGGxnT3W0fWY/kL8prc984b5A5Hkk8bohDxh
	 tGKZJv0eR2r43QY066EqF1xI7y/Yx4kiuGrjJeHJtl6O6BRSXEwSBleYu5dPYU3KIY
	 eYZw4u5S1u2bg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  8 Jan 2025 15:39:11 +0300 (MSK)
Message-ID: <a2a239f1-5697-cb09-5e4f-83c024fd5ea6@salutedevices.com>
Date: Wed, 8 Jan 2025 15:39:04 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] Bluetooth: hci_uart: fix race during initialization
Content-Language: en-US
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, <oxffffaa@gmail.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
 <CABBYNZLa9amkcQzqRyiCK7acKeXiPLkfX8thMonQhXN+5PnmmQ@mail.gmail.com>
 <e0b77a36-2d2b-735c-7a23-bbaab5adeba7@salutedevices.com>
In-Reply-To: <e0b77a36-2d2b-735c-7a23-bbaab5adeba7@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190199 [Jan 08 2025]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/01/08 10:11:00 #26958959
X-KSMG-AntiVirus-Status: Clean, skipped



On 19.12.2024 23:07, Arseniy Krasnov wrote:
> 
> 
> On 19.12.2024 22:18, Luiz Augusto von Dentz wrote:
>> Hi Arseniy,
>>
>> On Tue, Dec 17, 2024 at 3:12 AM Arseniy Krasnov
>> <avkrasnov@salutedevices.com> wrote:
>>>
>>> 'hci_register_dev()' calls power up function, which is executed by
>>> kworker - 'hci_power_on()'. This function does access to bluetooth chip
>>> using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
>>> Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
>>> if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
>>> 'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
>>> be executed before setting this bit. In that case HCI init logic fails.
>>>
>>> Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
>>> 'hci_uart_register_dev()'.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>>  Changelog v1->v2:
>>>  * Move 'set_bit()' before 'hci_uart_register_dev()' instead of
>>>    adding new bit 'HCI_UART_PROTO_INIT'.
>>
>> What drivers/controllers this was tested with? I want to make sure
>> this doesn't cause regressions to other drivers if there are perhaps
>> some drivers assuming HCI_UART_PROTO_READY was set in a certain order.
> 
> Hi,
> 
> I tested this on:
> 
> CONFIG_BT=y
> CONFIG_BT_HCIUART=y
> CONFIG_BT_HCIUART_H4=y

Hi, sorry, but is this enough info about my test env ?

Thanks

> 
> Yes, my v1 patchset with extra INIT bit was targeted to keep
> original behaviour - e.g. PROTO_READY bit usage still the same,
> just adding extra bit to handle this specific case.
> 
> Thanks
> 
>>
>>>  drivers/bluetooth/hci_ldisc.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>>> index 30192bb083549..07b9aa09bbe2e 100644
>>> --- a/drivers/bluetooth/hci_ldisc.c
>>> +++ b/drivers/bluetooth/hci_ldisc.c
>>> @@ -704,12 +704,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
>>>
>>>         hu->proto = p;
>>>
>>> +       set_bit(HCI_UART_PROTO_READY, &hu->flags);
>>> +
>>>         err = hci_uart_register_dev(hu);
>>>         if (err) {
>>>                 return err;
>>>         }
>>>
>>> -       set_bit(HCI_UART_PROTO_READY, &hu->flags);
>>>         return 0;
>>>  }
>>>
>>> --
>>> 2.30.1
>>
>>
>>
