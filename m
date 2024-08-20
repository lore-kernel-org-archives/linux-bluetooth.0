Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B22191476
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162667; cv=pass; b=poDW9dmb9DnTr7kbmjRtwWcj0ekGH39pR0TYSepvbEkscuJGBNbpqYzXuYAzzK8xymxFllvgPAphp32A+o1/1JF94YyB2o4+sVqsOMmhY/iVAnt8ynfLgBgRjncFHReikmBhQtOzsmOCnDsUd6q2DT1ka8YsGbTv4xbe00LXfxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162667; c=relaxed/simple;
	bh=A4NW1yg+fl/nHZrZLJikCceHKNv1o7J4XmcLlw4jRd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlRcdzqJMKpo8BZeRo8SL4Kq0GdbncXU7OmbSg2d/WE4wY6sFue+CutmmC5bHVWRKT0qrNnOVbUlP9vcABxnbytf4COM4zZQQUammgwBK0DPKCc10zV5z3F9uY3I/6l8dj9RUUFXz3m32L/njcbReNnWnZ7nzSZ7dTx4zPMincQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=BxXaZ5iu; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="BxXaZ5iu"
ARC-Seal: i=1; a=rsa-sha256; t=1724162661; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mz7tsNghXcPvBNvVBdsuenezjvcI0RV6Q6a4NCfebL8kK5wNOLs6EMkFjpjxg/L+jSoZVmlBeTS5WoWaLG1yCEScFhgqyeA5kZ7sJGg1pfxZwq7zjkoyuQjP995mO2gL8vUQCV9QzFczX6HYkwhVuTUWchHwpTJU0MymJirxBNc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724162661; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0Ud9NghJIIlZGeIo/8KuLkX2pdvHz+Va3xHSC9BZRCs=; 
	b=LgbSI00KqggIhhKzvFC9tq3MRUnS9BLdxCXOmPy2Fm6blcosfKbdVd9fONOfkMD+Kyisz/CNVE21izDLbbk4430J4s7LhTbDJVqLr+a0sA2aVmEEQfHq47L+SPCz7KzM+XX9BpqB2J4oGKv+DQKjCYdg+D6IfyzHnK1g1SW3am4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724162661;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0Ud9NghJIIlZGeIo/8KuLkX2pdvHz+Va3xHSC9BZRCs=;
	b=BxXaZ5iufcdEbkZ+51nloSCBa80+mMIYzPAj/DmBXRlc5NNrhAO3xO1Oun20ClRl
	eYpARMD1vhwDYkQN1Y4B7T3js9dtMez1yuxKw9HQzde3qSch8yj1AmZO/JGeB4OnCbI
	Fuq0I3BCO3HVDHGX6GEHmjEmImhv+E4O9ZM11W9s=
Received: by mx.zohomail.com with SMTPS id 172416266005230.829279300486974;
	Tue, 20 Aug 2024 07:04:20 -0700 (PDT)
Message-ID: <7ddf521f-4c43-4217-859a-aa59468b8e3a@collabora.com>
Date: Tue, 20 Aug 2024 16:04:17 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_bcm: Use speed set by btattach as
 oper_speed
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240814130018.263129-1-frederic.danis@collabora.com>
 <CABBYNZJsmq6KYEZi9+KbdtN40uoi+6M6j+D5-a732X_34H1-fA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZJsmq6KYEZi9+KbdtN40uoi+6M6j+D5-a732X_34H1-fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 19/08/2024 16:49, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Wed, Aug 14, 2024 at 9:07 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> Starting a BCM UART controller not defined as a platform device or
>> a serdev with "btattach -B /dev/ttyS1 -P bcm -S 3000000" works fine
>> but the serial port remains at the init_speed, i.e. 115200.
>>
>> The oper_speed is only set if a device is declared in ACPI, device
>> tree or as a platform device.
>>
>> When no registered device has been found this commit will use the
>> current tty speed set by btattach as the oper_speed.
>>
>> Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
>> ---
>>
>> This has been tested with 5.4 kernel only.
>> Afaict there's no change in this driver which should be impacted by
>> this commit in latest kernel.
>>
>>   drivers/bluetooth/hci_bcm.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index 89d4c2224546..57cacf63ae12 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -508,6 +508,11 @@ static int bcm_open(struct hci_uart *hu)
>>
>>                  if (err)
>>                          goto err_unset_hu;
>> +       } else {
>> +               /* This is not a serdev or platform device, it should have been started by
>> +                * btattach, in this case use the tty speed set by btattach as oper_speed
>> +                */
>> +               hu->oper_speed = hu->tty->termios.c_ospeed;
>>          }
> While Im fine with the general idea of derive the speed from the tty
> what Im not sure where it should be done since doing this on the
> driver may duplicate the logic if we later found there is a better
> place to do it.
>
> Looks at hci_uart.c it seems like we could actually register a set_termios:
>
>   * @set_termios: [TTY] ``void ()(struct tty_struct *tty, const struct
> ktermios *old)``
>   *
>   *    This function notifies the line discpline that a change has been made
>   *    to the termios structure.
>   *
>   *    Optional.
>
> So I assume when the user changes the speed the above callback gets
> called and we could then reflect the changes to the oper_speed, or
> perhaps the real problem was that hci_uart_set_baudrate was not
> called?

The hci_uart_set_baudrate is called correctly as when I forced the 
oper_speed the serial port speed changes accordingly and I saw the 
hci_uart_set_baudrate debug trace.

Unfortunately, the serial port speed is fixed by btattach before setting 
the line discipline, so that the set_termios is not called in this case.
But above all, set_termios is called each time the driver change the 
speed, i.e. when it sets the initial speed.

I will send a new patch to copy the serial port speed to the oper_speed 
in hci_uart_tty_open() of drivers/bluetooth/hci_ldisc.c.

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

