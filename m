Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6D13EFD22
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290346; cv=pass; b=HkhU02K/a+XIVCx152XTJ4gSEBnNXZyNXWQHE4WX1A0Mg2sK6gTJ9SmGRzlymUoExv/Ki9jZE/PwJgxFxrOQWuExRskGfT0JaXEWTP1EJStcrP97ZbOWESsIwzNNXaGVh9qG/2FiJc+jsTqx+FYJSr0Q2UlDhD5xx0sV5pro0XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290346; c=relaxed/simple;
	bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4yfasOAM6hSJK6ablAqRHPjT5w95AEl6UPLvC7ALLMmWpcaAES0w5bDcj0GTvDwLDbTmL4AAsDbgWxebYzc8SE5sp8Uluxtv5v9S+KExEx1h5C/gbFdl0Es8K3chXsG6J7t+ovAnU9Moyliz3G+Cq5SbUD1SdSaNnNfErjSbZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxjVXlqU; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxjVXlqU"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c477a3278so5255827d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 08:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290344; cv=none;
        d=google.com; s=arc-20240605;
        b=lONVR0NePC5Nqm+e/kciH4FLaekm/f+1wwukUdpUySDE6qLgXfcDJX9xoEKPIS8iEO
         N3eSljH+NqvYBufbttXvJKawyxVAIpN4Qo9LDV9AwHqAmxox1w4dRpg0OqNE3O2rgLoC
         nlLSr2jn98mkKjbXYcL1sGsRgHRgHttuerm2U+X9ZFnwLRHwDIEt6rid8PWsLTywl6Ho
         Znkl/e6kC7EFCYvOGyZJvyig/IJg8IjBG/VTDN+Ch3tNgwO7UDddPzU9OX0KNdu/S+g0
         lp7R9hwfjuVFl3S5DE47GivWoo/RK/3RTpTMjgMXgLSHeZbPEVQuh+OGtiH8IukjJwHG
         IaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
        fh=IcArLcmbaC4mEOTDthH6TAMr91G55nDyJTxxXZDEaI4=;
        b=WHq/8WaYAk5VcRNH+1hbQh9ddNfp78XoDBgsXPR7IeMxCNKKWuvjgYCBQAzcziKMTB
         KUuQeOpifx04GPRx/KWrThzrB8EAVRn4N3jEXNJiYX3o2g3GrMbDF+yyM8ljuY1Yjaza
         FAOE7K7JcAw4buhgn2bFFePKs4K9E40e7whIkELOFCxczvAdzoDwfripOi0SlpU7IZdG
         FHNMZd8Ee3dhnR65Vw3DkyAPQ+33mQ5Hd3cXT2Xm463wCrJ1TLAaDTv6hBh2ooB+VbtZ
         +mUpN9Xw65/XRTqRGd2ediuY4Hf4GgO48trbZzKkuc5FDV3yaAoI/05ol/6KeNktjZZZ
         P58w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779290344; x=1779895144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
        b=qxjVXlqUfdE03SRW71A2N06iP8qP5nLqeN6pprEDdnboEdVxgxQErzX37k47E8DT0q
         X5oXGoqhul/7ct506GVTNshptUrlIaciwMqm+bdopsNLktt1Viz5V2xTn1h/4+uQMOXD
         wEcaloOGdcmHRIljdy+jh+minQ271pk+h5FaTk86Q/xGaUHRRRKEuw4eXb/zjz2oBR+T
         pVAkqiVsSwixBdAMbIzlPFf1zp8M2LVxOLcdfpaSgBA6Vf3LnHbT7sb0+OyltHeDkOBU
         VYpLwUS9sm+j+KRiXhv040QJmZgnstR9XFZdp8yFggvx67Qg805i8UGet2AGwOLQ9nSA
         boLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290344; x=1779895144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3bmrQLW6G7lq7eJL1fF05clBDrJYs7JUDV2nc47aEbw=;
        b=HEGnDG+Up4ICbb12A9NpGiLmSn8ZYSP0aiiI71AgTd6dIWVhct2LmJ3hp70D8HRkVt
         JCunBQG/QC+H32U+8OQfW85rsgTjamgLz2dw9wkOBLNUku0LF9RY9pzJip3c80FX4s8f
         40jn/OhRBykl2f2n17Mn3ruMzM0/HOTYIq6ivdVuDaClCDs6nePXIy0hqg3UgWJXr2or
         Hq+YC1OQj9getznVWN0ih6kN5jAS42RGOEdo47piV2E2hzgyTDJ8D8naytdQidgPmuEz
         NdpA9pSC6ZkzB67XUvDG4zaE9kSmvvMFabIVY5sO/l05HVOTaDklgo48iWb1ogFuTN2y
         VnIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+K3mjY8E0ToTbZWqEMrF72fy/HoDq62ciDm/Y55d/wrYm4+Y4ohybzPmvamXuAll5yKFPN1E8KU6w6ffjCbSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6EtZsY3DGbBqdl5IfZWr/gW38Ms6fvg5DuhkWR8aZvsGj70h
	jmuA3RCTPe24qIoorubWpylp/DLKkj3dWpBgDnMZp35P8++YwBcUykIPuh0IoQ7QF+8XQX1djZq
	Vbjef8FdMqd2uPldXjMJabQtXHXxIQd/fq8qQV1g=
