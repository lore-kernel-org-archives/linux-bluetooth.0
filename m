Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB673B776C;
	Wed, 17 Jun 2026 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679249; cv=none; b=ddBthlxNYDgZrY3fCBV7Xxndmu/Iqrlc8f+WtY+ayUbVWDOGZSpAhFrhLmU1EXM5OEtBEBs4Eio5/N9GpzN/miGPkS8yGmZPqzndS/qCtX81lrI7bXzttc1p8JQ4xwFWRLqb6xppW1YEML+QUF93WMBEw+ZBfFGrdya8bxucx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679249; c=relaxed/simple;
	bh=1/nLpHtVi0nZEAxa6414A5pnJHcRkKsZpqayNyhUoEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ho+LwZfB+ABmarQmroMrwAFp2MmjI5g8PAeXBsTmSoyk4bx/2XGkydJcwMC8nXsczQczu8A2CFKHG7pJdngU3nAVcFZudfC8nOh7p59M/VZUpR/IvTtjNIpoe1iMwPCUE7EH1DhpeS/raT0UYhsd87sx0emDGEICoiYTxj68oLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.217] (p57bd9073.dip0.t-ipconnect.de [87.189.144.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E17394C1A4F350;
	Wed, 17 Jun 2026 08:53:42 +0200 (CEST)
Message-ID: <4501985d-c8df-4121-89fd-0b4eb09273c6@molgen.mpg.de>
Date: Wed, 17 Jun 2026 08:53:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btmtk: Add MT7928 support
To: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc: =?UTF-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
 =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
 luiz.dentz@gmail.com, marcel@holtmann.org, =?UTF-8?B?U1MgV3UgKOW3q+aGsg==?=
 =?UTF-8?B?5qyjKQ==?= <ss.wu@mediatek.com>, linux-kernel@vger.kernel.org,
 johan.hedberg@gmail.com, Sean Wang <Sean.Wang@mediatek.com>,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20260616030132.532184-1-chris.lu@mediatek.com>
 <6b29b553-d703-448d-9275-62912a62e356@molgen.mpg.de>
 <03e0a6787272a445448a3189b4b575aa85396fb0.camel@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <03e0a6787272a445448a3189b4b575aa85396fb0.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chris,


Thank you for your answer, and sending in v2.

Am 17.06.26 um 04:16 schrieb Chris Lu (陸稚泓):

> On Tue, 2026-06-16 at 12:24 +0200, Paul Menzel wrote:

>> Am 16.06.26 um 05:01 schrieb Chris Lu:
>>> Add support for MT7928 (device ID 0x7935) which requires additional
>>> firmware (CBMCU firmware) loading before Bluetooth firmware.
>>
>> Please detail what CBMCU firmware is.
> 
> CBMCU is a new component on MT7928 to handle common part shared across
> the combo chip (Wi-Fi/Bluetooth's subsystem), providing a better user
> experience through improved coordination between subsystems.

Thank you, but please add it to the commit message.

>>> Implement two-phase CBMCU firmware download: Phase 1 loads
>>> section with type 0x5 containing global descriptor,
>>> section maps and signature data; Phase 2 loads remaining
>>> firmware sections. Add retry mechanism for concurrent download
>>> protection.
>>
>> What is type 0x5? How big is the firmware, and how long does it take?
>>
>>> After CBMCU firmware loads successfully, the driver continues
>>> to load corresponding BT firmware based on device ID through
>>> fallthrough to case 0x7922/0x7925.
>>
>> Please add the new log message to the commit message.

Thank you for adding those. Please also mention, where to find the new 
firmware.

[…]


Kind regards,

Paul


PS: Also, Pauli’s question should be answered in the commit message 
(internal/external name). (If questions show up during review, it’s a 
good indicator to amend the commit message answering these questions.)
