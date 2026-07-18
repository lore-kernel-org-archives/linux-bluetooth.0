Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF73054C7
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411529; cv=none; b=h7WhhhvRgGN4d4kNHekrbp8Poa54mQHhuUDq3zdI7rSwdqqoN0AzJb0tXffbD02YsGe0KMTXnY0gLzhnBvBb4uNY1NP7FTX89ckWXy26CKUAASrsclswE8tIh5nzFDPPtVWoL4yNATPaUlTlUsyf3Nhjaum47TwjzK9wEPcjx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411529; c=relaxed/simple;
	bh=PBJtbQkRw8yjc+J+TwDu6qK0wpClmde4ArgYrjVgRrE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6eJlgBH8vqT+j8yDZ9MgQ1+rOnbTTKub8P9JMs57mHywb1HbqGRSTzExDxgbVQxUazpsfKwiSOD9TmaeSqQYw64dRs4wMA0znlje9HxqUAwz0TSH1s0Qwz3Lcw673wLjjII5Zf/ZFjHBJIPeJhg1QSjg2OmlvuMTlVEqASxOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=XuN7xc7O; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="XuN7xc7O"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47de008b020so1987450f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 14:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784411526; x=1785016326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AQE8WVd+a0T1RCuBc5UA0yq3AR7s7qi87aUMf/zKKas=;
        b=XuN7xc7OzHiPfV2Sjcuy41GUG3sYrQ52F6WZauydWeUt3esp2JXeCv8CiejY2kJv5Z
         jX3o99CPuTyyK96MfnVeQaR8t6G6xz+xSzuVG+j4zg6R66NcaQOEnb5S3YR4DNL5foJE
         N8BjYMigPalsJM+0vrMizfU6A4fQdVsuCgVZ5BefgQUSQZwkBDHeNZ76kEcBGrKqXKef
         CJ9lavkHRd+kn/LyQ4H0NmTByw6Wj/KKVz8qrHjYCVWG4NlYzV7nkcKQAL4L4hNOt7Mr
         qIDPZdbbTcep3ETZOC4V9WiHYJbI1+5rS38hsQtCVOg5A53w7j8Nd2Mh5M3Ny69/gLXK
         sk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411526; x=1785016326;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AQE8WVd+a0T1RCuBc5UA0yq3AR7s7qi87aUMf/zKKas=;
        b=R+y/tRz65G4lskNPDlBYOUFTGr6iHFGv4FRt/Ek9ptmEoDCd6BuIDkFK7OqCT1yHg7
         4XfEHr/1Ij0fYpZrBjWUlKGR8IkUqeHZKoMVeUjWGQCCGelgCLh2fkwCvSQMk1eoxp76
         b50SvrMVRFB/6T+SVZGJ48S/7giCer0vpRYj7O9lN2YUxckg4ji5//sKM0Eh4WMl6jBQ
         X2m9RNhM0/ButJPSrCojgSARcMrrQjNOrDdpMCVLEKZGNTmOSHaghaiSvTn5Uhm1kfQJ
         ybHZbFNCMKR5MHaQJbHmZydRabXzqpvxe+O90X4vXRvKiDjGWd/olMO8AKwU6R9Hc9tT
         9nGQ==
X-Gm-Message-State: AOJu0YxftOkquoZEctl5sKE9cZz7aZQHxLNOI1H9NNUK29G6g/h1uzxg
	25R7nQaAb1rIJY0vmCUQyk7bjdIo8DwXPl1xyv7jniwuhP/nHomwewHdF5eQBqjofO0bxe5uhDW
	BIVXC
