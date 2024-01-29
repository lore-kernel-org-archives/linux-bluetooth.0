Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769F66B42
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542718; cv=none; b=CmTHXTX3A7McDaFoVcAsULZ8A6N1+xbSm1NLvLCGdCtDvPLbSr4AFwffBktTLHg2JzYjuItXbypl0B8taYKsJELmnG+0gAreGiSRSxGhedQOcs6fGkdofBCR44KfiELSV12qPJDp08tasY0flBRR0dKLjIEBKUOcECYWsB5AwKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542718; c=relaxed/simple;
	bh=GOIH/21FBASTsUWYFZRoC9rpjITH9UsVURsCwH41pfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsPKyMxHqdxdYbdeB3BV5e2nCAoJ5Uxf3kqmf6VJxRJWQUYZoe2NEUZ2MiUL2PeU2jCGWR4cFWmvwAQ1jiZCtZIxgKkNXMkDlFVBUWkqHSZ8t5PClGba7e8rqrjDLelFMkZWFbzR7Pldg0TVz2S9uZhrcNghqvGdqXVD9t8bo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8317761E646C7;
	Mon, 29 Jan 2024 16:38:28 +0100 (CET)
Message-ID: <16304943-3d04-40c8-86e8-f60aa1d96ea3@molgen.mpg.de>
Date: Mon, 29 Jan 2024 16:38:27 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v4 8/8] android: export only (android) entrypoint
 from the modules
Content-Language: en-US
To: Emil Velikov <emil.velikov@collabora.com>
Cc: emil.l.velikov@gmail.com, linux-bluetooth@vger.kernel.org
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
 <20240129-rm-ext-plugins-v4-8-bfd1e08c7f99@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240129-rm-ext-plugins-v4-8-bfd1e08c7f99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Emil,


Thank you for your patches. One small nit.


Am 29.01.24 um 15:44 schrieb Emil Velikov via B4 Relay:
> From: Emil Velikov <emil.velikov@collabora.com>
> 
> The android specific modules, have a designated HMI entrypoint. Hide

The comma seems superfluous.

> everything else with -fvisibility=hidden.
> ---
>   android/Makefile.am     | 3 +++
>   android/hal-audio.c     | 1 +
>   android/hal-bluetooth.c | 1 +
>   android/hal-sco.c       | 1 +
>   4 files changed, 6 insertions(+)

[…]


Kind regards,

Paul
