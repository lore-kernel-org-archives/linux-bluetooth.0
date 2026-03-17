Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF453E92B2
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760373; cv=pass; b=l6d7l9SmoTwPMjh+aVoYGcBOLzxKJjQZYtRcxqJrHYIJQYrbCUo+LWagjYsl/dKr5abWDx8GTxT2SNX3KcRGsXO2htFGBcf3ZiSNV3CX5c+l6Srffnu8bxabCb8Hs++BrflN1aU4DTyaU8HUKcVLSKaubv+jYjGimK4nFy+A3p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760373; c=relaxed/simple;
	bh=+HDVmbMSA69qLi9QQPBjAVGPk7xACyJBX+5KURRokDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1rmdiOBJRUgg3c4UH6Y877sSkpyuXQsX1m0zTVwLIwAykgXR+rrQzVcgfumKvDxZfPr2558+2kJjL8N4O2TaVoXnKny9qyktLQ4iDJg1SLxLjGlBKmh4RFoYHdQ8+XyKKNo6U3eypDEuLKYVSPNf1wxjDo5B+cHg1YawCGMFxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSCTTU8+; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSCTTU8+"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad79df972so6253587d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 08:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773760371; cv=none;
        d=google.com; s=arc-20240605;
        b=Ma/BFJMESpoagcH3nMnAqrVXuLBhzl/smzrMUuBtpIQwzO++HVnG1SdtUBTp56GZ4j
         mqKQbkstmoQXhFqeAGtJGIg+hdLg6Rm36FHWNw6AMhxoKMazeMXdJLNEh5XHdhm0CB/P
         bHByLUoeEYxzYgLu60AutC3bR4SKyMCwKKqQJ7nr4Nxmg8xroahcWyc4TLDCGoVeuhpK
         ocuvFNliiS9f1GLXn7ZHrvMRZitMPyN7N1/SnFsPmoUkqoF/nGELBPsOpllkoIIw7BBg
         efsu3HCdVjToZUmqe0SRiXjA0190cH75ZCoNH1WpCYfUVoKF4C58vYEp8qKJn9zjOm2Y
         kT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+HDVmbMSA69qLi9QQPBjAVGPk7xACyJBX+5KURRokDI=;
        fh=Tfo6SRjJgZlUEoBxJz62CU2SiEXUQZJ4G4jsjgHMGS0=;
        b=U92o63VTywviPc8XNgNqNsBWlrKoGsXEO/ql6hIbqOWmMlPF2us4+BRsi2nJclQZmy
         2ZlD0pMzFhQz8Aypudu5Ja/GhzhBRmp6Ip2h1iBL4K/ULbXojDY09KR04sOia22nAl7m
         Uy+4wWY2eFZfuCw7XtFgZEIDwd8w7SnTPEiQKau4r1KEMMRIxukfEOy/p7az88SAOKE/
         LiQTgtGL8hki1HSl0raaqE2XWTrINhZI1NqF6hSq7qegIARGqGFEt3tZDZ2V6RquWLRB
         IhLki9FF6XCGw8JQCc4RzXMUri23VYt9bANJCjv84P+aDcrSvHl27w0PxNpD8Wbi1fSj
         mWjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773760371; x=1774365171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HDVmbMSA69qLi9QQPBjAVGPk7xACyJBX+5KURRokDI=;
        b=SSCTTU8+t1dv6rF1LDyseaR4J1Z/FiKsiRwzbUPEDQ3FQvAV1HGwUTuFHspySXTs6d
         G8xjRGNTbrn+UqMNpyCfedxJExJDD2k8DGjAFqH2y9QAN5DlexcSh2BVuS/vWc97uKVJ
         UFtxeNkcc1FH9+R74JnLoUVjale9x1UQrRZvj6bK6j93TavuvDJvFtepBId1EXkknnwd
         M0D8JRo2jiCqzHMT1vJiZlyzGMXiUTi2CY1SSj6HcbQ9ZCyD+wgs31FQ6xrN3BqFzE2s
         Eu9I0q9CCvvWXh4wrHIowx0EMFI0NXYU/MjngD6F+lAtMJHFnuH74PXdSgB6Sp5wFPwZ
         TqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760371; x=1774365171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+HDVmbMSA69qLi9QQPBjAVGPk7xACyJBX+5KURRokDI=;
        b=R86peO/lXFAFxptk9awTH5AMzW7pBxiCX5PB7j2ylCuPYT9zJbd7HYEAf1tRj2TyZa
         bAkQACaqcaAK0hPywtjL6jsWfQvgELtriKAriEoJorHN6Zxhuym0IU4g0Y+lFWRq8Ry+
         6QiQieG4qLnqKGeorIehHM4K3+6mmBEgrCnRvC0/CLzx3rFExiY5u+NlbrPSohmHxL1d
         36m+lYcsaFHhFmuU4E0ssBSjuLZs9c6ex8yryypMwA/ahJyuAWcI7G1RKO8Z8bPKwJZI
         XzJOYtyABqw4aN9gSCSfHh6HY6vWq4en8peqxwIZ2CkZUrWSZiyH0mlZt0vVV8ZijJYR
         s+7A==
