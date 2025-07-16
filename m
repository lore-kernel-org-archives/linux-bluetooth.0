Received: from mx4.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42526981E;
	Wed, 16 Jul 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678889; cv=none; b=gWltrnvLufsQ6TdTFmI0eeRB52etZxIcANB+piAiDg41bFHwqKtljNbYm98bEkkTT4uqw2EcV1UnR6XzGkOVXgZGbCkCDFuuNrsIH12JsNgfUsDx5BMSTLISlCjxmda2Z3h3Z+MHGuHwupXd2h3sJkIVJoGb0zmsVjWzw7VfLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678889; c=relaxed/simple;
	bh=Vimbz9+IH1LGVCB8UlGWULOY8ZJ4Ps1bDBLPARU1s0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o0OuJHrMktUEwQ5xdQOtk1oQ566h/j6zPI7tEpsrznlGWBQhiqOZDT+GgU/a1iY45We4D/6C++uNJHgiHYNuiJ+ckhJcy+2lxJIOwKTMLgZX1/cZvEmTNusIVQAQlAHgeBbmUMxVc0bFJ8L5o7BS2EgRUzvFbYzzlfR2w0SAqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ex3+OCOt; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ex3+OCOt"
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 4CB92240011;
	Wed, 16 Jul 2025 18:04:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 4CB92240011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1752678277;
	bh=NjtOa874GBjFsysgKDCFvsiz4EW20RSMKVAP+2m7PA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=ex3+OCOtqc5/Ros9fE0y58w9LGGQ8x51U+eWY0SKQ9BKawWd5g0wxFzQWCRiNQftd
	 PxUmH0OPPeVDgDOjpMsdu2fGghir/tuK9qiuKogpKk5IRVvQzao6PQsD2ZcRIrd1El
	 V5+a4ARTnwLyFagQ1jZpzxNYuDVtzZD8Uxn29Z17xhlJjFFyzybDKPzMds2oqxhiWH
	 pWUbVzWXM1dGoFDYGGjQ3mHTdI7GGZBNlf1CPnXZcAz83BAl4Tv2k+jw31JxGNtqN4
	 zsTBG9i59IRw+1bB7G86h+QgviEusgfH2Nik2kkTX6x63Zx0W9XXKlhcDJcuoJWsG2
	 EaZHDVnAA3EkA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R11" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 16 Jul 2025 18:04:36 +0300 (MSK)
Message-ID: <943f7a75-d1e8-2833-1ae4-f6979008868e@salutedevices.com>
Date: Wed, 16 Jul 2025 18:04:26 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] Bluetooth: hci_sync: fix double free in
 'hci_discovery_filter_clear()'
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <oxffffaa@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
References: <257a13b8-6d60-21b3-c714-c6cb74b7b091@salutedevices.com>
 <a408927c-3743-71de-b806-87fd404bb9a2@salutedevices.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <a408927c-3743-71de-b806-87fd404bb9a2@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 194892 [Jul 16 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/07/16 12:49:00 #27639138
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Hi, sorry, 2 weeks, pls ping

Thanks

On 30.06.2025 14:08, Arseniy Krasnov wrote:
> Hi, sorry, 2 weeks, pls ping
> 
> Thanks
