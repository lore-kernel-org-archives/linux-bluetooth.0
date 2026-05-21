Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0303672A7
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335844; cv=none; b=QokWmoYMURJRzsnnP3N2Bud4MGkdEA00PlvgWVousxfcvWM4uk8cTLwJDKHb9DZmTMF86vOf+2STWtscPx/QjX8AzQPB1xJtCFJDWNrhSoOiQOkTAEI3S2DIgWwMICaYPxNg3rQx/55/sK3ajiwb55pOWteibsPdjpVfX7woOzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335844; c=relaxed/simple;
	bh=rQ5YBH5OsuZ115C3KKURjIvzhYph0Y52zjDF0mYc6SU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HQSi3dxEW7Zh1A/0Ji7FfcqJUdtnDij2ZGJ6ea/BunE5R52W333xFI7G9GWDcczGdEeBR0EHIbNTPLBPaPQPSZUbKnUtTXDgcZz61BCku6KdbaUi7G6l7k20ozoArSY3KtOMDrzz4o+fzLiv5mv6N4jkSnRLDngkXkfa/MNs+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIEFFplh; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIEFFplh"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dcc9b506d9so5950012a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 20:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779335842; x=1779940642; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rQ5YBH5OsuZ115C3KKURjIvzhYph0Y52zjDF0mYc6SU=;
        b=SIEFFplhyHKc7FVqH90CWAoxRDqmDOpm2YmTbJO3bq0Xjuf+Xop9PfECbmwHP07QTB
         2M0HjcOIedMwjdeVRx3QCYspbcfNI3kobQLC3daPX0wlZwkv3zCHgKFiYbhK3ZpCzR4/
         UUErPMZz1yRZhcBdUZEQduma18Njz3kAQWAYnvJIj/13W+gpbtHAneQbhY28GnpbJZ+p
         MTRLOvXEnZAC0juTrsGA666UynQbc64bBGw6N+fw1ZLpXgiOtbN1PQvmHmDPT7fNW7wZ
         /bPW0e8COQxlycyLIPynArUzEnxAsWyfeC/jgqdV2SauY0zYuf9bW0Ga8H4CTCnahvyb
         pl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779335842; x=1779940642;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ5YBH5OsuZ115C3KKURjIvzhYph0Y52zjDF0mYc6SU=;
        b=LxwNS123vHbOVN2K4/tnOjR7pAwPcTZcloBrMYv8lC7zS+U//NMCg4fgzleWwkoYef
         VCWPnEWB+0MEpgSjFdsgtOTtf7/WA4rrloToGw5GXtDzHfyxqmtoRunRYCyxL8lxNujG
         sZ8UEMD4yUy/9dGQRQhyQxMOoooQLL9Z5D3Cry4l3JrAkGVNssrYdBITabQbPLyusxyM
         r4ZGb7S1ToQD0tt7YDZDbT7uDHh5Yysn8EEAACDJmXoI+vft/nwOQqpoMi5ASvP6LRQ0
         P+gOBm39wtv6z8Pp4zjaeKy58Y/xARnRcEESGF5L5+JaErj09KGjyqVQVBV3KOSOWNky
         w8/w==
X-Gm-Message-State: AOJu0Ywb5t6BCyCzDj4XscO2QTL+mnwDYSa69AddKp+5zQamo1q8pvWi
	bRI+1W4vzM8iTxtXgbqh7339CgYFywbINTOQsJ+9St5ed6yFicmZAj0DxqZDLQ==
X-Gm-Gg: Acq92OHkQkAG8xx5KirmJlAs384VVUtW31kzBznG2YORiBnMTxIgosj1xdd/LYoCkLr
	AT3z1+s4yCOrVTobI3lLWXA+ZVzFtdRqx30jg3l/hsHVFekkRqO6mDRDhmD+BxNQ+iR45iEq2xo
	/9jhtc6Xw7MaXm8GkOvuQzAB7b6qReexlAcL3SarhwnB1Dvv9WKLCF5aFA8xdPS6kZ6LZnt0914
	hEIVZmhojtF0xW1h47NNktoCIYSdBUlBLp7MmViN55jcn4vZSWoWXY9NJdVwmLVpCe7Rf9bxa0H
	Owy8+eZkGx3G6dlJlOfI9i0Xc6nQP8Bffp5oqq7g8Hl65SQbWkuMNGepYhHB3M5n3dADEmRO1wg
	+ktBK6VgJHUQgPT9mAUElMuora5p2w6BA1LcaAgwQliaUQYRmtov/tk1JsKe23IeKlTn1uiftJl
	oCqZ/JTi/4/IVQMR7Py58vPTD5vt+1pS3D93067pGA
X-Received: by 2002:a05:6820:180a:b0:694:6d72:9fd0 with SMTP id 006d021491bc7-69d6ee4e81bmr504576eaf.16.1779335842208;
        Wed, 20 May 2026 20:57:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.15.228.216])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d694d1f23sm1193181eaf.8.2026.05.20.20.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 20:57:21 -0700 (PDT)
Message-ID: <6a0e82a1.131d4d69.3874c7.d8ed@mx.google.com>
Date: Wed, 20 May 2026 20:57:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2185693424228909111=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v2] Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
In-Reply-To: <20260521021249.3258069-1-oss@fourdim.xyz>
References: <20260521021249.3258069-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2185693424228909111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_sock.c:1512
error: net/bluetooth/l2cap_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2185693424228909111==--
