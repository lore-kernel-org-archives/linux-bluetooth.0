Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82E30E831
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870552; cv=pass; b=Pe2v2/rzexSi1u9AoEy6b/XQdm5iUqrPtfXCzFnNhrDs+4tVm5FQ+CIsCyJY5JdMrnp3+oP59682ZoNIOHCsqSbkL1SegVNLzz8zefvnJRY6lfrEkroVQuejP6PGuOUEbPCb7fSDCXYZlE358f9kb5fgnnASoS7pNJzUmOHdz50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870552; c=relaxed/simple;
	bh=sBxpp7G1hGSRFEzvlZREZSsh2ubBEhHltUcHL8EqxDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaqpf9tFU2nYU5vtgvLXen39tfdYzktqf2bt5ZU9HWZSB13BFc2vn/eW9oPGGMVU3/9W2kUdriF2GYOF+XFmSARNDo48I4laE8EdN6M+w0DmcuKNLHdkvOccXNnrz7PkAWxQNoSowT/JD3ID5LM7+t6nUMzrzlrcbow0NDzVrpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu1k790T; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu1k790T"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-66ee7b9af94so2159524eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870550; cv=none;
        d=google.com; s=arc-20240605;
        b=WIumeHeIdOE4FEZVY6h0fujtecclZ61P0iMyKeFio53/MHnmgOktYRNZndDHHE8hTW
         WnQqDp4Klu5LT9uV1GqfckccVuVqaRiX2gP/uQJnpD65Fm3o2BUybxVfCiq3ASJYALRk
         Hh/K3a7gY5U9hKbuReaGewUhatR1to4uv73FPuZLXfe7LpDOz458xelz2rt/suRR01W7
         msGCofjaT3IeBHyBsCxtyHqGxfDn7Hb1ea7MH8cKNCrwF+LXE+0jjFh2hDgXdIWSTzgH
         6a0aX+ZmhIv9MYzdneULBW1tFqIzh5JVksluDw1M/mG9QsQU31i8trlbkQ6AYqU31Qxg
         0p8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uGy79cymkiDC4frLILWmwuYDcRF9vSptUaSzopr5FdM=;
        fh=+nrOS6ypJmP5PS9jzLlY6dGyGOptnvKG8qwzYtw/Cmc=;
        b=bBOAS/LD8b9Ln/cJ+WmIBFOghNqbsgQVS4KZAGVCl1sOXlcCK58XzqVoiF8grg1jVh
         xBBrMh2L44NGoi8LVOzAgn1OapRpJEHkEiB1gU3CFLu7vkJ297m/9ozBUw2WDrAmxdcj
         K5vN416FUyuONneHxXC9qa7T7eyO0pf9EpZWcuLR8TpNco2UcA484E3FHGCYUHXxTJty
         ODSgSVKvRX6Z2x3lCTSqAa/8uD7t9zzPKfKqlSheeQfnu3T50OuAE9ipK2Xu1M5VXi3a
         Eq9m805im1sD5CuRz1gSMC/eG10+k1ZAI8MnAt/+MbzmEx4NsrZ9sFXPUz3SClSHzyrl
         o9xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870550; x=1777475350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGy79cymkiDC4frLILWmwuYDcRF9vSptUaSzopr5FdM=;
        b=Tu1k790TqOsO/U5rOP+48M0w8hjkNuUFjXauUvDXCqObndd/lfyO73DKtFQ0VHcFI3
         7ahPOnQggXYvJfXLiWnuQoj7aWpZ2uph32kULXwy7qAchLR5j3haafXO0jaOr5yAqlLE
         yHkGZrFC8OtWw+J7ghFKeb+lOnXH+GBvWtgCnKZSVZasxT/eMSgak0amFC+2wcKZJs8J
         hWs88y39jF94r58MlKXiBI6dxoEaao57sDUBYsHlzVZprqgVDqlqkdTfonAFOICzM14T
         kPMEoyRDpkP+YG/4Ysan27A6H0z1qoxzd/ZzhrHg8z7m0OfY9rMkECjiGP0lIHFZYdxT
         iF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870550; x=1777475350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGy79cymkiDC4frLILWmwuYDcRF9vSptUaSzopr5FdM=;
        b=pfEHMQ9D4NP920Me0FNwIsQBuW1JMrFMlOymVbGqbgn5FWsedRAwt8sQCf8pqqYR39
         nbZtFFkDTYItJw9RCV/6cYqueWfVNINamI2jNG4J7+C+sTFrm8TIqGLBwTNeIs9BZ2wG
         BOvXrbcx5aEuzp8TX6Ln6CmHD8vMVEROJNpgW4JswtuisT/Obpd6HfuVBytqWBb6KYUr
         s/gxAUOTUR2pWzhqf1Df4gfqUmUg5KJ7ur834fKYJWspRLLMLCSM+1asIu5RxhiG+BWj
         95fUfYHHDscSPxSuGSV13OcxuHs7FNKf/m717qlYBr8bdEqhhA1k91Px7pQkd2A71WcO
         V4rA==
