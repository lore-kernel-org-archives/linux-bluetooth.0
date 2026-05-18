Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274839B48E
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140244; cv=pass; b=MyZ6dTDqc8Th3zxMT113TRehCx6nh4kJ5PRbv+Vk6Bj4XJUkH31+T7TDlhtdJJFMX5PeNcxKkqSgf0QYta8aqog1JddassVJTH0YrwGWAf0OVvjmAd4JGOehFdmJ6s+xfrUUbUoZATzW8kAkyoTRb/JaRzTLmo5hmHojl3ICyEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140244; c=relaxed/simple;
	bh=mfMUDYekYS56eQWEHanw85YPW1M4J2JISWWV083tWAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEKwSddeBGwh/oi98VpzuT89f8Ad5eBjCWFPqOIQ9skO+H3Uxr888vB46SFWthxxbIIuFDEkoI9MrGO6GCPS6Y66l/YlMBoD+UmmYtZ5NrWTOW69Y6a5Jr3tvpnWYfSnDuXG7IGrgbKqcCAdolCDnhlRIVmI9wu801eQiabIBO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2CZzYBZ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2CZzYBZ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6530287803cso2933399d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 14:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779140242; cv=none;
        d=google.com; s=arc-20240605;
        b=BSPg/TVWzpUAkTxdoWB7WkcH/i3DiXGhWNMBynZARR9MHDJeO+lOdiY4rIGWlblys5
         hxuS9gqqkq5Lr56RDxvb6lQ6Spsm6gUlxWKYs8fYuA4aJwFPS7e/Uds2V4XXab0FRUe+
         uFyIV3QKNAZ8RJDHbKriAEK+QOWGMw2pUSZbqQD9twbU/3e4BRroVm9/+vkWdQE3A5+m
         4P1ot2ggaqzgT46PepncAJUjcQMpEP+Flu/CQIE/PCxDdfP05LV0EFXa50HaA7cLRiQI
         WBcBbmMSIdBLu3yWEs6UEi3+hn0QBHZ2v9LBUkZ4tNIqIFR1eFRWciWvuoeSc9Rxjgfp
         FJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qlumPnv09oBBxunL6hPB5ttws3jV9ECjTGixjMdI8Ig=;
        fh=DdF+DECJRrQz4H8uhimVaEBHaXReLe+mCfJAkPr86dM=;
        b=JXuezf1FwUBMaPKVhuCTaXI42U3IkPYNj+3LCP3Q8xlPU4MrWTbsDSWa7g87BCAE36
         qF8lLMS04+xHLAa0WNDgLSavLRho5HR32PwB7jSZvfGjSdS4o+FiEZVcrnSGuu7owyjS
         RdVGPLoG++0VTu6kVqoYFwrD7S8p2PKYH3xeeycV8mK6Fq3xXpl8fbD/cKLKNumiuWFd
         +7PuadiQkVk/PwrBPvb67b9ddnrMjWderqE7OgOi6xEFEuWOGhpSi/PDzgbORL3wQ/rF
         f4psda9co3Up6wPqoqH+2n55Pnc0wxqpiTQTiTkCMUF1E3o3UG+R45oLFm+ab3s5JXkG
         2z0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779140242; x=1779745042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlumPnv09oBBxunL6hPB5ttws3jV9ECjTGixjMdI8Ig=;
        b=T2CZzYBZdrOhwv7edWIAGgGbKSoQLJQVg2p++DE76Kz1ZQ6Qf/FNkDWuA+NR613/5g
         uUJpDfq0i4gBiN87ZBcFB+xH8vdAa6OA15wkmLzG5ts+mWJpO5Z6zYSPtZHpfYoDb1Te
         iMTksyIzcmqG5BnslpK4Y85NyL/0i3tZ50yig6FWKYgVLp9U7JggJKxn/R6GtzRrbSrj
         8KEKmjbmhOa1sTUXlHXCjr525T1ShePstUogNAm1HU/2tYt469hWrTdmLMYQwRR5re+A
         s5jSfMWZA6B7tEQ4BEr9SAkAu/ruXST5jWDhWxui68ANHFAt+QhMUgRy4up3xPZai+Xo
         OYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779140242; x=1779745042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlumPnv09oBBxunL6hPB5ttws3jV9ECjTGixjMdI8Ig=;
        b=rOUexcw9Y6mI5nN5CG5CFXKDkcS97IRsW4HhSXSw0CpO2o/ZOrWoWakO/ywf+3oKwB
         ZG7yRV1uwduaVPS+m5l+sCuJxNHsNxLjKrR0tlB237arYF/DP60szkReS6hIzk6/8zgg
         jW18NTCfRKuSVBvcBLrFM2+P7saRwIJZkyoVgvUumu4UScux2IZYsGrozlh0+wFTWYaY
         nXJOSgUv+UYLP8/ZWnU8wioBsca22wtM7HD9++BPntCzRwAw3pbfjIfnb7TpCXJKGkwU
         y6nQYk+ddCAXM5ojEazTdd1Z7SGn4hdJU/O0ubM/TJUxEEN9dpg/RCaZ93zVYTfSkRSI
         SjAg==
X-Forwarded-Encrypted: i=1; AFNElJ+d31gTEHti0Nz+AefY2faniFilSE4cW4p+ejWVXAFGecbfyYt7sch8ty7iAaf/6AgRBst98nxmytxRy3e3lS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0fByz/OkYuVgmLvWbJBP5xcDWZxqnqO2HxwNia/16yiFAPRO
	KGiENn/v0PcLb3VwwJWY5qvoduDoM7gIb97Q+QSqih5K6o48/9LRXKqGzTvY3dfNQWq1gLo6y00
	gnV8u9YKbohzLtTTm/22BA7O54RoZEIW/UBYTFWcXSw==
