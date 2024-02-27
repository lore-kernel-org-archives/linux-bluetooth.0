Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D856742
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021555; cv=none; b=rHQg48MS8d7+Jnj/dS3dR9/92l4DX1jZ0O/GbdycYNabMa+GZ+ze93742UUFeq3DdxtFYEhoyb/j7DuEjCi+SLRn0A/84L6xl3LdhgnCe4/AhY0eBAw9D4OmJgMJccgEIvhbAKZE38ewJaIKDb2C3ApwaFQJqLJxtfA3vD/lHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021555; c=relaxed/simple;
	bh=C4QkWXw6VJkS7Xvlsk6GtcsX2TBibNWuILoSsSjQwiI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VdccyS8mYlPwzurI/lTwFXTY6Z/4aIwzF1vWiK2q3EYE142NcenXPK42FuCN10ceZNI6xUCPLJ0qBNc4qoWuhdTmhcsQ2WuKtvSj0pJxpC7J0SHRzrUl878DlSilgYzxviAP8ae+kKKxNh3CBiid1boNjkXW1bDc5iVgDTwehbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=Wp9VXLWE; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="Wp9VXLWE"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4TkVMv3CwwzDssM
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 09:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1709020971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LncrVm6Wg8UupleeIKQm4Y/HdGIGedm7Kk50QDr4Jkw=;
	b=Wp9VXLWEf84/5IvcHYDvrwGmkPX9b5U41ZROzPAmOkIQkOnmDTWr42BFrelo6q85Y9iCLe
	Qm1DkUZRspXblMLyQTLaoDdEdrCTpSbgqWpMOaPXPid8WollaFwn6S58pgDqZ536xBuCJS
	QGlhlw8UzII6GmSVMAZCBdFlW1dB1lQy+XTRByvCHLv3ald/0Lrk1lUz1WCDob5GrEdR8q
	827HfVXgCsOgqtnNoIMutP1QC+ssVDAzaFrayNEuUUMrCEDSz1gOD2uHm5JPi8YkPiDBnj
	2PFOsGahwrmc3Q7Jig7gf1Kb/zWEnwuczBcsZS6WHku36J5Bvl7C1/yf0CaH8w==
Message-ID: <78797476-82f4-4575-91e4-6b6bfb7b4c11@tavla.de>
Date: Tue, 27 Feb 2024 09:02:50 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Invalid URL, ignoring: --noplugin=input,hog(8)
Content-Language: en-GB
From: Martin Petzold <martin.petzold@tavla.de>
To: linux-bluetooth@vger.kernel.org
References: <c647b921-af65-49cc-b4cc-3673d20ff263@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <c647b921-af65-49cc-b4cc-3673d20ff263@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I was changing the line during package build: sed -i 
"s^bluetoothd^bluetoothd --noplugin=input,hog^" 
/usr/lib/systemd/system/bluetooth.service

However, with this I also change the documentation line of the service 
file (see below). And from there comes the error.

Hint: https://github.com/PowerDNS/pdns/issues/4048g

Am 26.02.24 um 15:29 schrieb Martin Petzold:
> Hi,
>
> why do I get the following error: 
> /lib/systemd/system/bluetooth.service:3: Invalid URL, ignoring: 
> --noplugin=input,hog(8)
>
> I just added this option "--noplugin=input,hog" in my systemd service, 
> which is in line with the documentation:
>
> -----
>
> [Unit]
> Description=Bluetooth service
> Documentation=man:bluetoothd --noplugin=input,hog(8)
> ConditionPathIsDirectory=/sys/class/bluetooth
>
> [Service]
> Type=dbus
> BusName=org.bluez
> ExecStart=/usr/libexec/bluetooth/bluetoothd --noplugin=input,hog
> NotifyAccess=main
> #WatchdogSec=10
> #Restart=on-failure
> CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> LimitNPROC=1
> ProtectHome=true
> ProtectSystem=full
>
> [Install]
> WantedBy=bluetooth.target
> Alias=dbus-org.bluez.service
>
> -----
>
> Thanks,
>
> Martin
>
>