X-Gm-Message-State: AOJu0YyLNV5pA9wjy1gIVM4OQqnPyNpN+bUyj9vT9S/TktI4c5AcP4zk
	063nCqq7EoJ5d5cXOB6gooRrgvTWxSK+2jqlNzI51VLjSJiTsKbM0nke13D8MaBG7ZjcdMz3WTC
	8ij6gTDHHwdDkjKiorD6PdLEZoEQ1RE0=
X-Gm-Gg: ATEYQzwQOzBPAhxJeVs051rRxdvN8M5b2lD2XP4xKPg0GoW7nVDBJrxq+IAh6bb6MHe
	o4dSPDp7ykHakZedKIrC2YsPy/Wcqq7sn2dlHF+w9DG0jzCrx9/J6hmrKu/AL+lcb3t54oYq5NT
	tXVzGLeRNbzKRJBzGkKyJAbr8oE+RAju8pbAsEPrVFWheAXeSt52d8CTyyuCSTvJgQlKEzb+J7Y
	jEHOWE0H2koY8Zeqes4bJlijNhzbYByJTfWmVLTOGnBI7Zvo1Jm7heO89v3XNFDA5ZF2K06gMlY
	4cGPMmCTpqI6BsgX3GPceLTtH0Q2SC5aKqqU+zOkgbZkI+yNHNmepbKF6UaAg9Tav4g=
X-Received: by 2002:a53:b1ca:0:b0:649:b468:d8b5 with SMTP id
 956f58d0204a3-64e9134aa8dmr15412d50.29.1773760371099; Tue, 17 Mar 2026
 08:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZL3W4+eF5ap7dS9ZSPmYkTLgmAEJ0H=OkC04x0LfXuqLA@mail.gmail.com>
 <20260315194407.13904-1-joanbrugueram@gmail.com> <CABBYNZ+reKNjLhs5f_xjqdDP-jz3jjkoDpm67XUOw7QUjhKTmA@mail.gmail.com>
 <18e6418b-9df8-46fd-87b1-d6bbae63f616@leemhuis.info>
In-Reply-To: <18e6418b-9df8-46fd-87b1-d6bbae63f616@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Mar 2026 11:12:39 -0400
X-Gm-Features: AaiRm51xz3vgrUDb0VEe1gybjvdBtTcYAUL2mVVv8fo4FDNiNlFMMEcsDfD2sg0
Message-ID: <CABBYNZLuDviAwqvKKidB3413Rzq+vfuiHU_sa5wfyOO5KOYOKA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Joan_Bruguera_Mic=C3=B3?= <joanbrugueram@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Tue, Mar 17, 2026 at 10:18=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> CCing the net maintainers because this is a regression that Linus afaics
> would like to have seen fixed by now.
>
> On 3/16/26 14:37, Luiz Augusto von Dentz wrote:
> > On Sun, Mar 15, 2026 at 3:44=E2=80=AFPM Joan Bruguera Mic=C3=B3
> > <joanbrugueram@gmail.com> wrote:
> >>>> I had trouble connecting my Bluetooth headphones on Linux 7.0-rc1,
> >>>> and a bisect landed me on this commit 6c3ea155e5ee. A revert fixes i=
t.
>
> Side note: there is now a third report where the reporter confirmed that
> reverting this patch (6c3ea155e5ee3e ("Bluetooth: L2CAP: Fix not
> tracking outstanding TX ident") [v7.0-rc1]) fixes the issue:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221177
>
> But I'm writing for another reason:
>
> Luiz, does it look like a fix will become available really soon now? If
> not, I wonder if we should just revert the culprit at this point (and
> reapply a improved change for 7.1), as the regression was first reported
> on 2026-02-22 =E2=80=93 so we are way beyond the ""rule of thumb should
> generally be "[fix regressions] within a week", preferably before the
> next rc."" that Linus recently mentioned:
> https://www.kernel.org/doc/html/next/process/handling-regressions.html#on=
-how-quickly-regressions-should-be-fixed

`idr_alloc_cyclic` is not compatible with `struct ida`, and changing
it to use `struct idr` will probably require reintroducing a lock
since the `idr_` functions appear unsafe to run in any context as the
`ida` versions.


--=20
Luiz Augusto von Dentz
