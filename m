Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A835948;
	Thu, 19 Dec 2024 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633783; cv=none; b=kSIro5QW76DZMyvPhVm/2edWV8hPzGfheHE2KNsJQ9bV1ilHsNIuZnxDG1Csp12ulduo8O7ZLyBs4Fhv2mTzhDIE4JAjiSRZdN20e7J3BqxgN5jHPjBk/q5+U9C3C+CqgGbcyAYAhL3IP8cafuBZhY4hRgUrV1GFPTsZaix8Juw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633783; c=relaxed/simple;
	bh=JVoO4kNfpxLIokbCUppurFxG/LXqe2Sag3iMswzKh1s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=WYFyhhRwRd2oypVmSlqAku3uC91lTr/XGjW+6DL23qMQRoEnrdPFj8OkS7lk1YgmRgJ8aE6ZHOFZgZSm1d+NUqBjv9FD48RceRRK4r7Axe9h7Xnerl5ssSy+OFpakJObhbAhJC0WIy97TxUkzLOcRllfJFU7cvCJE5Mmy9LSyqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=O9hPinNP; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="O9hPinNP"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 27F1B120010;
	Thu, 19 Dec 2024 21:42:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 27F1B120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1734633756;
	bh=esL9DkuK7JtVtcWQZeaz4UPNp+QhH3Q1Gw/XCsJDSic=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:From;
	b=O9hPinNPz6kxzm8oXspY2cHhVk8ejbzHg1tfwX+vNykRTA0saOmhTwPAiyw3n8FaW
	 QEPFUEFUoVmKGiLkNDIR+XBRPchjuN6Pjiw4vNBf2b+2R9a2LDmi7oSjp/69U3yMLW
	 nBgJVVQcqC8Dk9gBYRorQEMuCRvCmCXjJjD1T466TfvdSRxLe27b2kPcmU+wqI9Kbh
	 FXUqHctMYBBq5YdHtRnQCoytmNhDxP7WHTGH/7F6S278Xf/6poAs+v7wnn5hNiAJLn
	 LS4HLDn2jftkPj22V8/wE1SxKuol9b1H6FI/nhkblIKi/nNzuAJmrdOvFvHXzz5LXp
	 oVmwHgLqsT/cA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 19 Dec 2024 21:42:35 +0300 (MSK)
Message-ID: <4ef9c3a9-a8c4-fb98-2244-ed2770f71c17@salutedevices.com>
Date: Thu, 19 Dec 2024 21:42:26 +0300
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
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <oxffffaa@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
References: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
In-Reply-To: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189957 [Dec 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, patchwork.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/19 18:23:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/19 18:23:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/19 17:48:00 #26892060
X-KSMG-AntiVirus-Status: Clean, skipped

Hi, sorry i'm new in bluetooth subsystem. I get the following
message from CI:
https://patchwork.kernel.org/project/bluetooth/list/?series=918554
Where one of tests was failed. Where I can get more information
about failure:

tedd_an/TestRunner_mgmt-tester 	fail 	TestRunner_mgmt-tester: Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4 

?

Thanks

On 17.12.2024 11:12, Arseniy Krasnov wrote:
> 'hci_register_dev()' calls power up function, which is executed by
> kworker - 'hci_power_on()'. This function does access to bluetooth chip
> using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
> Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
> if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
> 'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
> be executed before setting this bit. In that case HCI init logic fails.
> 
> Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
> 'hci_uart_register_dev()'.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  Changelog v1->v2:
>  * Move 'set_bit()' before 'hci_uart_register_dev()' instead of
>    adding new bit 'HCI_UART_PROTO_INIT'.
> 
>  drivers/bluetooth/hci_ldisc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 30192bb083549..07b9aa09bbe2e 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -704,12 +704,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
>  
>  	hu->proto = p;
>  
> +	set_bit(HCI_UART_PROTO_READY, &hu->flags);
> +
>  	err = hci_uart_register_dev(hu);
>  	if (err) {
>  		return err;
>  	}
>  
> -	set_bit(HCI_UART_PROTO_READY, &hu->flags);
>  	return 0;
>  }
>  
