Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33101487E1;
	Thu, 30 Jan 2025 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262611; cv=none; b=hbYxtHuINg5Yl44zpEef/BGf6R/GAHBH6qTbvFpg0JwUnculz0jFiJg88Hzn0HVt29CGSQhFT1obXFOClc2xFwDXZw8Ayk7xesabqcC4Q3XTTBbNw+YyI0Vt52bEIEDTwFsk59LZf9pskfb/wfHwFAKYICZSi9idIhC65FTUclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262611; c=relaxed/simple;
	bh=VQoQE1pvDps6u/TV5tR/+cZkT00vTknF3QtDIvmdGAk=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:CC:
	 In-Reply-To:Content-Type; b=MXiTtV22ca6tl0FRCk5+ZbOrV/c4Ka8o9xgh9CczbdWuLahyXdgqm4RDT9r47nDBxWrP6MyYDNLXHhyjMwqo3izf2jgt5ILKJSWtIAvPhvoC+H8s5rb1Hyvvi0CuFImzbPmWiEcYld3JmoctaWbk7peb+ZPRlk6Np8ocjNqg2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=dcv5lnSu; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="dcv5lnSu"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 92628120007;
	Thu, 30 Jan 2025 21:43:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 92628120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1738262607;
	bh=Vc5nQTsMDqaeAk7HGlOpFwI9UvyMNhXjT59IqE4f+TA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
	b=dcv5lnSuEUJGbW7vQ/J6f75ExufMEmpbm8ARnbSZsEAU2L4I+oRu+GU3P2D2NlXfl
	 rPJfRuOlLvH2+OLUxeNVzqxk7zcLRGv1xu4MnNtl4mJX4x1knkIbiFxVkD5we4LdQX
	 2le1WEGrlv8uDCxJBHdEBxxt5i8NHVUz3hu9R3C8dXe2kYWo1m5nbDS1RXiibm5MwH
	 5IJ1NctCu7/JTjtk73Udv6Ow8wGTMt6VCtR4+dj6lu20ypoc5+vEK+SHUAUWWDT1mo
	 J/PSzBc0Tge+sHa+gTiZo3PrrZKze4I/CLi1PmV/kMhFcnQ/lPLAF7EsIlY+nZC0fJ
	 pk6w0I9zRRa9g==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 30 Jan 2025 21:43:27 +0300 (MSK)
Message-ID: <3674b7a9-109e-19d7-4db8-02e9a724c314@salutedevices.com>
Date: Thu, 30 Jan 2025 21:43:26 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [RESEND PATCH v2] Bluetooth: hci_uart: fix race during initialization
Content-Language: en-US
References: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <oxffffaa@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
In-Reply-To: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
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
X-KSMG-AntiSpam-Info: LuaCore: 50 0.3.50 df4aeb250ed63fd3baa80a493fa6caee5dd9e10f, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/01/30 12:39:00 #27158825
X-KSMG-AntiVirus-Status: Clean, skipped

'hci_register_dev()' calls power up function, which is executed by
kworker - 'hci_power_on()'. This function does access to bluetooth chip
using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
be executed before setting this bit. In that case HCI init logic fails.

Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
'hci_uart_register_dev()'.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 Changelog v1->v2:
 * Move 'set_bit()' before 'hci_uart_register_dev()' instead of
   adding new bit 'HCI_UART_PROTO_INIT'.

 drivers/bluetooth/hci_ldisc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 30192bb083549..07b9aa09bbe2e 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -704,12 +704,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
-	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 	return 0;
 }
 
-- 
2.30.1
