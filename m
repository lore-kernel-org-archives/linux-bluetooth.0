Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7339205E01
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713646021; cv=none; b=l3Pg0g0A2MagdlNO6fZNnorbGDnipsg+PG6Iyxoj26eMLAsA3t60WMEqW2QcF4xWXskKcJ24xSgXqk3Hqo8cwcT5IbsqfOqO7pI+/I80X7KTM7OgfZ3f/cKHkqqJNE/LiV4RvRkwPy67L6hx6Qj8fGHht3jAee55pjeGP5DWLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713646021; c=relaxed/simple;
	bh=naVZ5Qsah8ociYzcEljGsyU7g4Up3wvN+xOlp70Z0sE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DyTDeasou/uTuprvXLtLsT7YdXfpbQM78FJB9sXnwHTqpwjkTK3AxY4qtOvCzXT0psk4gyynubDl5a3gSnPBnRE/rL4Rahcb4pkv8i824IRPjuhpm+sPB5YHZNgkfLib1fSyf5GuvWpolKEMaeLOrtoOWcgkCMmfzCT0Gm42VkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=qiG0Y2ft; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="qiG0Y2ft"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4VMNc71HGHzDtbs
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 22:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1713645447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=reFQZ+alSql+tE3yVWtL784FzceZZIlFUkt2W8kA2JU=;
	b=qiG0Y2ftqFq3ACJYAfig2WFt0zYzPDxnnZOUFv9XXU/U/JoRGsTaa0D4+wTJf93mFMQcr7
	oi8A6RvA/zcpJB9I8vLM0MZynUXAYQnourpDf7GXtau1lPIByhUELrJ5Yf4mtpvDbCZ+jH
	5cqJy+W/SLo7EMBSTukVZiTilTw5yhAORCODrPDdQ+VRsyoTaSyoIFJBsibBTqyNPaLw7r
	jofs9rDkk/u5/65ox0iEh7D1aQ5HN8H8LSzkn8PpSNDabzJlv2B4/YJLVqKr96sDXLN1RN
	PTxnt7UCxyak6HVs5E3+cSc6rMrEpV/92jKNFfIdixRpRnReKDBh41RG1Ds0Ng==
Message-ID: <fe246f80-f463-460a-b6e2-9a4de8a03cd8@tavla.de>
Date: Sat, 20 Apr 2024 22:37:26 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
Subject: Why does my BlueZ not cache the services of a paired and trusted
 device over a reboot?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Kernel: 5.10
BlueZ: 5.55
Agent: Own agent, NOT bluetoothctl
Plugins: --noplugin=input,hog

Already spent a lot of time on this issue and it is really tricky. 
Please give me some hint...

I have a remote control and need to find related services after boot in 
order to set notifying on some characteristics. At this stage the remote 
control is not connected and cannot be connected. This is not working 
because after boot the services are not available via d-bus (empty). 
Only if I then press a button, the services are cached and I can catch 
this event and set notifying on the characteristics. However, this is 
too late and I miss some buttons pressed.

When I connect the remote and then later (even far later) and even if 
the remote is unpowered (no batteries) it is not a problem to find the 
cached services (without service resolving) and then I am able to set 
notifying on those characteristics.

Why does my BlueZ not cache the services of a paired and trusted device 
over a reboot?

Thanks,

Martin