X-Gm-Gg: Acq92OFKJIoERLiOFMEHZmjj5PSjiVDW2rCoujh+jHGXWmEJzvHcNUlNJNhTM9MBbMV
	7Pui8l71uNRnGgtZQsmbQPUBaug9zzJ/rPomj7dsM2OaCMO8vhGoCxXNG9mH9HWCRPUYMwoJdSZ
	+esGhVeFGwlAv8LzAb6pNJEt7+jxEXzWlM+SZ/NCuQZOXUrgr4nVKasEbwtaP6F+KZp6KnO+Rtm
	zVuGyjX7F/S+2yMzXjJGmOURvXSJUQ5AS4NoXtrwLtBnGPI92G7BHiqT2FkphuuQqV9tIhUx8aY
	1Z8yXvHk9mkiD7/nW62bGPWcvEfF42kZs1CNP7+Suf6kh/y2McnRd99fJF3USlJhgb8/RreJpLZ
	TPw==
X-Received: by 2002:a53:accf:0:20b0:651:d6a2:f766 with SMTP id
 956f58d0204a3-65e227bae88mr13719309d50.35.1779140242407; Mon, 18 May 2026
 14:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518002800.1361430-1-michael.bommarito@gmail.com>
 <20260518010019.121323-1-meatuni001@gmail.com> <CAJJ9bXz-Or+hQnCGYi9AD9+deQQHKewipU4-17CSgrS-4i-uEw@mail.gmail.com>
 <CABBYNZKA5SUNT8maNVzuAvxqaWYt-eU7F+h58oe8e==QsH53GA@mail.gmail.com>
In-Reply-To: <CABBYNZKA5SUNT8maNVzuAvxqaWYt-eU7F+h58oe8e==QsH53GA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 May 2026 17:37:10 -0400
X-Gm-Features: AVHnY4LF-ME3Pv25nKDMJ_ogSZQYXWtoBuT5oYox5NQaco4GmAGPj7niY84t5SE
Message-ID: <CABBYNZLMEH8D+fZp_xfu665-E0QxNaefcVEsku5wnUQrxQjKBQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: rate-limit ECHO_RSP per signaling PDU
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Muhammad Bilal <meatuni001@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, May 18, 2026 at 5:27=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Michael,
>
> On Sun, May 17, 2026 at 9:03=E2=80=AFPM Michael Bommarito
> <michael.bommarito@gmail.com> wrote:
> >
> > On Sun, May 17, 2026 at 9:00=E2=80=AFPM Muhammad Bilal <meatuni001@gmai=
l.com> wrote:
> > > A response counter covering all outbound responses generated per PDU
> > > would close both paths. Something like:
> > >
> > >         int resp_count =3D 0;
> > >
> > >         /* in the error path: */
> > >         if (err) {
> > >                 if (++resp_count <=3D L2CAP_SIG_ECHO_BURST) {
> > >                         BT_ERR("Wrong link type (%d)", err);
> > >                         l2cap_sig_send_rej(conn, cmd->ident);
> > >                 }
> > >                 continue;
> > >         }
> > >
> > >         /* existing echo path: */
> > >         if (cmd->code =3D=3D L2CAP_ECHO_REQ &&
> > >             ++resp_count > L2CAP_SIG_ECHO_BURST) {
> > >                 skb_pull(skb, len);
> > >                 continue;
> > >         }
> > >
> > > Using pr_warn_ratelimited() instead of BT_ERR() in the loop would
> > > also reduce log amplification independent of the skb path.
> >
> > Thanks, good catch on both!  Luiz reminded me about
> > pr_warn_ratelimited before and I missed that again.
> >
> > I'll give others an opportunity to weigh in and then send an updated v2=
.
>
> Hmm, the spec does not have support limitation though, it just says:
>
> Implementations shall be able to handle the reception of multiple
> commands in an L2CAP packet sent over fixed channel CID 0x0001.
> [] https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/=
Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specificat=
ion.html#UUID-32a25a06-4aa4-c6c7-77c5-dcfe3682355d
>
> Perhaps we should define our Signalling MTU:
>
> Signaling MTU (MTUsig)
>
> The maximum size of command information that the L2CAP layer entity is
> capable of accepting. The MTUsig, refers to the signaling channel only
> and corresponds to the maximum size of a C-frame, omitting the size of
> the Basic L2CAP header. The MTUsig value of a peer is discovered when
> a C-frame that is too large is rejected by the peer.
>
> The minimum MTU seems to be 48, so we could probably use that as a
> limit for the overall packet. If the response exceeds this limit, we
> should reject it as recommended by the spec, but I think we need to
> reject the whole packet rather than the cmd CID.

Just confirmed, the packet as whole needs to be rejected:

When multiple commands are included in an L2CAP packet and the packet
exceeds the signaling MTU (MTUsig) of the receiver, a single
L2CAP_COMMAND_REJECT_RSP packet shall be sent in response. The
identifier shall match the first request command in the L2CAP packet.
If only responses are recognized, the packet shall be silently
discarded.
[] https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Co=
re-62/out/en/host/logical-link-control-and-adaptation-protocol-specificatio=
n.html#UUID-692db0dd-8ed5-693f-d300-4fd7af07e340

So we need to reject with L2CAP_REJ_MTU_EXCEEDED.

> > Thanks,
> > Mike
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
