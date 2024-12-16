Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D6199B9;
	Mon, 16 Dec 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361617; cv=none; b=KmImcBpoa3pqswxq6071eBXV3grLBHbrcj9p+feo42Y6G/jop9AEhbks9hJCt7XGYR1h7KlmPA7GDxYBis4N96oXwCj9/Gr6ePQYNoKfMmF2oRwXAnm5LYh6eWm5t0liTkXStK/uXvHj+0sL8BMSej3Z0HPRGq5zMKXI6fztYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361617; c=relaxed/simple;
	bh=TzEoTsBvaYARaeayDsoIBjOQEdXasZhzTjqMqIPOgVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LkWDdcpOhak9OqoETribwtNWH/8J4IKE7C2fKsEnYhmdOyXOTAk5agNrqD7dBAyxDS0ZisREOk2Oj6yoflhi+vlhZAKB6pfp+Dm4HsMoeFk/VOi2HsF4EOcQbv2v472o3S1rJLZz+S53/VzKUPRT5nEChh+2+VRosNF8hUvUxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=betIl4PQ; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="betIl4PQ"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 46778100003;
	Mon, 16 Dec 2024 18:06:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 46778100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1734361597;
	bh=sFyGMIe/cWHSGp4/ziUFRDWY1kSa8zme+CKERgruf/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=betIl4PQPP6phE/CC9a3GdUyBBnz4i+4oSHuSspr94SdcUK7J7nh0zA4tWsMmPuER
	 XR5aJqguIq05yY+7GajqWcQ0HoQLCHSgXpkXGvPW5lNg5+LJCf7Bib+A8M2P1M4r53
	 5zcLwa6iaSaLNM1/c2xdtXIAnt/vnV/nQCqo4euexYyDlV2usmbmfLBFDcM7pAEsWW
	 bSewN1Ora7nuaEd/caTSBcg2qJm/q0/2yIlseOwFWr4BBRBx8pYxWilObn8a/ijOMd
	 D2C9IHKGZJ0ZvC19pq9Z1ilTrBODoOQxMKSO5oZ5Nsdke6nVYdX0J//7YYXeIRuS2G
	 GZXviGDvIIK4Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 16 Dec 2024 18:06:37 +0300 (MSK)
Message-ID: <609417f4-68c8-a382-0d95-04000c9df5cf@salutedevices.com>
Date: Mon, 16 Dec 2024 18:06:36 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1] Bluetooth: hci_uart: fix race during initialization
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oxffffaa@gmail.com>,
	<ddrokosov@salutedevices.com>
References: <a1db0c90-1803-e01c-3e23-d18e4343a4eb@salutedevices.com>
 <CABBYNZL6ZJkf=jQpdUyxYxZZwqRjHxWzDk4nCb74xdB78-33yg@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CABBYNZL6ZJkf=jQpdUyxYxZZwqRjHxWzDk4nCb74xdB78-33yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189864 [Dec 16 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 47 0.3.47 57010b355d009055a5b6c34e0385c69b21a4e07f, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/16 12:28:00 #26886242
X-KSMG-AntiVirus-Status: Clean, skipped



On 16.12.2024 17:52, Luiz Augusto von Dentz wrote:
> Hi Arseniy,
> 
> On Wed, Nov 27, 2024 at 7:38 AM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>> 'hci_register_dev()' calls power up function, which is executed by
>> kworker - 'hci_power_on()'. This function does access to bluetooth chip
>> using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
>> Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
>> if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
>> 'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
>> be executed before setting this bit. In that case HCI init logic fails.
>>
>> Patch adds one more bit in addition to 'HCI_UART_PROTO_READY' which
>> allows to perform power up logic without original bit set.
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>  drivers/bluetooth/hci_ldisc.c | 19 ++++++++++++++-----
>>  drivers/bluetooth/hci_uart.h  |  1 +
>>  2 files changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index 30192bb083549..2e20f00649bd7 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -102,7 +102,8 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
>>         if (!skb) {
>>                 percpu_down_read(&hu->proto_lock);
>>
>> -               if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
>> +               if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
>> +                   test_bit(HCI_UART_PROTO_INIT, &hu->flags))
>>                         skb = hu->proto->dequeue(hu);
>>
>>                 percpu_up_read(&hu->proto_lock);
>> @@ -124,7 +125,8 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
>>         if (!percpu_down_read_trylock(&hu->proto_lock))
>>                 return 0;
>>
>> -       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
>> +       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
>> +           !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
>>                 goto no_schedule;
>>
>>         set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
>> @@ -278,7 +280,8 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>>
>>         percpu_down_read(&hu->proto_lock);
>>
>> -       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>> +       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
>> +           !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
>>                 percpu_up_read(&hu->proto_lock);
>>                 return -EUNATCH;
>>         }
>> @@ -582,7 +585,8 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
>>         if (tty != hu->tty)
>>                 return;
>>
>> -       if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
>> +       if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
>> +           test_bit(HCI_UART_PROTO_INIT, &hu->flags))
>>                 hci_uart_tx_wakeup(hu);
>>  }
>>
>> @@ -608,7 +612,8 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
>>
>>         percpu_down_read(&hu->proto_lock);
>>
>> -       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>> +       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
>> +           !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
>>                 percpu_up_read(&hu->proto_lock);
>>                 return;
>>         }
>> @@ -704,12 +709,16 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
>>
>>         hu->proto = p;
>>
>> +       set_bit(HCI_UART_PROTO_INIT, &hu->flags);
>> +
>>         err = hci_uart_register_dev(hu);
>>         if (err) {
>>                 return err;
>>         }
>>
>>         set_bit(HCI_UART_PROTO_READY, &hu->flags);
>> +       clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
> 
> This should be quite obvious, why don't you just move the
> HCI_UART_PROTO_READY above hci_uart_register_dev?
> 

Hi, this is simplest way, but I had doubts that this may be so obvious because
I don't have enough experience in bt logic.

I'll send v2 with it.

Thanks

>>         return 0;
>>  }
>>
>> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
>> index 00bf7ae82c5b7..39f39704be41f 100644
>> --- a/drivers/bluetooth/hci_uart.h
>> +++ b/drivers/bluetooth/hci_uart.h
>> @@ -89,6 +89,7 @@ struct hci_uart {
>>  #define HCI_UART_REGISTERED            1
>>  #define HCI_UART_PROTO_READY           2
>>  #define HCI_UART_NO_SUSPEND_NOTIFIER   3
>> +#define HCI_UART_PROTO_INIT            4
>>
>>  /* TX states  */
>>  #define HCI_UART_SENDING       1
>> --
>> 2.30.1
> 
> 
> 
