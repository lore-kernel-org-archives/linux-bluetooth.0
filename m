Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795618929;
	b=I8xK5T0CmpTqFtB/SC+ZNODcg5gbQfkvNBOf04UYO/tTeRgM05aCWZcqWUMQ0+beaEFM
	 3yiKpMUK275SZlvNDkOwR5wMHDqJUdOOiBUiaCtiyLNTC8//BRsIPsLELn8Jf11uBSROt
	 84r+SQHw5wnbj3i/XQ3ovTY4NS6eIbA5ASklOw4UVxdur3nOMfg7Ai7lpkWV/aPcR2QXp
	 w9sSL7rwH0Fk4fvCE/7OqV0hupAxq9dKh9W8jUfAxwXnCM/QpfkO8Y57akY7hOQ2jtdWW
	 ATHOlKLLUGyHpd3x8oKnARl9NT2zgFxQBsah4xezJmKUsR1qP85NuTW2Zj0+GGNPefA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hELYUxhQkvYIzyA9tRpVhvm2X0Oca3rRHIm55pSdV2U=;
	b=H0Q8LeUjhN/YEuGzLYGIW78nb9etltW048eXM3Z7LeIPw4k0HzOAUyvqpgnDhRZEWXY9
	 qZblUERa7FvN5H2h7dmMA+Fvnxu781+eOFpjeIzMELYBtXQy1qorytqGP4LmqPrJ0fv7T
	 keI9PuOTHrT6w5nInMQjpcHjb4NXTbL1BdthlSfbXtxYIBaT5VQ2DpH1rSBfZXja3ne+6
	 g95iq6Z4+Qo2RrR+lEy6PMX8gJQr4Ji+SCho9UO04xJpkCsOspk3Ivirp9TMcNLWj5dfR
	 KHhgowhZ8nVS572kGNG4yWamAjXNFj0xQK7fMZgD6Ffz3g5U/udnxjuOccjmXCi3KDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jB8orB8y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF40606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DF40606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jB8orB8y
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67db6d4054eso6486373d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:02:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795618928; cv=none;
        d=google.com; s=arc-20260327;
        b=jLPYxLFL/pVN6zNFgJZs169AXqyUY1ekkxWwpxWNsW2e3NNS0C33Aq096vg0pnUXFc
         kc3C4Vo4xQRpk0rOfN8jmCEI03qpwYZK8d68kOXspXJNubmHC53VV0L4yKTZFJ/07//f
         h9tZIwFIa0Md+2QqBMBitTVaj21qq8d7BhzqLlogk/ZeQSc6ZScZi6OEPkQR2FJnZ6fy
         bKIY4ZK6zAg3b0BQgtQnewX9I9w47E9jQJRvQ0d43S82e2ZX4TEi3CRkOhMs2TrvM9n5
         1vY9mgqg5iVQ2Jew3G78zflckTjPRUdJe9e8JSd78UWk2YVKagClk3Kr0nvlZYJnZXuB
         VHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hELYUxhQkvYIzyA9tRpVhvm2X0Oca3rRHIm55pSdV2U=;
        fh=6Ejz2qDC1kzAz/SGTrdN+HkwL3203PQPsV+Bv5fThMU=;
        b=mkcEZQbqYuLAGQFzD2H0dcyPAj4JsOfdAJ4vn9RBI0c15w1RE/hzDDsUDxyJfRjKKV
         klF/7YzgiTHtQDicQ1IsMMrXkJOWNXSWGwLVZi3b/o+BUuu2Hb9bVH7HBoHEEhT4WCHl
         /lTPX0cu8R3PJArgaWWEkearX7mmPuo3LlSkedth8MLzTeVAxzuePf0iSGxuRn6DSzmn
         L8oG+4Z5MZgTeMpzlfwd+MOta4wuWFx4gOkIfmDSaWRYhUMF7I+Md9a2x9IqxAoFEfd7
         OqxHy9nNMWtX8yvSZDqvzR/vz652yzhtf6lT9l9Wfgu24AUURQe0N961zbtvEgXcFRum
         wvTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795618928; x=1796223728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hELYUxhQkvYIzyA9tRpVhvm2X0Oca3rRHIm55pSdV2U=;
        b=jB8orB8yPrYb9BeziArBXIrHCA66iRqQviztZXVEPcIYXO36lr6l/hD7yDOaDOUcSE
         GGSz09abzIqkLK9JE1j8kVe8f1JXKjiTlFkavK/fy7HGv2sNykhll43bBqmYYW7ECFeo
         7sX4qe4oXfbwa3cBlIJ5KpEc4rMndRnkNNV5Sz8cldlfKoJtq9w9sWWVudZaVv0wMXc7
         UCyP6MyFpEY9VLGHTr+Ufwqb4k12g8+qkaXWJPLU1p2WzPjrIV/XQP/zkV0UAwTzRfBp
         5Ppe85jcyxzU7txowV3W6MjLlEnHOvwI2/S1wKv+qGAx0/rfpvwbzbuvTCOyK113N5vW
         Q/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618928; x=1796223728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hELYUxhQkvYIzyA9tRpVhvm2X0Oca3rRHIm55pSdV2U=;
        b=sIEHIIgXDLhL9FlYrg348wGI22LjVGVSta6Ynva5lHWJsHBS/0uraOiYMk2OwuIWSf
         LHOd2T8FHsJzwCWxQlk8fL6anvALhm08cFtAcFhGITJYjvL3FS5YS/Mrk3zm7hCnb9c/
         ovJ0c3DgSkDHDy27G50amNzB2RV2Tp0SqxMFuXfKjUVoup9WtOtLogGHriOAG5lFWuoY
         CoKyqryvvt7qhXqVT6iVgxZICPodoKYgAedIZSjGzEXcI07CTGDOI999i+xsye6DsMxa
         YUi2BArwikClGxez6ngTEGQNcmpAXfmjP48dkPcI+P2iawEt5vwJJfKg75fuqsqPgjrl
         ZUlg==
