Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62796215F7D
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605220; cv=none; b=TLuUYRd+jTKV9eti/m2neCePx7dOLGE3vi2n72aB2CnYOL3Gn+wN/9Z5argo9dP90f1hVx2hJHCclTlSIW3QL8qCYbyfssjfLOATAYAV1CEDe3Syp9jnQ7tw8n+kAlPtcJqNM7pZHQZIxBWSdUfN905WUimPhSJF5WLZ/914nSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605220; c=relaxed/simple;
	bh=ShraT/ycBj2nZBWqXisrh0Rkv57NXR3xoJHGp8homNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXjbYXZ/BiOEquUvMJ3IkuRRnMvbXi0G67QbVJ76DvDdqklSscIpsjNKRPt9Tf/7J1c0P7F16Pk7/zNSt3P6CrGHOyBKSmEJbHLCNWPwYi6rKunNFeWKrcbELR3/H6KRN0IZIs++wXbDkwcFq5tGWbW046eqG0OGgNcRbZbsN2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGXo38ph; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGXo38ph"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso24972011fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745605215; x=1746210015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMke1zJlfzHfqAOlFLYgmiWCPNk9C4fZh9wGl2/FhQ4=;
        b=mGXo38phAnqx78xLAg2Ca0toLUUKfV//3GQz5Ls9Agrp8A9hXCGTQFkh1jGf86RK11
         +MoxZ50gDfRjacS3rKhM7BKrJJTEnnzyoNIZcCNQ51talYHfFHWQ1R8SzNN7/Ar54EvT
         40caqud0D8l1hjICdF8KqAr5WZwUb1bZGvSCXb7WHZQ0kA16CQp1nVLfpcEnV6QF5nWt
         MDLkhidMeQTjRDU5//OAEScRsVVfpR5PGhRJfIHJRoGmtuEPYwgxVkzFDNl+Km6dZlza
         9u6e0gCGELMrpKrZ8cB99naxbBc5bG8XpMAltUWj89J8tucBVDdhBTpWWMXw6Ysn0LFc
         yJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745605215; x=1746210015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMke1zJlfzHfqAOlFLYgmiWCPNk9C4fZh9wGl2/FhQ4=;
        b=TyhXt5FnnlWlldrwxQZ3qpc4y6IpROhuygkRZekpWReXFgmJMPCwynyljgPTySqTlH
         RPaQ1RHGqDdUeChz+9H5ninFYI3ZVamaLdrOqjomASoCE+vP4zmj9lvn61BLAXdAAr34
         hVBN6j+tHhyatSTN83vCSjMNtgZBSGlVQyUIGJyZBLL+6PsTp0HbLPLVCrjbDc08Kpt+
         cIMsxYvoYmijsvK4r6WYQz3Lw2mh0v1HFef+P+GpYGx0S9IRZGLSog4y30cWW6b18i9/
         j4sfU50jmzVQy1O2fvBewECBPaLizYcImV9XQy2FnAgdFbVIOy7TnTbrLt4xcXG/Rrtl
         j6XA==
X-Gm-Message-State: AOJu0Yz+1s5HbwalRv6hEi243QfjvYGkI7bh0YbwlQLEuKDRBLQMwAOd
	PrStuNsC9yrh8ZTIJ0VnJniRr5krC3t+IeuX8CcNcEU1t0OvDmjgfBXzGU+3pC410HR+UB1Pd7o
	lGMBNyDgR+v0q6jAwnmhAygbuNvaLBXTnwe/TDw==
X-Gm-Gg: ASbGnctkQ3zGvXq5bLlJuXSoWSvlncqnKIq8HvJmJMMKThyMIPEqtr18GForPkQqhju
	NjVoRicV8ibX+TQ0ZEWd8jv6ciep+CrXsv8z3NPHb9p1OCpKJMV8iNN+md6jLuC+2KlxMt/JulF
	Tkg7K7I2pFsd59J64NEJy8
X-Google-Smtp-Source: AGHT+IG8l4anTsRrJCAMJrscIFJyxB35TUqIKM8O3yAVI4et+THW/dkb+fJtYND6eCA0GIezc0gv99yiIG/UI84LCmM=
X-Received: by 2002:a05:651c:1463:b0:30b:ec4d:e5df with SMTP id
 38308e7fff4ca-319ddd6681emr940521fa.34.1745605215057; Fri, 25 Apr 2025
 11:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425171505.573271-1-kernel.org@pileofstuff.org>
In-Reply-To: <20250425171505.573271-1-kernel.org@pileofstuff.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 25 Apr 2025 14:20:03 -0400
X-Gm-Features: ATxdqUFuytn8stJ-0ObWNESGIf40vHMkruJPXx63bx_D6sPRwl8qlBLTi0V4e_8
Message-ID: <CABBYNZLb+GrBEiy8VaQDAGtxcRqn6wUweaxXu7mD6ti4VoTeKw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/4] obexd: unregister profiles when the user is inactive
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Apr 25, 2025 at 1:15=E2=80=AFPM Andrew Sayers
<kernel.org@pileofstuff.org> wrote:
>
> This is a follow-up to "obexd: only run one instance at once".
> Instead of refusing to run parallel services, it unregisters
> profiles when the user is inactive.  This avoids the need
> for tmpfiles, and avoids issues where the user with the
> obex service logs out, leaving obex disabled altogether.
>
> Luiz previously suggested moving this to systemd, but I haven't had much
> luck getting the systemd devs to accept changes, and Pauli's mention of
> elogind (i.e. logind without systemd) suggests it's probably better
> to avoid the dependency anyway.
>
> I considered writing a separate D-Bus service that would notify you
> when the session became (in)active, but D-Bus doesn't have particularly
> strong guarantees about how long messages take to deliver, which could
> lead to race conditions between instances on overloaded systems.
>
> I also considered writing some kind of library, but there's not much
> code to deduplicate, and most of it would need to be reworked for every
> service that uses it.  So I wrote a gist for people to copy/paste:
>
> https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e
>
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>
> V1 -> V2 Open/close private DBus connections instead of
>           calling UnregisterProfile (thanks Pauli Virtanen)
>          Add obex_setup_dbus_connection_private() (to enable the above)
>          Fix CI errors
>          Minor issues I missed last time:
>            * s/regster/register/ in e-mail subject lines
>            * s/login_.*_cb/logind_$1_cb/g in logind.[ch]
>            * remove watches on exit in pbap.c and bluetooth.c
>
> Andrew Sayers (5):
>       pbap: Support calling pbap_init() after pbap_exit()
>       obexd/bluetooth: Support calling bluetooth_init() after bluetooth_e=
xit()
>       obexd: Support creating private system/session bus connections
>       obexd: Unregister profiles when the user is inactive
>       Revert "obexd: only run one instance at once"
>
>  Makefile.obexd            |  10 ++
>  obexd/client/pbap.c       |  33 ++++++-
>  obexd/plugins/bluetooth.c |  30 +++++-
>  obexd/src/logind.c        | 245 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  obexd/src/logind.h        |  26 +++++
>  obexd/src/main.c          |  12 +++
>  obexd/src/obex.service.in |   9 --
>  obexd/src/obexd.h         |   2 +
>  8 files changed, 349 insertions(+), 18 deletions(-)

Seems that the coding style is not quite right:

https://github.com/bluez/bluez/actions/runs/14670164969/job/41174608664?pr=
=3D1198

I'm adding .clang-format and .editorconfig in order to make it simpler
for linters and editor to detect the coding style automatically.

--=20
Luiz Augusto von Dentz
