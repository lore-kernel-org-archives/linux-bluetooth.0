Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D28E18F2CF
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565188; cv=none; b=vA3JTK8rqwm0S/W3ITopBeMsMHolJLvopCQBcCuCi1XZanYEVovNLzKze2wnB2MBIdTi2edYi08h3V4NhJu81rzoUW+njsC1rGtG20tdotwKae4FZi7fo/088w3K4wkD2pRq9prfyA2xiHi1L3S+NJR8imTQi7NxL6Zp08uxu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565188; c=relaxed/simple;
	bh=1FnpD8TrXG2Zg48P6SjkH9fscFUVl+62K+mhoss1Jxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTytkRLGaB9KYcTD7yCWrBrzGtu5wUwQLUBwpVpSws22TagKs11C50BZp6hQ5K/IRUZ8FPhwDfYL9UJCw7F8pwyrqcvUdZVH6olMJVHIilnm9nNJbNDvQAa7f9mKvwKRQhvF2IoMhkSbkKvrDtbl50bwlA5ftxEr/1WVwlmtaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwEy6nW6; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwEy6nW6"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30761be8fcfso25533561fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 12:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739565184; x=1740169984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywQ4bInpDS27h6i4+Gp+pAo1Ad5BLFPpTQFH8fRKbws=;
        b=UwEy6nW6CBYFqbC0G8a7T+fx1yihGqR4ySU5f/rB+Bpd/EWywt7uRKTuoHK3j58JIf
         QFTnvLkgK+/fpgMd4iSB8j/mCBsPyAukBZiCaQq1QrtHUIyadib4WtYK9TNWrqw1E1WL
         DaciWYnp59xFSBujQOumNv35/zEpqaccsxQB24GvIFTSD89baM5BbZas1NQfWf5n+b1g
         cy3Cw5APzKHP7iOjn1IwPtEHtABbM6tTfOVO3GpaKldxaVYrm9g/5Pz2+Jtn+VBT41Ra
         BjqpNjagx0Cee695d/iHfz3J5rZiFSh5FEc8ViFWhvz1y7URyMI/Esm446OyoeYiP7yL
         XG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739565184; x=1740169984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywQ4bInpDS27h6i4+Gp+pAo1Ad5BLFPpTQFH8fRKbws=;
        b=N457Rvqg+TE7T8gyGUBG9z9Yj5T01T2OVb7mimf0YDmCoOsqDEbDZ4BsJckjHYzR4G
         o2D9Nu4sxGTVc30XXS3GHRqqY5tz94dyxntkoeO219bAkSYQNV/pJfPoNsqomZy3rvD/
         ymGBq0hA0YQLaySN4i+euI5BGl4bvaxHXtpsMSfOcmJZilRxYIkmogqPefp7X7PTDV2J
         Cxjuw+LkJsCtFaOzUuNKjIiinqMOXPZdhQXEwvhq6ftdNvoN+TXHWjdsJY85UCCsDD6L
         YJBfBks07g6wkGB4m+JU1PArGv7/c3Oiqmu06B/vyhf72GkNT0LLxdQLD7syxMzqZXBi
         gbuw==
X-Gm-Message-State: AOJu0Yyu4xWWfcq0VnfXhCN3ZQFnekEwImSwg35HoQ1sQKLk/T4kKjfM
	1OZkBEabnUoK+k24tS1nLB/zD/btv+teLNi5LUBj73BEYuj7mpOF0xmBCLYlTkQODD5+8GadjQw
	u6OAL6L8zV61G6eBDJQOcmV3ugzn0sXmP
X-Gm-Gg: ASbGncvbRr7SiLdHjYb2JDHEpzZjYgL3rrnhnsBLdsukvzvIroCY2hyPVH/FeTyPnf0
	pht9qL4R5FzRdWns2uWsWIlFj/08RFVg9TfDa4TQPbWmTDh868GLNiIrE3v1WQRPQQ6SVuMkZaw
	==
X-Google-Smtp-Source: AGHT+IFkmLAS6TiKiDnjnCgtgqiqNUJa+2/jsGOTI+68iDnExWUTKlrbwgG40UgkobDU4EnPJtsyNKuJWw3sB2MPwOQ=
X-Received: by 2002:a2e:8954:0:b0:300:38ff:f8de with SMTP id
 38308e7fff4ca-30927a72243mr2773591fa.16.1739565183328; Fri, 14 Feb 2025
 12:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214202129.968369-1-luiz.dentz@gmail.com>
In-Reply-To: <20250214202129.968369-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 14 Feb 2025 15:32:50 -0500
X-Gm-Features: AWEUYZmi458w2NufbriLDcbIRVOYMXQ1getp1zFJ1w3yvrKEkDclxodfH3w1ReY
Message-ID: <CABBYNZJmigw_3=5CZ5eaSGC8ZHTzmsZA11p558EtcET-FcrVEA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] org.bluez.Device: Introduced PreferredBearer
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli, Bastien,

On Fri, Feb 14, 2025 at 3:21=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This introduces PreferredBearer property which can be used to indicate
> what bearer shall be connected first rather than just using last seen
> bearer which may not work always since it seems some devices sometimes
> advertises on LE bearer but expects connections over BR/EDR e.g:
>
> https://github.com/bluez/bluez/issues/1092
>
> Also with the introduction of LE Audio this might become even more of a
> problem since most likely users would like to select which bearer to use
> rather than using the last-seen policy.
> ---
>  doc/org.bluez.Device.rst | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> index f8d4a68a6b41..e3cf4d12b173 100644
> --- a/doc/org.bluez.Device.rst
> +++ b/doc/org.bluez.Device.rst
> @@ -40,7 +40,8 @@ void Connect()
>         are skip and check latest seen bearer.
>
>         3. Connect last seen bearer, in case the timestamps are the same =
BR/EDR
> -       takes precedence.
> +       takes precedence, or in case **PreferredBearer** has been set to =
a
> +       specific bearer then that is used instead.
>
>         Possible errors:
>
> @@ -346,3 +347,23 @@ array{object, dict} Sets [readonly, experimental]
>         :byte Rank:
>
>                 Rank of the device in the Set.
> +
> +string PreferredBearer [readwrite, optional, experimental]
> +``````````````````````````````````````````````````````````
> +
> +       Indicate the preferred bearer when initiating a connection, only
> +       available for dual-mode devices.
> +
> +       Possible values:
> +
> +       :"last-seen":
> +
> +               Connect to last seen bearer first. Default.
> +
> +       :"bredr":
> +
> +               Connect to BR/EDR first.
> +
> +       :"le":
> +
> +               Connect to LE first.
> --
> 2.48.1

Please have a look at this since we might need some integration with
upper layers, at very least bluetooth settings needs to be involved,
this is similar to the likes of Windows and Android settings which
allows enabling LE Audio on per device basis but instead of being
specific to LE Audio, which rules out other services that maybe
exposed over LE, this enables the connection policy to be tuned per
bearer. Now there maybe another policy which we could use which is to
do dual-mode, but I don't think headsets will deal nicely with that,
specially because no-one seem to be doing it, that said that would
make things simpler since we could expose things to be just a
codec/transport switch rather than a entire bearer switch.

--=20
Luiz Augusto von Dentz
