Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4B3B7B91
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252411; cv=pass; b=WVW1HrucA7QWIgJbS0jf5iXDMrq9Co49/K7yVWm0v4b5U/EzjeU0zyGXaTKs8uXLbSBPl4Tgp+ZaFFWBHvYgp8vMiO5bR9PjlD/ezwMLn2OD4HcMZoyR17Z1a69iVHvq6Rrud57Wybq6HiaLdWgKbzUlfJlgl+Z3yJzMmeTgf+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252411; c=relaxed/simple;
	bh=P4Bjcc2g90rCZwpLUPfcYDqywWWZ3CPJdaKkyPaUlPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkrk33mxIfk+dbmigGjpDfQUrOxtdhx2hNJwuTjhsF9ZbEJHmvLExv8zvQpHchEIe2r1jhA40JDDbtEMi8K0/f1lZNAEQgWgLgAtGdU+9L+YLnTTtni5cJrcIH02qIfDddzQMmu5RMhOQ9yyZZdO0LwOObKyMaJlqFrPBZ78ZIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn0nxI0L; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn0nxI0L"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-697764213d6so523063a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 15:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782252408; cv=none;
        d=google.com; s=arc-20240605;
        b=Y+YAACifqcoRPM1pIqpWbH2OsUEpiKw/L8u1d7Vxlwg1Tlm7XpYLjqS8A/4ak3EK+T
         xrJPFDJ/o9ayqmQ59DnJxJ/O1Qqlkh0wYAbD8QCdP1p99P/Hg6UyS2j2b4GHzIfcq79g
         O+c7Lha3siSzTVWm/Wqo2Tce3RRm7VW3ghBUBSIwcXlFH3PMRw/WlcsDZcfAdeTMAgUW
         +bXt0e3CI4myU6MUHBDRw1tBFDPwhPPQlvMqA//IgQx1ladcZ9HXEGJIbY5GYuKyVFxj
         ks0NhMQY4p0ZyNJVghJHZa26YdchwaQCSucMtrOzgto8K8tkRW5hYP2Y5eiE6Ve3XrHc
         y1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoJED+TBqNpCfXx2/2rhI9BnHRUNSOFVPTrIiEf4/tE=;
        fh=jthEJk8aGWOZFhIOfnYUe2KfBIk6DSVmT4wH0frmmtY=;
        b=MkH4SPQnqjWGiSwaLoc6/1lKKfjCHd3pM3oIFebC4+vhHoKQxr044DgMaYebAYsja/
         lT9WK7AzHTcSvaEaFpyWVYKmMNdM7GZQsr8JTWeqISwtI27BihiSQLMU3pdkeFscu/Y4
         cS6YuWTH1VxpDJOzCzvC3qFkNX+ibtm45TNODDOJAFT/7cfqzgKM5E344rYGQ54hiZlJ
         fF1EDVU0RlPpes1JeZ+HhZjCfbw+ue1N5HtMj8B5XlO7EhjN2BaJWqFHafA26hBrFFdc
         lBnHctYSCSE0SwG+q2w2Hnke7kZNHiXU1xk40OKZD95zutnRQGs5QDwBvsUry3setapf
         NWlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782252408; x=1782857208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoJED+TBqNpCfXx2/2rhI9BnHRUNSOFVPTrIiEf4/tE=;
        b=nn0nxI0LL0ujyTcRYudT83wXs5YAnXQXPEvbSakGfIUPr7OauhwhUAVByUfyjQsE4G
         3VsbLDTuZfm9pKV/RMoJiNnQOQzLQc9H/0AewOryQVRgcxSvH5ztRM7Kj83wf25Mwcj9
         tT23LPx8w1vNREnckrRCKp4844JqBv3D9kF2pbiKV1kxe6KD637tqtGmMFlMlxqj9igW
         g+/eLdjtEpl2+oM1TQfM6LU04V51mvvZ2U3aGgGrbAb5sJtR/X0gnWQz+nvIMxXvQYgI
         6bF65nHrwFEpZvHRk89RCsMlJYYmm6sSo098xDc1b2Cd+3xphLPphdQhMceBP0zCVIU7
         uIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782252408; x=1782857208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XoJED+TBqNpCfXx2/2rhI9BnHRUNSOFVPTrIiEf4/tE=;
        b=F26k4mAgzUFbh1J++RCTc4XQbbeQQH86WWpL9ShLhzs6yRDehTq2ERGmGCQq2Imnqo
         SO7+n+LCeQlNhZSvGtGjlK0ZumqMcHeYD++F2SNGdk2Zn/V89VSS30+Hz2vDdaybD59u
         /EOpSdNLz0xBB/9yvIRSl935RlRv3pZyJJVXgKlAW7OCWMN0Ha6JZfSXlWCO/wbzualp
         I9NLS2riWwCA0j5M+4X3v9Osf06Ik27WbEPZLCQl//8KgnYDMCVaFnBvNW5Ggf6ehPFT
         RrjvmVAdsxr6EY+c7Zseg1jGNYDuPekhhUxO0iMTXbeyo0VEDuuucG83ystlj7oLZdMe
         pAxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3w0nVU3+y02v5gIZAZXAlLUDYIu4C/Cf1eiuSY500dBA6XnbZ352cQXBNUz6Itx754xCxSoi2s5l/PBzpn1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+JCp702jQ+LXMTdFDgvtgiJMlF9sIWrdPzvjZz6tn7IJ2zsO
	PQCLrhpqbut6QnRai4AwStPXM4UdqKWAgD19MODMSrDUW/YH+epAHhVufWnFIH6mhcLhtOQbVdB
	7o0+EcSXbsDWDtklbSqUKa3IIj10a8B8=
