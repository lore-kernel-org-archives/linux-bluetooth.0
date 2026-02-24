Received: from mail.schildbach.de (mail.schildbach.de [162.55.211.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE063A9002
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.211.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951660; cv=none; b=o/JziQgHvKtTDZ4oZYT+TNF8pGLsTQlU2Xirc5YlwBLLpdRRpdBJOhZsFWMev8/P8MoB7zbR6Tld/AfTF5v5jNd9uTKnp1nPX/EuWbpUIQmVVPeTYYnyTt8p7Dq6kySSlNphNUBsja5B0qK45YNCIRFRVPZgyEzWn7QmeHIRxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951660; c=relaxed/simple;
	bh=+okXQuoetVCD0Nwnb1ay4Tcruxd+pA5o4Z1CItoNeZs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lItly1KVfEwGKuNcSMGzJNsuJ/HdeFQWcxSHu8oZK/rRaYajNFIPb6AplFHmjjo+sJQtNA1eyQBC66TctASS+Fyl9XJEzs8tl+4Gm2LfLYUt2Thv5rCYJy8lm9Ri5Jxh2PSfywO/MAzA6kwVrZIqV8sqDoOdq8mlH2AhJ2fVM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schildbach.de; spf=pass smtp.mailfrom=schildbach.de; dkim=pass (2048-bit key) header.d=schildbach.de header.i=@schildbach.de header.b=pMCqy1IB; arc=none smtp.client-ip=162.55.211.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schildbach.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schildbach.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schildbach.de header.i=@schildbach.de header.b="pMCqy1IB"
Received: from [IPV6:2a02:3100:28ff:af00:34e8:9256:e842:2942] (dynamic-2a02-3100-28ff-af00-34e8-9256-e842-2942.310.pool.telefonica.de [IPv6:2a02:3100:28ff:af00:34e8:9256:e842:2942])
	by mail.schildbach.de (Postfix) with ESMTPSA id 8B3A63A8486D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schildbach.de;
	s=default; t=1771951657;
	bh=+okXQuoetVCD0Nwnb1ay4Tcruxd+pA5o4Z1CItoNeZs=;
	h=Date:To:From:Subject;
	b=pMCqy1IBpEd9imkYvZZtvGLY422ExCAmdfKf9yP4vStJgGaRxDgJiDbghaQXhcGfv
	 mlaxq5712zkjVbL/ywK4vN2AfvnHd5wRIla4VFMkL6wogw+//icevoImdiEMY02Y9G
	 hBJkajVRGopoBOOXVu9bJD7ElPrDom82HwHRaCqn5siUdiLQYub4/FKolNzoAEg+5X
	 R21SHi00iGD+oVRd9Fr9P9Fa5yEH+0tVZ+BCPQmzP9gHvtrUhmxSmTa8A6ZzDBAQnk
	 Y/lte9b2sdPa5d0/8V4gUlDXhe3ochAlo9r32reNe/l4MQaXny54LGj1BB4T6NQL3s
	 zs8jkbNjvVnKw==
Message-ID: <1c887efa-9722-4e24-b49a-da21eadc2ce0@schildbach.de>
Date: Tue, 24 Feb 2026 17:47:36 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org
Content-Language: en-US
From: Andreas Schildbach <kernel.org@schildbach.de>
Subject: minimal permissions for BLE operations?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I wonder what kernel capabilities or permissions are needed to use HCI for

1. passive BLE scan on channels 37, 38, 39,
2. (read) access to a BLE GAP (for Thread/Matter device commissioning)
3. hciconfig hci0 up/down

I'm asking because I just hardened a Docker image by restricting to an 
unprivileged user, but the above BLE operations fail. I was expecting to 
add something like NET_ADMIN + NET_RAW kernel caps, but it didn't change 
anything. I also tried adding the unprivileged user to the bluetooth group.

Does "hciconfig hci0 up" always need the root user, or is there a 
minimal permission I could grant instead? Currently, I get "Can't init 
device hci0: Operation not permitted (1)" if I try from an unprivileged 
user.

Maybe related: is it normal that if you use HCI from within a Docker 
container you mount the DBus (/run/dbus) into the container? Is it 
perhaps possible to just pass the hci0 device via `--device` instead? I 
didn't manage to do that either.

I'm on kernel 6.12.69, Docker version 26.1.5, bluez 5.82 (both on host 
and in container)

Cheers,
Andreas


