Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500322;
	b=k3rq8qI9UqxK47pkyjO3+o795BqQqfg5gN5MANvC0F/1sW/w2vkCeHvILL6FD6wFtoRd
	 3BITwQl3JN4rXrry64o3Xda2bl51KqiaalF9r+aj/ngGvt/6O2yTBLbG0SERTkigavMzi
	 gL5PJRVt+j6AAwiTzYEtMCPTMXwgug/RBMArrVuE4ZFMdACEGtROJD75yDBeC/Zr/mfQP
	 5ej3dwJNVc8PjFdRku5rtK8dcbhOkdCAF6cIKma9a4BWg+QtLPQCK2cYPKHN+p58oMjdh
	 2yy+dVI01Cl1FkpcJsBmlmjXs1gPCP9WLv8PY/Im4hlsDw65iuopomHa/ZJ3c1uB0hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=wm2X6Q9WO6S3ryZqISgW6UrbipF+rIndX88Sra72qMM=;
	b=k8SOX1jOeRwTxJuBv8s/umNn9Nc1dnWIQJhdH5KPLfdYEFGkBRM3OyTZ+YnC6UlM20/6
	 I/ImjSANPiRYAQKQ8blVp6sdBsjMZpTepREfCaAACAlmA3x2Z63XVWo23Fl14xwrChoh+
	 Vc3p3og83cHJ41gNtPslG2yX2POIZBEi2A8NAydu+J1GUT6WB+8OK/xtiz+7gmCHKlwcs
	 UQBH0PN+6sSLQhNy0yBJl4t8aSAM4YcdGBy94qLg5p8KHAfejo295eAqB6rh7H36QGXl+
	 NlmfiUFcR0h+v3USZkf2/P1RaHcHnKRpPCupNxH2XmNlN1bYq8VRbKzMwj33TE7JrJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g80a7033;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA2606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 16:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60EA2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g80a7033
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5365f9a04c5so56158331cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794500321; x=1795105121; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wm2X6Q9WO6S3ryZqISgW6UrbipF+rIndX88Sra72qMM=;
        b=g80a7033OAOgNdk30monzeqjuPKHAoQTJdp16xcS1MuKiq1NqDbyJ9RQq1EmVX5V6G
         Eyjoin4NZAXvOYX5CtvSqReZyI2MOqxa93EQqQuQ4aNd16AxwK0nrgWrx6mLptXhdhp3
         KGGWsNCt0mkknrEWA1mkQBx/Y4K0yEEJXP196oyN9tjgppPy0Q2nwKjK7MDzFGD68q4c
         PhMciObFgFOIMi9v+vB+RV8STWJYeUlIi6iMbHA/I4ooBgtaXTa35QfJxA1RZUwRKIcG
         tcsxPkEq2iHFnSCQC8D17tJrNpfdLAbASonq1qw6dF0yAJrTN5Ke8PckPnQL6GqaNpyF
         Ud9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500321; x=1795105121;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wm2X6Q9WO6S3ryZqISgW6UrbipF+rIndX88Sra72qMM=;
        b=1ciDphcBHm37Jgd9CLnYPspZxtjOFwF8E7JqPS09w2x6gRREeB1UV9uGGS5O7VrYTG
         tvop1Ab1tEFZIrCSfyQp1ezljm+UCMt3x32mls5aEj0Afrq4pC7g6TwhTcnxAHM5dNGv
         /QrlcQ2dzORWy83lGFW0gZr+BQCLuuft5S4FFDpkELQvCnKU0j8FWd6MLY8UmqidEjIA
         x3Uq1YelZjyBw4RTfGUqRC5fCOHWLC76n/SrfPq/kiQHZJpuJdfAiHt8os+5g9LBQ13H
         o9jJUUtANis1EoPsUHzxElgXRjD1mh0/5GGoApckMSWRz6MCKLyKPa4BusObgHbRwB0P
         DJcA==
X-Gm-Message-State: APuU4Z9U+O9APeCvD++VKoNbTlGDZL02twTEqcm8FNw+ADb45lUuuu1B
	qST2Ma8OdHzq02NQiB8wSHwL15Nw3E61qYi3ChJLPKu52gzVL27LNXYxbEb5wQ==
X-Gm-Gg: AYBFou3gmjBUSch1iJPmyRFIXP3ooq/yb1n48E1/ppS8wUJtDMwIl50+KG7Di8z2ZRe
	0ifjl+xrZLA3h2LQYS4TRuxV9Gr+p+ZIZquy3Y32Wi7VZPBmfGyYvQx6MSx0fr07DQbNN/Z9e82
	PPCO0beSMjtKg9lgwD6pUH2Qol3XED/FeTiwSQcNdk9gfnvdgfY+Gh12KCYhNI8DSD98YQ6V/5y
	b3p4cv9iiQLWP1Gwiz9PvttfW8XWIp01ooIGtYljDYvgzIKOU09vgMEp4Sg/fkR4N18B/5W5Q/g
	XBo3cghFw+1BUj8Kh5hJWGY9X1+xx8gUhHl+70M5p5OpVlJEhwXUMqNctak2B6SebDX3JRZ7duJ
	bkukiwr1ntC98d5mIZUKnAe5emYXN7jQiGOgJRN90MbpkiSzSWQRb3cIeLDDb3Z5PjzrUtNvn7M
	XWBnKcNXOht7oWEHhwXdSpnMjjcrxkystvjtW9vArlQgHF1NsUc4EF0mzgMf2h2kmFEMucmdZlb
	oLc0clZXxjTqIupbKHSQbcIMCRBdOruhwjv/A7+YJ8xwvUa/MtzGgKneAc5kg==
X-Received: by 2002:a05:622a:590b:b0:537:5488:ac63 with SMTP id d75a77b69052e-556c05ee631mr108089281cf.34.1794500321348;
        Thu, 12 Nov 2026 08:18:41 -0800 (PST)
Received: from [172.17.0.2] ([68.154.79.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550ba432c4sm76931231cf.20.2026.11.12.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:18:40 -0800 (PST)
Message-ID: <6af5e6e0.55d9540d.264330.5663@mx.google.com>
Date: Thu, 12 Nov 2026 08:18:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8624806167529045618=="
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
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [bluez] doc: Add CONFIG_POWER_SEQUENCING to tester.config
In-Reply-To: <20261028-fix_tester_cfg-v1-1-e965db9c3c09@oss.qualcomm.com>
References: <20261028-fix_tester_cfg-v1-1-e965db9c3c09@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8624806167529045618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [bluez] doc: Add CONFIG_POWER_SEQUENCING to tester.config
   Pull Request: https://github.com/bluez/bluez/pull/2732
   Created:      2026-10-28 15:21:12+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8624806167529045618==--
