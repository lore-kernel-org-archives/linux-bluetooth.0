Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B2317164
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869922; cv=pass; b=QgMynMBr3hC1IAs7nh3VhIrmRn2yI14D/wSEvDMfDgQVZQYqYLnLKqe4JoIbV+TXCbM9yeDoDPQFuU+RCe/m/+jxM+EloEd81WI2E4oKEKXWIvRlQc2P+fj4uU5SzDCEqDOE9hs2CIVJ7kxoAL0ivLpeEDd5gQEXvb3xd+uY4UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869922; c=relaxed/simple;
	bh=078rttVyJWbDLtpUTmpCNyeg3LrV+3Yx+Iqwf0wDCYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8MbjxcDEo6kR1uV+B+R9A933jHB247RHRYdtQ/fF7aRHSwW4uM/Ry7MKkwded/kYT3I3n6iL7pLeOqulsDp9tZEV28s3gxj9FO5226PS2pqzp21zS16belwC9JB1LhXcuM98A9Xngk6oO7r/RC0DRSfhHUGaa5fbsIR1Qd93D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwkKD5Ki; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwkKD5Ki"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651b0eb2564so5913937d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 07:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869920; cv=none;
        d=google.com; s=arc-20240605;
        b=ihV5kYsfBIwmghfjzNKXjwyL9fgcDC3av3rc9vJho5DTFiiO9+jKTr27Z+PluHlmMf
         aD1UDqSlAofJxc9sJo9X3rXpE3/ZFWwN2HS7nJodSQZHE7mt2P4D48DlZq7uNUQwtF5E
         omTJt0g1Hs6rHnH6uA4sSjYyr3GIgPE+OwCqdPcODeiSXp/Ih54oSjg67WApr7f2a4kI
         fYWFhVnZWx3FsUv/Jba+5eYeikdCMc1k1+TTSii3C3CUsu8E1pN4qFB7cUnVKh7T8QY6
         nacp/aKax/tP29sxfL4pffafKgW4GwJyL6itWKh/WIwXQDkC1k4gGPq2ExTydEE0+7w3
         xblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NqyJWtKrH9oShmW+WNLiSnqWcym7LdgzARbMIJVVAy8=;
        fh=sqV2+Eu9IQn4YDymdzhPe7sMFEHg8ej50eXfMopfuKg=;
        b=IJlKVfPmXERxeEIvAVMShwuECKG+y8ptk7dXnA1IRoHDj54YoEYINgvqRBxFuEj5f9
         T6uJnkHFvNovI3ugF/hNYIumwQd4UgJWPcgqvf3hAznya80FA3AbyFtBGt02ttOkNqHp
         74SzrYnXHBs+c902fePSNQZG2CdCLKWTEztm6ZKb4qXa7dtKyrYudiflCABExwx90a36
         GssUs+PMWOjJcGgHa9jRwYFem0SHw6q/J48z5pxhVPSq66+mn15naX0iTFhsnOjvVBPa
         76zvuQFoUkaBSSgMrEq+xfHs47E04JeSMgcdSve+ZSxGIQYAaHTEttjrIBWYWr0MM+pR
         DVKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869920; x=1777474720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqyJWtKrH9oShmW+WNLiSnqWcym7LdgzARbMIJVVAy8=;
        b=VwkKD5Ki9NpKUqQa6sLkt8/vMeRNjrS7bhzhrz/sEzDEbygGRCvdV1oBCuK22YoFSW
         2tTso3xLdzxj7b3bPIt2BYgujvXuBT9lZQFkrF+x+RUu+8Slnl0ktkzAOa7BxkISR8R9
         jUAusZrbcVLDR5Y/7HMgQFFjPFN8HFzZf+7dK/bBPD76nhdUZ2blSoLDDeAiontsqhIz
         8WTUWDbk68zA7EKqAF4xS524CZicbs5V1YyZLB2B5sYuvtdZv5P7M+Jos3fbg1OBBuLf
         o9I5ZRK+Kx7Sz6zGxWY7U+Rz7wsJduBbZ515++zBCtZ5UKrqxB3+4W/VQViQdjVle+oe
         pr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869920; x=1777474720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NqyJWtKrH9oShmW+WNLiSnqWcym7LdgzARbMIJVVAy8=;
        b=rP2tJowuXUKvd1QkWCiZW+3qVi8UUj9+wul51NjZ8CmC6FBxEZ1YEi6W+Wx6gyDLFI
         QGFHqsExmPu8rVC6yjuc2HbZm+6PA3omxW9lD6349Sw1G+OGbTkSkME+dFDZAd9QStby
         B0MS6bsfKy9xGKL0jsxEl/IvlzAIq8Gi+ckenC3qwbXtcaTAgAybst3A7bdnPpOBsk7b
         6nkB3H3GxvJhCkBpGZhZUk0N+MmRoxV/v3g4x93H7eParCk9aWqCHoKCAXfCLNM2Uahg
         VVbP9HcqZ2aEScvmagw4aLfR3JKuQ8z72szyKkujOfHlUY85uvvh4+mTnFHUtGtVfVuF
         KJMA==
