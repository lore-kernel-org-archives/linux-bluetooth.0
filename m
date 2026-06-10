Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141934028E8
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096798; cv=pass; b=WoqWRKnBOedw0yYHNBe1hyhb2qoVdPiD+x/XHYUBlnei0747St5nHxYNRaAUKsqWA/jCjXTa2z2d6eq5iq3mhkg0OXpdnaSsRQnMEd4mZ+EAtVa2NxOesE9mw6ANFWC5N8d/4mJbwozqk27jayzFp8r1VcZCwNPmaA/6ZvArhD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096798; c=relaxed/simple;
	bh=FON1CoKM0rF1uFhumS7et83MHpk9d5AZyBQCPyEfjKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0cogrC3/Aw32jzBI8R7HKbFzkPsQbeicE9ndgrh4ijJSqQ0oXSjJJFiuNOt4iVFepx4+5p2CrPMCfB1KkwngHVyJJLC7e9cYUUyUmCLKDZg/QzYOBvzzsVfgZ2WY0xzEGK8UFEiVvJs42If/P8mRy37R2Np9vhODxrXxybvQAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQr4PeJm; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQr4PeJm"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66077c46c5cso5992196d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 06:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781096796; cv=none;
        d=google.com; s=arc-20240605;
        b=GS9YXzAaKIVmQrGKFx+ggbc40FFvyRimwzdb4lFFana3Vn6PVOV9XOQhOgKqDWLUDl
         L4YJCCjd0fCtrDHEsku7mNBJ6FLC46f0ECHpol9xAdSETLodQZm8DplXTHd4HORGHNMz
         EhFzfGhnn3PqxS+amrYLoiVld+P0j2D1bSLyptCalbNUrzyAzQHx+CqBdLrcoJOsnxBU
         tySW4IC4JGCksEEfsEgtggAYKdTqVhRbUhhH2j4D05IoXUbwKPmlppmXL2RCz4UkuzSX
         TLFcS6MyOkU8PjnrdAgYZNFXNfBIdh1DTgzTkYP/+rl/PWhv0BI5BeI0BuCm9H8vs7X9
         e80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7wMnEXqbxoYhFkOWgFz+4A88tJVsu+eaTHJQLIWdC2o=;
        fh=1lai2hMMrhvWubpUepE0bblohQpWi2VePt0uB1TFfOE=;
        b=EBWkYKDv4iZuBW52xWMDnhc+eko5+pZE/i6pWHKb4EKN1fOhx83mBWT6G+6mz88/uR
         zzaADBuKuUM7wCvyHS7/z8JiDiv7SC6i08+xi9/Ff8TF1QPwDDP7L0ot1XrovxHmrRVs
         CKP3s7Jet+OHhTOtzbKEe/S051yzOhyhuJ9/aOxtZtwC3ZMt6BoRkmQ+3xPd3wnXNx7m
         H/qfbF/W+vc185L5SefHTB8Zdibwrve/uwqlRPck2eepydz3uxHHDDGDKpzBCSvitskq
         58J7IkbZJmMKOsUsYSHke8x+Voxn7CRVGwCOkGdY2bDAKwIgEUPGsEPGbxRvKlKoaOvd
         1Y9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096796; x=1781701596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wMnEXqbxoYhFkOWgFz+4A88tJVsu+eaTHJQLIWdC2o=;
        b=GQr4PeJmFWDYubkWswXKoeIvdX5i8j4nDvVUCWG3vE0Bga5Ed1I/DEWxU7ATNWVryf
         YvSPeXnk5j1fdILGTuvzc7L4Tqq+GI3BqVCcP52iOtgvgBaTEe2gLQeY0USZZp0PmDRs
         zxd0aHqydlBEO88Zg2JY7vqpHFt4vA/k3R4BAFfmF8TObgvybY9d2IOHvmCXTr2u1Tiv
         2CPK4xDOVdkZ9xnAKId1FVKhfU/P2X0Gn89W+v/z+ZZD2azttsN4DkBI0H0VNiBHGI7t
         Cbi8LqO7CKUk2l5NZepDGDn4WFWtm31DMWXbDsyWyWZPEEBt/XMp3ErKdAhSOiRDh77K
         ZPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096796; x=1781701596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wMnEXqbxoYhFkOWgFz+4A88tJVsu+eaTHJQLIWdC2o=;
        b=MOqqounmNWb7g8anKwjXnIVdQS2XuQ4v8HlNV/eeGJRdfnpCwA4ExebpMj3nkj8RVI
         P0F8bwEYdUweo9YuQSNC48GYV2LsV2O16YrXGaDTSXQZT7hLJIJJGayv9PpG7cJ34dei
         Gv5vdOSpD9hpwFaArkEhWF9ipWNShp/UvAZbfDSvhVQExVJV1iJWRf8UWslvuGEnuc6H
         cH5aAvi7FSXbAhqipM21aMIqMJsZ7Hi+RSbZP5bUeHHXlbh8iaL+LicO5c8oH2ztfZt/
         lgWZtCrl8kx7nK099udjRHkOG6F1NMw8UqINg4tImFY4hMLc16O/lJlJokmtMfuW9myh
         nW+A==
