Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19D26CE32
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949727; cv=pass; b=AohaNjzEW9G6P01Ba/PvTgMMSP++U7UaOCYn+GVX7+jc+oAxEALaEaer/w2FLLrt8gkOFHLTG+p0+I8YqNsP/QmCQ04XGXwlmmhsA6iVnrEVEYmBY7VPBc81oCMQsaC/DHs8fqZMO2UEACJgk1fp7PFKO/iI2CmgyfDLuWgvQUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949727; c=relaxed/simple;
	bh=lLsSYORUhXg5csXtryKI4yrhi7Mi3by2ZRmVBvD0fnU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GaLn1gBPrDlAmk9DX5nY0eymgUjD86HSw9GKZ9wsbsBFLu5CaGcKI6F/3I3qdkx5Lu85ll8ic6JlpRvULARs1Er7Tf3+Wuw8/6a7sUd8bC2o0PzK4WFxlghFwNdb7UPG0GL8WoHakTCAxFg2RD2iNAEjY2tbLoEVQPSsKNaUQxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4EYD+O1; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4EYD+O1"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efcef23d21so7488326d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 16:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782949725; cv=none;
        d=google.com; s=arc-20260327;
        b=K6wf8VaznBhybFtDR/i3yZPMjC/jGoVjFdve1TJPmjvWCUBN8HVWcv0qnVHMTDsreo
         XOz1UmVK7q040R/U5n9aKgpui0zG5p1MGBC8fQL8/VY7fCYhAr5C5mFOIjkI6zBir0P2
         FpZkwy7yRptGTqmLih2cg2OF6Uw/T2fRuqidCz8u9e/BMmXPl4I5353zzbMyyfnNPJi3
         ghE1SSOkHMbqhJglCGTRu9cIHaMGrWwJfbqe/bSroO8iJAKpOIG0+mJukMg7jRngQL06
         SLyiR+J/cH9hrDu3WNt0W+lmYfykLhyZK3s3md9GmBchkib8jG+bkhTC+16kxfWu6pqD
         nKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lLsSYORUhXg5csXtryKI4yrhi7Mi3by2ZRmVBvD0fnU=;
        fh=57qyEZNdGrDPmxvVGEykGBW4sEu+txlrN6w+N80qi4o=;
        b=nLDELLQmyDscD8+eNpozbXRKdHNnA5IJGUqGWKmxTwnYo3LPnj8MMSbmbZJ63U9Tb8
         4yz1x7WWac3f+qhFirta5nySadpkMan/Pcxr+1KgXfHG/9fqsEmYL4iEXc/032p7dbBf
         Vuq7s6a0fva7k3e+qPURj73G5DW50/FfhvwzPnZXAtWhe8ine5uxyofy4Q4C/AcCax1R
         H0u6fDom/Y3BA19WaAQLOXdSKORQ54fCFBcKvv1WA7Y2LXlgK07Y095OKt7tjSu29Y+o
         +6osrM093T1ycNnH+vCL4XrZL5EHSXbeccPI5T2G5EfxNyPuLrRwpOD/WwsRbnvcxrJy
         /cpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782949725; x=1783554525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lLsSYORUhXg5csXtryKI4yrhi7Mi3by2ZRmVBvD0fnU=;
        b=i4EYD+O1w24q7+z6lxpoHo+wFmeut7tIO3OC2xFmBRyEKbQAOh34B6d1dA/OEVHn3S
         rtpC10UbIwaejeUneSQ6hQhYvEX/YmVyjU6JNtx5WDeEoY5jNPLt8996B6RfdDFiU2fu
         A9sGJ0ASmbXxIT+U9kVF9juTtvdgj1s0O8ZccAXrBY2plQujKZ6zQrvkRLoITyFmXq/e
         v9I7XJNRWNAKKAgT+/WGk6IhZxWc24aL+rMS1aqu50i0hXMEFXSwSUrMpws1fqBHITui
         sL4ikWgPv03EzvJaQ3bsADrOpmZBCfv053czDwRQeNRluDmEF+KSLIjUdgoVJ/Uahdvu
         XLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782949725; x=1783554525;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLsSYORUhXg5csXtryKI4yrhi7Mi3by2ZRmVBvD0fnU=;
        b=g4LB2/NML6ourRkFxcd+CwV96PGFoPSLjmJ0NVPfiA9m37zz6ZznKgFOFfSv7IAcYY
         YKHzOHlBJdcEHfkA7/uZeVSX2k5T949I2oFTNyblhLRajyNwIT3VoclqAHkJY6AKT+0t
         QbPQUc7MZXYqAH4is5yAWKU/27ha1fxqLIGtQrJrv3CqmC+6oIVAptyLoK3XCFD86s6O
         UCUkkBzP9q7JV6+Y/DMTUr0isc2iZ/HEhq8cCu38UEbQx3SL+dX7cR7jrPA6kdpmF9yH
         X2zLySa1TlZCJ7W17EMpnh4V2sYZ+kp2cSsSrV8aGA0TW78IWzeNR027dm4+eWJuCLVp
         vy4g==
