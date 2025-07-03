Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576B2ED86C;
	Thu,  3 Jul 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553441; cv=none; b=Y2wyHkw6oEkyz9y4duf3ilA8FbUlfdJ5byb4W7iROCUg3y1wlXwlAuHkpM9eYYggKI+K07NTFheztw33Y/Ic2j1UNfCMOHNM4UWxB2V4gQ4dNpJAq3qoKmkxanIS67Ku16DzwlWBpk8uWacgA6Q8Wpbc7ThJMQR2OFCRUm9xXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553441; c=relaxed/simple;
	bh=iphZ0xLbalXMFojOT6bd7BRieX/Qbn1y8a8/nwka6Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ET+fEFyfY7kHjXvpc3OcXPvZiaQ1qywEMl+IOCRRvLBS/v8KXd7Bi4bexweCkv4TF7JhOyacz4Sh5s9DimxgtTacA0HgdgX/7FBtTG8RzaKlPB6F1WJLP5P1p06LIYfHB/zUmMCZVF7qiq88z2JpkGMuh4GfHhgzrLbc2FWJzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9F6E3601D7115;
	Thu, 03 Jul 2025 16:35:33 +0200 (CEST)
Message-ID: <6be1c1c6-8d8a-49e3-bb14-dc8fcbfc2c50@molgen.mpg.de>
Date: Thu, 3 Jul 2025 16:35:32 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] Bluetooth: btrtl: Fix typo
To: Bastien Nocera <hadess@hadess.net>
References: <20250703142542.985248-1-hadess@hadess.net>
 <20250703142542.985248-4-hadess@hadess.net>
Content-Language: en-US
Cc: trivial@kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Johan Hedberg <johan.hedberg@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>,
 Kees Cook <kees@kernel.org>, Erick Archer <erick.archer@outlook.com>,
 Chris Lu <chris.lu@mediatek.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250703142542.985248-4-hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Bastien,


Am 03.07.25 um 16:24 schrieb Bastien Nocera:
> Found by codespell.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>   drivers/bluetooth/btrtl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 7838c89e529e..3d137944c458 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -693,7 +693,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>   
>   	/* Loop from the end of the firmware parsing instructions, until
>   	 * we find an instruction that identifies the "project ID" for the
> -	 * hardware supported by this firwmare file.
> +	 * hardware supported by this firmwmare file.

Without the second m.

>   	 * Once we have that, we double-check that project_id is suitable
>   	 * for the hardware we are working with.
>   	 */


Kind regards,

Paul


PS: Should you resend, it’d be great if you wrote in the summary/title 
if it’s in a comment or in a log string.
