Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589700;
	b=q2OzaXBZrsUADfNyqSu46/JfAr6AALZWihNowgTQ52GJTOkzmiaFjaDKji5qz0lP6h74
	 C/CQts7y45CenCcHh8DpG94j+LV4ZMquI1PBCHhSzN7i0d89udBwUxu2tkfrzM/VaG6aY
	 iXJpMDktseYHjoezKruVyy+hb5pvxXaC8Gu1fJ7cES8fzRQfEn/pAvXW40w+QiTLTTB9x
	 HAG5Qsbge2tziNBfe/5K8CiZodWepec9T6yozC1N4xlU8k31KDPTFPJ4l/jq83t8Ae+vn
	 Sn5AO8Y5vgJxA1uDxkzMrmdGlFyL7V+qZ/nqevi5BasoskcS2EM2IgmhuP5qsgWyOPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=c3lkDz4gk1pZio9pWWDcA+jV49I7KoGgy7iCSzIUP/o=;
	b=3AH8c71feUYIdzMOccQ4mf0pFkRfqu3F3GFGI+PMcwqVmUiAFWD7QSCWmmr/1Xds5dBf
	 qnMZ+szSU8Xd/TVzWvFkAvfYtXcG0JUh9swXjdlkDA4tyiWaFM1lO4TCqEjL8nzfvQe2o
	 KX6LBM0p61fwRarKA5TI81WtBm/ckbxyVxZ9kp5u17OgV4cDEBW7cgLHZ1OxM0RPjp+Z8
	 +tkT7a9Zog3WFgDlLn5XKXw5i6jiG9+D4PUktdRSflmkz7mt/Doqhtafh5mcVjVARHroH
	 F8v4q6ze/t5OsQ8Mg2yfT9PVTTqJwQtmQDKViGmlhW2qpqEBHivfyYW+x8mON5beQmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhP6OGpO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EA606A327
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 17:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC1EA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhP6OGpO
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3acec6677so1498048c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794589699; cv=none;
        d=google.com; s=arc-20260327;
        b=ULD75ru/C5y77cPj3/VD7jbtOxnXFa0PnBVbkugafPTBsXwGSWv67yB+Vfsk/wZ8ew
         YqMiLBWYvPD/WdWTRk+0v4Bj97I7QS1n5NGaS/VQdS7wAaSxBUEedi9BNp7OSncZIgvs
         ezh559qbpbSn0mGUgyqHVavuA07CPJOrvqeJUnGdOJy1UTzA+h4u/SsGEBJnos9atWPB
         y1l5IWqHLVNIQvf7v8tPjPbOLdBJVZ+rsa0vu6ASlhM1yRfsviO3IXS5SJ1CREV9MVpW
         IOx06wweFWQSphCvF3sYRbLd6NGUeuH4YrUtIyD2eNNog9b7SBQnCoP4ZIuZrfD+7jlz
         V1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c3lkDz4gk1pZio9pWWDcA+jV49I7KoGgy7iCSzIUP/o=;
        fh=v4Z3N2Htbr8NtGqMLkQjkIE/EbeUcf6lhEWEAm07n3g=;
        b=H8AfORSGIggx/Czk6nTGshVlPYqfQrzbJz/qrF2N9Fnw/iqDwDcy+qAfsoe1XeS4Xd
         UtdhjrkwMnrIJ0FLc2zcZWd7/rQG1pR15taSMpC8M8ZzBpDbHqw5+XVzetLe9KYW5FUZ
         hnBHi9Mvi1pmerbU5+tCPMtH0Ac9NIzOpUB2dMg7nar7Y5T2jrZKOjUmixKJly0LT4tI
         U3lOBT9V2B/ckWOUeOoCSKDs9xuBtAxv1zo1X5RRk/9BxuLdcOzsiFotfbqMzFM9t9zd
         /6qPtA0Am3obVmuN/IwqHiY9kAifi6O12+wyI11dlEgs2WQ5QbsWlVaQaO5PStDv/+Lj
         TnBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794589699; x=1795194499; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c3lkDz4gk1pZio9pWWDcA+jV49I7KoGgy7iCSzIUP/o=;
        b=jhP6OGpOcIr2XbQAX7XJ9x3dgBm0a/005PdpXzsYJMJNEcztpTSg77S02e/eokC5dh
         UxBOb9Za4qW5ri2S+iOkUxzhIDIfNExmPKlRdBS0ySFIbaybHCwOYSM1jkgvLsJDsJZ3
         e++keOTusmCtMeqZZhiOTWjW5p2zFQHns2QEutemGaQ5LIQ0C/sSgVh3giBHniuQoRZx
         LANSDeB7qcxTTJK7Ri52nzJ9kEoy1yWGSHhBGLBRAr8B9iD2rtdQ++vqFnJOcAYhDUOI
         9nm0799HOEGAgaPA4dpBwXzDGwBImRYzDrypvlGahw+IdMb7esN6et8Dpay+HPxrMpGR
         aqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589699; x=1795194499;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c3lkDz4gk1pZio9pWWDcA+jV49I7KoGgy7iCSzIUP/o=;
        b=pqD2aRg+0q52amnOQZ4eYe/h08DZDIV0mQZr9w3cxXOH/0qwvpeFx3Dsc+VIVpxbrm
         nunDpolO/ATHZSkqrJ6fef1iadsLF4eVU5CEIT3asgVpCzb9LVcUOS9Zl68Mfltl6msT
         6VQrYd3kV64iLw1x9lZodZI6OdXLRLcr+vwfw8AVHE8aNvHwv4l/veA81NrJorF0aWjs
         nskbZiA+X4QaK1OM4xcVyYetnC0BvLhzMdVkLOrkSvygl46VLnyy9v0cad3dMx/Mv3+s
         VesHuzN/eBhjR3qT/PaENlIQCqU0KA1uNW8BKSS5/zH+ItenzanXoWZZ0rW6vteSaWzI
         yw4Q==
