Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8DB332EBB
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479234; cv=pass; b=MTll1XGQpnrpnj4boJm2GYsNLiUBjbj+uYphmNnofzmiBcgmow/F/J4dppONvX9pdojTTv2Tw9FuPYT28V6TgT4kR4spKd6Ce8C24Ol3sxhH3BJjLzshD0Oe9xy0yr7pZTtfH60Qb2O2QVHk+Sskr4hmz1fP7xLx8SIHKfjU9dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479234; c=relaxed/simple;
	bh=dLCdwUEu/yYo/ni9uPZVWhd1og3aTejgh7eFjzybx3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o29w6SOS/aLr/5XFcFsO4tMVoZE339K9Uc4sGHNA0GVUpFncnVXbfYPcn2Mp12if4v4A1k2CQ+C/4KjF4WaLYi4cAoNncExDDsd8+Yhy9A+6Av847vD7gbX018TDdvEI67p6E4L/DiqXo/9qtBYlZZN8cTC9NqSSLgVHRLAtcnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQeYJTeE; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQeYJTeE"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64c9ebd1369so4196764d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 11:20:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772479231; cv=none;
        d=google.com; s=arc-20240605;
        b=WRRC4SKaunjGurFYf7heIqnv8tHq280BVAkfBj39scPx8VRVjBOk7E5Ac+MCHJ0bEI
         KcjmSSvNsD8T6ezf7WUTZSdMALtygg0TdEhYm6G1t7FCRJDJhLp3SdNXDIm5JSkHT+FE
         hZsFxTnIa8U/L4RM4DqeICNnBPcXPtcziaU2ETMvwC56SwU3zv8QXIxvHq7U1gz50y4h
         g6I6EFVy/jG+H48vXkfVsInM9Y99Lb48k7+DEUGLtWVEpvATEl5IMg5LZwxcN5ObBRet
         YuDqx+OA3q5yO3YeelkMLcyXq6qdKGigy0wDSYZ3W0wWcC+vc9hy1HBoKQPAl5DFEGRR
         AUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WQWlv7crj89AQFSzu/5s/HRmOcWAQBLelHudUZVyJyM=;
        fh=VdViJEWK0zEe76q9oaPK0bXBLW+HCyLVUPlVNBp5cIk=;
        b=b5YxVmOMimCEN/mQBAlg7MH4Jmetd0GZd9c8G6c9+sdEOng6TzcgRH29RJ4LqgFVPx
         yM7Gb7JN80dTU+orw5OZlhymKc9cy6PdzTue3cjxChHhhl5J+iRbBsjU1u7ipaEIt25M
         zVmz5cwFr/p8DOEu4idB/zoVwy+mFluskhbPZGLZgioHetx1TrbHZrW40A+bgyaUVozv
         VHL2iq4PLBQoITH/cghYPmsppb8/gPBGMToXOvW1EWG7cDp1IzxWZk/9LzAkSFo6i4Qm
         dWLHwfBR6bFgV/pXhgak+vJdcMt9YtDDquVtb2y/A7Q7e6EBkpF9mZ/4wY4G4Uphf9Ng
         2w4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772479231; x=1773084031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQWlv7crj89AQFSzu/5s/HRmOcWAQBLelHudUZVyJyM=;
        b=EQeYJTeEYdwxcAkGDawpjn+s5XZTphbOsZiU9xC1EV126LSA84fUtiqFEHmQoF6C4g
         V5SMDB9TOAC3CMBaJt3vGeJNdcFdP6Lm3epxz1djv/9fF1WvBIuyfvs1NLFNRUSVAORV
         3OrdBFEdu0TfbTVsPlnw2nsu+v1lfJC8EuHTXsV7uTJrZwzE4AojFy2S01Gl1v9kpxqv
         1svgoisZnvExnml9Bw9OVlhp7iw02EsU7UE6lPCHvfSl9BhemV5gCiGbz1XsHANtNIfQ
         +l+XlxIJ37IX4mXP9xZhLwaxpAypMFv3RN6fSYCTExaJeXZcJbIa8gI2yjT/MOMXcXa+
         DDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772479231; x=1773084031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQWlv7crj89AQFSzu/5s/HRmOcWAQBLelHudUZVyJyM=;
        b=UEII1SpBmwLGQBrJJCR9qV2xhRmhxXwDSn3jhSvL6SEigam+EmdBPLPVv0a0AZXPXg
         9gYh0QerobxYTp0YsV88+Pko3ADe6v4yf2JTrTLj3o7qlBlgGzZlOHA/E+Kh7yba4yHD
         6/0OyDGFm8QGSTU1NbisAhF9U/qq1KWTT+dGKIC8DBZ8bFZW/0vesy3IlZqdy/L6BeNE
         HZoE/qK/QFTmDLj6ZqRRRx3I8YVVqdD93zpithvYXLfOes1drbtT0qgFoJwoHMLnL1Dz
         8l3hpGyR/0zVaNXipl3aP3m9cWQ6hPVRr/9y/sUFDREWPGrTXANynculsQVZfx8JCm4W
         lywA==
