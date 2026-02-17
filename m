Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623736AB5B;
	Tue, 17 Feb 2026 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771337059; cv=none; b=CNEFxncvH+a3ak17Ab/XjmtxBvq2qUWk1d1UVNQ/vNRs8LnNRAUkHFJshk31oVKyd+C+HaeJTXCCmaQngu+Irh/4J+J8S7p1dMZb0U74OOVKfWjkjuayM3CJ6bfMm11qjjv/qsJt7QadbIDXc666ybm+5WqWnAo6UHo1buSTy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771337059; c=relaxed/simple;
	bh=G3jX06Fj6EFl6VCKrfBSg0jf3O/MfW9i6odQHNdgrDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sntDBSuJZhEgfWEHvj9PQdR93G0tKw7zJA2vbhGWEI64wFwsHqN8DePDjmG4OxR0kH3wE23sAV+P6TCMSCyjjHZtTArpZIryEAi1uTfufaPE8voei1tNY7sGg1luB4q4XrvggmZP0nmSMsZ7DFZQIXcaZ4QuSRg7drvAaffcFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C81154C4430071;
	Tue, 17 Feb 2026 15:04:04 +0100 (CET)
Message-ID: <cab7c1e5-1fe0-4914-8b5b-bfcff8b61de3@molgen.mpg.de>
Date: Tue, 17 Feb 2026 15:04:03 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluetooth] btmtk: fix MT7927 / MT6639 firmware loading and
 section filtering
To: =?UTF-8?Q?Jean-Fran=C3=A7ois_Marli=C3=A9re?= <freelance@marliere.fr>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <496b0f8505eb6ffb19fdbee6f963c62aa6790fba.camel@marliere.fr>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <496b0f8505eb6ffb19fdbee6f963c62aa6790fba.camel@marliere.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jean-François,


Thank you for your message.

Am 08.02.26 um 20:52 schrieb Jean-François Marliére:

> Bluetooth on MediaTek MT7927 (hardware variant 0x6639) is currently
> broken on Linux.
> The device is detected (USB VID:PID 0489:e13a, Foxconn/Hon Hai), but
> initialization
> fails with "Unsupported hardware variant (00006639)" or the chip hangs
> during
> firmware download.
> 
> I investigated this issue by comparing Linux behavior with USB captures
> from the
> Windows driver and identified three root causes in btmtk:
> 
> 1. Hardware variant 0x6639 is missing from btmtk switch/case handling
> 2. Incorrect firmware naming is used (_1_1_hdr.bin instead of
> _2_1_hdr.bin)
> 3. Critical issue: non-Bluetooth firmware sections are sent to the
> chip, which
>     causes an irreversible BT subsystem hang (requires full power cycle)
> 
> The Windows driver only downloads firmware sections where
> (dlmodecrctype & 0xff) == 0x01. The MT6639 firmware contains 9
> sections, but only
> the first 5 are Bluetooth-related. Sending the remaining sections
> (WiFi/other)
> causes the failure observed on Linux.
> 
> This patch:

Unfortunately, despite the subject containing the tag *PATCH*, no patch 
is included in your message – also not in the archive [1].

> - Adds support for hardware variant 0x6639
> - Uses the correct firmware naming format for MT6639
> - Filters firmware sections to only download Bluetooth sections
>    (dlmodecrctype & 0xff == 0x01), matching Windows driver behavior
> 
> Tested on:
> 
> - Debian 13 (Trixie)
> - Kernel 6.12.63
> - ASUS ProArt X870E-CREATOR-WIFI motherboard
> - MediaTek MT7927 / MT6639 Bluetooth
> 
> A full technical analysis, reproduction steps, and testing details are
> available here:
> https://gitlab.com/jfmarliere/linux-driver-mediatek-mt7927-bluetooth

Great work!

> Please let me know if you would prefer this split into multiple patches
> or if additional testing/logs are required.
If a patch can be split, I would split it with a dedicated commit 
message, and Signed-off-by line, and Link: tags – like the newly created 
bug report [2]. Please note, that patches for the Bluetooth subsystem 
need to be have the prefix `Bluetooth: `. `git log drivers/bluetooth` 
should give you some examples – also what logs to include.

I am looking forward to your patch submissions.


Kind regards,

Paul


PS: Please note, that

Marliére Jean-François <freelance@marliere.fr>

looks strange, and a comma is missing or the given name should come first.


[1]: 
https://lore.kernel.org/all/496b0f8505eb6ffb19fdbee6f963c62aa6790fba.camel@marliere.fr/
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=221096
