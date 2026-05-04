Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA63DB642
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902880; cv=pass; b=kKepbZDShm1OXmRcRomKkI3hMn43r3I0cllyW4jpqGKEWoXeVcsN9SB6RrL9rfh8m16gfptn1mE9E79RKihUxNoppT1IFyRKuMnyYZX9romj/U27cI+qk0AKhJHrnM/9cDS7Lv2ZSz6Em68NCRe3re623liq8rwEI0+fdvDy1J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902880; c=relaxed/simple;
	bh=98/7LAnTgaj80FF9fluImQdKqYe+c1aMZB6dLK/qmX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEU4/UZwJNE86W0H2qLMC5XlLJfGnD7kmdWUNbpylu5hxmsoESVw2Kgp0fIEdpK+HUTOmSkr0Muigkt/PyOHfdJDKpFz8sOa4R8NoesROaNnLu8O//JHTPtAaE8caAA+/TpCsv854JdIj6omDhT8/YDhNGvN2q/mG1OsCPVU1ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJ3+vQwe; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ3+vQwe"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651c5d525f6so3645850d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 06:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777902878; cv=none;
        d=google.com; s=arc-20240605;
        b=Z7e9CuimCFH4NXlp688WnH/wFu9dqqF/qSWucsq5nkc6h3f5F3yTUg9XW3a3aIRfva
         SfIwdff73q2vrlCOzD63I/YN7CmpU9L4qPc/fqmoMTUkXYzXKCquxf5XuFc8raLUqmtV
         iPFi3CsrrVePDfKqAFtaeehgTKY2pPT42/Hz4YbUdC23KDK6a8G5LKBOcuIYAeaOZS6a
         c5KGpoTHGcCE7xmervjOMpKod85HwXRP/OGdNUq1Z9HHWa1ST6gEJHeKxcGcxb5n9Jm8
         CHWQvPRPMm1dt6xCen8jInQsy2TYDJ/3jNHOVKrwsfye5fykv3S7QOn68GpTvrKh14iZ
         mryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wGEzPkSlT63Ty7ZTtgdlFN0NcXI8KanlbGfJG4YQcW4=;
        fh=o8NNz34DwVSw7MPJlEb3OWegD1ei3PfHO8o7tqRMUfs=;
        b=GUG1ClhyzpZnoBoJc83NCMQsTukmS8ly5u9VJjVomSECAXUlC9P5YN3zdGMcziK1Zb
         m6XdrHcWYcQZ0SFpA8QI5ypr4hmoYKyl8b31OKIFpfFctQEAEzAoTSx9/x5rBNBLdWht
         A+dyLSW+RBOi/kubEv5+2rxCo2fn25jYXR+dNq6P9n+BvtlLvUjoRtiBUXqajBoNeW+8
         MuXI4aVHG+bmyySTwih4q3kWXr6nnJxYB2igXEB4jnKhYyDW/yB/pl2cUIv5JfglerGX
         j/UL7ypYVbu5iqFohROSrvYSG8E19Bl29GkG9CNjr3L2RdDmGLU6T/HjCR0vh8agkrJe
         RLnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777902878; x=1778507678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGEzPkSlT63Ty7ZTtgdlFN0NcXI8KanlbGfJG4YQcW4=;
        b=pJ3+vQweN5Yz2OAueQ4CQF9j2E4iBZp6G5Up5qNSkR7eiOtQK/BOdKTZZandQN22Uc
         FhRnvVEtDIfescw+VoSCLF7NcdvmeJqLVrCWTjo4ajYxGFbb2dRSw8O3wet2BLHRS44x
         zcypJwnxGQ8Lb/9XMCBsu/tUVo4Z2I/QGtaKYpfIiZ/TSKJohfnJKtRMPcGSR6TB6MNu
         gOPBHBV2BAHAUE2Sxhi86mjPIzHbXcbz87eraSNArYoAn1Z9r8Ha6t9oIs4AJDbFt7IJ
         pUai47fePsmk3olsYyX3l5Zwtf25T/YFUz2U40Z/WK9rJRSO8++/B2E0O8s0EClekiMv
         DRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777902878; x=1778507678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGEzPkSlT63Ty7ZTtgdlFN0NcXI8KanlbGfJG4YQcW4=;
        b=owX1aHd+Ler4TVevxHobQUV5jaxC0BZNeZ7DiN2ezncm0hcBAcMLFFbwI8s53/yTwD
         qXMM41M03sGe2T0CKOBZ7cLhcseRfbkB85Sxu7tUxMjv4CstmuKFi+2izcAsn9zUSFDV
         PVxWCJYtyok4Wy/0jw3XKYZzthOWiQ2hm3C5Quo6xzO67yhYmlUeUn3pY492uwBJje7h
         lrg982Rxb8rKbThwdHiNZbyR5TiNScEn0apR3+KR0w+7hucyAcIqvJbjookLX0rgFtyy
         uQNXnCIdPxs0W2GJZ2X5embdCiUbRM6wui5rBbiy4YHF+HH+QvCbI+Y0Aj1BLnlbdxC8
         M1uQ==
