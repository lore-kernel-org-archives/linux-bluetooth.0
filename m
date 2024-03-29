Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153FE3CF7D
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703596; cv=none; b=uLB+YP4WNioHgeO2cuvnHdz+3B6aEK7X0Q968onQRo42SzxX6/SOhjGVvtdJkB9nwz+8DLhgZGHloXMNrIRHxvbaubPBY86ST4u89vIjW5gt9zyF4GY7yomaf1fX0mFRGruZDuq5INh4GnKKdhiPbUxJVD6WTdXToZ9b9NkeOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703596; c=relaxed/simple;
	bh=8pBZqcXYozg+NDDMS9/9XZJw12sGkJSfubs4bVyvQuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mr3ImV5sLdGGUFgotk6j0vowWdXTx9OE7tiUtsQS5O79et2sqVQ4P680NZNADeOLxoDYmo7BfyeuThbTm4TZfW6AS13GYmxDsq6ZNthIWl4zXA1RAJejz0ytUyo4iJq/NuXmt3FgzvOi00Uq2LKEBwZNJkl4jpS6eGVhAFGe+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af607.dynamic.kabel-deutschland.de [95.90.246.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7956261E5FE05;
	Fri, 29 Mar 2024 10:13:02 +0100 (CET)
Message-ID: <e7dfb37d-9163-4d58-aafb-2a2ebca73c4d@molgen.mpg.de>
Date: Fri, 29 Mar 2024 10:13:01 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1 1/1] Autoconnecttimeout max value increased to
 20000 msecs from 16384 msecs
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
 luiz.dentz@gmail.com, sarveshwar.bajaj@nxp.com
References: <20240329063534.56892-1-mahesh.talewad@nxp.com>
 <20240329063534.56892-2-mahesh.talewad@nxp.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240329063534.56892-2-mahesh.talewad@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mahesh,


Thank you for you patch.

Am 29.03.24 um 07:35 schrieb Mahesh Talewad:
>   - In implementation Autoconnecttimeout max value is 16384 msecs.
>     Increased this Autoconnecttimeout max value to 20000 msecs.

Please do *not* format it as a list item. I’d also rewrite the commit 
message summary/title to use imperative mood:

> Increase autoconnect timeout max from 16.384 s to 20 s

Please also add, why this change is necessary.

> Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> ---
>   src/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/main.c b/src/main.c
> index b1339c230..8ce72badc 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -656,7 +656,7 @@ static void parse_le_config(GKeyFile *config)
>   		  &btd_opts.defaults.le.autoconnect_timeout,
>   		  sizeof(btd_opts.defaults.le.autoconnect_timeout),
>   		  0x0001,
> -		  0x4000},
> +		  0x4E20},

Please add a comment with the decimal value. (Or why not use a decimal 
value?)

Also, isn’t

2 * 16 + 15 * 256 + 4 * 16^3 = 20256

Why not just use 0x5000 (= 20480) to make it easier to calculate?

>   		{ "AdvMonAllowlistScanDuration",
>   		  &btd_opts.defaults.le.advmon_allowlist_scan_duration,
>   		  sizeof(btd_opts.defaults.le.advmon_allowlist_scan_duration),
