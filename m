Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2604149DF0;
	Mon, 20 Jan 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737361956; cv=none; b=oDnwHMg5FROQaLoxl5c+2lRppLd5XakR4QcO/SSR57o+72KplblgsAnaUhKXi4eJhwVMLERxDToSDozhfYY4HjVU+0McxqDM+66SGl1ouWCybzL6Ets8AYQmmtt0PTNvoqJ53HsXblyHgpm0JpJMhly/6UTbjSG4WmgpkJBr67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737361956; c=relaxed/simple;
	bh=wVkvyGTK45J4y/o22IWYpYvMIyWyJjwzt7eipjV7lj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKS5bflzLBjPEjIG61yNn5K+ZEQDL1N7rz8TpCwyzx5S1e/V1ED6SoVLRNqlT/jHRkw9R0j99AkTmROAyTHCkqX/iqZez4RjGOGSPriHh7v2+WyelFSrlrqG2vme21/iL7oe1Q+WUY9URmswYuXSSYR0au4CpsN20dvjXMWeJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae882.dynamic.kabel-deutschland.de [95.90.232.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 250E161EA1BEE;
	Mon, 20 Jan 2025 09:32:18 +0100 (CET)
Message-ID: <0ad410cf-f4f1-4519-96fe-9a2a07865963@molgen.mpg.de>
Date: Mon, 20 Jan 2025 09:32:16 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: Add ABI doc for sysfs reset
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 chromeos-bluetooth-upstreaming@chromium.org,
 Hsin-chen Chuang <chharry@chromium.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
References: <20250120162456.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250120162456.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hsin-chen,


Thank you for your patch.


Am 20.01.25 um 09:24 schrieb Hsin-chen Chuang:
> From: Hsin-chen Chuang <chharry@chromium.org>
> 
> The functionality was implemented in commit 0f8a00137411 ("Bluetooth:
> Allow reset via sysfs")

Add a Fixes: tag?

> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
> 
>   Documentation/ABI/stable/sysfs-class-bluetooth | 9 +++++++++
>   MAINTAINERS                                    | 1 +
>   2 files changed, 10 insertions(+)
>   create mode 100644 Documentation/ABI/stable/sysfs-class-bluetooth
> 
> diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentation/ABI/stable/sysfs-class-bluetooth
> new file mode 100644
> index 000000000000..e794ce706582
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> @@ -0,0 +1,9 @@
> +What: 		/sys/class/bluetooth/hci<index>/reset
> +Date:		14-Jan-2025
> +KernelVersion:	6.13
> +Contact:	linux-bluetooth@vger.kernel.org
> +Description: 	This write-only attribute allows users to trigger the vendor reset
> +		method on the Bluetooth device when an arbitrary data is written.

*data* is plural, so “when arbitrary data is written”?

> +		The reset may or may not be done through the device transport
> +		(e.g., UART/USB), and can through an out-of-band approach such as

…, and can *also be done* through …

> +		GPIO.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 797e94ba74f7..e949c3ac7846 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4058,6 +4058,7 @@ S:	Supported
>   W:	http://www.bluez.org/
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
> +F:	Documentation/ABI/stable/sysfs-class-bluetooth
>   F:	include/net/bluetooth/
>   F:	net/bluetooth/
>   


Kind regards,

Paul