X-Gm-Gg: AfdE7cnnKoOXEcDOonTNAYUOa9Ry2Z3k2ClI/BIclzsLZsyst/WJ9pgxOOUN3qThqWb
	VJyYqdwIeJEVRP0sSF9x25TshpDuLhPlxIU+pSO0HC6AAjUt7NNaj1wRZoJqfJRyVwjp0wosxYj
	37apzIjUnjm2OvaFYHQfuO2yWAQ6yM4Q+a57+wRkwSmqqiogNukrM5gQq8pHOIWlmXj0GNnjv1c
	4uLYofAX9s0wlo0xW+ar8UavmMnb/n1olBOTrxCOC30z3oLZVKU9snE7/fEqaT1YYEiRavjVIoI
	BR5CNrrCGVmeX0EfX331lFFisDE4aFf7+2ehJRVOwuj3W/wDS5MXoCE78mR/QPeEfDebpmonSu7
	p4NutEyYWC3+FswsqGUTisd/U7Wx0Bv5D2seenoT3MAUgYQ==
X-Received: by 2002:a05:6402:146e:b0:68d:235a:cdaf with SMTP id
 4fb4d7f45d1cf-697f377116bmr189804a12.5.1782252407504; Tue, 23 Jun 2026
 15:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622234803.6982-1-ebiggers@kernel.org> <CAKxU2N_EGTWkvtPOxQXBroxGVXDf1atPoFVyRRu0wHOtEXVWaA@mail.gmail.com>
 <20260623214730.GA3281861@google.com>
In-Reply-To: <20260623214730.GA3281861@google.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 23 Jun 2026 15:06:36 -0700
X-Gm-Features: AVVi8CeboaDakYuMckubiPixxEKhNCjPeUq6olU2uxCUHJDj2YuT_JoocSvKBZ8
Message-ID: <CAKxU2N_yu1LZeNxEUkhahx_5VYML7PZ0-EZfP94p7SmpWbO6qg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 2:47=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Tue, Jun 23, 2026 at 02:28:17PM -0700, Rosen Penev wrote:
> > > +static const struct af_alg_allowlist_entry hash_allowlist[] =3D {
> > > +       { "cmac(aes)", true }, /* iwd, bluez */
> > > +       { "hmac(md5)", true }, /* iwd */
> > > +       { "hmac(sha1)", true }, /* iwd */
> > > +       { "hmac(sha224)", true }, /* iwd */
> > > +       { "hmac(sha256)", true }, /* iwd */
> > > +       { "hmac(sha384)", true }, /* iwd */
> > > +       { "hmac(sha512)", true }, /* iwd, sha512hmac */
> > > +       { "md4", true }, /* iwd */
> > > +       { "md5", true }, /* iwd */
> > > +       { "sha1", false }, /* iwd, iproute2 < 7.0 */
> > > +       { "sha224", true }, /* iwd */
> > > +       { "sha256", true }, /* iwd */
> > > +       { "sha384", true }, /* iwd */
> > > +       { "sha512", true }, /* iwd */
> > > +       {},
> > In OpenWrt, https://gitlab.com/linux-afs/kafs-client and strongswan
> > seem to be the other users of the user API. I haven't looked into what
> > they need.
>
> [Please trim your replies, thanks!]
Not sure what you mean.
>
> https://gitlab.com/linux-afs/kafs-client uses AF_ALG only for
> "hmac(md5)", which I already put on the privileged allowlist due to iwd
> also using it.  So it would still work by default with the current
> patch, unless it needs to use it unprivileged.
>
> (FWIW, a use of a single obsolete algorithm like this is also a good
> candidate for just replacing with local code...)
>
> https://github.com/strongswan/strongswan already supports userspace
> crypto libraries.
Oh lovely. Looks like this needs fixing in OpenWrt.
>
> - Eric
