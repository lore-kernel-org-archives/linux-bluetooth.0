Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B930E831
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870718; cv=pass; b=cYr6135cOQX+UKAaolZSDvmyZPe1kmEsgW82UkUx1jOUBtLuWx2kC6FpbSBU69YI3/ZWw9s9KjvNOYsmLpY7MxEHmPgpiEeF9g4SpBzrM1mDV6C7cB2tBdxIL0Lx1Pq4YpEIe6NnjqLrFbEvkgmO/87fS7U3Uw+Xzb1KfbndQvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870718; c=relaxed/simple;
	bh=mhsSIyJljT1ri9cXEnM5p/ZpeffSYBc3tKbOFjC9Eqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anRfGlFoF1WxFrazOX9z4YcpttFZ1/EpCbjtdUH+mhqkiJBrZA7SJCNPUlf40+bUJtlkss8WR4YPyMiefBJpStjsGBwpCOpfFPmAca9CLY8HZwOwz4rA5VMQ7lgkCkH9ez8UNsh6FPVz2dUlPkIzpsRqZzg8cEMhF3QYzOc7BLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hARLAlRu; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hARLAlRu"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65006c99d38so5251488d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870716; cv=none;
        d=google.com; s=arc-20240605;
        b=W+vfdTTsEguFAnWlo1gZF22J4si/S//0ZJ0fjf5UEIWgW8w/Q8iKmKWqyC184Jt5cp
         COvVIVnu4yciP9Cyk9bBADZHZrxr9cC4qPTS78rozK5B9VB82lZ6zR54S1ljln/qev6V
         q2B9gavnzMC19t/bGTj4SHVoTFtFnjJl8aNN+8Iy9PyPLaEo4Kic8UycmczpYuqxCQ+e
         XK0L1/fymVbmjqoftdI4ImHnI10T+4l+OOeeR0nwC/JbQHb65L67tLnifVI0KXE1bgGt
         XI6wnRYUw8F3Czcgd8Y61vBcLV/vhecmSn9x+9nPZ2ODy15vK8xy1PzuBXxehF8rFChf
         /0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJadbR8Ee8ex4TmlYfT2JJ0NYAt6/4fvgV47acLHcHU=;
        fh=2Hhs5LheMF5XgMxHYdZoBMceuI+Ib3J5uXN27YAfwgI=;
        b=SsmNIz5O+V5XBgewANZG+HEW+emvAJJ/Cs3oq5G5MLpX47vJcfA9lDaVJJtduB8ZP9
         EMpGjZQDIb7j7ewKAP6gTR0538M2ivbddYvmM/QHIKZMt37UeKPEoOW/n/Aeant73a3w
         nhTXemaBoEjlwsIf9y5IGYwE2kvq+X/p5WbgYcJJhvaY6Q4WALODHDxUGV5o5WHe0osc
         cg8ZfMgx/R7r9qHr6CgG2QIhZ2IDDFrhd6xOHV49RlBt3h/8G+Eunv64AfdtzUXSIecV
         6vpB6QjKdvsR7on7rmXNkNDjtUo9Ml4iYmF1JqX92d21Dfx2e49Xf7sY5v7T0oMCIQXW
         PF1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870716; x=1777475516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJadbR8Ee8ex4TmlYfT2JJ0NYAt6/4fvgV47acLHcHU=;
        b=hARLAlRuQJ2rKRIQe05edvkAUfSx0WHvTlH65V4ZcBDHI0hvF33zNEiLjVT3zVHKPQ
         p3iHjgJjkg9Tzydsviawc9jd35Ae5cZ/OxcqyBhIRsPJOFeXPh6wkqK9RAaEpkRQKc8h
         cmIXkyHzoSXvk4GIehuJU/Z+a+J8LCxlsQmfo5tuJ0TT6zlkpI8KEAbp2/q4xRS6ijmX
         VsxhDApo9njAieFxVntPa915xIYb8aRBAsfU/lqkHN7mZ9L/JMypQFzs8q77Hl9Nl7B1
         wlXmhJcLQue5GQarjt+dlqvO1omfuqvh0FABT9JRuPoRgjFM3d+MvtE7adbC70gwqQL+
         qkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870716; x=1777475516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJadbR8Ee8ex4TmlYfT2JJ0NYAt6/4fvgV47acLHcHU=;
        b=fIdTLTQrVUHXAMUJq+kkYs944YqvPJOdL3PGEoZ8dBaB2ZT7tlzqi2xC0I90Vvk34N
         uH29Ni+Dlhjkudy07aTwUgP/c0teNaqu0HWi2DghETI1XP8Wpi75juOivnnD5zvH/toR
         Hv3fyZ1rUI2j4LKoOXBDDkEJeRpvVhY+u/xhIHTy2IliuewSTp3dbePcAlxeznKkHQm6
         IEZgXUso7G1059EATvAvHSZEvDt8eXtJPZ2TBDtecIcuwvnqnH6Nznnnm7l9WEmje5e2
         vv2THY78YtZR/qQaRmzKkmVKeAafgb3jo8hBcj7AV/91r/YDP/J+oBrV+NwEEU7efTXv
         qmYA==
