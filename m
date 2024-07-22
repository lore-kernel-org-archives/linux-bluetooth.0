Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05631EB56;
	Mon, 22 Jul 2024 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646355; cv=none; b=NAwUeYg40bp1lxcEl7W1wzMHJoJgjD47Q5JvTBav4f6sDAZ5mhk9qHIfV6+FvELkVVEQ2n/diDus6QWn/6DJo1UNtLOtgClHImybsPKKZt4MSt6bhktXOSBxQq987FpAkQTRq/L4PDHXcZ2YWSjbxQj89cAotUARsUqcMpEzExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646355; c=relaxed/simple;
	bh=rauISwWqe6NRv/aDtwraK5xUFBcodPwNCI+Gmaz8FR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbK5hds9gdecQ3SwW9HO6VhfRBJ0mwxamACVXgMpZo71LvU3XYpwrkFHj13jQ/oqdod9S14YyLNcplDz6r+Az15BbAC/0rz4wj/ZAS+0YzibCnpS43Pcmwh6fUWx+2h10VM71DZdj9WldivEBn73hbLB2r4H8QwP9Bec0T5eLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ylLgCoR+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ylLgCoR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721646351;
	bh=rauISwWqe6NRv/aDtwraK5xUFBcodPwNCI+Gmaz8FR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ylLgCoR+RRwDqWSVmbD6fllbe9r2zpHr0braZNkJJ4L/GBoyWRY8VVR/IjJhoHR5l
	 OO4aGFLndZoE3i28i8ysIqAxd4Ov1cXx80tGoUtiDbJlq+ylml2F80sRWStyn0fO+Y
	 FT5WbQlIZA15GWGjfGNOzwu9PydGIOhai2JewWvq4Fosw1ONmjh8anbrC9zitlOfHJ
	 Lz0OA66WeReUhsyQpbB3mIJqXOJD6MRCHyR90c6VgfC67qQ75SNBMq5amnx7/8NSCt
	 YEL6ECw7co7dpKBvKSipqVFHIREmF+/ZxTP4T6i6UdPXwV4qfrnXO3oVIF8ZX4orBE
	 HV3J8rk7j9ZjQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D0F1537808FA;
	Mon, 22 Jul 2024 11:05:50 +0000 (UTC)
Message-ID: <487dda47-ee5e-4835-ba63-05c0ce7ac6fc@collabora.com>
Date: Mon, 22 Jul 2024 13:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Bluetooth: btmtk: remove #ifdef around declarations
To: Arnd Bergmann <arnd@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Chris Lu <chris.lu@mediatek.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sean Wang <sean.wang@mediatek.com>,
 Jing Cai <jing.cai@mediatek.com>, Takashi Iwai <tiwai@suse.de>,
 Peter Tsao <peter.tsao@mediatek.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240722092735.1109925-1-arnd@kernel.org>
 <20240722092735.1109925-2-arnd@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240722092735.1109925-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/07/24 11:27, Arnd Bergmann ha scritto:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The caller of these functions in btusb.c is guarded with an
> if(IS_ENABLED()) style check, so dead code is left out, but the
> declarations are still needed at compile time:
> 
> drivers/bluetooth/btusb.c: In function 'btusb_mtk_reset':
> drivers/bluetooth/btusb.c:2705:15: error: implicit declaration of function 'btmtk_usb_subsys_reset' [-Wimplicit-function-declaration]
>   2705 |         err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
>        |               ^~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/btusb.c: In function 'btusb_send_frame_mtk':
> drivers/bluetooth/btusb.c:2720:23: error: implicit declaration of function 'alloc_mtk_intr_urb' [-Wimplicit-function-declaration]
>   2720 |                 urb = alloc_mtk_intr_urb(hdev, skb, btusb_tx_complete);
>        |                       ^~~~~~~~~~~~~~~~~~
> drivers/bluetooth/btusb.c:2720:21: error: assignment to 'struct urb *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   2720 |                 urb = alloc_mtk_intr_urb(hdev, skb, btusb_tx_complete);
>        |                     ^
> 
> Fixes: 52828ea60dfd ("Bluetooth: btmtk: Fix btmtk.c undefined reference build error")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


