Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026186;
	b=CnF4xutKRJGGhYi3xi7+bo6kQjXSRpfqIKQuKneeimstfIlL/TWB1vIyG3XPk+cwqaul
	 zDvso1/P/78DtqzDGXGK3ysk/1RH1vS9TgY1wgT1n4ZeEEDPphS+v20j+f0UAcgZoc//v
	 Kbs2dRpu0IKIZ1K+RbqW4OSp5yOgSqmAVk1bmtciiluFHmLFPyJm5aIDOm8GBk02DFIod
	 OW9Y+h6rzyqvejySKxkpDA14wFEQHR4mZvUghlYShFqhPIOG3Ukm7YMOUTaoFjkxkjuzi
	 nLCVP/ETYsL6YkSWXRMP4eeA09FN622+f2u7rcYH7ZoQUb2CEKv+pFgn6BXa+qH64Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=HvDhsTuC6CIoeeF8m7vRBoiFrfgm7ZZgcncQxRsgRoI=;
	b=M10p+Za2uNhzNWSPJPTgCb6WyEuRyVgMdUMYWHu3aqSCm+Xd5fP3OpWgjbHFIadaBs15
	 +r2Mfd3ELyYrn1XwCUeU6eZ1lMN2mBdYAx0eiyKfirTSK8NHa/TtzmtoEYzEqHDktUEe9
	 eMBpGLSxCcJHLggtvrD/S3GRj5QrfvPyqBdc4th6RuWY/QF4d9UtQr2z7eUs9mT2fqFGe
	 wZ2B0YMUtHhMuQS0mcSbtECYsVIjX0I7Huch4u0kZK9lQyB7Y6eEdjN2ZtOraSFoYCJBG
	 V3BGtE7TTyrhP8ztGcQRqgwers/OH8VoU6+SSmKnIACqP0gSLQzOC2+H4auv/uzyidg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=quj2Td12;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913160A260C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 18:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8913160A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=quj2Td12
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb628232d2so809219a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 10:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795026186; x=1795630986; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HvDhsTuC6CIoeeF8m7vRBoiFrfgm7ZZgcncQxRsgRoI=;
        b=quj2Td12kw/h4Rq2Ye2njUjlca7upIKqqIRG166mORG/a7h14aaeVfYGjeAKy9xZhn
         2cwwVc/IQ0fSi6HwnRSg9y/p749SlJ66UoRvieEkxSdP7+/NLlJL5IWEDFN490+cXyt1
         o/pyN76+CUtBLvf6SUDqiASaJSgkL833p5iSyspNjswI/sBPb32EQOCiOYJ2f5ye7kGc
         Y2ufal+ZLUmSp4sqSzX14PhOdgSbT0cN9EUA3y+gwKUaX+awZ+ovFGLvC3U82vcZgnjo
         5aomb7eaSJvC4yWiUO/luWBbRj5V/Ug3co9H9w7fMJ2fZYOZpk2Ycu4iboUFJh3q8VRt
         bMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795026186; x=1795630986;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HvDhsTuC6CIoeeF8m7vRBoiFrfgm7ZZgcncQxRsgRoI=;
        b=nyiI7UIzFE7n5iDbzs3wKIHNsMPIDh6SFkOcp1j/wHbKV/OSU2Gn6quavay9F5nQbe
         2XMn69dIkhhiA8fXYI6YnSYOlbpUWSG0gzRlXTzRCdzeMJSKyL/5OuDgHslocZnfs495
         LtpatkBIvDnfuS8xWQGWVIRu+nh8z7l11icD2L8isZJNHErrYG6uW3gUsUXQkpntCCQk
         Nbi+rVia+QY0b3R5LZUD2l8Uk/6NpIxWSIiqUyQgMpMOTqu8QDBBAtPqDyjy9ewLAwSO
         zAeaZSikND1HqExrJyPrjTfgLiOYYsZNCSeEK8S0iKvhyEBw6dE1UgSpDr9HIX998ox3
         UzUg==
X-Gm-Message-State: APuU4Z/8d6kMunFuBoWKlG0EMekdCfZg6CQyTPCTnWIKiot6s7l5A/Kq
	MLhqIFrJFmiwPVFEl8sewAk6XnfwtLPpvORtjvYXYPK/GYd1/YPGoC209KH0DA==
X-Gm-Gg: AZFdTZd5l0PQvcJSXeSAm/4mkDOr2ulNTA+j/1C3Der/B2H+7p9FxAdYGGDsUF9GHMS
	1pohuz5a14gYSIilzowxJYdTb2yvqTN60JBByxkFST8PFGxvkVDRbe5XnvnPpStwZDCG1YiLuC0
	27nLfah3yCvLPbnWPpYXBAsujEL3Z0peMvSZwvQ74K+mJNvHDjfTDCPCroVFArvHyIeA9Snmurg
	3Bp5nHcACc9nhcYmC0tJ8cvGqZGh4t9dwM/JgDn0KVy5+OPK2HNWc0rvT/2krFAspdD0X11kjgz
	f8z+R31IVtquRtQ0ePcQNW4C0xGy/EOirozEVw6eu7CQUkgeo5syYcN2P5qRIA8+xczRj1/wUGk
	Yzurwci3yY+SLWdG/FrYECZTqJhTpinSr3VhYjeiXa3YQ70NqnjZkLOHoWqb3n5RF3scDqXPbDU
	GSeFbvrVOHltgXi4F1d+Y/ousQ5DMLz0wMFN3D+aRjiYI2orpyJT1chTxizvrTVPaozyIx4lw8X
	r8uWeS10wOWzxg2bI1h3OoWLwQWdadU3YQXnQK8gOCUgr70Y5asLmZywnrkN1EUDsc0RAKs8zhy
	ViOKVxLwy4X8GuGzMC4HVPOUKMdTa+pddCg9TSZ4
X-Received: by 2002:a17:90b:2e83:b0:3ac:ffb8:183b with SMTP id 98e67ed59e1d1-3b3d07d929amr3917121a91.51.1795026185847;
        Wed, 18 Nov 2026 10:23:05 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-143.us-west-2.compute.amazonaws.com. [3.42.157.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3f6be0617sm386002a91.13.2026.11.18.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 10:23:05 -0800 (PST)
Message-ID: <6afded09.54fdaaba.21e250.53a0@mx.google.com>
Date: Wed, 18 Nov 2026 10:23:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6359321203011850647=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, junzheyu1@gmail.com
Subject: RE: [6.6] Bluetooth: hci_core: lookup hci_conn on RX path
In-Reply-To: <20261118123533.25-1-junzheyu1@gmail.com>
References: <20261118123533.25-1-junzheyu1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6359321203011850647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:837
error: include/net/bluetooth/hci_core.h: patch does not apply
error: patch failed: net/bluetooth/hci_core.c:3798
error: net/bluetooth/hci_core.c: patch does not apply
error: patch failed: net/bluetooth/iso.c:2059
error: net/bluetooth/iso.c: patch does not apply
error: patch failed: net/bluetooth/l2cap_core.c:7752
error: net/bluetooth/l2cap_core.c: patch does not apply
error: patch failed: net/bluetooth/sco.c:1432
error: net/bluetooth/sco.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6359321203011850647==--
