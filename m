Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36B126BF7;
	Tue, 17 Dec 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423148; cv=none; b=ZYWcFan92/xrD/gatb81fBfbYh+DmQ1EaamdhomqJYGD32wqPdBSn3JazhJgXkfQP/xsFhNXR7JvCV3ZtQxrZrNORKTHpyoVOf+ZdACIBeORizDYvZ+7c3GGd5Vhq5b8eLifZVMhRNgrjgIhjrdecZRIKtrXPwQIG/HgkSSbuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423148; c=relaxed/simple;
	bh=VQoQE1pvDps6u/TV5tR/+cZkT00vTknF3QtDIvmdGAk=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=jylHnYuf+aZoiMcDiFj3CX8/yyzVo4uITeaGTNOoO+xXLCw0ThjVcEf5Jzgy/UTX/0YL0feE68X8Q9ELNmLgdP+6V0MTsbtgqxS0yP+LHwuW4GY+lrMUxQ3ERuev7oUi9RiZtmHjyr+lTZlFZMiVGGLZRYWmcJi6NEhSs0FwxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Oa4KZcRd; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Oa4KZcRd"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 86C8E120005;
	Tue, 17 Dec 2024 11:12:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 86C8E120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1734423134;
	bh=Vc5nQTsMDqaeAk7HGlOpFwI9UvyMNhXjT59IqE4f+TA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:From;
	b=Oa4KZcRdDq4IoWRLLehI8LZt69Xj+Vgm0JcvvMaSJJvfW+N3z4JV7mC1TdnqHL2aC
	 mWr6vCnSwudGvP6CipiBAnb9hGuyWO4lTbP/1IyBdXWZJxN0ehoiaHT3DWHcDMb8dJ
	 BiZqGytwvg0BAKMpiyUbEUY/4VJ1E/WnIhQTGKM2BWq9ljBilZcgr76sObCvC9IoRU
	 uKv6tsPrhWuH4PVtIZay6MhuRYHdfELHJkEPpFYvl2YokXz0fZ+2IUY7wlUVQhMAyQ
	 EEQbuKEFsz+8Dtrs8orPDmjhSMP8jvboPePboa5MSMzgpO95Ujhry9fJ1u79u/Q7yT
	 33UKFM4Erwx8Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 17 Dec 2024 11:12:14 +0300 (MSK)
Message-ID: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
Date: Tue, 17 Dec 2024 11:12:08 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <oxffffaa@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH v2] Bluetooth: hci_uart: fix race during initialization
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189880 [Dec 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 47 0.3.47 57010b355d009055a5b6c34e0385c69b21a4e07f, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/17 06:22:00 #26894014
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
