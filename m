Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BB2690F7
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935052; cv=none; b=h15J90q7/ASga0vSe+TLQyXnabWuNk31hgN/Rc3R+s9LJr4MAA776DJACX7hYqXDXKuwiJGS+Jjd/Zr8GLQCpE7iPBTsvPVz27wqWU7cdwEJ5ipfF8jyZ/AOa2jL7IJnbIo3jGWVUSeXUi7urwQafkAMpH8Qgpp5OH7UTfXJlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935052; c=relaxed/simple;
	bh=8oxQ4fSj7f22EeCh5Gjev+wAj7G6i7wGqtGjCrm1lX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vd866otSKUk9TyTbarUXzNRTTjPjrMgckMuHSglJrxm1+xGbXv7A9jZkJxMGlZwG9cXxRjnYna57nDQBN4Rxj5Kqs5LkX6KpmKPUqdy4+bbH41uUoQlAz+cYtrwMVGwHgDhGqq4fzHP/QF86S6aqlLDPneucjDzxVr43u523yyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.20.154.245] (guest-wlan-ext.mpip-mainz.mpg.de [194.95.63.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7217361E6479C;
	Tue, 03 Jun 2025 09:16:12 +0200 (CEST)
Message-ID: <b0e014cb-b7af-444d-97f7-1330fa63aebc@molgen.mpg.de>
Date: Tue, 3 Jun 2025 09:16:09 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Do not start mpris-proxy for system users
To: Antonio Russo <aerusso@aerusso.net>
Cc: linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Andrew Sayers <kernel.org@pileofstuff.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Salvatore Bonaccorso <carnil@debian.org>, =?UTF-8?Q?Guido_G=C3=BCnther?=
 <agx@sigxcpu.org>
References: <a15e6919-9000-4628-baec-a2d2cc327903@aerusso.net>
 <aCiLTy-IuqV6V7WA@eldamar.lan> <aCncrfc7qbtLEpta@andrews-2024-laptop.sayers>
 <aDq72xTNkz0kDqpW@eldamar.lan> <aDtHoRCof-iND3Td@quark2.heme.sigxcpu.org>
 <30a9641a-05fa-4a44-af58-6b155dc7ecfc@aerusso.net>
 <CABBYNZLQ+HkEm0koVtwJGgxaOTxiy=UTOtc2Do1n0q3CRXEm7w@mail.gmail.com>
 <9d7984b8-79c6-478e-95c8-28a6d4a7ba9b@aerusso.net>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <9d7984b8-79c6-478e-95c8-28a6d4a7ba9b@aerusso.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Antonio,


Thank you for your patch.


Am 03.06.25 um 05:37 schrieb Antonio Russo:
> A default installation of bluez results in the systemd user unit
> mpris-proxy.service being started for all users---including root.
> This unnecessarily exposes system users to any security
> vulnerabilities in mpris-proxy.
> 
> Inhibit this default behavior by using ConditionUser=!@system.
> 
> Signed-off-by: Antonio Enrico Russo <aerusso@aerusso.net>
> ---
>   tools/mpris-proxy.service.in | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
> index c49d255..6ae56c6 100644
> --- a/tools/mpris-proxy.service.in
> +++ b/tools/mpris-proxy.service.in
> @@ -4,6 +4,7 @@ Documentation=man:mpris-proxy(1)
>   
>  Wants=dbus.socket
>  After=dbus.socket dbus.service
> +ConditionUser=!@system
>  
>  [Service]
>  Type=simple

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
