Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E42144A5
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994684; cv=none; b=QRNpv2sd4v5Z72Pa1557JaQ3lYWA2W0v2SbFl960YRW3F9H/wIdFr3tWrahCaX1IzSQaXZC3XcwjkNZ5COCOmU17f9W4u5CXCdsW6GxkiR+nRbLaCdtycd481rjPXxzRStnwIVHCQwP8kcgLLJcv1Yw+MfU/AmufEv/RBhj6Hg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994684; c=relaxed/simple;
	bh=4IllMvPf7AO+WxKEXzCoTY863WBK3ECX2mrtcD/sr1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4iciimqBubqjvee5H4IDcZhSza2bITyvQkMdaMvrStiBobRbAvHwWLUrv+Fli+DeB8d8VDK7YyRL2zN+56/L1H61WkJ+5pKZ0Y3xAbXowf7aIXalpCY8m2LK+wlORU+YVAO8zqvJR4uFwbjXhlG2Yi41OjCZ9nPB48MnVv8xxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcNppU4z; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcNppU4z"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso1019571e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Nov 2024 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730994680; x=1731599480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IllMvPf7AO+WxKEXzCoTY863WBK3ECX2mrtcD/sr1Q=;
        b=HcNppU4zgE+wWuNF682NIPYmoXExvn43IKcG5mu8x4YnjqvwkM/59htmSw/YphL7d5
         jdPZHnVgL8+4S8IBKVmRj1uqjyuzqkAuw6tTWfkXdcurAfZ7h1EhtrUyE17+aI7GVugj
         9pR360drn9vnCZGFqeoJ4Ew/nis6EnZyJnZ5Cvtz3vgqHBI5w1yNcgIVCm8r4XTqzh77
         AngONSr7rBI5X6M2SEb8obZ2HPEZWn4IZA8VRZsWjV7YqPl8pxssnomAkDlUW0WCiQbe
         +2kyfnO3PK9ztgsbs21JTTYhBaTe1Wp7yTtOEI3Qun+hoqic4fDslgwx6HavjFd7Srtx
         oV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730994680; x=1731599480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IllMvPf7AO+WxKEXzCoTY863WBK3ECX2mrtcD/sr1Q=;
        b=Q0+lD+cYckAxE7Zxj87JmcQ/vxVLIiJ0lcNlPl85BxPHzb+LqYc1iK0o/bhDY8BAtJ
         HHILb8Tqfi4Ha3Qmck32h8NHtAfvkM8SLMGfzGIlJzPktn3uMCIRXJoEjYby9+35eySb
         hQ3re4tt6iJX8PWiBDzPeu6jAVD/8NO/dLjoobZwJY+LivXJcuB4DZATiVvZ0vgLDiyf
         bpmB3GJ8EB/PIqn8JBkqWgwdHFg1b9P1qsjUFbLZ7gh92VZMal35kt0umWU9V1DwJenY
         Ljax9Ce8h1ENse/uM31+oRLPT3cjBB/eAFEaXdSUTL25c8UQrCHJwxrhDoKR3MssJZnp
         qUew==
X-Gm-Message-State: AOJu0YyL0LGp2eR12CE2ckbEZOwinAnsrM9C/0CaThCM9TkygTNkpwA0
	ifCJ8c5paZPRABBX1M/ENrjueDp5ixRMaDmoLqXukT+FPjbBcwdy1SbgO6aGL8fa1uuSQFshzbt
	nDOtDoZ5l4+ykQC82srov+7lBUn/16yZq
X-Google-Smtp-Source: AGHT+IG0Gi4ZwFkVuq30f/QB54X+Ve57ATcV8jNlJkJRK4yNlcRiiiD+CS/qCSlcmZK0H5eNECYuMDFYCYfLbIJcAbQ=
X-Received: by 2002:a05:651c:b06:b0:2fa:c59d:1af3 with SMTP id
 38308e7fff4ca-2ff1e8d8f52mr3727901fa.20.1730994679351; Thu, 07 Nov 2024
 07:51:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107102628.537015-1-quic_dgangire@quicinc.com> <672c9925.620a0220.6fccb.2907@mx.google.com>
In-Reply-To: <672c9925.620a0220.6fccb.2907@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 7 Nov 2024 10:51:06 -0500
Message-ID: <CABBYNZJPHjZQMcvK1OS0VJs-kFRYrASndJ4ZC6saCDh+gqmvLA@mail.gmail.com>
Subject: Re: [BlueZ,v6] obexd: Add system bus support for obexd
To: linux-bluetooth@vger.kernel.org
Cc: quic_dgangire@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 7, 2024 at 5:40=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be appli=
ed to the current HEAD of the repository.
>
> ----- Output -----
>
> error: patch failed: Makefile.am:39
> error: Makefile.am: patch does not apply
> error: patch failed: obexd/client/ftp.c:19
> error: obexd/client/ftp.c: patch does not apply
> error: patch failed: obexd/client/map.c:27
> error: obexd/client/map.c: patch does not apply
> error: patch failed: obexd/client/opp.c:17
> error: obexd/client/opp.c: patch does not apply
> error: patch failed: obexd/client/pbap.c:27
> error: obexd/client/pbap.c: patch does not apply
> error: patch failed: obexd/client/session.c:27
> error: obexd/client/session.c: patch does not apply
> error: patch failed: obexd/client/sync.c:21
> error: obexd/client/sync.c: patch does not apply
> error: patch failed: obexd/plugins/pcsuite.c:322
> error: obexd/plugins/pcsuite.c: patch does not apply
> error: patch failed: obexd/src/main.c:41
> error: obexd/src/main.c: patch does not apply
> error: patch failed: obexd/src/manager.c:488
> error: obexd/src/manager.c: patch does not apply
> error: obexd/src/obex.conf: already exists in index
> error: patch failed: obexd/src/obexd.h:8
> error: obexd/src/obexd.h: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.

These changes has already been applied:

https://github.com/bluez/bluez/commit/002ee180b1b5c17989e197ee0b77cdcac5a5e=
f6e

>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
