Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3A2E401
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235835; cv=none; b=m9rUmj627YtpGp9/ZyhNTiO0ojXVK5ynKxIWH10z5dq2xesQ3b+b1nqaxqNqUCvUvnZRt6GzPP5nbHfQWRiWblWW3DjCHoV6EvhP7Fpk/KGJhcoaa4Z+3nSUKKAdxSJ/hypg+s/qVM0IM3+aNacLr0f+0vfXBS9hfAJpn/NlenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235835; c=relaxed/simple;
	bh=5+LOEPoEn2zJj6/I5/Os2seFzvs9spi2YA7tp20xc0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAqn01qMUt6D5EAARiY2EjFxB5zKIsm9Xl/apCeQ1w5GCukTVvECmoEOK5gapYK/D/LxLu4A1ptYluk8ulzcmGx6+YNjP6lE+v90litxCPRjnnVPJDq0ldKH8sJdaGpRZDGpkhTPeGoW3YpnHloMslAw9YXAPYo/RbeH/u9z4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CC36961E5FE05;
	Thu,  4 Apr 2024 15:03:30 +0200 (CEST)
Message-ID: <bb9ff5ff-f8ab-4bd8-b266-d78030b0fbde@molgen.mpg.de>
Date: Thu, 4 Apr 2024 15:03:30 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 1/1] Increase autoconnect timeout max from
 16.384s to 20.480s
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
 luiz.dentz@gmail.com, sarveshwar.bajaj@nxp.com
References: <20240404114054.4987-1-mahesh.talewad@nxp.com>
 <20240404114054.4987-2-mahesh.talewad@nxp.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240404114054.4987-2-mahesh.talewad@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Mahesh,


Thank you for sending version 2.

Am 04.04.24 um 13:40 schrieb Mahesh Talewad:
>   - In current implementation Autoconnecttimeout max value is
>     16384[0x4000] msecs.
>   - Since some controllers need some more time to respond to cmd
>     'LE Extended Create Connection' hence increased this
>     Autoconnecttimeout max value to 20480[0x5000] msecs.
> 
> For ex:
> - In some controllers, If we include LE-Coded PHY in the initiating
>   PHY List, BLE INIT scheduler selects the 1M and Coded PHY scanning
>   as an initiator in round robin manner, and due to this available
>   bandwidth gets distributed between 1M and Coded PHY, and this
>   results in longer time taken for connection establishment by
>   the controller.
> - If ref device is advertising at 1.5 sec intervals, with create
>   connection timeout of 4 sec,  the controller gets only 2 opportunities
>   for the connection. Without the inclusion of LE-coded PHY,
>   DUT takes ~3.8 sec for the connection establishment.Hence as described
>   in above point  with the inclusion of LE-coded PHY it is difficult to
>   achieve 100% connection success with the device having
>   adv interval of 1.5 sec.
> 
> Hence increased Autoconnecttimeout max value to 20480[0x5000] msecs.
> 
> Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> ---
>   src/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/main.c b/src/main.c
> index f774670e4..081a388ad 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -657,7 +657,7 @@ static void parse_le_config(GKeyFile *config)
>   		  &btd_opts.defaults.le.autoconnect_timeout,
>   		  sizeof(btd_opts.defaults.le.autoconnect_timeout),
>   		  0x0001,
> -		  0x4000},
> +		  0x5000},  /*max val: 20480 msec*/

Please add spaces after /* and before */.

>   		{ "AdvMonAllowlistScanDuration",
>   		  &btd_opts.defaults.le.advmon_allowlist_scan_duration,
>   		  sizeof(btd_opts.defaults.le.advmon_allowlist_scan_duration),


Kind regards,

Paul
