Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019733C8194
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900283; cv=pass; b=Ag+CaSPhpV9FCZmd8T6K9iaQ1Y0pxrWb0ifuTP7JopSgnOpv7usjy+LqhgdjC6jX+tWYUMtbKZKrfjk3bBCGh+Dc3nDar79R1nAJVRtwNx43AtjmkyH9cz4DzWtvh8RM5jDapCIKVD/YcEHziNlPoCy1yPp+Z10f2z8lCkJKRUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900283; c=relaxed/simple;
	bh=DzrcFEY1rgwWm3JFIyxQNMKW2PekoiwLPfU9/04RBt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niX11Rn3x4qXrRBJh6QbDG24Mm22rYZNg6/IaRs2B/g/jvasfQCHpzvP6A43ZY9j0HmlioU165NoFbiWXeDf3hHeUfDRJ5VhuMpoK3M1r1/fpZNgBA3D6j9fRE2/wjEZsbT+1/gPGY9mMHLR2EeyqCSlp9bUT5iRAO0VMVY2CsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgBs7nM/; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgBs7nM/"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ae8607e8afso19870017b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 07:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791900281; cv=none;
        d=google.com; s=arc-20260327;
        b=katkybNRzC3lZMRf8Jm/EbgGS2uJ70jUepFQRdxl2P9c/UXsrqDhfTqBxi2wg/5t19
         cg0r0tAHWcjRInJErYBf3xdKe5FOQ65/g5yPIj8gXWkyYPHLcHmYExOBOe7m6lCG8Biq
         WwSyeSyvUbeewo/4xfhRfD5yebNogS/3jzwKSHWIzGrxLwJFZm3ef2SeJv0WhrlzgEXG
         mBBXlf9jTQ2vYUvxjXEigGitKHb3yaQEYH2NQ0OBh3J5uZNi3ChGUY+DcHXstCA7fnqt
         vdnW3dsFkCs4x+kx9hyM26rfAGvzp2H3Q/Scaz/E9Hj+vCH5y6VRWHU6/yfWzJbNtxN9
         1LGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JOjVfbTHlQbpGLyJKUI687tyzNFy+QciAXgAHH6YLBI=;
        fh=vuVUmdkZOmSwauP1T7ISBYV/hT0f3+Bylcp8nFr99Cs=;
        b=XK1B4ftGqYejE7Pd9Nhv4cgl2trS2sqvm1LuvS4KbzOzFBrFMDO7Qh6KXC2Ak5N2tN
         a+3tel62UZEPuF6fD2QPdhddRg8WZ8moZq2NG5gbpoS+/CO7PIyWaunQQv6/Xnen0oTM
         Y4Fy6Y1KdsfJXPAAFvZtSkfyjg4M2VYVcGRjs+cj0wHUfr1+Hfxs1AMSY4cLnvePDgm9
         rCHn7JjY3a+kUtLvXdOevpP/3Dg5clPkuZ0rz3y6g4h9nnHr01i+uI4hI57Q/QMVz689
         DywMEstFGZZLHNxcB95Ej9MMhbUcUQZ91X+U2Lr+jyz+clwBRLQo4UntQAcfZspRvAiB
         QSLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900281; x=1792505081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JOjVfbTHlQbpGLyJKUI687tyzNFy+QciAXgAHH6YLBI=;
        b=fgBs7nM/KN2MgMoXs2Mi34GLEr2d4sQ59SoMOKYOHGBVe17HwZcfQ9EVDUBbjoGHE8
         ukOl9Mv9/lm5dm07ykC7Y7WvXD0ymyWIxF87ApQd5bFyKdb4C5p4eDXs9qNSEolthiNg
         EY+J/Cg7qTagk5+YqqD6LFTevbsUcz+T246Y28Fnpu/NBb1dK3DJ8PJ3XjZyqhnDxcny
         YCkgDTtY77gQIqlXivCpdZOjhkX2P83iWt5wDGsnIZXv+Zv3PafS0xIN5D0txVCnxeey
         EnEHXmsWgUdVaLZBxK7vxFn7rAKz6rLZ8Atmp62lcPKBPLoC32IyQl4tu9vZTCTkEPgt
         ODFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900281; x=1792505081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JOjVfbTHlQbpGLyJKUI687tyzNFy+QciAXgAHH6YLBI=;
        b=o0/gMEMXMrlVNXFvO7mWuZTeFspqOF3QAwz3d80j7+72RtX637lp3Fu5Kg/q2Cl4b4
         s/HkYub6VlnMvir+jkABsyfk3iUl8PuGfMOyjzEBcym/UScP7Ruv621fVulom3HhgAGL
         wHC3S6Rge8NR0lAquePmSb1okH8HXp8BpU+mU9v22anksI92F+gU333hYe1LbG0bUBXZ
         SlAuTKtk99mXCuQx5OI6MOIkR1yt5nokzKfztQAiO4q0HkHBtT2GL5sK3V5zCb5b22M3
         LyBVg4mDVJKDHu6t4oruDmuhsgTeU2aMyXHMkxpGGgnXrZasTu/ojTT5GS1oJh0DBJ9X
         BpVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZn4KvzWCQpTLs4/f7oNttH+G1Rji8IRPH3LSjknIdbcuOpGzMFA+vl7ianP7ErI5KJAHB2Pqq9EL6PdmSqa8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbpll3YC0QX4ZMGSFbOBwMrNkNKpafFmw+OVp/9NmCoe2pDk7O
	w8jLXsvzyEdB1J3fiC2m+kiGULwKvUPhjeh4qH/5JPimPyvnk1+DfuDZX1vJjeDWKD44H2qBKBp
	W6QVRodCmDdX1lK9Fo7D/lW5+EZR8uf8=