X-Gm-Gg: AfdE7cntYagJA5bfKE0ARNMkJREQ7n7uKhGF7FfeXNSHcucie0sSnmtaqe9GJ8J79wc
	IvU0ezcBBCRQS0TWFvzMDeLcx0y6lhSRHbPFUrFt3q5wdbVFSv5aj8g65reE/JX1u8ldN2oEp8U
	+wVx/5LtTTrWOnro1fQ+Yds/lFyb3xq11Je8zlJT7yw0tS1VpHIcrryH7NWsTWGX1bZOy/GdZbC
	MGBKPNFPMkm29NDYIDQ0QWO1O6Dqp0aXCOex0ho9kgBF1eF5ONfWGB6lh57tRvxx8XezHXmIlOU
	dc136O0emOgWcQRecgSJJAOj9cM3ZtG5LaPp54o/lrnSiFvoHpaiNAgV4I7WfbzCzA5M3w6Edr1
	3MkRYJXUkFbBzhMfLcfwI9wRH/hfOMZU1z1RCfWEO7bQsE+l//Qfa8nrLRnBUzWqpjPybRmG3iZ
	N7ZMYBv94=
X-Received: by 2002:a05:6000:310a:b0:47d:edc7:4c44 with SMTP id ffacd0b85a97d-47f623d8340mr9070049f8f.19.1784411526172;
        Sat, 18 Jul 2026 14:52:06 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63ed1911sm16696425f8f.22.2026.07.18.14.52.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:52:05 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:52:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RESEND] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
Message-ID: <alv03f_71iJ0tsxU@monoceros>
References: <20260718172513.986134-2-u.kleine-koenig@baylibre.com>
 <6a5bbfe0.3cce8983.3cf542.f6be@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bpyzxgbtqeepyc7f"
Content-Disposition: inline
In-Reply-To: <6a5bbfe0.3cce8983.3cf542.f6be@mx.google.com>


--bpyzxgbtqeepyc7f
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
MIME-Version: 1.0

Hello,

On Sat, Jul 18, 2026 at 11:03:12AM -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!

I disregard that because IMHO the judgement made here is misleading.

> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D113=
0117
>=20
> ---Test result---
>=20
> Test Summary:
> CheckPatch                    PASS      0.56 seconds
> VerifyFixes                   PASS      0.09 seconds
> VerifySignedoff               PASS      0.09 seconds
> GitLint                       FAIL      0.25 seconds
> SubjectPrefix                 PASS      0.09 seconds
> BuildKernel                   PASS      24.19 seconds
> CheckAllWarning               PASS      27.46 seconds
> CheckSparse                   PASS      33.51 seconds
> BuildKernel32                 PASS      24.60 seconds
> CheckKernelLLVM               SKIP      0.00 seconds
> TestRunnerSetup               PASS      442.54 seconds
> IncrementalBuild              PASS      23.86 seconds
>=20
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [RESEND] Bluetooth: hci_bcm4377: Use named initializers for pci_device_id=
 array
>=20
> 20: B2 Line has trailing whitespace: "or "

Indeed, however this is in the "cover" text that doesn't make it into
git. So I won't resend to fix that and hope you won't discard the patch
just because you see that FAIL.

Best regards
Uwe

--bpyzxgbtqeepyc7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpb9YIACgkQj4D7WH0S
/k68ZggAmsBTZGkopK86Q/g7berJqUxBoP0IrsSNw9RcjRLATRbPjgZAV9xe8f4L
c2cOpw8U1BqunOvhWtMXEsHQxVv4qvzNHkfqwSxefbIw0RX8ztb55gBix+P52shZ
fGdiymyrxFKSP3AXnPpAJdQxZRbFx+iltK2knlKCc5yg1pfgIpW7qNirEuKdcck+
dGoWY3AkMVUTr8M/lZ9+tfbVelj/K3RgfdsDldHP6ir//6FfzIypTZ5Ev2fKKNgW
yIu1b5sWMD0OmrY0R5h34AK+HCyT5hD9NLSeHfU9osgzUj6FcmUhMUw+/uGP+uxe
86r3oIAjyRETAK50mLGjSvLNhyn62Q==
=q6UW
-----END PGP SIGNATURE-----

--bpyzxgbtqeepyc7f--