X-Gm-Message-State: AOJu0YwVu8N5kT6vbC/FAi29NPoWDJg5qkWjhvBcTNGDDGbsqnvelqLR
	ln3k4jrtVNmBXJqdOJjalWlp+he7EJ1eAGa9JGq3yXHBUlACnEGEQtqoKwlG+GZ+XxAXSdzlBY3
	X5Vu66x/7pILe4MtXhCXxxLbfFAhWN+ragcX6YH1oTA==
X-Gm-Gg: ATEYQzwAF1SAu5bt0t5pqsBd2GD1UqBv/rb76euG423077Ya7MFezfYPlPBry5DT9Sm
	/8LnFMYNaRiEZki/Q9ntfIsYWfgZuGZyNTtxo5WDjXeQt8q0t6z3RHM8AnUfmAIlMRe36xAi1+Y
	+Giti7sl29Z7dOOfgopKWvSJIHtS6lVvwVdLebnqqPEEwT+P/9i12MDVqaT0HZko3Pf26E0YdB2
	37AL1tOoM62EV5j0PuWQ+byq7wHSJROaCJCXc6aPFyJ7APLgyxpGTNok6bCXf0ysaGRg2qr1G7x
	8u8vnSKsCMcyFUv/wkCa8wIUf6fmy+ViPoRVmkPkynHycHG8H5t2xp+xQ2nB6tiwroE=
X-Received: by 2002:a05:690e:d53:b0:641:f5bc:6934 with SMTP id
 956f58d0204a3-64cc237cd67mr10554091d50.72.1772479230625; Mon, 02 Mar 2026
 11:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301152930.221472-1-martinbts@gmx.net> <20260301152930.221472-2-martinbts@gmx.net>
In-Reply-To: <20260301152930.221472-2-martinbts@gmx.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Mar 2026 14:20:18 -0500
X-Gm-Features: AaiRm51Jxj3oM-vR3ihZa5Xejbg_xKyW4VDE1Iwq6T4lMH2efzOEEZszKwepj9M
Message-ID: <CABBYNZLNJnnO+WUQCgzZ2BvgCqftvsSbX3qKDh=fZcfm-KQf5Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] shared/att: Don't disconnect on ATT request timeout
To: Martin BTS <martinbts@gmx.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Sun, Mar 1, 2026 at 10:30=E2=80=AFAM Martin BTS <martinbts@gmx.net> wrot=
e:
>
> The ATT layer currently calls io_shutdown() on every request timeout,
> terminating the connection.  This is too aggressive for devices that
> silently ignore optional ATT requests (e.g. secondary service
> discovery, UUID 0x2801) while remaining otherwise fully functional.
>
> Remove the io_shutdown() call from timeout_cb().  The upper layer
> (gatt-client.c) already handles aborted-request error codes for
> optional operations and continues discovery.  Truly dead connections
> are caught by the link-layer supervision timeout.
> ---
>  src/shared/att.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 3d3c8cfa2..e93e7429a 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -504,11 +504,15 @@ static bool timeout_cb(void *user_data)
>         disc_att_send_op(op);
>
>         /*
> -        * Directly terminate the connection as required by the ATT proto=
col.
> -        * This should trigger an io disconnect event which will clean up=
 the
> -        * io and notify the upper layer.
> +        * Do NOT call io_shutdown() here. Shutting down the ATT bearer o=
n
> +        * every request timeout is too aggressive: some devices never re=
spond
> +        * to optional ATT requests (e.g. secondary service discovery, UU=
ID
> +        * 0x2801) while remaining otherwise fully functional. The upper =
layer
> +        * (gatt-client.c) already handles the aborted-request error code=
s
> +        * (BT_ATT_ERROR_UNLIKELY) for optional operations and continues
> +        * discovery. Truly dead connections are handled by the LL superv=
ision
> +        * timeout without requiring ATT-level disconnection here.

Well this is by the spec, so if we remove this there may affect
qualification tests:

'A transaction not completed within 30 seconds shall time out. Such a
transaction shall be considered to have failed and the local higher
layers shall be informed of this failure. _No more_ Attribute Protocol
requests, commands, indications or notifications shall be sent to the
target device on this ATT bearer.

To send another Attribute Protocol PDU, a new ATT bearer _must_ be
established between these devices. The existing ATT bearer may need to
be terminated before the new ATT bearer is established.'
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-=
62/out/en/host/attribute-protocol--att-.html#UUID-55e35307-dcf7-8b68-15b4-f=
bfcd86799a3

So it doesn't say we must disconnect, but it does say we cannot use
the bearer anymore, so my interpretation is that the bearer is useless
after a timeout thus we shall disconnect.

Now, if you are suggesting that we sacrifice compliance for
compatibility, we will need a configuration setting, which should
probably default to compliance. However, that adds another item to
document regarding qualification, which seems like using a bigger
hammer to force a solution.

>          */
> -       io_shutdown(chan->io);
>
>         return false;
>  }
> --
> 2.47.3
>
>


--=20
Luiz Augusto von Dentz
