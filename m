Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478B509F01
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902303; cv=pass; b=rdO381XQyVsqyu67taBMhnkW4DeslvyDd+5q228E3PFHNeINfzvOGC8nvK/SfzuWZuk6JMx1qe4H7VN46CNqhq1D1fiRb8ImuG0Jj1reA4SfbZvNWeDZnisNeesrJow9xEcXlASXHzTVO7ym88o5KCWpIHys2ErXELvepCEquwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902303; c=relaxed/simple;
	bh=RbSjUQCsPJ1GB9PoxGtOVzybu2SY4MsN5p2cxCLc9iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQ2rwQq0FBcxNeO2L9HI0s72aQPOwmt5UhNfA4i6g84E+5xVbHrLfWG/lkxPOJ9DegM9wxYwQI57rpZ0kD7uLd5O0f/UkhPHjRbepEDcXZMUYqaetg0zajcaAspe7K+6k1p9zPFVr9wRI3+J5xVE2BrebM9hoY/qd4fUbyhjVVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9tuFAt5; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9tuFAt5"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0703011c2so22721607b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 07:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791902301; cv=none;
        d=google.com; s=arc-20260327;
        b=GghM0EuqmFbsWFsKO2CrQrz9BaFUcDVo91Dngu+FSP4rCu8jQc8cOcmLhif+lcBzur
         WhqP8MUd5SIyPgkux7Y10y7ahUi0jiKsO6pM2aJx0FumYzIQeKOC1dA/F2C7kMHglbg+
         QPim1EVHe0DJNAuKL7OEyesdBMaBMeyWBD3oqFKwl6Wdifk3hv6S9diIQKtD8TlsAIld
         IOo37namPVqOMXNTqpHPlT1SdMkIQZ2WBp96EhksyyH2q3ozuJxVWd5tsPo2J0UHZJJb
         z4YMWtpJA8ID8G6a+IMRwah+B5Xv4ifRcz9EfKOBdMbTbHXHKs3abCofN+U5Y2rV2+4T
         2ukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UZvfucgE3y3Sdudr/dL/bVu22Dv23ASShFKdCR0HD50=;
        fh=bAf3uaujpCfZ+gfuJE9eD1gL5QYFdHZrAlQVfG7eWXo=;
        b=SwcxrwIuAGOZE4OxV421Tl9gFmMf08X1eMU0Sf2wZuekxrFDBfPcCy549YlE/q3JAS
         L9a4lbbSuIDB2I1SSYdi88DHxnyu3zrbHHFQ4uRNWCeyNh8pxxOxiaDSWfhgU1MqTO+K
         /1lYgOhaa74v4fbezHXPWAt8p58ydVoiYTO/R+owFNYzZTFdTBrReQlaAxeFymIlUx+l
         9A+gx8eZVLMpmpD2EbBOZlhJjf0Y5K9TxFifmvzXDdIr3r2LxvR0lHGNnGmdNd0fnLEI
         C7iYt7L8gHuN0T9k3q1DwG0KwCf2gNzR7/AgDjpH+ONVkEmH+cQ9fD6Bg1ZTEY5I/LOh
         4tmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902301; x=1792507101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UZvfucgE3y3Sdudr/dL/bVu22Dv23ASShFKdCR0HD50=;
        b=O9tuFAt5Difg6tUKGDz2athBTHnExpqxFbg3BdwCNE9MHiUoyH7A75fewTjCe0NjOJ
         MuBWZ2VzBRnWzO2m8d9oUIzPVxuRjW2b/+VC8B+fFmdfj0icIjByP42QhM/2m0XLhWYZ
         rB0l0z46Dga8svC5Lvo2ayxhBlLhasCh/ii9+tVyDaBjBAiKp2fjUOC3By1iuWReUygU
         kto2RFqbGsc3Q0KhlBgkV2O2ecsIxO2pi4O0uooVvUtRO2t47lNluuN+/llHim4dK98b
         rjLHpAUOeCvRanWbdv9/ts4gh/9cqloxMCg2xo76qBDfmAu8Wvs/67GlqHFSSpKWGh1q
         iyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902301; x=1792507101;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UZvfucgE3y3Sdudr/dL/bVu22Dv23ASShFKdCR0HD50=;
        b=yAwfrQO68hSo136CEZAn5BKjCtUSYoDkPkd0ZVyr+tM51PK8++v2bxsYeoCGNUvC4t
         splRK/GXyZerXMmRhdswt+wAVAhPN5ncL/JDbucaXDEt3psDFeD7P2m7s9LrGJvvOBf+
         QOZmXS4Uy0237NK0nkwAZRkOl0OD2Syg8cYnDE33ya3ZuPlqJF4YEl3T4/0KkjOScYk/
         TOcZE4v0kDJ41UQYj2NkhAacX+veTZoXSKa1ql95JAuzsFSB0c6Y3FN+rh/WDaTpen/T
         BAt5BVvLcx5z2WkYIhF73RbyebnHeYgYoJ3YNv0rzZBEhJouxpltaDlo4RkBWMLP5Vp3
         sEgw==
X-Gm-Message-State: AFq9FYL8PXhilWkeDlS/6iU3/h/NHCgZcCIz9jpnqY5x/5m4TiGF7LhP
	2HadjN3tETIJGF2FpdGwahoZMgb+1PQqoVrOjSyuX33JKkXxLBt880FYzz5tF10xxj9k/5ViLpH
	LJ06eZLQNbpjCyHKGzAcRJ4qoIh70sK0lJw==
