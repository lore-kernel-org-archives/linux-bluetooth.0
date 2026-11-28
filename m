Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795832333;
	b=gTiUbHwZ9dvxMYqTWLqK8wNAl1ZEwDecy0hona24SIuOfUz2KApocGOpiZB3/F7HjnZ9
	 /ynAqVoejb/g7Es+XxuzoNvJd2m/EUmeZcS7vU/3dbHfGxgA23B52WYacw+VKe8kvNYwW
	 xsdo6i3PgE7V4rfwHMqjRPBbjK2kJSqkkX9OQFM7RPQ5dVXMqcAjXDk1tz5iN+p/pwt+T
	 9yX6D2dFA+ctDwfO0JzxY64EIXa9I2DY5bOub8K/JOD1n6YVjr0wiomew0GwFVf6ngJCN
	 W/xDTs/N6BOV0NBr3v5GgJh/ot3SOg9O/sYMuZnFUqlrNjJunOJHasDEsTXtwJwdEDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795832333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uG5ILL5BgO6hSQt/fxlPzvAFsfMAM1Hk8k/W0WwQnGc=;
	b=vvv8+kIgNBF2musX714X1YRkk5NyrgB2GRoEjeK5ge9WnCJhENL55gyAEkTWc8AiwrYV
	 vlFqF0dbFiE+zylM+1a3KJPOw0lgY8zH/gyavoOxZceFQ8l++JTscNsDEZXYjM0+vk3uz
	 BX9DbzdI1BnLBCXxb08m/hrMp4ZJZeO99nhXzFReaFfOriSKTltYbvVx1CskEbIkJH3CE
	 L1oB934Q2i0DNi2jQJQ3wHxxeiOHY9VyD4QR72HT2FTIFHK14HO1qP4ATrsMmBnUQ6JM3
	 09xsX+Ap830X9Kns8oG89R68xdRaL+PCarIfQGDirEL0ZHAvbNmYY3Y91pcqVKZdmbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EYvj092r;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC1606A337
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2026 02:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DEC1606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EYvj092r
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-385d8a00598so13619828eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 18:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795832332; x=1796437132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uG5ILL5BgO6hSQt/fxlPzvAFsfMAM1Hk8k/W0WwQnGc=;
        b=EYvj092rITeNh0PQzJQlHsoEeX2o9dw5eeNZMMTFKjhO1WGGKlexR5laBD33OPbavM
         M+ymZEdVns1QnhgMtURft41WB3C55dhyrot1i6eQK1UbsQ6+rFVU8n/LemXz9KwC2KNW
         cvr9r6wDaapMF/w5vfOFrVczkvaUHpE/LJW93nIR+V+0s7vlNu0yOzPo/PFOSvf1WHYZ
         wpeZ9Fg7cS0DILE5o46Xbcmg5nAv4B156rn8lTcewwl/Ih3ZlP1wtS/HPPRfRI22WYrs
         PiZX9CqullPRg9Xex5LL4bw3rLB1OeT96hEBtJhhiPYPoQEE8r8MnXaphmlK71Ieq53Y
         RWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795832332; x=1796437132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uG5ILL5BgO6hSQt/fxlPzvAFsfMAM1Hk8k/W0WwQnGc=;
        b=hbwe0IleQh+Q6DSNlgkjsecxqZZt0UyHZtlxWN2oOAFlw2qkDaeE3xdiA6N+zB7E0O
         yc8CIb/XdSDpnAKOb9Yr0+ibEIaVAYs2y2hUtSEfuEMgcapESRxTZ0wHfxQHcKQFNkc4
         WF46Shr0zSl8qSSSn7/npBW/HkbD0oej+FvQ5GCZCzpzKS+68P1+sbF4hciPHcC8N9Th
         idQw5MQhRVRV3+nZlzrrdlzBc3n2TcGFC04p8itzaGH9F9bBwgsfUH7AQmZYI6uBpK/Z
         y1ePvetWNLGgDOW7hj7Ef7kFR2VxSBDW4tbTPkrzvvmS57GqSRN114WLer5PJBXCs+s+
         kZ5g==
X-Forwarded-Encrypted: i=1; AL+hErEw8gUOPdzjfyi9D2z3rfaA/L+CT9NjnXHeL2ZsbozJKNCgQenCAm/jB7fsERzaJhZHMvOmUxaEXqtEbuOW838=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HVx5Q3i43o1P48hTNk5w5jQZDITBOet+SE3+rAQn8DICv1RcU
	bLYmPSpYE5zGZ8a/OogxVyKxxYQ4/0It6Lk+oY5Ur6ycnMEpVXF3uMN3
