Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5BC2054F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487013; cv=none; b=i0/MZ94xolKgr4aLSFESI1341rV8VHn8ungGUM+eeJBvUNx67AF0f17QmHdAHbr9daTMrid0m/hDQWqCBtKx92B68QiANH0AqDqm2vasBX3U0WmKGWZsxGOMI06GkT83T6QTJKIC6UnFOzQX0dL64WOH71Lbf2mpg2Y/R677f9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487013; c=relaxed/simple;
	bh=trUbUx4lcSRz6XGNww0LptAKTheqcTJMtXIcy2+bNAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=LHnQ9WFgy0LiX5zeYXIiRK52D4WhxflQWcOyzqX+h4YFQyAyXqrUZPsw9JpoL9y3gJzzrmE1meTt3vwadcb8gN4MxDIcyE7flUWmeSvG4KbdyypQ5sRQ36IVvbNcXaOgXRvQ+nlCHzziMbmvjPtP0dOWE1C8oYNmzgw5J52vucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4039E61E647AA;
	Tue, 25 Feb 2025 13:35:48 +0100 (CET)
Message-ID: <b442d481-292e-4b43-9467-1f14796f6f5d@molgen.mpg.de>
Date: Tue, 25 Feb 2025 13:35:47 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez] adapter: Prepend the new added device to the
 adapter devices list
To: Ye He <ye.he@amlogic.com>
References: <20250225-leaudio-no-media-v1-1-6da9454067d3@amlogic.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250225-leaudio-no-media-v1-1-6da9454067d3@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ye,


Thank you for your patch.

Am 25.02.25 um 10:04 schrieb ye.he via B4 Relay:
> From: "ye.he" <ye.he@amlogic.com>

I’d be great if you could spell your name *Ye He*.

     $ git config --global user.name "Ye He"
     $ git commit --amend --author="Ye He <ye.he@amlogic.com>"

> When the DUT is paired with a mobile phone using RPA multiple times,
> multiple device contexts with the same bdaddr will be cached.
> When we query the device context through bdaddr, we always get the
> context at the head of adapter->devices, but its status is inactive.
> 
> https://github.com/bluez/bluez/issues/1095
> 
> Signed-off-by: ye.he <ye.he@amlogic.com>

Ditto.

> ---
>   src/adapter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

[…]


Kind regards,

Paul