X-Gm-Gg: AYBFou3WSqBuR/vDhDCjKxJda7zXSAlF3swic+6beUrUfserT7jhr5bXn7Ndc3xHrm0
	tE9BWCRugBqX7ljG4XYtRYYgF4f0MI9XVXuJtv0oPXXosPHdXEwDfaVlPA2Sg93q26RcZy9M665
	tP3t8qIFVN3TAE9eiBevV/6mcArjuMbYR1fuamAqETC9TRJsLLrcKO4LpSfzoDaikh6SjY8hpYa
	Qo6RBnUPWCvWeiZS50lyyBmwqGl5wh06wYIjDpOx6eblIYNR/ou8iXICYeZ6x/mXmE9YNOpD0jz
	20MjjjaDoEplLU9pZ3rjW0H19ymYCOSJQcCv1LZqN4nhK2zQMM/dxLI/S9x9W1W1GAnRTBHMtkf
	b2KvoohNODi0CfAvMhu7mqd84p1GFMieTvTUfEmzIJWY=
X-Received: by 2002:a05:690c:e68e:b0:8b0:6866:c58f with SMTP id
 00721157ae682-8b07ebf6118mr22092347b3.3.1791900280818; Tue, 13 Oct 2026
 07:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012210758.275556-1-luiz.dentz@gmail.com> <48d2ed02-c5b6-428f-b290-bb6bd92fe299@redhat.com>
In-Reply-To: <48d2ed02-c5b6-428f-b290-bb6bd92fe299@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Oct 2026 10:04:27 -0400
X-Gm-Features: AclHuK8CwNefDVU2g9r8mUJAY4xvM3jSYTURNrAHjc7AUPLST2NnWSBIBIDU7Kk
Message-ID: <CABBYNZLogtjwKWe396jbm9zwGf8k32f8NgC2ynm-oFv7huEyEw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-10-12
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Tue, Oct 13, 2026 at 5:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/12/26 23:07, Luiz Augusto von Dentz wrote:
> > The following changes since commit e32d80293a0e1a160d5e5101daa8c82148c0=
7510:
> >
> >    Bluetooth: ISO: Serialize concurrent connect calls (2026-10-05 13:10=
:47 -0400)
> >
> > are available in the Git repository at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.gi=
t tags/for-net-2026-10-12
> >
> > for you to fetch changes up to 23ad91f6a21a830b67f5eee790caa0053bd6537d=
:
> >
> >    Bluetooth: MSFT: Serialize handle map cleanup with event processing =
(2026-10-12 16:27:16 -0400)
> >
> > ----------------------------------------------------------------
> > bluetooth pull request for net:
> >
> > Core:
> >
> >   - hci_core: Keep RCU protection through LTK filtering
> >   - hci_sync: Serialize devcoredump reset during device open
> >   - hci_sync: Protect IRK identity reads with RCU
> >   - hci_sync: fix mesh adv timeout units
> >   - hci_debugfs: Pin module for debugfs file operations
> >   - L2CAP: Hold the listener while notifying child teardown
> >   - ISO: Hold the listener during disconnect notification
> >   - MGMT: Reject quality report requests during unregister
> >   - MGMT: Fix advertising instances with Global Advertising
> >   - MGMT: Fix pending state of instances added without HCI traffic
> >   - MGMT: Fix leaking instance on Add Extended Advertising Parameters
> >   - MGMT: Allow connection rate request as peripheral
> >   - selftest: Pin module for selftest debugfs file operations
> >   - 6lowpan: Pin module for 6lowpan_control debugfs file
> >   - 6LoWPAN: Use RCU-safe device list removal
> >   - 6lowpan: Drain RCU readers on registration failure
> >   - msft: Lock failed probe cleanup against feature readers
> >   - MSFT: Serialize handle map cleanup with event processing
> >   - Add missing newline to bt_dev_{err,warn}_ratelimited()
> >   - Fix tracking of instances sharing handle 0x00
> >
> > Drivers:
> >
> >   - btintel: Zero version data before parsing TLVs
> >   - btmtk: fix skb double free on ISO padding failure
> >   - hci_vhci: Pin module for debugfs file operations
>
> Ouch, that quite a significant PR! Linus is pushing towards
> smaller RCs: he is not going to be happy. I must admit I
> would be slightly concerned by the size this late in the
> cycle even without additional pressure.
>
> Do you think anything of the above could be moved to next?
> Things broken since the beginning and/or required root access
> could be good candidates.

I'm fine either way, I will send the next PR later today and it should
contain everything including these fixes.

--=20
Luiz Augusto von Dentz