X-Gm-Gg: AZFdTZdO1WMNprUlef36iwuiQSv/RUsQZYGSqeoRy3zRX3PwppLgAKvgtgrTurghSs8
	sKGnEVTAViR5XBA/yqvsn+HPIrFaRRPSJFedWewUVeNcJCc5uDv4qo0NsIO5w5ryW7GdGW/M4V+
	uNQ1+d6VEXdRf73ru1uYJ1ECjypxWDrn5HTaytTtRCRqRE/rMA4lpPYGgCkuN8UmfAReffM7ZXd
	v9ezokwTmPUOzmC2fjxTlGLL0nBO9h1pWlf3jDOsTpYlQV/9fJvtSU5+kKc+JYs9yws8NGikFxR
	Y+A5r9OivJebPzvB51TT2ogGvAl7+9heOwYxPakmGJnbqqf47i8elFygk703nrKgG2FMifXcXdP
	OH23AaIfvMnJy3f4JD/w9M59skLsETbMaOeTI+wo9U0TLNsE/4XYuYUa+DmBPVtKoScc1rKyKBQ
	kn7We9NsEZartCCayflH6PKZl0LxVulbmNWzFd5BnNfmSLN7mb+5eNciPlc1YC3F6VFn+SVQANj
	95uMLkAUW2btfag82+uQsWhjuYJbrZ9GmwAN2xZUU0c61OvjPpoU5O+jVi9CjxTC174GxdAUqyT
	Nj0XnYaHdKRNz3Gq8h5Z3beOutKzIj4n3YGpZKADrjPos56r7LUZoxcAbQ/tctKajLNSVB6MabI
	=
X-Received: by 2002:a05:701b:4587:b0:1b5:1a7a:2ebc with SMTP id a92af1059eb24-1b56f87ab60mr19128757c88.16.1795832332170;
        Fri, 27 Nov 2026 18:18:52 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm52760208c88.4.2026.11.27.18.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:18:51 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Weihong Guan <weihong.guan@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Kyle Pepper <cochcoder@proton.me>
Subject: Re: [PATCH] Bluetooth: hci_sync: Unfiltered scan for peers outside resolving list
Date: Sat, 28 Nov 2026 02:18:44 +0000
Message-ID: <20261128021848.3616395-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CABBYNZLOCfG449tJUnAGjN=PvLVFy4Vj=bgvSCMeFEQbnudA_g@mail.gmail.com>
References: <CABBYNZLOCfG449tJUnAGjN=PvLVFy4Vj=bgvSCMeFEQbnudA_g@mail.gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

On Fri, Nov 27, 2026 at 12:10 PM Luiz Augusto von Dentz wrote:
> Something is off here, afaik that flag shall always be set if LL
> Privacy is supported. If it is not then the resolving list shall not
> be used at all so the controller shouldn't be attempting to resolve
> anything.

Agreed, and I think this is where it is off: the params the kernel
creates itself for an explicit connect never get the flag.

The case first seen (a BL602 as the private peer, Linux 6.18 and BlueZ
5.88, bluetoothd running): Device1.Connect to a bonded device that
bluetoothd has not added to the kernel's connect list. bluetoothd sets the
flag on the devices it adds (since "device: Fix privacy", 5.85), but this
connect goes hci_connect_le_scan() -> hci_explicit_conn_params_set() ->
hci_conn_params_add(), whose params are zero-allocated: flags 0, on a
controller with LL privacy. l2test by identity takes the same path. The
peer's IRK then stays out of the resolving list, as you say it should
without the flag, while the identity still goes to the accept list and
the scan is filtered, so the controller drops every advertisement from
the peer's RPA and the connect never completes. Setting the flag by hand
(btmgmt set-flags 0x4) makes it connect, on an nRF52840 and on a CH583.

So instead of this patch, a v2 could set the flag where the kernel makes
those params, when the controller supports it, in
hci_explicit_conn_params_set():

	params->auto_connect = HCI_AUTO_CONN_EXPLICIT;
	params->flags |= hdev->conn_flags & HCI_CONN_FLAG_ADDRESS_RESOLUTION;

That leaves the accept-list scan as your mgmt-tester cases expect (they
go through Add Device), and userspace's choice on the devices it adds
untouched.

Tested on a Raspberry Pi 5 (7.4-rc2 with bluetooth-next's
net/bluetooth), an nRF52840 (Zephyr hci_usb, LL privacy) as the central
and a CH583 making its RPAs in the host as the peer, each run from a
freshly loaded stack: without the change, l2test by identity not
connected in 15 s, 2 of 2, resolv_list empty; with it, connected, 3 of
3, the identity in resolv_list, so the controller resolved the RPA.
With the flag set by hand (btmgmt set-flags 0x4) both connect.

Would that be the right place, or would you rather have
hci_conn_params_add() set it for every new entry? If this is it, I'll
send it as v2 in place of the unfiltered scan.

Thanks,
Weihong