X-Gm-Gg: AYBFou3X1KubxNGZ6RstKmoX8njlmdTahVt5sd45D5kybQwpdcn4KUY9TMHdCSBIxlR
	c1bCVJYXsuWeJE93g99SS4uOnqpk/I/Y478qrZkX6BwuoEhwsRKHYIfCr+6hxhQ9/RLgDRkWSGM
	Y1CIzUKhSNWKaGIwBgR5QtlW1CUZ6pucvORluEXfGBtbOxb9Wzg+EDrPYkL/VZ3jOcFjyOu22JX
	YvNHMFDwU5AiESePKnO4y8XiM2etFsgyxp7EtsFv0FGOVue1qBVlnAXMfhOBBtX3mJGW41+MlQU
	ssWLnY2T1uyJRyfFMGAiiXRgasw0wXmBVt1sYHvlFgGjJGCEnWvP4fgOaIlD/04UKUZUNBIWinq
	YkwAjrLZDN5atJGiKhXHXCJmQU9IROYQK8FdSJP8Tug==
X-Received: by 2002:a05:690c:389:b0:8a8:889d:2ec with SMTP id
 00721157ae682-8b07f0b050bmr42706887b3.65.1791902301375; Tue, 13 Oct 2026
 07:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013031329.483597-1-cochcoder@proton.me>
In-Reply-To: <20261013031329.483597-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Oct 2026 10:38:09 -0400
X-Gm-Features: AclHuK9v335onbua_Lc-ycuPInqEsyDVYv4IJ7Fyi6VC3eSDAeTiuVVQlWdv9_Y
Message-ID: <CABBYNZJsTEdKnY2V=gpn+HpVJ4dmS7j2vmi+BDV_Okm2ZZRNkg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Mon, Oct 12, 2026 at 11:13=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> =
wrote:
>
> On controllers without LL Privacy, the accept list cannot match a bonded
> peer identity against the peer Resolvable Private Address. Background
> scans using the accept-list filter therefore hide those advertisements
> from host-side address resolution and auto-connect never starts.
>
> When a pending peer has an IRK but controller-side resolution is
> unavailable, use unfiltered scanning while the host is awake. Keep
> accept-list filtering during suspend, where host-side resolution cannot
> run.
>
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> Submission review notes (not part of the commit message):
> The downstream N8/UB500 recovers an ACL link after range loss.
> No patch-off comparison or changed-RPA necessity test was supplied.
> Do not equate link reconnection with automatic audio/application resume.
> Privacy-capable and suspend/wake regressions remain coverage gaps.
>
>  net/bluetooth/hci_sync.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index efbd2e538..d0fbb3e08 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2907,6 +2907,7 @@ static u8 hci_update_accept_list_sync(struct hci_de=
v *hdev)
>         struct bdaddr_list *b, *t;
>         u8 num_entries =3D 0;
>         bool pend_conn, pend_report;
> +       bool rpa_no_llp =3D false;
>         u8 filter_policy;
>         size_t i, n;
>         int err;
> @@ -3025,6 +3026,17 @@ static u8 hci_update_accept_list_sync(struct hci_d=
ev *hdev)
>                         kvfree(params);
>                         goto done;
>                 }
> +
> +               /* A bonded peer that advertises with a Resolvable Privat=
e
> +                * Address can only be matched by the controller's accept=
 list
> +                * if the controller can resolve addresses itself (LL Pri=
vacy).
> +                * When it cannot, note the peer so the scan below can fa=
ll back
> +                * to host-side resolution instead of accept list filteri=
ng.
> +                */
> +               if (!ll_privacy_capable(hdev) &&
> +                   hci_find_irk_by_addr(hdev, &params[i].addr,
> +                                        params[i].addr_type))
> +                       rpa_no_llp =3D true;
>         }
>
>         kvfree(params);
> @@ -3047,6 +3059,11 @@ static u8 hci_update_accept_list_sync(struct hci_d=
ev *hdev)
>                         kvfree(params);
>                         goto done;
>                 }
> +
> +               if (!ll_privacy_capable(hdev) &&
> +                   hci_find_irk_by_addr(hdev, &params[i].addr,
> +                                        params[i].addr_type))
> +                       rpa_no_llp =3D true;
>         }
>
>         kvfree(params);
> @@ -3061,6 +3078,16 @@ static u8 hci_update_accept_list_sync(struct hci_d=
ev *hdev)
>             hdev->interleave_scan_state !=3D INTERLEAVE_SCAN_ALLOWLIST)
>                 err =3D -EINVAL;
>
> +       /* If a pending peer advertises with an RPA but the controller ca=
nnot
> +        * resolve addresses (no LL Privacy), accept list filtering would=
 drop
> +        * its resolvable adverts and it could never be reconnected. Scan
> +        * unfiltered instead so the host resolves the RPA in software an=
d
> +        * triggers the connection (see process_adv_report()). Skipped wh=
ile
> +        * suspended, where host-side resolution is not available.
> +        */
> +       if (rpa_no_llp && !hdev->suspended)
> +               err =3D -EINVAL;

Weird, I thought we already captured this case. Perhaps there is a bug
in the code if AI is still flagging it as unsupported. Anyway we need
to mgmt-tester to confirm it.

>  done:
>         filter_policy =3D err ? 0x00 : 0x01;
>
>
> base-commit: 964430c038967fd06643e866f68115664e1a1bd1
>


--=20
Luiz Augusto von Dentz