X-Forwarded-Encrypted: i=1; AFNElJ8ws2eRKa2dUNd41/A2Is1/fv70jFEvue1zFLIJzrwI4LbOcTEf+DASHypuW6u30UD0PDFG66mQmNKZlVmxL4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMMg0DPI2wr8KmNZIAXQ7vIbVuZCmwG6Oqwz6cKLAbkPVo+a8R
	DH2qcDZutvJRRAatjXgpYxJVhcXbTf4Jskege9ZsZw21Q1Accp4jxuwCVOXbdszB57nYv8RNIop
	zKXLEHRU9GCm3Lxc/cuOLhTXv4tfzC8k=
X-Gm-Gg: Acq92OGZ/aJ9ZywbNqHntQJc+NKy+mjFZmmvjR9nhl18AYy9191TfEbMBxbuvpRVjZf
	Etvex8UPdBBaeW2ELdNoHtY4IHWSG6gSjrDuQs11sKFUaAgoQlWHDyGkVJ3hGzllrl459kJssjH
	ayJVZZqUwWy+8yGI9T09QEBrTN++oCsMegmx8OqukrUamm1TWWKEkdMZs2+h+VBY8Rx+m6Wl+3Y
	Fqsynh9cVC+kxrGaJ53OvN70OJJtyM+PxxMCF+wNDNxKpVGLdtIYf4F73RYj7taJuZCXp2rYwbr
	Wrec/J+N1Lhi785uKrW/eWtpwmQVrD8rYkVBBqpCrtOx+7u/pji6I5AvcUvBGXDW+/2CQEMo9wc
	aYg==
X-Received: by 2002:a05:690e:134d:b0:651:c468:99a2 with SMTP id
 956f58d0204a3-66108356e4emr23038007d50.45.1781096795910; Wed, 10 Jun 2026
 06:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609211111.3887657-1-simon.mikuda@streamunlimited.com>
 <0744a915b7ea628647a17fa9aad0aa4365f83989.camel@iki.fi> <fa0febe1-5866-4a3f-9f86-ae70e9d4b22d@streamunlimited.com>
In-Reply-To: <fa0febe1-5866-4a3f-9f86-ae70e9d4b22d@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jun 2026 09:06:23 -0400
X-Gm-Features: AVVi8Cc1fh8z4eAoiSiTBl7tDORY2MFrKaAJ1lZdY7eUFZnlokYaQB1jbl6gM_Q
Message-ID: <CABBYNZKD7WGUpkQk94ruAnPw=ToGnChbRUjuBVTMJ7+fZ2M4vg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/bap: Don't link ucast streams before CIS IDs
 are assigned
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Wed, Jun 10, 2026 at 3:51=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> I looked into it and 0 is valid ID (probably not used, but still valid).
>
> There is a ugly part in bluez though, when stream is allocated cig and
> cis in qos struct are 0 not 0xff:
>
> stream =3D new0(struct bt_bap_stream, 1);   /* qos all-zero: cig/cis =3D =
0 */
>
> and also in tests there are some struct comparisons that also use
> cig/cis =3D=3D 0. Some parts check for 0xff (BT_ISO_QOS_CIG_UNSET,
> BT_ISO_QOS_CIS_UNSET)

We should probably initialize it with unset and then check if CIS/CIG
have been set upon linking.

> Maybe more clean fix would be to hook this up to state, so that when
> CIG/CIS is not at least configured it is rejected e.g.:
>
> if (stream->ep->state < BT_ASCS_ASE_STATE_QOS || link->ep->state <
> BT_ASCS_ASE_STATE_QOS)
>          return -EINVAL;
>
> Also probably i should cleanup all structs (code and tests), so that cig
> and cis are initialized properly with 0xff. And then provide the fix?
>
> On 6/10/26 00:03, Pauli Virtanen wrote:
> > ti, 2026-06-09 kello 23:11 +0200, Simon Mikuda kirjoitti:
> >> bap_ucast_io_link pairs streams whose CIG/CIS IDs match, but the IDs
> >> are unset in Codec Configured state, so a Sink and Source bound for
> >> different CISes get linked. The stray link later propagates a
> >> disconnect to the wrong ASE and breaks Receiver Start Ready.
> >>
> >> Skip linking until QoS Configured assigns the IDs.
> >>
> >> Fixes PTS test BAP/USR/STR/BV-362-C
> >> ---
> >>   src/shared/bap.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/src/shared/bap.c b/src/shared/bap.c
> >> index deb85b264..98537de60 100644
> >> --- a/src/shared/bap.c
> >> +++ b/src/shared/bap.c
> >> @@ -2679,6 +2679,12 @@ static int bap_ucast_io_link(struct bt_bap_stre=
am *stream,
> >>                      stream->ep->dir =3D=3D link->ep->dir)
> >>              return -EINVAL;
> >>
> >> +    /* Don't link until QoS Configured assigns the CIS IDs; while uns=
et
> >> +     * the check above would pair unrelated streams.
> >> +     */
> >> +    if (!stream->qos.ucast.cis_id || !link->qos.ucast.cis_id)
> >> +            return -EINVAL;
> > Zero is valid CIS ID?
> >
> >> +
> >>      if (stream->client && !(stream->locked && link->locked))
> >>              return -EINVAL;
> >>
>


--=20
Luiz Augusto von Dentz
