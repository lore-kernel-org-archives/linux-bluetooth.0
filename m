Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B4478875
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629397; cv=pass; b=X4orfkx/CjQ2UquF84NTCEYOZ17PQftUyIZemfADy5yNXxYo3F5Qowk/bgMrSy+LKUFUZzlREiIP0HCnZf/UmmXV5mG6RE0dru39UzaqexSXuPtQEn7xfSYxMeafr+OESEaIjqpxr+6P2BRMWbrgjQGQd7rmWnIPgjD9SBFrfV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629397; c=relaxed/simple;
	bh=MNXqhaYaMWU9zsb5Slse9+FDDVQmqFJOgVPKOCpPoQQ=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxDx8B/EF4ZTTas1ecqY/DDRQP4z0hvrnZ2ynb9xo6AtaUreM7n5Inmhtm07BMkI63Y8ZTEuMLD8CXL2GNg3IONYuvsR2hWApf/YWRorFHGTZcB+FvtIQd1YvxY5vAR/iuXusLhrV/wQOHC0XhIHLINMAKdyImwz4fU5Pp01cu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmBl6tr+; arc=pass smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmBl6tr+"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-88103e47f72so2256523b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790629396; cv=none;
        d=google.com; s=arc-20260327;
        b=gxGXzfhhKV8sOlYpve8VFMVUqu3jZQlbQBpm4BxQb/M8AeAWddva/G3Xc361SUYAtm
         Gu6jddetAFE7W3zXK761XAAWMSHDS2ZM7E5/t7033VyoDrkjDwsJnU3flxVh6/jhbgFM
         ElaUihDkwV4OAiy03Z7m8mIrpmilyyUlek4AG6hPcUsnqJglHBTVAuqEM+Gawv/gJFZ6
         s1mVHSvXWM0vHvy+fUpupmLzzly1CC4JalNGRZBm0RmtmYHQUjzGNM74YsABcADEfXwM
         ywJMPwpSA5SGKQ87vZd8i/Y6i5rH6aJqRM61WQ8QkBkBk+OsDLKx9uKf9h2u0KrtUQ3Z
         poOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=MNXqhaYaMWU9zsb5Slse9+FDDVQmqFJOgVPKOCpPoQQ=;
        fh=v4Z3N2Htbr8NtGqMLkQjkIE/EbeUcf6lhEWEAm07n3g=;
        b=kkrwk9GxsLMC+1SDonLwtEPd+tsCIqGN6MbOF6s6wh0fDz8jSdRGkjnMm2atHsyj6U
         z2hJ667Wj6pEbGbrI4P66zaMoXzvMge16if34sFnyzjBlzGVo7h4D9n7bQo0LcAbdl8l
         MMyf6wa3PDzDdrnbQ+nqVN+MzIJNlES82Xb4m1KjmthwXGNImwpoHY3+Mxf48zHwVODl
         EHkm4V0E/PUSU+MtN31LGuGrS9Kc6sVFGKe8NzJKsuKTbMXvJuGief+dDUMLtVHJdHty
         SegUFzBYc79Rom+izz7M4f2DF0c/m52k+UFhqV6TpvTvxGoJm5G4PJAYrnKm5Wh0lz9f
         xIcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629396; x=1791234196; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNXqhaYaMWU9zsb5Slse9+FDDVQmqFJOgVPKOCpPoQQ=;
        b=cmBl6tr+AcRvOqHk6e4PnHV1OsFl6+dHthL3KspDm6sHv38qMp0W9TXoL6iCu5OABb
         qP2DMCNqYzua4erqCcKBGFAVv+57CceWJWA15K9qicucW1Lso30TABmHVPDe5ifIHAOU
         UTTJz7KvmJEb9FtYDegH8cSKKQdI2PHP3aVHpA3leQlg+eLMcVlMm2We18Ar4nLaIRAH
         3m0zt1hOIdoWK0BDwEPBqi/hSvvBp5brWQxkA/Hoexn2/ZFk6ydfZ4TwM8IZ6/Na/nJ1
         d+GW10Ev55ZdxPZkaVLVwsBAx6pPyo9ye1c7w67ZIXLQq2JJFuwh7TBhyLpW8ljVoHIJ
         zc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629396; x=1791234196;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MNXqhaYaMWU9zsb5Slse9+FDDVQmqFJOgVPKOCpPoQQ=;
        b=m7KX5w1Yd9SpaNvDjDT5cluvNcFAlJC8OboYReXyPuRZHgzBPnv0YFvC9CzMsH1CRj
         KYcIZfUint6e4cXExMtke6LiPSjWKqOKXmu1qQ+24eyOzi0xjz6jJT4ydCQGu5G1i4gC
         KNqSw1Y1Ppj/nxdFhDKDiQOsnDkwjeclof25jLshE2p+vDakfcK5MLeAnx0XHFLAiwBi
         fZS352e4E9Lsw8Dj04dcvMwrVV3w5990SX8UPXjslqfQImkgxhza4Yp+idv7VuQKzYpG
         mISkgt9TMvQ0o1HRfWaJi4gvTd9aWbUAFHWboS+dbiV5YCEFxWTuVKZebnIttPWAK7Fx
         zhAg==