X-Forwarded-Encrypted: i=1; AFNElJ9or1+9AMTGFX/NpV9lYYenePvD2gd9ySQPRykZepiHJVxpHtTf1iVGB6COL11GpoaOuXNoH8MVHZkjiuKvZkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1WtkzPlEAsNGadEHCJX5044M2Tn6d2jkoEOKg0ZrWY/axFmZG
	ibxz1kRMsrDJiVQuwlF6zKXX6STDqadTM6UEDJLaAxzAjhwHhu3XKmuBE10YJXQHAxZAxEy8E/j
	lu66lzUKzBM5GJ3qRHjnH7wLzHGupx98=
X-Gm-Gg: AeBDietEKLQXDlwNqZFd3gqpqc1Zk/jvsSsyVY4EAA23VVnntzfGk7l6u+on9PnpQwN
	t9y5Jp3vw1+LeSjyT9o7sm3nXVe8NiZh7pGmZZw3cyhiO8U4zgBa2eZ4LHQBkna+AP5fEKC7Fz1
	0e2eYTpjEroRZTDrP86T6Ifvl05zk1AWPIliFDyu+LmE29M8hCPFbK7+byKpHSM6uxEnTWeX2t/
	k62i10L0bEa9vtSEi8cLui2qLMVOeykD09vM0HmtzP5PtHxwXQS+FgfwtoTM+p+v+l0GKodBOAJ
	3DuxyXZUzplLZ8DJumEVbCDjVV870du5hwPIuUZb1+yafFvIc/Ia4EDiPg==
X-Received: by 2002:a05:690e:128c:b0:651:c5d5:1141 with SMTP id
 956f58d0204a3-6531088e804mr21017595d50.28.1776869919985; Wed, 22 Apr 2026
 07:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
 <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
 <20260421135639.3185653-2-michael.bommarito@gmail.com> <CABBYNZKS5Prm+BTkpdPgArgODTEDgHXLjecfux=3ZW0r2x=UXw@mail.gmail.com>
In-Reply-To: <CABBYNZKS5Prm+BTkpdPgArgODTEDgHXLjecfux=3ZW0r2x=UXw@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 22 Apr 2026 10:58:28 -0400
X-Gm-Features: AQROBzDekR93usvh9Pimj95cjSzQS5l71ZvY76cwJ2OQBfEIuaMxc8oI-vdcE1A
Message-ID: <CAJJ9bXy8CVjC4xG0zBcxi9xtiep33-uRGSysL1Q3FiqCN7Rt0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM
 RFC option
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <martineau@kernel.org>, 
	Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> This seems to be going sideways:
>
> https://sashiko.dev/#/patchset/CABBYNZ%2Bf3pur4cSsanQ1kvv-yORp2E0qmVLt9si=
_%2BFnnJup4Ng%40mail.gmail.com
>
> Patch 2/2 seems totally broken.

Yeah, not a great turn.  I am struggling to figure out where to move
some of these parts and where to put the guards without touching too
much.  As Sashiko pointed out, there are some preexisting bugs or spec
questions that I don't feel like I should be touching unless we expand
this to more of a cleanup + hardening patch set.

If we break this down, there are now ~5 different issues in
adjacent/connected spots:

Ones I was trying to hit or introduced:
1. Zero txwin_size in inbound CONFIG_REQ (ERTM RFC) - original bug.
Need to balance normalization with spec.
2. Repeated CONFIG_RSP re-running l2cap_ertm_init in BT_CONNECTED -
original v2 2/2 target.  We need the guard somewhere safe under the
state model.
3. Zero txwin_size from userspace setsockopt - original v2 1/2 hunk in
l2cap_sock.c.

Pre-existing issues:
3. STREAMING -> ERTM mode switch via late CONF_RSP - pre-existing.
4. l2cap_sock_setsockopt_old locking - pre-existing.

It feels like the safe solution is probably going to be at least +100
or 200 by the time it's done and more than just a hardening patch.  I
can take a spin at it, but I will probably be slower and more
bug-prone than someone else.  No pride of ownership here.  Just let me
know if you want to take the fix over or let me try again

Thanks,
MIke Bommarito
