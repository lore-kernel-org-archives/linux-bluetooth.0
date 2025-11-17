Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002728640B
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379287; cv=none; b=iUJMqAPBsHBAOj6+XFBB2n6EZ2SBCGBta6KsTQYbL6qS+azbP1I250GZAJUpziGPezpmOh2dMDVls7prV26d3Dlh4d/Ir14Q+UBkkthkfcySVtnEebLteOtPbNlCNrR3A+cXrK3GorA3pKFrXDsxVYOVd4Db4LGDx7i+eUKJe+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379287; c=relaxed/simple;
	bh=9FR3pJnfG6r5uLM0TtaUVY0yKpjl5psqVMBNPoMTXJc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oU/b21vdCfa9pmq4Y2pTnQdtASOJuVaOYbUx1rEelKUdij6pvc/r1yFYujcR1IVcKaLQjbVAiZMM63ndLTBTQ80fLND9ehL99NumKQjUazh3TwTzMnBKutyTwLOe2BJorY7Gk3L/KugxrTJ3W4YjY+7b91WB8oUHpLqUoFUJ09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7wtzXyT; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7wtzXyT"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7866bca6765so38207397b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 03:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763379284; x=1763984084; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bFZXzu+U52iTEAqHg1ir1DUJ2LdbSo8VbGgRADiDLpY=;
        b=V7wtzXyTXqPTA46IzzG3YC4kFyiB+34WAPwMyRKTHOICTe9/LHJQzHct2BzAVTDJuX
         Xtoq/9bcsy1G9pFINH3pQFjJD6I6imKpZhDiG27HYyzeDNm0O2G/0E+aXRlWLgfEIXpR
         loVW+XWhB9bY40PxQNZmeWEA6t2l/OErQUqsJM3JpAgGVc8H4A8fCsMrnuZIuhcLamRv
         pXsYiOHg5gUEPjo0av7ddmkInuxh00GVs/3qiNodPGjzrvm+nwpE+w11KfMake5HcNYa
         N74yzw10cRzBzNVEpdLlK/BBzaSrcY80gGYtSgyTCXGdzltSJzgDUPadqVmmr3fbsZBF
         kiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763379284; x=1763984084;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFZXzu+U52iTEAqHg1ir1DUJ2LdbSo8VbGgRADiDLpY=;
        b=YW4cm9s5aXefRhzcLFrZ7ie+mKOZHMZmmFHaG85GPYBG3XzGjkTp1BXbEfN3c4W2EE
         j/YC+xRDvQbP3+3zHxd+mOWF5iNN4DMhJd1lywMVamadqx3KCr+SMc4UwdOZON46AplI
         mkHjXD73Q6OauTZo1Nt/HzElWg/kkx8jEOVRv/r0jEA4mPxnq/VyHkZu6JagRKHlj0aJ
         1uPgyggLb4MH6hmMCePu3D16KDA8m+BR6W89S02acJMxm/todW9nzFIWri+UCpO6WVnt
         iYl6bUN0ecb1ihvRsLDCSQbLgsKkKbBUMLxg2ryUBcBR9N+GVkNN/8sfjkICUzX9puGw
         Va9w==
X-Gm-Message-State: AOJu0Yw2v11WuOT290RyASrRNHVRtMdi8LkqEeCwc0f30g51PzjGUeFZ
	WW0gIh5RJlv7ZRaOK5yULzll270sSZgRRLRmIDV6S6SUgU7ozXZB6Z/FwuNca+zM5Wv4A1wsxD+
	aMT5tuJYDtwbK/U8IhAK5SbpZgCoOv5N2XTN/PLU=
X-Gm-Gg: ASbGncsf1VpBOux27+50pJzWhtkzDTehWBM/qvUv1nLvciIk85aXSMoblwjjmHCZiFM
	9cyM99oUh++/ftZqOoGAolvYMFrlbnqg8GO8S+j+3Wn0npFoNeAZIrmLFSeg5CsPTP3J7vzwCnJ
	bB30mYEN8dnWg87zxCBU2yPg3K/HJOyTbKp0vfION2ozs8VeIryQf3Nf3z4owq6UiTxpRdFMAVv
	j93bNFoK7xe48aldLi+ss0eF2RAFmXsQxTc62lWTF0B8ZzGMNO2s+ljLvgc6crjDZigYKLtYMAF
	vxHTDAAFwjxIuujFBLOdhT2uXaMf
X-Google-Smtp-Source: AGHT+IF9hHqJ79LSBA0KSwushmuiY5GRpbYNmQfksDey5Atud7iPl7COAMDlHQ0bxB0HBMuQMk7SG2DbvNA8WvaFr9U=
X-Received: by 2002:a05:690e:d45:b0:63f:ab9d:11f3 with SMTP id
 956f58d0204a3-641e7605773mr9996348d50.33.1763379284433; Mon, 17 Nov 2025
 03:34:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: fortune elkins <frelkins@gmail.com>
Date: Mon, 17 Nov 2025 11:34:08 +0000
X-Gm-Features: AWmQ_blS1LODOihap3b2n3kOHuGVEtEjqYixUIIqNi7hk-9IU2aCdQKhOqXAJ3I
Message-ID: <CAO8FxWrNEAw_X_TT=T82639H0o+HfRCj9O_0WZjAZUPYrMYS3g@mail.gmail.com>
Subject: Subject: [Bluetooth] Request for status on stable implementation of
 LC3 + Auracast for hearing aid support
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello BlueZ and Bluetooth kernel maintainers,

I am writing to report an issue encountered while trying to enable the
LC3 audio protocol or Auracast support on my TuxedoOS 4 laptop for use
with ReSound Vivia Bluetooth LE hearing aids.

Linux distro: TuxedoOS 4
Pipewire version: 1.4.9-1tux1
BlueZ version: 5.82-3~really5.72~tux1
Kernel version: 6.14.0-115036-tuxedo
Device: Tuxedo Infinity Book Pro 14 (Gen 8)

I have paired my hearing aids successfully but they are recognized
only as an "other device."

btmgmt commands:
sudo btmgmt le on
btmgmt ssp on
btmgmt isoback on

While the first two commands succeed, the third one (isoback on) fails with:

Invalid command in menu mgmt: isoback

I have explored the btmgmt menus and found no alternative command
related to isoback or Isochronous Broadcast backchannel. My
understanding is that this command is necessary to fully enable
streaming to Auracast-compatible devices such as Bluetooth-enabled
hearing aids.

Is there a known workaround or timeline for these features until the
experimental LC3 audio protocol kernel is complete and stable?

Thank you very much for your continued work on Linux Bluetooth
support. I look forward to any advice or pointers.

Kind regards.

-- 
Let's experiment & learn together.
Book your time: https://zcal.co/fortunebuchholtz
