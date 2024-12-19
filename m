Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927F1B6544;
	Thu, 19 Dec 2024 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638856; cv=none; b=XcjTWmyM95Q0DB9FO4C4ucWszXtYzMpwIil08HWt4HcQVwbaOwd2aFG8AFT8Gbah3VTIPPbBFR3IQgCaYjK5mHj/lmbzfj2EY3IuCuILt3J7QoM99S6qPiOBiogSAPII3KknP6JafAXYSgQo7XcPuq4rt6xhF51z1lmNj1sMNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638856; c=relaxed/simple;
	bh=B0Xp3A2yPEfIcAATIlJ24RIYtizsHOQuyhvi7wd1kCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UoMzod8Ec0AhF+D5zBcCCWLptX4pci4KivgDp75mnXwMyy4oBk3x7zOFvh7dO496b/XC9PoIL8OKCTOOldHEf5r5HLhL8iXcP0SfQMi4/z1Zo8ZUL5Ed7IEim8c7mUH6p7Q9GJ9njERJP756rT9O2fhitE24019AM1LGSjEbTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=AhgQkgiK; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="AhgQkgiK"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B4648100005;
	Thu, 19 Dec 2024 23:07:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B4648100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1734638843;
	bh=k30LIFlh1WzNLysVHl9oy4Bw2pAysphoNeGqoYRO53M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=AhgQkgiKXJ2AneCyi0DMBc9/Fz0xv51QV2eDqDWPD4RMjtXP/XA1wFNPwQnoXpAvV
	 5Ag9ZKcHojIwyqnthA5lTStgqon5HdMr7OIWoBwDYYJ13cM0GE9Vy2EpwFXsMxwh7H
	 kpuHzGWMPuPH6aI0oL2nZxTcWtvEQejXT2m6oNtUWPRges5mRpwO/9jwaNLIv06CyN
	 hXD6dObf0w7I3OuBTY2k+0zE1dL7jApjgwY6LSM3VZ+7t5bS5HA/UVMzrTz3QcwETQ
	 nwRQGzUxt4Nt6klt/MKFTuGRR+P9A/kHzWRDvSzTNlwxOxa1V4capGGFjCRFbwAtIw
	 xpWM7X4r84Lcg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 19 Dec 2024 23:07:23 +0300 (MSK)
Message-ID: <b7fdaca1-b127-71c2-3286-2dd68b59f746@salutedevices.com>
Date: Thu, 19 Dec 2024 23:07:22 +0300
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
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, <oxffffaa@gmail.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
 <4ef9c3a9-a8c4-fb98-2244-ed2770f71c17@salutedevices.com>
 <CABBYNZKXJAvOQie37yCgNUTct2HXzPYNNqNN5Am+pGViGe1=Gw@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CABBYNZKXJAvOQie37yCgNUTct2HXzPYNNqNN5Am+pGViGe1=Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189958 [Dec 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_uf_ne_domains}, {Tracking_arrow_http, text}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;patchwork.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/19 19:31:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/19 19:31:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/19 19:16:00 #26891781
X-KSMG-AntiVirus-Status: Clean, skipped



On 19.12.2024 22:01, Luiz Augusto von Dentz wrote:
> Hi Arseniy,
> 
> On Thu, Dec 19, 2024 at 1:42 PM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>> Hi, sorry i'm new in bluetooth subsystem. I get the following
>> message from CI:
>> https://patchwork.kernel.org/project/bluetooth/list/?series=918554
>> Where one of tests was failed. Where I can get more information
>> about failure:
>>
>> tedd_an/TestRunner_mgmt-tester  fail    TestRunner_mgmt-tester: Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4
> 
> These looks like a false positives, your changes should affect the
> tests since that run with hci_vhci driver, not the uart ones.

Got it,

Thanks

> 
>> ?
>>
>> Thanks
>>
>> On 17.12.2024 11:12, Arseniy Krasnov wrote:
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
>>>
>>>  drivers/bluetooth/hci_ldisc.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>>> index 30192bb083549..07b9aa09bbe2e 100644
>>> --- a/drivers/bluetooth/hci_ldisc.c
>>> +++ b/drivers/bluetooth/hci_ldisc.c
>>> @@ -704,12 +704,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
>>>
>>>       hu->proto = p;
>>>
>>> +     set_bit(HCI_UART_PROTO_READY, &hu->flags);
>>> +
>>>       err = hci_uart_register_dev(hu);
>>>       if (err) {
>>>               return err;
>>>       }
>>>
>>> -     set_bit(HCI_UART_PROTO_READY, &hu->flags);
>>>       return 0;
>>>  }
>>>
> 
> 
> 