X-Gm-Message-State: AOJu0YzLIhMKzSyZfhsLCBaFI8086kMex/mIIQgpyS6TQ4TOrs8v9VHB
	KcG+FLjQSHk0xNRC1Pi+AgNZ0XfWBvzJ6uRh+Qq77cMxDCrrnG59GBuKZpewCs09grWNKGr2z77
	AVYWJnuz2u3MPd7gkqY3vmglP42W8/pKoGf9R
X-Gm-Gg: AfdE7cm2B7OnOoB+9nU020CqYJRfCdlqrKdRfl4QpZNomZ2I/03GisErSk86l4gsZBV
	KxrL0lW3WPnJpTP+cjSixe+NjuNP5IoK+FqkjUK8SSXXvy2ZayLm/9mgQsoMPwjAINVkKGfWFfD
	q1kA60B48A4MdBbcV5hyqb75AdwCIsPMPIZIN5pd53NJhKr6IkVZNLK5I5fE/rhEid6O4kjabxM
	SMZJU6N9l/9D/g7pEN6a/e8AkdAU8QHSi8A5gvXTPoEaE1wrjiHug9XkrWd1USfBTJu/rgtzmYd
	QGAwLaIjIQ==
X-Received: by 2002:ad4:5fc9:0:b0:8f0:c170:4591 with SMTP id
 6a1803df08f44-8f3c63d9fb1mr53138096d6.4.1782949725476; Wed, 01 Jul 2026
 16:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joe Sarsfield <joe.sarsfield@gmail.com>
Date: Thu, 2 Jul 2026 01:48:34 +0200
X-Gm-Features: AVVi8CfczNZusxjS2wW4lPdL8YAwDvDqrI9dCYcSN3EhuIzTVOGHtN8dWQxImYw
Message-ID: <CAOMLKVHui-5Gkm6Pz=nc9kUmOJBKFCMoRSi_=4=SA_LQUh=DCA@mail.gmail.com>
Subject: [BUG] Bluetooth: MT7925 LE Audio BAP duplex invalid ISO packets /
 controller reset
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I originally reported this in BlueZ because the visible failure is
with LE Audio BAP duplex, but after collecting btmon and dmesg logs it
looks like it may involve the kernel/controller ISO/CIS path or the
MT7925 Bluetooth firmware/driver interaction.

BlueZ issue with logs/snippets:
https://github.com/bluez/bluez/issues/2067#issuecomment-4860805376

Short summary:

- Hardware: MediaTek MT7925 / Filogic 360, PCI ID 14c3:7925
- BlueZ: 5.86
- Kernel tested: linux-cachyos 7.1.2-3
- Headset: Creative Aurvana Ace 2
- BAP sink / LC3 playback works
- BAP duplex can sometimes establish, but ISO traffic becomes unstable
- btmon shows repeated malformed/unknown ISO RX packets on handle 0
- dmesg reports repeated: Bluetooth: hci1: ISO packet for unknown
connection handle 0
- Earlier attempts also produced HCI opcode failures and a MediaTek
controller coredump/reset
- After later shutdown, the console showed a Bluetooth kernel stall in
hci1 hci_rx_work, with the trace going through iso_conn_del ->
hci_disconn_complete_evt -> hci_event_packet -> hci_rx_work

The controller advertises cis-central/cis-peripheral and ISO-related
capabilities via btmgmt, but duplex appears to trigger invalid ISO
traffic or bad CIS handling.

Thanks.
