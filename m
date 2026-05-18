Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D017DFE7
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066237; cv=pass; b=qkkxj/D/CLk2ANG23LAT9Y8bw9t9cG9jfmJr0qg4PUW1+HKRw5C+Wt/Db2TiKPjDMCmjBysCQxes9yssGfXHHSkeW39aEJgJJVZAxaTZedHlvir0tpGMpPfd4l6PFAkX+Xv9BUCEkSrXnY+whV5V4v8YtsMEd8VB9wm8VQnorF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066237; c=relaxed/simple;
	bh=utx9LGutwgSd8Hcjfc8gIyBXV0dK+4qA8MsZSzPpAvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKtdvMTPc8e2VjezPdJJeZC51vUT+vCncvYfi2NgsJiCkYDVMTJ+IqeYidPL+iwRRy6gluVjOI6Chdwd+4ZtZRPaXNuxF9xoYHeRF61ucp2c6UUofAsdr+GiB55dmbCkQoX7IWpEEvVvYnky2dmASkU0Apuumo/AYKph1fJmniA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9+gqi4s; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9+gqi4s"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651c366f7efso1828020d50.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 18:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779066235; cv=none;
        d=google.com; s=arc-20240605;
        b=NxLloU5FQ36EAGHQErqjLz2vW98y75eChHukkhfLkSiWG42m95cDA08XX5LaWVs7JK
         azWlIEy477GRLi3jyfaKEJLFchJTsQuI54GZJsiDNRgNbydIxHhqkAk4B0cLqCODYXz6
         zOq4lhxy1z1z7iaz35P2EEEaOjDC3s8JKu7lSkHj+LQfq0recUrtrKpAu0vNGvFu0bWX
         ovsNkTFXtgujVlPp0KWijyAFixFhqwnwseCBshvwCYtN+7wVBmIT7qt7GLtAie4HnQSh
         MBF4IDZ5ekQZ0pf05Rt6IsRvLkgaw5rjFZyKQGcAp5chR1TPfOS5MjVI/GDdvEx2ts9W
         2F7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=91x4En/yixttZsPqKMUGLJ+HDfp3MoNxeXIT7uGfHLU=;
        fh=2+BmNno+tUJGzmo49VuhN+L32Ek9bzM9xQkpcErEljA=;
        b=aWD8lyzVidyeobJd5lKgefnEHJPc0l6mDK4+pHQ1H2LWOwryoqT2Znplmx0gxUjYay
         0CHnxldS0q9LFg4ltwdL7Ll7dIlWDAVn3BAaZMHqTmDaO/cngMoW6j1KDiDNNY1un6QT
         R6hMPIAG/kwVuWA/L5N0Kj8aXnicJiKU5Th8PWAUP0kgNp6jajXbBSBSFusqHFrIOZf8
         LbxpUKR1OivD3qh4vpeMBHnxi6i5RBDUJ63KalTX9goWuzDuH2CYLrMO0NC+LpFPzaTA
         XmKwjXPCKs8PcibZU5aKL37NHGPrUlIkZBZCyC0bz9/P1ehsgP+aHXIpHG0e9IUgDjGd
         KdgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779066235; x=1779671035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91x4En/yixttZsPqKMUGLJ+HDfp3MoNxeXIT7uGfHLU=;
        b=L9+gqi4sfbCSVdXZ4FKehvCq9DL4k6j9ViO9s5+BeyFztpBDeo6P5yTPfQV27slQfF
         HJkGJL/UEQf5E4WJbfauvnTHs74eAmz1vXlcAY7lEq70HxrM7ctu0u/TXEDv/4liv+3Y
         ZIBaXf+x0W5cDJoFi7SWUmwxJXrnacO867fKGdX+zjUaRS68kIuYOnqbDidC/RShHHqw
         F67xfsyObaY41b11p+VFBintSrhEJaBo9PyQ71dpb01/E0D4xbeFQBEtn30J4w63SFu4
         QL6up6cNLTtqfT3+dM1YLZlsRtF3BELgoQqFCLbCpfTamyPxTpYAOnzi/rVNMDNQ/0YJ
         Vntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779066235; x=1779671035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91x4En/yixttZsPqKMUGLJ+HDfp3MoNxeXIT7uGfHLU=;
        b=NG8segot0KqoLmSQ8Uu5zr2gN9gNwgrnzwY8YzhtThdV7+/kIA+bZxqBwa6eFctx05
         Nk3em9zoSjW7xS4UbNndFmpW8NXlmRA5vsczoKyiUXsmOQIiI11JcZjzTQs03I/gWlXs
         5Np2nfGJeXtrEOPqD4uTbYYMgkmpQE9o8REJzcHOuI7Pe7+IPn0/rQv31wtIZUg3Jmkg
         HPwWllYEbEn3zkvFo+JsYI4dMfpB419pGwYFZTG4Qyz4W3I5YXunbHdTO4lKNnHd8+Ou
         WZ70aJIHkL802NVgoHfPTq3yY1Dew4QP7bSJwWARouWw6N6YaDHmysWC7rJtFWZ1uzjf
         KNFg==
