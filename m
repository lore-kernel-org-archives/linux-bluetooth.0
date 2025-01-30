Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09701482E1;
	Thu, 30 Jan 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262115; cv=none; b=r7P/d3oy5pLG1nSSveIgfFVsTSIQqe3n5wfzirdpV3oJTZuHcA1g+7x24rCfJrZ9RPftHsV/Mie22tyh8rx5weTFgqOjnVmxVQM97UFDN9BFQgDXCFD8PIJhS1fPwIZ79CyGXycpjJnTTX7JNxrwWQ+krM9a9czM20vb0nIRIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262115; c=relaxed/simple;
	bh=TwAAoJer/FPnpvBQxGFZ60k7H5CAyYtl65JkhxpM9DA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=KsxekG9viljW8KNClK396iMgfGslVjFxJnGK1Q80e0LOpyWXfLUsHAjMHTPuHqckZG/p6VcDtcztuLsszrLNYVidAzbVVM6BDckR5Tj4JyuYd/lpfeBk3kdPE+c8uM+CA0AH25yf0WEu/hS5uq5CnxoZERx8hF5dnSc+rzZ5sQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=tSHLTJPX; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="tSHLTJPX"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4D9AB120006;
	Thu, 30 Jan 2025 21:34:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4D9AB120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1738262095;
	bh=pDRf5BLR0/0IYmafaREu9IPC4OM9eMc7Mv+ojVZWcio=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:From;
	b=tSHLTJPXbbJ2xABGU65bbxvB48O+kwGMCL5OJs1D+1r77mgxpB5ZTGaImZM57n3B7
	 wu9H3RSsqbLaIBa5h/awhMXClDcgxAKDMLQbCCrZQI8vWGsp7G8lz/gJ5CAjl2PnYp
	 qBuwSNVBscCa3YExK622Dt9eKGczmTrRjqWl2hDdyft0jJXSCFUf/X8tLZZeSfNgUk
	 yj2uvuAkawxE2fXb63PlFBqLYm41sQeRMh7egziUyLPZBxuHn0OSLVdZn2/DbFTCfb
	 WmZviYDflcQrWeBKa5C/PA3X/7hThnJU2tISCM5GHpzI7pZcaz9nZTqJcEucnGx1DQ
	 133LI6Q+jCCNw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 30 Jan 2025 21:34:55 +0300 (MSK)
Message-ID: <95904850-fe5c-4866-3da6-3e021c6becf8@salutedevices.com>
Date: Thu, 30 Jan 2025 21:34:10 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] Bluetooth: hci_uart: fix race during initialization
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, <oxffffaa@gmail.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
 <CABBYNZLa9amkcQzqRyiCK7acKeXiPLkfX8thMonQhXN+5PnmmQ@mail.gmail.com>
 <e0b77a36-2d2b-735c-7a23-bbaab5adeba7@salutedevices.com>
 <a2a239f1-5697-cb09-5e4f-83c024fd5ea6@salutedevices.com>
Content-Language: en-US
In-Reply-To: <a2a239f1-5697-cb09-5e4f-83c024fd5ea6@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190694 [Jan 30 2025]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 50 0.3.50 df4aeb250ed63fd3baa80a493fa6caee5dd9e10f, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/01/30 12:39:00 #27158825
X-KSMG-AntiVirus-Status: Clean, skipped

Hi, sorry ping

Thanks

On 08.01.2025 15:39, Arseniy Krasnov wrote:
> 
> 
> On 19.12.2024 23:07, Arseniy Krasnov wrote:
>>
>>
>> On 19.12.2024 22:18, Luiz Augusto von Dentz wrote:
>>> Hi Arseniy,
>>>
>>> On Tue, Dec 17, 2024 at 3:12 AM Arseniy Krasnov
>>> <avkrasnov@salutedevices.com> wrote:
>>>>
>>>> 'hci_register_dev()' calls power up function, which is executed by
>>>> kworker - 'hci_power_on()'. This function does access to bluetooth chip
>>>> using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
>>>> Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
>>>> if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
>>>> 'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
>>>> be executed before setting this bit. In that case HCI init logic fails.
>>>>
>>>> Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
>>>> 'hci_uart_register_dev()'.
>>>>
>>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>>> ---
>>>>  Changelog v1->v2:
>>>>  * Move 'set_bit()' before 'hci_uart_register_dev()' instead of
>>>>    adding new bit 'HCI_UART_PROTO_INIT'.
>>>
>>> What drivers/controllers this was tested with? I want to make sure
>>> this doesn't cause regressions to other drivers if there are perhaps
>>> some drivers assuming HCI_UART_PROTO_READY was set in a certain order.
>>
>> Hi,
>>
>> I tested this on:
>>
>> CONFIG_BT=y
>> CONFIG_BT_HCIUART=y
>> CONFIG_BT_HCIUART_H4=y
> 
> Hi, sorry, but is this enough info about my test env ?
> 
> Thanks
> 
>>
>> Yes, my v1 patchset with extra INIT bit was targeted to keep
>> original behaviour - e.g. PROTO_READY bit usage still the same,
>> just adding extra bit to handle this specific case.
>>
>> Thanks
>>
>>>
>>>>  drivers/bluetooth/hci_ldisc.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>>>> index 30192bb083549..07b9aa09bbe2e 100644
>>>> --- a/drivers/bluetooth/hci_ldisc.c
>>>> +++ b/drivers/bluetooth/hci_ldisc.c
>>>> @@ -704,12 +704,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
>>>>
>>>>         hu->proto = p;
>>>>
>>>> +       set_bit(HCI_UART_PROTO_READY, &hu->flags);
>>>> +
>>>>         err = hci_uart_register_dev(hu);
>>>>         if (err) {
>>>>                 return err;
>>>>         }
>>>>
>>>> -       set_bit(HCI_UART_PROTO_READY, &hu->flags);
>>>>         return 0;
>>>>  }
>>>>
>>>> --
>>>> 2.30.1
>>>
>>>
>>>
