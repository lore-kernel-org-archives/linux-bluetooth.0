Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ABF3EF0D7
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301632; cv=pass; b=BkAS1Pxs+myX+Dat1hsUx8C9WDPHaM6SfdfkZfRZ0KzdY7mjyCGYID62vYrYZxZyzyhKUCreps2DVrsxWS8WIgdfmv45XBcfgOI823aRhig6hYQn0bcCoAZzsMiSMOcJk57MenZuJVEM6zcQ49FKilDaWxGPdyaT4by4p0Iv8Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301632; c=relaxed/simple;
	bh=ysGUfS49lJ5c+7LgpnRCTYdkl/gfVYIeJzFbwamzHkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swkLKNJbOGNJQkt3bEHdqvn++5lg3OJ1cMGGGihPpvTfywYbG/IWCx2RsqTEXLbF4KmxIvegOQIKOCdXe+pzT+eM6yPxejo5bXo+wvFUr6SEygPr2RaLCGdYzPy6Izp3pupPDWPjOZe0UOZXWrwvyYqXZXqEr/gnxw8joUkIW5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq5nhoC2; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq5nhoC2"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65dd9b25829so4160909d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 11:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779301630; cv=none;
        d=google.com; s=arc-20240605;
        b=akUYmy3ZcNRmNfHOvgG+ZIOoUclJSikdMuXdFpLlqVUzaqAaSPmmiColuu31DEdahm
         2qp+fIHqL7qXywPk3h7v3go7KFuXV7Z4vHt7slwTjv2ALA3dRfPn9ZE0z6HEDZEM4db9
         zrA7AYu1UVztt4cw8auNdFr4iL48c/yaujPYBX0GW37Jeg6UJgT0keJycg7D6F5I4vOn
         h+WlQ8GFBpw/VQYeANqKtinskG1jFjcJzvzh8ulGQ/J409MF19BVKWqZFfgiw745LkwC
         9sZs+h77rafm9qGtuIhNXHmZwCbIfv944HPBKqygQRJ7sjx0pAkVVVAXUNdXfRijzglp
         ghdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pH7GE2ZCeYjvi/Wz8cOdjRlsulmki1w3No6Jb6ld9eU=;
        fh=xh+4nNYd3Cgtzt9jag2NU7Enm9kQjvBwsvoOtT9iUKs=;
        b=e5qx6UJ7vGB+C+0gXsj0J3DT0f/vYdNoU9vz3W6rL1YLk5qJIEuqePoOFrtX0QJj7l
         Ic/ExnbHfAgHn9QoxKY4N9v4aqNT282aRA1Eqz3UK6TiAXWPJHZBQ+AWDX6eLZspb+Ti
         B6jSCJ5OOi20i3N+o9rH5P96QUwjCQNVH7teNE1ILdtWavcAQPsVSmZcqfV7cBGTgiEa
         Rc/xwV7meoPgqq/Y+2rjGnUFiw4jxZJz7PFRMjyF1gDbIO94WgB6NzuKoSABH2kOk0Ym
         /Wqu9KV/H+GybcpNFZACUJdiEzHz/ZdTqJ1PtlIqJ4efjYsA4mcLEPDGIc3Lme/YRNb5
         i4vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779301630; x=1779906430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH7GE2ZCeYjvi/Wz8cOdjRlsulmki1w3No6Jb6ld9eU=;
        b=Eq5nhoC2UF858C2VzSNEZiDROx5C0ocl7VBp2cJnL2KC3W6xR0vgG0OXHPnqUWBEye
         t2w5B91l51Pq41uExwbqId7z3sr7j6AdXgwKfPwGBymyf0T9Iv9bfb9v2emL7umGv5aJ
         YLGcEoi6d5BjWFEVt/qZqE8+P1nx5IDhpWhnx9b01jKKWCeH+dUSFhF+GrwvRW5eiklH
         vQdrX2695G5MQRCchFcjPD4ecdjpvFnmwh0WILXIFQvYXmvzZkL+F1P28SRLJrUVO9cT
         F06/i+QPyAnfZxmJRgpWBlBz/OrIgefDkzBsv0+Vqtd7ROAllt/jxmQYXcvyOi0UXmpt
         nD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779301630; x=1779906430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pH7GE2ZCeYjvi/Wz8cOdjRlsulmki1w3No6Jb6ld9eU=;
        b=cubaxQgFEoIe5DqNFPiNNMqYCfg6TRmpHEH67yP//ou97u4lA1Z0wouzVsvsYz4m/z
         DZNUfPb6l0PASciVdYLcYs5jxXRVVhdv3SvQ20gePspA0hFGYG35y9E6k9KyAvSpCK8k
         L1CNu23Yy60EEqgJVDicWTt4SF4RrUlyNcbsOxg/yWOe1sbl8LL7JJ8kno1+nBJfKtnf
         ZQgQjz65YIFtur5lGLF5wJGcTJXWfhU+3bTItUjxkzWIStop8rwhDV9zbZOX1uUFyCsm
         BQoeraJ6qdaOJk4a1LGSccD5/Y4Ol9UYYm6uZ9eEzHwpm/zHm+GvW2ndKzeVPMpsc5d5
         KU1g==