X-Forwarded-Encrypted: i=1; AFNElJ9zw2Iyfar3WLhmNU05tirSVFq/N3wEq9763gzWRutJYXFGFzzG1B+FadOaF9tSERzeCEvykOMUCCXS1rqYFB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRE19GiS9XQh/e3ehsCoSP5ZStT95P4pUK+WGsabetQUqf8K5
	xMiBblsC+p+QEu6f7eoYErRstwRTADCe0B6mqcQAvCNID779kEMSILLbRUvEt7KGcV4gCD8fTtn
	/i0eSYOcDNwe9BT53VA5mNYWuxgWUom0=
X-Gm-Gg: AeBDieuNX0iJK6hjx+iRtyWFU13X4vDeqTLRsZk3u4zbTUl3tk7qrfOKhmInGxQYCJd
	84iK6juDoFeeFi4djXwoXm/rvJU0KRn5OrFSnSReDWvPCvNf1kln1I12k4vQbRcebwqYgihjsYc
	2/Zq6xAhmJLujmCFSCkp4FBURa4CjA9yK4h/qh2NOeJt3ul5NFE95RrR3kB6g8cZ1Nqcjrw1S2J
	MdUxSUoBVu6OKbFqGeA65t/VPGsdnppZ41QT9phiBnrwGybSP0h6QkGBoYHBsWw7/YU/0YvQB8Q
	+FJOiFw8V2oKFUhxtCfG0wNurdJCtwYwsgS/djS7SySyNkbZJf1/Ld3WZrOiGh0UPqb88n/alvr
	Z1nGP
X-Received: by 2002:a05:6808:1a0d:b0:479:ffcf:52e7 with SMTP id
 5614622812f47-479ffcf56c9mr2116979b6e.45.1776870549931; Wed, 22 Apr 2026
 08:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
 <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
 <20260421135639.3185653-2-michael.bommarito@gmail.com> <CABBYNZKS5Prm+BTkpdPgArgODTEDgHXLjecfux=3ZW0r2x=UXw@mail.gmail.com>
 <CAJJ9bXy8CVjC4xG0zBcxi9xtiep33-uRGSysL1Q3FiqCN7Rt0w@mail.gmail.com>
In-Reply-To: <CAJJ9bXy8CVjC4xG0zBcxi9xtiep33-uRGSysL1Q3FiqCN7Rt0w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2026 11:08:58 -0400
X-Gm-Features: AQROBzBpAa3bFHNHHM2cSEM-QAiFopVAaeqTBVT_jbR8_JmNoVXMRcDVmd8ZkqI
Message-ID: <CABBYNZK+o0wwOvjoz9w0ju4SoXpt6PM1xQwXU6OozVJLstWMGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM
 RFC option
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <martineau@kernel.org>, 
	Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, Apr 22, 2026 at 10:58=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > This seems to be going sideways:
> >
> > https://sashiko.dev/#/patchset/CABBYNZ%2Bf3pur4cSsanQ1kvv-yORp2E0qmVLt9=
si_%2BFnnJup4Ng%40mail.gmail.com
> >
> > Patch 2/2 seems totally broken.
>
> Yeah, not a great turn.  I am struggling to figure out where to move
> some of these parts and where to put the guards without touching too
> much.  As Sashiko pointed out, there are some preexisting bugs or spec
> questions that I don't feel like I should be touching unless we expand
> this to more of a cleanup + hardening patch set.
>
> If we break this down, there are now ~5 different issues in
> adjacent/connected spots:
>
> Ones I was trying to hit or introduced:
> 1. Zero txwin_size in inbound CONFIG_REQ (ERTM RFC) - original bug.
> Need to balance normalization with spec.
> 2. Repeated CONFIG_RSP re-running l2cap_ertm_init in BT_CONNECTED -
> original v2 2/2 target.  We need the guard somewhere safe under the
> state model.
> 3. Zero txwin_size from userspace setsockopt - original v2 1/2 hunk in
> l2cap_sock.c.
>
> Pre-existing issues:
> 3. STREAMING -> ERTM mode switch via late CONF_RSP - pre-existing.
> 4. l2cap_sock_setsockopt_old locking - pre-existing.
>
> It feels like the safe solution is probably going to be at least +100
> or 200 by the time it's done and more than just a hardening patch.  I
> can take a spin at it, but I will probably be slower and more
> bug-prone than someone else.  No pride of ownership here.  Just let me
> know if you want to take the fix over or let me try again

100-200 is not too bad though, if there are splits in, let's say, 5
changes that seem doable, especially now that we can sashiko review it
and point out if we are missing something. Another approach would be
to leave the pre-existing issues to be fixed in a separate set.

> Thanks,
> MIke Bommarito



--=20
Luiz Augusto von Dentz
