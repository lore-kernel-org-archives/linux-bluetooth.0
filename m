Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667437;
	b=AZIgBluTtQcIkzmLWU0dRLB9zBzr+AS6I+QXp2we3KJXw2Wxc4qOQaWgJw7ehTBenSDs
	 Ug7E68hYcyzw6UfeK3DSgkw4mW37M2LnZ5nSZE34VMjAfLKTkogKlTTPZsCxQWYoz54+N
	 dFzkmalcvzbsq3A1PDGqqUzg+fz8EvaC6km6XKqRNe6JAkRfC0TxNYt4s4yapdUN2KblL
	 qDxk225oq010kObVpU1OnVFLshXth0wUZz96H/vk5lKsRg9uxcF8RqbP/YuzNzc72wbcl
	 5KVUzaQ6gIojNNWhXIKZlabdSPULH32NxMuPqo3lZ+Z8UW0GNJPM3TCyC29DBCnShqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=jN2ob6Zeke70EzTLSquxhjFtzjNrD0wDnoFlU2WRI1s=;
	b=401U2dgo40RemAuBbI5sWF3daBD3Hi4oSSQ6c54isvV/5DMz4TuNQitTLMl329lF2/Pl
	 QCyMOwkem73b69CSqaoB3NAgjrceBoQfuzcOttrpHpxgBf/95yUYZAgBtqV1tsQg0YA1u
	 IN+y/yCvi694bvONVcjI9BD/an/Y3dXtixrH4GuEBwNhPLzA5JvwXWPvVXRyDUELkJHjZ
	 ycMmYshDEg8dgG7Au0CR2PdUNEHBCqcmXsdj+YIJFxhZc+Usv+PfXO4Uz+KOzn0Ykn0kT
	 LwXWGXanwUfuYTre0yivcAUCkaiOCFRkVnpT2Rgf5Hau8xV/p45d6pBahQD/oxyI1xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uZ+mC9Q4;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198D606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 04:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B198D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uZ+mC9Q4
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-862df509d48so5030147a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 20:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795667435; x=1796272235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jN2ob6Zeke70EzTLSquxhjFtzjNrD0wDnoFlU2WRI1s=;
        b=uZ+mC9Q4eAk6n0ZeZ10++3pGXeYeBrw178Y4c6D/ZE2QDLawDPu8KviSsyQGio5hVL
         H1PVQa4PYg4UpqkMWt4E0/sZaI6O/dpOTzrCnxASiZCqObjXGvTpqDcdfgelNmjXYaTj
         0bAtrjV6gcKuNGwEwj5YmlSeqPxm77mzoPco3LYnfoc1OqmDqf4FuXk+RGKUsOegUiOa
         3bUZQdeMSSUPQFb6s/40f2hnImN3OJPif0OeGKWmnfBT20FOXGInyjj64KJ5GSZAux80
         0t2JEcz+vy2nVA+5VQUnnLJhOGONXoCVqUnFhqc0uB9drkk9sANu2/vYYeoRnTA25DDO
         cs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795667435; x=1796272235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jN2ob6Zeke70EzTLSquxhjFtzjNrD0wDnoFlU2WRI1s=;
        b=aXJdq3ZFzDKrcPiIlKKVy1BpTwzZgThtuTkm9rdJwFShslD22R+nrPP00t1q1e2IO2
         eLQqYb2yySkk66ABGftmjI0pZosTmneUZJbknJwVsG94yKLXUyiYa7PVSmlgnZshDAxu
         MR4eglogboEuDcChzWRAE1uRvMQNMawLcurhivxdojcnRPRyEzUHLR/d0r8L9K3s1oSt
         RRRd2UEb3XDSPvngd/JG9hdeck3tGT29Lztw21Z4X0fB0mtkETzb+a/zF8dfprGiHuXF
         lNP9Rfbdq5qmrXiAVoc7B9Q3HHOvun7ZrlobOlSiogdLZnhobhk+2iFppH9P9eqJqMLU
         +ScQ==
X-Gm-Message-State: APuU4Z8WNGCPam45QwbGbSVsMlfuQ/XMls2c2RQxt/AVbC19Zucnx8Bo
	KZrRGQ5e7EaFVUIsHHovBRwN4lf/7bGlRQwLB08SewtFMC+EkwM2CpsOxBWHRwfW
X-Gm-Gg: AZFdTZft0gM8jcTqLg4eHEpT1zbRSLESmYYNXgihBlnJD5NnxeqkTeRqV3eFzDYy/w4
	lmnJk5muo8A1DWEN5LL3tB3Rq+JLpenC6Nd4vZDIzZA7HemwzCpRGXNvgNugzPnrdzDVG98/Z7u
	4g66Mnd2aJ/EPqQYeHTIhhBFByvUagsAscWa3qIzRXvmMnUDAvkQGdIweS2TDfiT8K2QAuDOCa8
	OJSlRsSSAjUNmRB2f/to/KYCXID4eXmB//xF208O2PxYVG9V9l7YIsrxvEw7aRIp6fFwid0LmIr
	luIMbHZ88zOGbaUihHh4wlG6FOs9NlYl0N1KJ5WZ8nRx5UlEXpO6d77UvXS2XSJSdrngjADstg9
	E2feX4QYP1eGCaION1rAVeqR6A42aZYP+gFbmxHlIqdD7R7irLL+sdgJ0BwX0ojxABa0YO6QnP6
	rv4nScTegNtOboI4mfKGh6X1lXfCdb+3+A8GRVKdonmVgrOvZfUWoxh7m3LHHlDczfZFnISqAYZ
	uKQl/gHQzVwLB7RISkpZF/nG7iGavNgA88ZlYg5Q/RQzirWhZp34x8oXKYTVbQDRQ==
X-Received: by 2002:a05:6830:2683:b0:862:a5be:a6a4 with SMTP id 46e09a7af769-863091a7251mr17177993a34.13.1795667435211;
        Wed, 25 Nov 2026 20:30:35 -0800 (PST)
Received: from [172.17.0.2] ([52.173.179.181])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6e7sm16230822a34.12.2026.11.25.20.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:30:34 -0800 (PST)
Message-ID: <6b07b5ea.5293ddad.2544a6.0354@mx.google.com>
Date: Wed, 25 Nov 2026 20:30:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0662887014667796618=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/8] transport: Hand the owner over to a link still streaming
In-Reply-To: <3b2039804cdb286aab8d19e6e2e74e6d641f4d9c.1794349049.git.luiz.von.dentz@intel.com>
References: <3b2039804cdb286aab8d19e6e2e74e6d641f4d9c.1794349049.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0662887014667796618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v1,1/8] transport: Hand the owner over to a link still streaming
   Pull Request: https://github.com/bluez/bluez/pull/2791
   Created:      2026-11-11 03:05:27+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0662887014667796618==--
