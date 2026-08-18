Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC243CEED
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076537; cv=pass; b=hPzHldkgk7N14HUzO8SgT3xkBmV30anTLFVN3OZWun7n9cniLe7Ey1ygX2H0nKxqgWfjNusDbetRi2Ynt8WLsW9/ZMKh+lTIRVqJQYqka0z/RgWjEnNRz2wAvjbIhGx7o6If5LCfWuvMQJPGOe809xRNPjtWyZqVGHypUbXOGPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076537; c=relaxed/simple;
	bh=SEUySfRaQtbQd7ONSCax+h6nByvImRHhLqI63bO+18Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNUiOOucIt5V7tNXTeR7bATMU1z2lk713lEvcrj/Y3EKerKIp2DbmsphsIX3oLeVA9YznL7zWRwELieBcn8EEJ+DbtzA1/KrueDVcQLNINiPHHdYFdafuLN0tlVk8RJblqRtmuXdr3nXsDQ0wuLrJjVkOijLcuES/JamTznidGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkdlVUgl; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkdlVUgl"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-836eac5682bso1373757b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 11:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787076535; cv=none;
        d=google.com; s=arc-20260327;
        b=GMZX8biYKOQBVTlX8k4Mmtn84rnav896nLiVPCkBBDdm/EdjBkW0/6TaoAP4ue9l+u
         /mMQ5HWlLDzFT6dbpCHEeK6B6YcnDiedy+fajmLjrks/VuBTbRlqtOlsGtLHmo5IaiAz
         i9UksKGz+Z9mpwkwKOAAohLL7uc6CN/un0pW5UsWsKJrkfyXydk3YTo+EtcJi+ttiK0O
         w5M94ZocMgcD8OqOF2zg0lH4BzYHcOLS//Fuqcw4NecTM+oky/tSIBj9NF/f0xFh7SVN
         PGuiYp6ebG4IttntiY/uHmiR31FaC6OJ1k717f82xlkAcCvRA3rZFvNe6myCizggPRfl
         RsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2uqoXLdriDwngiEdIujJPR1d7VzbepHTpyozA2PyKQQ=;
        fh=3r5wukVUl7DT0M9rkP1SkUrHMvBAMeQCIdmYfp3ptAc=;
        b=gild8LXlFRHiww4duVeS79hDb9oVMg+PfGNF2YIjUkW/XK2KGkhh2cS5oIlupKIALA
         cqDxXJYZsGA2A7RE4iAs7RyXn4WgcpTfYiQ0W+l0MkXNtICVcjYKw8+ezAGzyxv726jw
         KrO2bIRUMIvUpto3H6h1SPfAXBlj3sGHhHtigB4DvdfUqyvUWF580AIeh28K896HS/Mo
         SfjhfGCmFABudifADyU1JV7gZhRNdxC9/5O85X/HaMVGXGWQGFu4b9VCHB07t7HcYP9l
         NY6QtBtFjeL08B1rPymKhj3OLTr1iPRdZx7+26Apg0yVcoHgWQL6cs9sshXRnsy92v23
         qa8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787076535; x=1787681335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2uqoXLdriDwngiEdIujJPR1d7VzbepHTpyozA2PyKQQ=;
        b=pkdlVUgl4tMtPE1utRsDlQCsi4ea7D36l+QK23WFlzYvzttqzevGnWmm6qOJsqYixm
         aqxsU2jxeDgeaH7pdmzzlg3i4UYh8bd7yTGx3/cR9Z6y8Dz0iHamrE+6j0VmFCdffPrl
         g5LVCKJeughLKb9bpSbnlBHG+9E/2JSUp4lYSoZSHlAxCAS0FjSnUwDoKz8Y0Rac9vLM
         ml/wmLJZCHpbp3ZuDzR3iu/ecdiTXgi22L6SVRpYCjp1tBh4W/f6tRePEe0nnUuViiMO
         +Qf5uG/gL5tjkTGOOT86Qoj05rA/VaAJb6BJ0U5g5qSiAkHXkOnaNC3NvhX2zwhh7wVb
         cG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076535; x=1787681335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2uqoXLdriDwngiEdIujJPR1d7VzbepHTpyozA2PyKQQ=;
        b=cTneJ0f9jHGKJxhFh6sm8Ix3BrWOJrGv8C8eHsvAbchSx61BA6jIitdNJhf5UldPqu
         Ckae0gipspvE7JUX9+pr1mLeMIS4zGIhWw31IkmtQoNa5JdFZW4FZFc0bk7CDl9XrfU0
         dQQWw16ILqIAavdgvPmh6NMQ2fwkwCLdHluqb7Oh+5B9mcsZAMttaZIaM+ONhZ9hUMyM
         lx/i51DLWpI7mUWqOAHP5wgotmCE/JYKmh6C1peMVqlkIuyBziIHcMbdI8GCkCc3e1Yk
         o7JntA1xppZPA7VqQqTvejL2WUwJaJIcURkkjp+6b+I79YkB/bGpSO1R00jq7xTd8xMu
         cV0Q==