X-Gm-Message-State: AFuF++myzNuphs8q5D1tf1CkXIjbXhCm1GYo3eAHE/p6HtoIMDkvQ3XW
	fajFXBgWPa8J303VVRW6NU9ShdG2taR+cRC7o6RtmuX9WD3qd/3pJ63/oPtKcNj6gmGBncYYAjz
	eL3INk3VqLRkJa1qRVu69C66vU9eZQAFmsA==
X-Gm-Gg: AYBFou2zOE4bD2kaJJJ9C0yotNv56iZj3iueGUYfcR5dHmw00YPXgjCrFQ4RXwCfCwb
	PfySug8jIPwUBJqgpgKXEWtgUQ4qaTkOtjkN5TlUMVwlfgzVra5rC1gs6nj3xFNGHK9JD1S/liW
	NCr1qS+plM7E/fmFJH28tw+qdK660CVkI5yqPy0g7OPEBGYJZXCcvt58EDDu3b+mse805MFKz3s
	c3hkPyqyyZ+VujZAdqjHxSI9U2yw1fBTDM2NTiQsfEHqv5H0KZRn4lHS0nokz64XrjrgOQqTu1K
	xCVfj4itG5EcH4JyuP2XGJ8e3SxrmmId2L1LFboZe9084PauN2qlplMtAY+nqpPE
X-Received: by 2002:a05:6a00:90a6:b0:87c:d00a:f351 with SMTP id
 d2e1a72fcca58-87e9c0699b4mr11060552b3a.47.1790629395526; Mon, 28 Sep 2026
 14:03:15 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 28 Sep 2026 14:03:14 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 28 Sep 2026 16:02:57 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Mon, 28 Sep 2026 16:02:48 -0500
From: Giuseppe Piscitelli <ooonea@gmail.com>
In-Reply-To: <CABBYNZKb1cr85s8sRQe6LQwhmqeApAs26OaDgV_fJpNQu=ViAQ@mail.gmail.com>
References: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
 <CABBYNZKb1cr85s8sRQe6LQwhmqeApAs26OaDgV_fJpNQu=ViAQ@mail.gmail.com>
Date: Mon, 28 Sep 2026 14:03:14 -0700
X-Gm-Features: AclHuK-K2ubpMvDEYl25GOmHCYKnoJZxnApv00iQ7-TomHjcHlU-lrFgzoOeC6g
Message-ID: <CACmoRBa6Ga+Em+JdfM7kkvHKvWgYd=hheUEJjs7aJFWeXoP+Xw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] input: Reset report map state on detach
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

I tested the linked v5 series with both reconnect cases using simulated
ATT/UHID transports: an ATT error during the Report Map read, and detach
while that read is pending. Both request the map again and create UHID
after reconnect. A late response after cancellation is also ignored.

In patch 13/21 [1], report_map_read_cb() clears the ID on completion,
and bt_hog_detach() explicitly cancels and clears it. These paths cover
both cases without cloning the client. My one-line fix targets the
existing hog-lib.c; v5 already handles these two cases.

[1] https://patchwork.kernel.org/project/bluetooth/patch/20260928173243.1073509-14-luiz.dentz@gmail.com/

Assisted-by: OpenAI Codex:gpt-6
