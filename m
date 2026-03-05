Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FB29A1
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698389; cv=none; b=SxUqIokgUcertkiU/UZRkzSmCsbE8mzxfV03ooKlcTFWtILUNoOTRW94VLgNVSjmEsIJpm0bkyQFSwnKLEt0GC6I9sngs5ZuZm5ITG65v9asbygK/T6gWuZA43Ii3icjYrsEtkjrC8aK3YEGuPZVyEzHMkMVI4kv1N/lD6Zl1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698389; c=relaxed/simple;
	bh=Y8DjHD572kRJ/X4RGJxBzhh18brg5JvUe+qFeNW6q3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Wi+DiOE2ZkQJx1lEiRVq7vPOBPjwoIRvh5Xg+aui6i7dUjCAW4WCQFWg6mw3ranckZnyYKSkH8qMCXoVvo739JBa6/hqW26zZ7IujdroodoPbnl+XI8n4z680JEtJma1Of/Vc2aoOyrYKcqDGGHf3WxCoCvLowymP25lDTC7Qh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.221] (p5dc551cf.dip0.t-ipconnect.de [93.197.81.207])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EB0124C443053C;
	Thu, 05 Mar 2026 09:12:54 +0100 (CET)
Message-ID: <668efc09-fd4a-4bd5-acc7-c06aae454798@molgen.mpg.de>
Date: Thu, 5 Mar 2026 09:12:53 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Bluetooth: HIDP: Mark BT_HIDP as DEPRECATED
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20260304200632.273572-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260304200632.273572-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for this suggestion.

Am 04.03.26 um 21:06 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This marks BT_HIDP as DEPRECATED as it is no longer needed on systems
> with UHID which is preferred over BT_HIDP as that works both on BR/EDR
> and LE beares.
> 
> Userspace already defaults to UHID since 9698870015b0
> ("input.conf: Make UserspaceHID defaults to true") which was released
> with 5.73.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hidp/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hidp/Kconfig b/net/bluetooth/hidp/Kconfig
> index e08aae35351a..915035e23719 100644
> --- a/net/bluetooth/hidp/Kconfig
> +++ b/net/bluetooth/hidp/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config BT_HIDP
> -	tristate "HIDP protocol support"
> -	depends on BT_BREDR && HID
> +	tristate "HIDP protocol support (DEPRECATED)"
> +	depends on BT_BREDR && HID && DEPRECATED
>   	help
>   	  HIDP (Human Interface Device Protocol) is a transport layer
>   	  for HID reports.  HIDP is required for the Bluetooth Human

Could you also update the help text with the information from the commit 
message? I guess, this would help some users.


Kind regards,

Paul