X-Gm-Message-State: APuU4Z/cbfk1jwGton17/kFGiRU6f4Q6Bh4QooASWECTSKuMOhFiGfa5
	9aaOFiank1vIj/v/35QSke3Bv2X1cNQ02gJcUmCBGA7aNssOCB0ulwBqt7jdRsrN7j9TPokXzym
	FqxGNrilMnPsr2mMSpDJa5vg5ywm7bqUEBLSD
X-Gm-Gg: AZFdTZdJhFtcO+sw7j65A9eaHfFNlIwasSKDJISaKLiBQFf1Min7Pnh+NYKOE5u69TK
	cbO0qfI2+opZ8cj6LpytNnbIETfdyeA0gz6orws9ppaOzi+F5UYpHOIwCvHKeW9T1UevZoNeuHB
	kKS7ShPu5tcwwJkMT2zSdvEm6hAIo+6jd6zWmevDtSwBNrMbqHjrOUzFrtBdgLaGUNZPPL9mdFW
	JsxGdOCph7hcT37bn4Lqnbzhkv1iYmauvJmX2WmNgXNQcqFrPObKL7A0WJFdLjcHkmw5grWuGzy
	lWY68IVPC69HioJgVa0QnugOQbTrQJv0G5cgQ0kJIhjPBrF9zeemetpsK0/hbZVGDO1TWkeRGlV
	9r5zNwJ43ag5weNq5mOGy9/mi/8byvIlNf48Nn/og3D1sizn0gSQSlZuKB5uSUOYX59pap//jpU
	sTya7yzqFdcuvbTK6tJcVq1w8Ne+tz0ZD1YLMJK+o8JPUrLegzytBiHq+Hqgw=
X-Received: by 2002:a05:690e:4403:b0:67d:ac2d:d813 with SMTP id
 956f58d0204a3-67df4492cb4mr4678765d50.101.1795618926878; Wed, 25 Nov 2026
 07:02:06 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125075709.459719-2-frederic.danis@collabora.com> <6b06f54f.77c88264.209d21.483b@mx.google.com>
In-Reply-To: <6b06f54f.77c88264.209d21.483b@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Nov 2026 10:01:55 -0500
X-Gm-Features: Aa3M54qWFB4Jm0tAVaJ7sJ8qXwX5roORQRHiqciYv4T0s5kS6Zh3wVfMTP2mys0
Message-ID: <CABBYNZL19wcrAwdNhS0rKo_yY-Y+dZYTYfgHH1dR37nid9aL=A@mail.gmail.com>
Subject: Re: client/btpclient: Security Level reporting
To: linux-bluetooth@vger.kernel.org
Cc: frederic.danis@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Wed, Nov 25, 2026 at 9:50=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1221749/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.13 seconds
> GitLint                       PASS      0.75 seconds
> BuildEll                      PASS      20.47 seconds
> BluezMake                     PASS      314.18 seconds
> MakeCheck                     PASS      14.83 seconds
> MakeDistcheck                 PASS      150.31 seconds
> CheckValgrind                 PASS      349.93 seconds
> CheckSmatch                   PASS      318.57 seconds
> bluezmakeextell               PASS      101.59 seconds
> TestFunctional                PASS      1231.46 seconds
> IncrementalBuild              PASS      312.36 seconds
> ScanBuild                     PASS      1175.58 seconds
>
>
>
> https://github.com/bluez/bluez/pull/2918
>
> ---
> Regards,
> Linux Bluetooth

Copilot flagged a couple of problems:

https://github.com/bluez/bluez/pull/2918#pullrequestreview-6059967867


--=20
Luiz Augusto von Dentz
