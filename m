Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F312BEAB
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958060; cv=none; b=DrRI1JFxTQTjdrdmNEedWPabxXP55rNC19xikbgx8/SgL7oFAXSa8n0u9y0JC3Yrzm8HKIzqSgdkMPk1L0vTrIb38hwh6LOZrzuIlyqBVJ93up4MAYpEltYogV+5z8oDclYNBTIDxhQXCr8Y/1QHdOKgiAbYBMPIbN4Nlc+ymv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958060; c=relaxed/simple;
	bh=1B3O3Ue5no8cigqy16l9ZBEntxHsGiCvAnVr2nVG4Nw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Z3ZNwo8NsvPTLpEBQ8svXe59XKdPPy9W/AnWucb/BVfqCUkw2ztW8VFcLHR6MP4hR/kG8U0qXqChj//i7k2KXjLX1tin/PeictECChWnOi2lJyN1ntadHZdCTu5sX7agMDSn6tmluH+ElImXdUFIktRDwY/aZA1Qq26Nfy16kf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=GwM+w7KH; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="GwM+w7KH"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4Tk300709zzDtq0
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 15:29:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1708957745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ih7XG8JD4l6nDyD47SkGkmucSvIBd2egUQFmwL0SpE4=;
	b=GwM+w7KHArgUfR4oSs4lE+1k5Yz6fiJUkIsLItJjXe6Jc0w2EsbRc0l7ynfbhE4w38eoOc
	MLuFjSFztzd+QRx2bsOGbhrJYqenUFdEEaEuikZKC6OnbLN8fxix+41/1vcq0pYmsQpnZ0
	xt72MJyomqucPgFFy2HpswbK/YDybijYtqv1SE90iGwmpBgbjheMFkirkQwKKY8u6EMzUy
	32UjyvVMeIQ31quJHTfEx0KUZywN0FVIQJZmGC/SiAt1unZ9/fIL5CiUQrdxwwdY15vN3I
	ffHhwUrhc5TN+fzVXo9zx4pTjBmnkOuLmfXfGD+iDl8xzp985Eiz99cuP8kyZA==
Message-ID: <c647b921-af65-49cc-b4cc-3673d20ff263@tavla.de>
Date: Mon, 26 Feb 2024 15:29:04 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Subject: Invalid URL, ignoring: --noplugin=input,hog(8)
Organization: TAVLA Technology GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Tk300709zzDtq0

Hi,

why do I get the following error: 
/lib/systemd/system/bluetooth.service:3: Invalid URL, ignoring: 
--noplugin=input,hog(8)

I just added this option "--noplugin=input,hog" in my systemd service, 
which is in line with the documentation:

-----

[Unit]
Description=Bluetooth service
Documentation=man:bluetoothd --noplugin=input,hog(8)
ConditionPathIsDirectory=/sys/class/bluetooth

[Service]
Type=dbus
BusName=org.bluez
ExecStart=/usr/libexec/bluetooth/bluetoothd --noplugin=input,hog
NotifyAccess=main
#WatchdogSec=10
#Restart=on-failure
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
LimitNPROC=1
ProtectHome=true
ProtectSystem=full

[Install]
WantedBy=bluetooth.target
Alias=dbus-org.bluez.service

-----

Thanks,

Martin