X-Gm-Gg: Acq92OG/4UhFhAy8Qr00tReLwxtjt0z19S5LcwIkfzJuKUvst0NNGberpV/3BvCh/HJ
	QZuzK+Sea06hR+r3g+eKNv/bEANiEr0PFq008y9AN6IkRzLbmMU7T3N4RZYmJPLQ1pdyVvxt5ws
	7mzejq6pJboBsT3BsmEzuSjkUZEYOpFJXwY9nlS+w45wXXgn447UNfT5gpnylYJFVz29PefrWPA
	VpNxhD4Xkko8S6snpZnv07H66VDlTssxTx1YJ5KD1RbBCWpsbqc9rg4xKQDMHAdzj1LdM0yk89b
	gyJC6Yn7/f44Ra5Heat0KEtRlTe7XkcYHlGeEPfshiuljpk61IsnMQmCc/e1DVgvFHUo40oIfxr
	pIQ==
X-Received: by 2002:a05:690e:250b:20b0:651:92cb:7157 with SMTP id
 956f58d0204a3-65e227fb576mr19553117d50.36.1779290343944; Wed, 20 May 2026
 08:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
 <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com> <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
In-Reply-To: <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 11:18:52 -0400
X-Gm-Features: AVHnY4KnSO7nh2Mxl3gO31RP70GuHBlFZ_lZE7u6YBzWgqLDOxXw38-nlAPr38I
Message-ID: <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, May 20, 2026 at 10:13=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Wed, May 20, 2026 at 10:00=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Weird, does the AI come up with this? The id is actually _not_
> > important because the error code will essentially indicate that the
> > entire packet was rejected. Therefore, it doesn't matter if the id is
> > for a request or a response, it still needs rejection if it exceeds
> > the MTU, so this seems overengineered.
>
> Yes, and I debated this with Claude, but it convinced me that the
> lifted helpers were more idiomatic for the actual spec and bt system:
> "The identifier shall match the first request command in the L2CAP
> packet. If only responses are recognized, the packet shall be silently
> discarded."

This coming from the spec is priceless because silently discarding the
packets means the remote stack won't know the responses were
discarded, causing the stacks to go out of sync. We also shouldn't
process packets beyond the allowed MTU. Therefore, I strongly disagree
with the spec requiring an identifier on the reject, as this implies
that even if a custom MTU is set, the packet must still be processed
if it exceeds that MTU to find the first request command within it.

> So if we ever lifted or refactored the code, it would be abundantly
> clear/safe to reuse elsewhere.
>
> There is also much shorter version that just peeks skb->data[1] and
> exits early if not ident=3D0 if that's what you're going for.
>
> Just let me know what version you prefer.
>
> Thanks,
> Mike



--=20
Luiz Augusto von Dentz
