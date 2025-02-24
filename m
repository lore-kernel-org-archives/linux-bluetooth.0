Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2621CA1F;
	Mon, 24 Feb 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386577; cv=none; b=QdTEm2HKDpPo5JJnxG+nxk6MmzyuTg6CFdB2ACyOjF7G7c5rEkY+IuJJSQotUheBj2Gd66vjHW9R51ZONFWF9HK2/6oQ+pYIpHXkIBHUk2rN7uHFoQMtAqVkRQui+zsRUU9Hji3Lp2q1z3ALYRIc0wF92hyOY6ZMJewodfLMAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386577; c=relaxed/simple;
	bh=PWO83aK5CYVEGr0X7EyJC9ycMxkzA9Nn+SU+14qBxyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCDVjZIevOL0YuCZ2IBhCos/ddocSJdHh7Qqf/cKaD/AKIypglHCZixTDkwExsURz1kTGy31VYStzlaFYYpApxHf54pOmKH2dNFeyS4f8Ad/D3/9AGvxuMt0YjvB+9JgsaSsQzX4Aau1LlJqzWK5F65KJR1AdkETcrEpOwvJqPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (unknown [95.90.242.117])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 981E061E64856;
	Mon, 24 Feb 2025 09:42:42 +0100 (CET)
Message-ID: <2ab0d1c5-1bfe-4ef3-b23d-fee0ae1d7ad6@molgen.mpg.de>
Date: Mon, 24 Feb 2025 09:42:41 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 gregkh@linuxfoundation.org, chromeos-bluetooth-upstreaming@chromium.org,
 Hsin-chen Chuang <chharry@chromium.org>,
 Marcel Holtmann <marcel@holtmann.org>, Ying Hsu <yinghsu@chromium.org>,
 linux-kernel@vger.kernel.org
References: <20250224022447.1141413-1-chharry@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250224022447.1141413-1-chharry@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hsin-chen,


Thank you for your patch.

Am 24.02.25 um 03:24 schrieb Hsin-chen Chuang:
> From: Hsin-chen Chuang <chharry@chromium.org>
> 
> Automatically configure the altsetting for USER_CHANNEL when a SCO is
> connected or disconnected. This adds support for the USER_CHANNEL to
> transfer SCO data over USB transport.

Should you re-spin, it’d be great if you elaborated a little more. 
Especially for the motivation. It’d be also great, if you added how to 
test this.

> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
> 
>   drivers/bluetooth/btusb.c | 224 +++++++++++++++++++++++++++++++-------
>   1 file changed, 186 insertions(+), 38 deletions(-)

[…]


Kind regards,

Paul