X-Gm-Message-State: AOJu0YxyYJRUCJ8KYkjYrFL9bAuxUdatFG6GZyzDC6U5+kb6+7EpTHFv
	7BM85BrAcHnqk267UFcg2aT2/5HFYOR/4UCtbPo23nADQcO8nHUtEmBXK/9gBAlxKcRI/C8Zi0g
	hfO5zdZaHeeAMkDiJK7vzUQM6u0R12bA=
X-Gm-Gg: AR+sD13QqFHaUYujSi8xKpGPPQj4f56xv3kyKOmeFm7j9/IV36dyY9uW3/1NJqcwnaU
	eRtIbR4L4UgobhPk35yCBSNcw5sc9bAr/7AmKlT7yJKu9uDLREwK13J+T+CmBI5Xq1Kwsse/A8n
	hdqqeH4TSiG98TNaKxfUZOO84ZaiwolpR4qMFhmE43KIPNAIdT5H0zBDCiEwgwfwKUvQO6b6khD
	5xjbRCPgd44rbOVQIL/zxcdWrOF/fkwjnJifQ7+oNkaXv2Rqd1C6/3knVZDYXITXDkEf5dnlZrx
	zKqsvna7gk3CDfUega5Dv2IUyM/JaKUxewzIv+TzK7jUQJOoAgKnWwXSyKNyoXtb1gtYBtn6Svf
	MEj/8gpH9PTLW4vQVz2HA3xfvus7U/fY=
X-Received: by 2002:a05:690c:e649:10b0:7ef:9fd9:db07 with SMTP id
 00721157ae682-8449448428bmr482527b3.12.1787076535103; Tue, 18 Aug 2026
 11:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_1E12CBD7417A4019FF058EFD19B1DB930006@qq.com>
In-Reply-To: <tencent_1E12CBD7417A4019FF058EFD19B1DB930006@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Aug 2026 14:08:43 -0400
X-Gm-Features: AcwNN1UH_RpM9ZVjCPTTexQXLT4sspTvFco6Bzj2nGl1dnd4gH3a2pfhfNV5OR4
Message-ID: <CABBYNZL1_fTkwdhjK0aKqg44c0MneOAOWThQQDPudFUe0m_htA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: ISO: fix use-after-free of listener socket
 in iso_conn_ready
To: Hang Nan <2122295973@qq.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hang,

On Tue, Aug 18, 2026 at 7:33=E2=80=AFAM Hang Nan <2122295973@qq.com> wrote:
>
> iso_conn_ready() looks up the BIS listener socket with iso_get_sock(),
> which takes a reference, and then, without re-checking its state,
> creates a child socket from it:
>
>     parent =3D iso_get_sock(hdev, ...);
>     if (!parent)
>         return;
>
>     lock_sock(parent);
>     sk =3D iso_sock_alloc(sock_net(parent), NULL, BTPROTO_ISO, ...);
>     ...
>     iso_chan_add(conn, sk, parent);
>     ...
>     release_sock(parent);
>     sock_put(parent);
>
> If the listener socket is closed concurrently, between iso_get_sock()
> and lock_sock(), the reference taken by iso_get_sock() may be the last
> one: the close path drops the link-list reference, and once
> iso_conn_ready() drops its own reference at the end of the function the
> socket is freed.  The child socket, however, is already linked to the
> freed parent, and a later disconnect of the child runs iso_chan_del()
> -> bt_accept_unlink(), which dereferences the dangling parent pointer
> into the freed accept queue (a use-after-free).  The same dangling
> pointer is also dereferenced through parent->***() in
> iso_chan_del().
>
> Fix it the same way the connected (non-BIS) path was fixed in commit
> 0d255e63fcf3 ("Bluetooth: ISO: hold sk properly in iso_conn_ready"):
> after taking the socket lock, re-check that the parent is still a
> listening, alive socket, and bail out otherwise.
>
> Fixes: ccf74f2390d60 ("Bluetooth: Add BTPROTO_ISO socket type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hang Nan <2122295973@qq.com>
> ---
> Changes in v3:
> - Move the changelog below the "---" separator so it is not part
>   of the commit message
> - Shorten the comment in iso_conn_ready()
>
> Changes in v2:
> - Fix GitLint B3: replace hard tabs with spaces in the commit
>   message code snippet (no functional change)
>
>  net/bluetooth/iso.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index aa2ce78f56a2..069fc87a4e18 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2277,6 +2277,14 @@ static void iso_conn_ready(struct iso_conn *conn)
>
>                 lock_sock(parent);
>
> +               /* The listener may have been closed concurrently. */
> +               if (parent->sk_state !=3D BT_LISTEN ||
> +                   (parent, SOCK_ZAPPED)) {
> +                       release_sock_flagsock(parent);
> +                       sock_put(parent);
> +                       return;
> +               }

Looks like there is a typo and this should have been release_sock
rather than release_sock_flagsock (or there is a new function called
that introduced via some other tree?)

>                 sk =3D iso_sock_alloc(sock_net(parent), NULL,
>                                     BTPROTO_ISO, GFP_ATOMIC, 0);
>                 if (!sk) {
>


--=20
Luiz Augusto von Dentz