X-Gm-Message-State: AOJu0YzyMAZ+I5qSr2SWbfPyc2xI4vfjQqD2AW0I2ZpCdDnXweuYDzaD
	6IA4uG0s9QtGxDgVHgym46gaQvXQNXRn4wFXOUhfhmoKyfgfyk/abMxtaTjlwNR1NeYKP06txeP
	evZKejclW8w+iXtdUwyBwpEGUZ8T6t04zEjRJ
X-Gm-Gg: AeBDievWyt0ckcsx7MiHB81Qg15aXRndjEbpSbBjfzO2WDJVphpgkW+mh1Iq6ffsmRM
	wO1jEh82WQS8a6cLjZKrnX9vUoSqvQ6nGESIjg1v1w5WafPZ1fFKa+MEJzQ6C9eYhPljp1RZMjf
	7jnpL11+cX9lMOX7r0O5zcvImh8JNaLuefvzOVJp5qZKg/GfpuJ5MbrZ5LE/douFzSaM+BWYwN5
	Jg/87+3AJx8B24TGvkH/jQyrZ0zVnwlJ7Y9bM5r9nBn9z1Ndlrikk0uf1wZhuNAQNfG7d0yZPVx
	jHBLa1GIiRfuEkjXqWM1AXcLHEHoGuapmv1Bzhl7rDZQK3CkRIiZkULVqQJxODsEHEo/77TgPek
	+wZKs/vMaXMVuwQY=
X-Received: by 2002:a05:690e:1901:b0:651:c8a5:fdd0 with SMTP id
 956f58d0204a3-65c3db279c8mr9303427d50.46.1777902878377; Mon, 04 May 2026
 06:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ygH6bncNsvf-0Hco92Ae11Lw8-jOfekFO6O3bUvFK8w0DTueny_rwJIF6ffZg2G_XCB4v8h8xRIcAL2b_KwaweNcGa231ZQDHCMpzyvR5i8=@fluentlogic.org>
 <CABBYNZLV8-8YYwDEAno4_WBNEv-hcERL_NvwMfHBnLK4ZDZ+7g@mail.gmail.com> <ZgWmfG6CS-u2_HPDI1pPPbm4Q8YdH7I2nyjgRojT45C7wW7KwOMs7_TRD5TeC9jz0K3fHhN4MPoyL66KdgxLIPQxo9ofTvgumVqXhtsb13o=@fluentlogic.org>
In-Reply-To: <ZgWmfG6CS-u2_HPDI1pPPbm4Q8YdH7I2nyjgRojT45C7wW7KwOMs7_TRD5TeC9jz0K3fHhN4MPoyL66KdgxLIPQxo9ofTvgumVqXhtsb13o=@fluentlogic.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 May 2026 09:54:26 -0400
X-Gm-Features: AVHnY4J2Sd7UZfh0MiKm-T6LLODA8vMkE2PiM0QATsX5evkAtLSdiKNaFo74ywo
Message-ID: <CABBYNZ+b1s95Y_VRE7fq27L74X_QnuJhPezrjM3DFQLO5=w=hQ@mail.gmail.com>
Subject: Re: [SECURITY] BlueZ sdp.c signed integer underflow in SDP sequence
 parsing (8.1 HIGH)
To: admin <admin@fluentlogic.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 4, 2026 at 9:51=E2=80=AFAM admin <admin@fluentlogic.org> wrote:
>
>
>   To: Luiz Augusto von Dentz
>   Cc: linux-bluetooth@vger.kernel.org
>   Subject: Re: [SECURITY] BlueZ sdp.c signed integer underflow in SDP seq=
uence parsing
>
>   =E2=96=8E Yes, I'd like to send a fix.
>
>   Here it is =E2=80=94 single-hunk patch, no indentation changes:
>
>   From: Martin Brodeur <admin@fluentlogic.org>
>   Subject: [PATCH] sdp: fix signed integer overflow in sdp_extract_seqtyp=
e()
>
>   bt_get_be32() returns uint32_t. Assigning directly to the int *size  pa=
rameter sign-extends values greater than INT_MAX to negative, which bypasse=
s the sequence-length sanity checks in extract_seq() and  sdp_extract_pdu()=
 callers.
>
>   Store the result in a uint32_t first and return an error if the value  =
exceeds INT_MAX. This closes the residual paths not covered by  commit 31e4=
fb1.
>
>   Reported-by: Martin Brodeur <admin@fluentlogic.org>
>   ---
>    lib/bluetooth/sdp.c | 10 +++++++++-
>    1 file changed, 9 insertions(+), 1 deletion(-)
>
>   @@ -1249,7 +1249,15 @@ int sdp_extract_seqtype(...)
>                         return 0;
>                 }
>   -             *size =3D bt_get_be32(buf);
>   +             {
>   +                     uint32_t val32 =3D bt_get_be32(buf);
>   +
>   +                     if (val32 > INT_MAX) {
>   +                             SDPERR("Sequence length overflow");
>   +                             return 0;
>   +                     }
>   +                     *size =3D (int) val32;
>   +             }
>                 scanned +=3D sizeof(uint32_t);
>
>   ---
>   The full .patch file is at /tmp/0001-sdp-fix-signed-integer-overflow.pa=
tch

Please do follow the instructions:

https://github.com/bluez/bluez/blob/master/HACKING#L98
