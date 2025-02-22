Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284613A3F7
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 05:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740202163; cv=none; b=cB7RLZtZyhsu1FAGexEThZOWmS+47OWxINn6GFZ8rhDEr+zfMCRLcb7k8FHJsDylxXYcIw4QLPEGXhOFmtzwO4DC40RLczJq6/BXtnaTEgGI3choWv9SgTKB+1q2JO+gt5kbZsFOwGvf0uZXDWcZwYD8c4Nfyft9qjGVeyoiNo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740202163; c=relaxed/simple;
	bh=gjphTjljBkm1j8jMuC3wl20UU+TwDjiYHhkJxAvumn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIXew+vxDLBPD1jCFsOlUBZvHzZF/lQ0tejFhLHKvOKL3+wrq7qbe9LabYon2e5znAqfZlRLuddUxucJakMu9nToMH2ms+vqzCcNQw+YgzAdhQi9hvUMPPO+ZPfI3dFPBKPZKEMjKUsaMRIr4KGKGAs6RPHcl+xgYwmetxOakuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af50a.dynamic.kabel-deutschland.de [95.90.245.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4293A61E64783;
	Sat, 22 Feb 2025 06:29:15 +0100 (CET)
Message-ID: <95d0f052-c931-45f5-8212-60f9308a2672@molgen.mpg.de>
Date: Sat, 22 Feb 2025 06:29:14 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: btusb: Fix regression in the
 initialization of fake Bluetooth controllers
To: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>
References: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
 <20250222050439.1494-2-nishiyama.pedro@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250222050439.1494-2-nishiyama.pedro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Pedro,


Am 22.02.25 um 06:04 schrieb Pedro Nishiyama:
> Set HCI_OP_READ_VOICE_SETTING and HCI_OP_READ_PAGE_SCAN_TYPE as broken.
> These features are falsely reported as supported.

Please list the affected controllers.

> Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")

As the summary/title says, that it’s a regression, could you please 
elaborate, that it worked before, and how it regressed? Were these 
quirks present before?

> Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8149e53fd0a7..903361456acf 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2436,6 +2436,8 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>   		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
>   		set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
>   		set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
> +		set_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirks);
> +		set_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks);
>   
>   		/* Clear the reset quirk since this is not an actual
>   		 * early Bluetooth 1.1 device from CSR.


Kind regards,

Paul