X-Gm-Message-State: APuU4Z+Oum+2iwF6/kto+49/xMM+1x5gmV7r0ffFSBZlJhu1tH3oiY2Z
	gmnjHChT2rLzL+/OZBF2naxSysjkfAz9uSCy6yvHTEHeeh+J6l4bQx74qD5L6CjhMajANpYXKnW
	FRGp2GpL7uGbLPPrdF2BTp5glFHsGX38=
X-Gm-Gg: AYBFou29zc7zINJdFa6zWNU5RfkY5RPKWah/TTiN3gmBXe7Xqsmx+SxUAGl8uk5pV8C
	1LQepCxkRd5aZpZDEN6E4DMEKa5/UC1s8Xn97FSRM79hCZjCKNoXPBVX3J2fwSEiu+uXvb2vYrb
	IMBE0qBOdMDNBzppIr6S0VfBQGMAVD+wFmX5Hp4R9FGLub36VY6CcpxoHyGHhdnfScW1811Ie0A
	uivbIcd3MPm5jm9A0aJ7qT1XhwEzGf9pMxwUXwkeXdhM7kxsw2VOD3wDVMnIrD4IWzhvQI4PD+j
	lheK93v8jKHq6k3W1O57xF3WbPJeqswSs1hz6bn8UApRyr2UDQ4xnyml9dKIJ3A7NzmL0E83lo8
	M+3GrkLt4LguOYoIL7YyMqhPazz/f5lTA5T/GxhBo3EgMcyq3QMc4ryKVbiT+72ZQaK5cQA==
X-Received: by 2002:a05:701b:4582:20b0:1a8:7b58:6f1b with SMTP id
 a92af1059eb24-1b5030f6715mr2934529c88.19.1794589697732; Fri, 13 Nov 2026
 09:08:17 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-svc-chngd-notify-only-v1-1-c7db7ac47acf@gmail.com>
 <6af68961.ab57093c.3191a3.e109@mx.google.com> <CABBYNZLW9vNnP+o46DMV7WzuGSphMEyJdaznhNU-FgEMeUW3UA@mail.gmail.com>
In-Reply-To: <CABBYNZLW9vNnP+o46DMV7WzuGSphMEyJdaznhNU-FgEMeUW3UA@mail.gmail.com>
From: =?UTF-8?B?TWFyacOhbiBQb2zFpcOhaw==?= <marianpoltak@gmail.com>
Date: Fri, 13 Nov 2026 18:08:06 +0100
X-Gm-Features: AclHuK_SxKHdW0FB-AOdH-HNfftRsV0FAm3oy5SpAt_AXE8L2wrkeh4cZHa_LN0
Message-ID: <CAN7Z8PwDtVSmxpojsrRd6aHZZ0+en+UOfum2kUT9SZPd4sRRow@mail.gmail.com>
Subject: Re: shared/gatt-client: Fix init when Service Changed lacks Indicate
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

On Fri, Nov 13, 2026 at 5:04 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Copilot flagged a problem:
> https://github.com/bluez/bluez/pull/2817#pullrequestreview-5894233165

Thanks, the finding was valid. client_ready_cb() quit the context as
soon as the client reported ready, which happens once the Service
Changed CCC write is queued, so both new tests ended as "Not Run"
without exchanging the write.

v2 gives the tests a step and a terminating empty PDU, so they now run
until the CCC write is exchanged and check the value. The Notify-only
est also fails without the gatt-client fix applied.

v2: https://patch.msgid.link/20261113-svc-chngd-notify-only-v2-0-e07cc198f32b@gmail.com

Regards,
Marian
