Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8155125DF;
	Wed, 28 May 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416094; cv=none; b=UBbAyYAuQ5J/FeSEBcp0C0dZvSuYNHMniW4K8MRyOnI5l6RBio/l9LIlaWdrDTjJKFYxVaXvGL4LXmlig/qjaw6tQGpONNL61mMZrdUbcaVSd9vsdIXFjwZE6GWa3n9vJ4+EhbsA7+RGDI+tXDly2pwMY8RqjCQGnpCy7zTtHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416094; c=relaxed/simple;
	bh=5d3E9NSUDjdC6JOq/ogmX74FGiGbrM5Qw8kYaUwJB2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQzM3MHSX/5tbO60XWIQVvmfXd8CGSuE4CJrIxS9PbO+NO8Cw9HTX9aLpSv8X0t9KdbQiRoIAf78othtuxNNm4WDp0/r7iHKynHdxLd04yqoBvoICZRILJjDN7ASqqUFWnT1eeoJ0opBWqSdFMQo50/dlOy4ggZJ76vCyDNJvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af669.dynamic.kabel-deutschland.de [95.90.246.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AE289601EEA61;
	Wed, 28 May 2025 09:07:21 +0200 (CEST)
Message-ID: <afe65c91-9120-4327-84a0-faf2d341ebb0@molgen.mpg.de>
Date: Wed, 28 May 2025 09:07:21 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mediatek MT7925: update bluetooth firmware to
 20250526153203
To: Chris Lu <chris.lu@mediatek.com>
Cc: Josh Boyer <jwboyer@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Ben Hutchings <ben@decadent.org.uk>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Jiande Lu <jiande.lu@mediatek.com>,
 Will Lee <will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>,
 Steve Lee <steve.lee@mediatek.com>, linux-firmware@kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20250528064625.533578-1-chris.lu@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250528064625.533578-1-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chris,


Thank you for updating the firmware file


Am 28.05.25 um 08:46 schrieb Chris Lu:
> Update binary firmware for MT7925 BT devices.
> 
> File: mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin
> Version: 20250526153203

It’d be great if you could add some kind of change-log compared to the 
previous version 20250425073330.

> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
>   WHENCE                                        |   2 +-
>   .../mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin     | Bin 459695 -> 459887 bytes
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/WHENCE b/WHENCE
> index 93f849c4..c653db09 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -6225,7 +6225,7 @@ Licence: Redistributable. See LICENCE.mediatek for details.
>   Driver: mt7925 - MediaTek MT7925 bluetooth chipset
>   
>   File: mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin
> -Version: 20250425073330
> +Version: 20250526153203
>   
>   Licence: Redistributable. See LICENCE.mediatek for details.
>   
> diff --git a/mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin b/mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin
> index cce1ddaeefac5a70d7ac9172ef78ce6043bf1334..9263027786aa73ad3de420ff14131492ad7f16a6 100644

[…]


Kind regards,

Paul
