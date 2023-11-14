Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A67BA2B
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="P10myidc"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B42194
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 23:06:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id B8AAF41F75;
	Tue, 14 Nov 2023 06:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1699945200; bh=QFda20ZkGQv23urtjlXxGti8E4jjdJdG88PRBb+IHmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P10myidcp8XUSwKDBWQgwOxvIJlc48tXjteqCM9jtN37zv7eMGr9+WhncMNETJXLC
	 3j8LRRqaBn23vn2hOXeNLYfmQDrCRTjAyMie98S45oH4CzsIihUsO0GjTFBsdQf9cC
	 fKLyJDx+JI8tS1Y/+Zby9CNL+XvVEBfstBZ474RQDDatogbMuoiAfVuf+G6tcwtxoS
	 umlkqHt6MwegQ1oBwA7xd/fbC0nKrkI5MGkFaJBa4mKdEG9nyveIzuNpsVEw5f9jxw
	 u6K5ipzjcKuaEW9GCdCElRXEgnp+FO2FjzyXT+mOma6KAmsY40fnzHBjx6s9dvsxPv
	 KhbRHoHF/EjKA==
Message-ID: <88fcc70e-9f4b-eeb9-d826-03fa4c40e7c3@marcan.st>
Date: Tue, 14 Nov 2023 15:59:53 +0900
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
To: Aditya Garg <gargaditya08@live.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>,
 Kerem Karabay <kekrby@gmail.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Asahi Linux Mailing List <asahi@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
 <ZVKxtD2Mt_eVyttJ@archie.me>
 <MA0P287MB021794BCCCFB5EA57C1C3B69B8B2A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <MA0P287MB021794BCCCFB5EA57C1C3B69B8B2A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/11/2023 15.23, Aditya Garg wrote:
> 
> 
>> On 14-Nov-2023, at 5:01 AM, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> ﻿On Mon, Nov 13, 2023 at 08:57:35PM +0000, Aditya Garg wrote:
>>> Starting from kernel 6.5, a regression in the kernel is causing Bluetooth to not work on T2 Macs with BCM4377 chip.
>>>
>>> Journalctl of kernel 6.4.8 which has Bluetooth working is given here: https://pastebin.com/u9U3kbFJ
>>>
>>> Journalctl of kernel 6.5.2, which has Bluetooth broken is given here: https://pastebin.com/aVHNFMRs
>>>
>>> Also, the bug hasn’t been fixed even in 6.6.1, as reported by users.
>>
>> Can you bisect this regression please?
> 
> Since I don't have access to this hardware, it's not possible for me to bisect this regression. Let's hope someone is able to do so though.

It's not a regression, it was always broken. I'm sending a patch.

- Hector