X-Forwarded-Encrypted: i=1; AFNElJ98JUFFXtDMmmUZWAISwScTP15ZQD8HPVnplvbeKiQFjpd78byW/8dtezVju3BEPPiyy5E6LROZsmkHtB/C0ME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yd7I0Nno69/dDTRysFDZBX/DQGzLUszaiy1uGC3em//Euvxk
	NSHaUMJQh/KS/024syPU0f6ZqnfmVUIxcvLMX7SLcX4D8ohOfPNv3h5Uk3U2RHvLyS3V5qTHrH3
	oIeP+UbfcAfq+oxjqQ5SCU02F7lFWocVQ5Ip7PjU=
X-Gm-Gg: Acq92OGkFc4j5VH1DgCHWHTJ/uD7CxZ6i+TXD38hyRvUBEFVWn4vPiyXkaLF/DWbUHV
	Kv1gojXV4rsEuyEF+qOuTQAa8S2mJKwUAwTl9T+Ies/1jGcLvZmprs5BsR1biuZuOGu2g6lh7qm
	KIdD8qZGK8cdjYjSKnDhdzrpv/bjccWk0KJqXduk+EYQefQ6k4dTf8Q3DmfLpthps3LqOjCAvpm
	29VcesS3OqqnzBLG8G+OZH3Lbc+vXwdxC29xfNt/P4A9P/YICJiVcx6oP5vM8ZKRkMIcGOTZmUB
	POa6IvYOLtJSvO3FOFbP1BdjJQZKVG5qhiXq7tOI+JJLOpLyRAqA+CKH/GbUNWh7tssPQC1h/qG
	PbA==
X-Received: by 2002:a05:690e:1552:10b0:657:1da9:7b36 with SMTP id
 956f58d0204a3-65e226dcf95mr20118992d50.17.1779301629951; Wed, 20 May 2026
 11:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520163859.2859782-1-oss@fourdim.xyz>
In-Reply-To: <20260520163859.2859782-1-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 14:26:58 -0400
X-Gm-Features: AVHnY4JVEv-hQZyUuQUg0SvTtbwaEVdNw4wDs_a0JslXWXO-kpnsJGeMdhjxYv4
Message-ID: <CABBYNZ+6bP78+_m_ehhif3xCXxn2ZLQE2q5O3X_03mU8=_T5uA@mail.gmail.com>
Subject: Re: [PATCH v7 RESEND 0/1] Bluetooth: L2CAP: Fix slab-use-after-free
 in l2cap_sock_cleanup_listen()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	=?UTF-8?Q?Safa_Karaku=C5=9F?= <safa.karakus@secunnix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, May 20, 2026 at 12:39=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> wrot=
e:
>
> Hi Bluetooth maintainers,
>
> A public patch covering the same UAF in l2cap_sock_cleanup_listen() was p=
osted to linux-bluetooth on April 28
> by Safa Karaku=C5=9F. v4 is here:
>
> https://lore.kernel.org/linux-bluetooth/AS8P250MB079109F82C16BEDC4F9FE584=
EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM/
>
> I thanks for Safa's report and patch. I already reported the same issue p=
rivately to the maintainers in
> April 11th. The public patch breaks the embargo and I would like to resen=
d my patch here.
>
> Safa's v4 closes the sk-lifetime hole (sock_hold inside bt_accept_dequeue=
) but does not take conn->lock around
> l2cap_chan_close, so the conn->chan_l list-corruption race in my report i=
s still open after it.

Are your changes on top of Safa's though? That seems a lot cleaner to be ho=
nest.

> My patch closes both: it drops the parent sk_lock, acquires conn->lock =
=E2=86=92 chan->lock in the established order
> to serialize the chan_l mutation, and re-takes the parent sk_lock before =
returning.

I rather have each issue handled separately though.

> Crash stack and C reproducers are available upon request, only for the ma=
intainers.
>
> Maintainers can also refer to the email thread [Bug] KASAN: slab-use-afte=
r-free Read in l2cap_security_cfm
> sent to security@kernel.org on April 11th for more details.
>
> Detailed Timeline:
>
> April 11th: I privately reported the issue to the maintainers and securit=
y@kernel.org
> April 12th: Patch v1
> April 13th: Patch v2
> April 13th: Patch v3
> April 14th: Patch v4
> April 15th: Patch v5
> May 2nd: Patch v6
> May 2nd: Patch v7
> May 20th: Resend v7 with a cover letter
>
> Best,
> Siwei
>
> Siwei Zhang (1):
>   Bluetooth: L2CAP: Fix slab-use-after-free in
>     l2cap_sock_cleanup_listen()
>
>  net/bluetooth/l2cap_sock.c | 57 ++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 8 deletions(-)
>
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