X-Forwarded-Encrypted: i=1; AFNElJ9SsMKuoN7eMJcU3h+vS3Bz9Hy8LadEjwlYo3EAihxLjZNOIbwVhnxPThEQpZZfBkEHNKYB9SKVENR7q/J36P4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3pYJCk8/QRpUH+P6QYyQQN2Z1t97mjDpZv2ot1CA/kWwBNKV/
	cjVZScXewSwpDvE/KhphnpklwAl4qQlA1eBs3zHEOkLy1nKszC3JKONtPlQguzFW2etVzibRyeM
	9s+isIkx0l78mUDfM2YXAkBkEIh/5lIU=
X-Gm-Gg: AeBDiet4OTzaOg8ubRzT8dNzWYILm7en7zGhMXjYf0oY7e4eepXxueNSQY58qL6XgAz
	shushLyG18QvT7+MFhAwFhPVEJhJ+wO5cb1iZD8dAtKw3bqugzPNINvyyAel6IxMILOF+CDWqQ0
	xHfNx/zA6qu60xgbIzm6IQiLHutP31Luu5x4ZAAhmGgZLQbT3vVaXIQtpx+wiWdLn6US/aMLA+V
	NMi2Do5nFE4Dsucg+FCw8aUdoasUstBYFlRsoHAdByvJReTMEdPrEcUyAKv7i85eT1yusj6WKgw
	QTC/UHNE2xCeiNxH9EMYRSrKC7KHFtnpTcdxheyB27K8HkxtiG7OpbGGQA==
X-Received: by 2002:a53:d015:0:b0:652:cacb:ba15 with SMTP id
 956f58d0204a3-65310b7b907mr17950201d50.64.1776870716398; Wed, 22 Apr 2026
 08:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
 <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
 <20260421135639.3185653-2-michael.bommarito@gmail.com> <CABBYNZKS5Prm+BTkpdPgArgODTEDgHXLjecfux=3ZW0r2x=UXw@mail.gmail.com>
 <CAJJ9bXy8CVjC4xG0zBcxi9xtiep33-uRGSysL1Q3FiqCN7Rt0w@mail.gmail.com> <CABBYNZK+o0wwOvjoz9w0ju4SoXpt6PM1xQwXU6OozVJLstWMGw@mail.gmail.com>
In-Reply-To: <CABBYNZK+o0wwOvjoz9w0ju4SoXpt6PM1xQwXU6OozVJLstWMGw@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 22 Apr 2026 11:11:44 -0400
X-Gm-Features: AQROBzAu4VbldwFPAE-MOIjgHMfiFTItXYow0k5lFdAXPvhF8M-n6NytunHWXUI
Message-ID: <CAJJ9bXzsEfzaRzbL35UQyeKF=00pq_c1x95ppTKod3wog7o7NQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM
 RFC option
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <martineau@kernel.org>, 
	Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 11:09=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> 100-200 is not too bad though, if there are splits in, let's say, 5
> changes that seem doable, especially now that we can sashiko review it
> and point out if we are missing something. Another approach would be
> to leave the pre-existing issues to be fixed in a separate set.

OK, if you're down with a bigger blast radius, I'll go through and put
together a bigger patch set so we just fix it instead of deferring.

Might be a few days, I need to block out more time to diagram the
state model and conditions here given my lack of familiarity.  Thanks
for your patience

Thanks,
Mike Bommarito
