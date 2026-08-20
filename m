Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF9481B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203100; cv=none; b=aFjNK33vHKNRWFRc2wIjn8glJ5cwmUBXs3vidyGn2GeL6bdD12wpXIKOTgvv1l1TtfMmCTft8IxfwHP8VKEi02Sbw/dtuhw0+hWql44IvQEh3xnhxqgq1mULCZa/BVZvVgPTRsfNRYb3BgRGGnpj1mmdPwE7HtnNt8w2PoPjgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203100; c=relaxed/simple;
	bh=bR41JdT5RPpnJv4fPUrhOv21ghSmOtoYgMzAQHMfUrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8iRmkliSfF4KnU1F3FCcLz+vhmAm5uBZhdFBEd1AcuXf/KAxIc0CZ+KIJ9ks4HMfwI5gPtXf2/54ZZjeO1jR+Oe5lc0X+so8rJHHcGMniUTu44AdkJRISUIOwsg59aXYiZ/72G7nMU9SeygcFpJSOsD+IAOMqfGVP8d1qqqjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ag4MFOcf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ag4MFOcf"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-482938466a7so1517757f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 22:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787203096; x=1787807896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bR41JdT5RPpnJv4fPUrhOv21ghSmOtoYgMzAQHMfUrU=;
        b=Ag4MFOcfgDViB9Rn6U9484ZK3dmleA11aTg3aHihL6PVv92PlCvMd9J8di+pJLJHhU
         p7ZSPaXsVJqfN5LyEGxDnSxbAzvo5Y4p/BQWtjX57g8VCJturrDHdR0BbHsxPcD1GBOg
         rKd7skCh95MnLYMq8kV8uFDw9fEeXPTUrbied1XXJtfZKIzVi3HrLzsBpG4nV96rfDaw
         LkLhD2C1NU9XvSbBtsEWCXsf7biIPd9JvijgjrktiTCtem5/TvsN/AgYtu8yiD4eDvlh
         PUxeaXG3c4Si859q3hslRkL5v/0g3uVFoLwpNnojSQCsXwvq9PVYl2nR1Olrsyh6nLdN
         zJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787203096; x=1787807896;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bR41JdT5RPpnJv4fPUrhOv21ghSmOtoYgMzAQHMfUrU=;
        b=AHrL8nrVgNji/4BT5em4p/V2CVbDq/wLGplKqIQk6yu0AGPiAyd7JvEb2/nM1jHDJk
         8M7ddYVNaLz3GZgkrHS/J62OaNRmf+1SxX8X6IA+6PZakn4C17EfQpCA414FXQcaexn3
         lAt9bYEsPjZzbZEBJ6cJ50MOOX3ylF3QO64nNVKh11voQV8fhulMzmfTiVY5iwKk/ndz
         uX61Z9r/RRMlGN9R8oppmH9rFQaHm1YDuy1I7dBKgNinxP/6lQMjyiNpy4PjlHEZT4yW
         aV3DeKbqYh7hud12vMtu9wPd1nSpZs81e6r4MF8b41zPEHcIbD+cM/pbIQRjAClnQLzf
         xN1w==
X-Forwarded-Encrypted: i=1; AHgh+RrLzaWoiLFn1RilJztpsD9a4Dd1qGhyztMLPskIGQHYNkWmH4u+z+6QSXKsRJ++Nd+Kv0Delay4In3Bpeyrkp4=@vger.kernel.org
X-Gm-Message-State: AFuF++n1oezJnYNLhLAd5fIiGeV5s+o6lQIzmNWkoaLXCRLRAIzxD5O0
	jcMg8Jd9orreKo9CrlVfYMF0DriJshjS+Lbo/Sjp3CkGCuFVJiRxFe6KqHxUGVUoeemyGa6xZsV
	5rj2J0xU=
X-Gm-Gg: AR+sD10D4gakFBfJdb2fTiQKkF5ANz/nNFKccxmzJBj4hKpWNxGFh1Fwh+xbiVIZZhP
	1JTs1bldBLRiVGPC/sOqwu/fjARhvk0LW+Q0VF5QFXKx8OEgIQZLiV6h1j4q5RKtOgdHzWEWQud
	vWClgGhot+CRjBuKajZEN3fSDfmTpB6W1R/OCoxN+Sz8Nyaeb72+kD5makMHb3ndjiHlrmZWCb7
	5b+8HTIVrDu4iIv/pakNW/Z6Og3jiOCGt9Y53akHMKCpmxbmxmj8VEGbrlcIcD56DHDZMrr3LSe
	LJj8565d8c+sjndvnMYMXBIEGVr5X/uC23VSkVD0Q1f1D9cXzFUqyvwbdHjmjrzo0q8dnqjke0J
	CAJtbZ3tkQ21B0cAel9n1UgBRoIwHcA0f/LahpqamZmybEGfqXr1n9/agU9nywI5wqrBNLpylxB
	t04XEr5qBZ93fNrkL2/2qphoe21SuClsnhOrSQHki8UaBijFksOcXQQJoafH5y7zubJA==
X-Received: by 2002:a5d:5e86:0:b0:47f:f002:3652 with SMTP id ffacd0b85a97d-482b1fdc0b9mr18651245f8f.12.1787203096089;
        Wed, 19 Aug 2026 22:18:16 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-482b14c46f2sm11773721f8f.29.2026.08.19.22.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 22:18:15 -0700 (PDT)
Date: Thu, 20 Aug 2026 07:18:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Li Jun <lijun01@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, 
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
Message-ID: <aoaMcmrLlLlsPonj@monoceros>
References: <20260820005058.1285971-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="65k3o3gdtookejjx"
Content-Disposition: inline
In-Reply-To: <20260820005058.1285971-1-lijun01@kylinos.cn>


--65k3o3gdtookejjx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] Bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
MIME-Version: 1.0

Hello,

On Thu, Aug 20, 2026 at 08:50:58AM +0800, Li Jun wrote:
> use SIMPLE_DEV_PM_OPS for btmrvl_sdio_pm_ops,and add the value of
> .freeze .thaw .poweroff .restore.if these address are null, may cause
> error in s4.

Please use spaces after punctuation marks.
=20
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---

Please apply what you learned during submission of similar patches.

There is no changelog describing what changed in v4. Also please use
pm_sleep_ptr() and practise some patience between revisions. Four
revisions within 24h is too much.

Best regards
Uwe

--65k3o3gdtookejjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqGjhQACgkQj4D7WH0S
/k5cRAf9FQiJE26Me34mjiFf7VyexXwFxe9Z468DFgvo60sbcLPmxqz/buFD0j3Z
x1B4kzaXHrsaXddCaST25hicZQsZ1ETv5WSCYSTcsK281sxh4JOm3Qh6qq/OgA+I
KJDM2WRdVjlZ6+BoARZEmLfl+2LS7FHghXv/hfEQYQGI8znTkJ5BGvyQ+9LqqKuv
wJNsZB42lOOc8+J5tR+klVOyJtiMGC30OekkP22bNjKdNYpW59m0uvJxg8r6IDrw
aNGFPl6FdchxDrKW2JeOcih6rE+2W85zy4gWoEKsw9mFl+icSBNkelfy0BREAOny
wV8Gnbgs3wdDaq82Z8agut3syR4KCg==
=nOvy
-----END PGP SIGNATURE-----

--65k3o3gdtookejjx--