X-Gm-Message-State: AOJu0YzOwu2xJgGs2Fic8ZK7KN5d3BHYsmyw08m9KKwYjX3hgDlSmBUr
	KP75Yp4tCTDYpM6Wu7gC4WMSuwtz9ALbumEiJ0AlDdiEkG6DmQoVI+G0bbcf9c7oG2SjbCizsuo
	k5eGH/rkiIgkofl2b9vfGU1DmiFMuFFc=
X-Gm-Gg: Acq92OFfNdSGEOkJGRdsbXEgdNmYUqyAcYfjPTYEi8VJcxIWsuuW/WBPfOQSh2e/q+i
	172YYvKhydomicM3NUeambg9APFZIt2pGrpYrtQZ1AAgBGFZoo0YJc4vj6H81snB9LBe6JWH3j3
	cOuRhBFjyeGJXvZx9A2RzBc8dVvyaiTYwevh+f45sp9yticEnFT6Z88GjE964pWzamgw2mxX8op
	yu7WdYOW933CVej8ONuTCBDm6c+iW4NaHybuAPHu6YpiBnVKCBaI7qLuDWI39xRPC3/RJnNhPE0
	Opad63FkDClzD8qIDvGawhcAuO3eU3eML615PIKBzIbFJR0=
X-Received: by 2002:a05:690e:1556:20b0:64e:f106:60e5 with SMTP id
 956f58d0204a3-65e2289734cmr11121438d50.52.1779066234884; Sun, 17 May 2026
 18:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518002800.1361430-1-michael.bommarito@gmail.com> <20260518010019.121323-1-meatuni001@gmail.com>
In-Reply-To: <20260518010019.121323-1-meatuni001@gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sun, 17 May 2026 21:03:43 -0400
X-Gm-Features: AVHnY4IEVRSimXev0TAeCWU_HHRbUJx3s-3rbOZEcCheeFff6XadNpyMUP1ClAY
Message-ID: <CAJJ9bXz-Or+hQnCGYi9AD9+deQQHKewipU4-17CSgrS-4i-uEw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: rate-limit ECHO_RSP per signaling PDU
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 9:00=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
> A response counter covering all outbound responses generated per PDU
> would close both paths. Something like:
>
>         int resp_count =3D 0;
>
>         /* in the error path: */
>         if (err) {
>                 if (++resp_count <=3D L2CAP_SIG_ECHO_BURST) {
>                         BT_ERR("Wrong link type (%d)", err);
>                         l2cap_sig_send_rej(conn, cmd->ident);
>                 }
>                 continue;
>         }
>
>         /* existing echo path: */
>         if (cmd->code =3D=3D L2CAP_ECHO_REQ &&
>             ++resp_count > L2CAP_SIG_ECHO_BURST) {
>                 skb_pull(skb, len);
>                 continue;
>         }
>
> Using pr_warn_ratelimited() instead of BT_ERR() in the loop would
> also reduce log amplification independent of the skb path.

Thanks, good catch on both!  Luiz reminded me about
pr_warn_ratelimited before and I missed that again.

I'll give others an opportunity to weigh in and then send an updated v2.

Thanks,
Mike
