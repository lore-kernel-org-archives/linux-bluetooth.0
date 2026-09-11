Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D435F163
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137242; cv=pass; b=uFC0Lrcl+gMShtdB6JaInONSZCyCPph4qfPcnYZ4lpXNtwaN1c4cSsvtUekKjSU2gUTQkOtjZGsI4FEnf/+KjiZvIfFqc9BSWnOwoYThh1IdUo1qRbIO/iFPtuoBj/dcvEBDrta6WO+QmL+drwX0uyIx7RJ8BpyzkyMMgfaVD98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137242; c=relaxed/simple;
	bh=Lq85WXNE3B6YdVcdVzLIUHNyP68RoDDuzGsNkOKe6D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ok8oU3CERhCjBUYQ70RqEHxcNOIWFlz2sM7br5v5Fwch4hoSpPYC5B/pEh7xqNnQxl3T4MkjxjbkWk+q4QUXLGBSfubKJ2dcwMiB60VTOd9owGpovcgDYlE3P/9rVy/tD9yJWo+jeuJ2afJY8/HuxQ9PQ9B+v3anxvtDThUg1Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rjHv0euU; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjHv0euU"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcbso161507b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 07:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789137239; cv=none;
        d=google.com; s=arc-20260327;
        b=F7JpoO0hlgqrbnkgPtbVviSMIwzEIeIdWnTXDPv7qljx5E4djeRi2ztdzKiyt1yZz8
         /xa0IGq5kfNjJ3g0uIfnz5L6fStkQogExlMy7pNAp1EIjmkLmatueslDuzjdWhSIhlET
         yRVr3FQdAB0Ld896DCOo0nhwbDdlAOvY8bSLixI6hFuB2ZkMGgEXk8KuGP/lhzWdQJEE
         3oE1EMQFLSvmSy06uhdNnCtL5dZ7iBeeXW1Ic73JGCt+DhHP/RoC/C6FPNInGPU158Ij
         mC27m+D/+PaqimmTN0ICdMOepg8lcXMrHmrCSJgZueVCg/UszbHcCR1LhQQDP4nF/JR/
         VTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=253PUwIF2lUbExbnq4pn03NFxabLUx1bSqL243QpTlU=;
        fh=bJ/lPg3NQBED/e/zHKSyr73I9Iyir3vfw9d3mVpgf4k=;
        b=Et9dOhsrs+od8BPQWNwhVaNoJd4bkkgWXBmV0dKm3n3qF6xd6DBObIPzUFAxA3I7MM
         VLe2XS0E09o4ZJAD8g7K7SYfN1wXUwNoaet9rDCMav226Laa0LcwZ90Q+td/5Ay5yeyx
         IHS85NIB1bHPqISTRee4FzOZwE4tqkMmMmOLN+0rcimVaAQZsVVT+2UYfCAZhxQ/DrIV
         /1UK3E4JMpK8JC7rBgY3RM6sVc1MNgIErWva0gmj+wfzOpCPnCuVdJJfaQX4MH2sOvph
         s5YQsKe+iw/5ebk423hQfj4eqD2Njx7r0ws+kqVIaAyPB0I8G7iLkic3zrYY3y5qAxZu
         E1Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789137239; x=1789742039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=253PUwIF2lUbExbnq4pn03NFxabLUx1bSqL243QpTlU=;
        b=rjHv0euU+pcmVHL+V6UqxQi2WYPJD2pJH9lQxY/FIHlQEswSsGWtgrV3ByyD+1Amuk
         WWkk1D4K9W8bLOVknbefu6dMM01T5UhKvepV5WK7gGHazGPqfVkD2706uFn0ccRijPK3
         sJzn6JReReo19mM4kwu0d4/2IjVsNHn1JDZi6jYWzHRdcBgm4+frWyDJhm8joLmOQWjD
         4MnozQab1ROzb1rn558JXRMeP/kDdPIVOLhlgQ8P6QPSUe+42zeJkN5m7G1RPi/y1IL3
         n8kGFGMdpZlia+AD1FpH1dcYGfdBW2bk2IYPJdlYBNQpHdsRatd9MacjS/t+f6mwijLC
         c4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137239; x=1789742039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=253PUwIF2lUbExbnq4pn03NFxabLUx1bSqL243QpTlU=;
        b=UbwGli8zX+JRvucVyuCN7eqAsOYN6EQpGUDQkthhJJmhxz16OzFK2XwqjrkMMEFGfH
         0jOmaVxr4Wi0pKTMB4+EmoGmJ1H+JHgfHnxvfFsz39sYdfPnzbaWsAM4FXZzOlz99xfl
         YP4p6JMiab9OpjxXewiwSeRu4Y2vgOkB30qtBHy4aCTSYNNo799JU1hg+h9HE4HEFc2i
         sgtXpGTAnLqGmIykkcDQ7yFEgkzG8dT2iJgYZZHJudSCnkhvfGXlMlim3KUiHPf8qgeO
         MN4m5yt8DsKj+O4DUUbrTOkLzHx2Oku7/PUXsKXmWzHf295uO5O5uqKvY6UXmJ4KhaxP
         XhRg==
X-Forwarded-Encrypted: i=1; AKwUvBwS14kiD0R2O+UqOUdY2FCgfC/CrruKrnKeHz21HtEtAf4snjRPggERoub/yJm7F4ZIN5IT1Cpcf4OylNQYji0=@vger.kernel.org
X-Gm-Message-State: AFuF++n2U0Z+E9oy7JtE1KY0hPeci0aIC929rrGkrg1Rjh/tGw3/b1OW
	25qjLgVIjPjisDYu7FauIuSNz/9mBcT0kHxadufqtSzD0XLt1vixxXXV3dhGL9jqhhvor+osRkU
	HKJkPqbBDp4a85dOw1Go0SGthHAdsTJ0=
X-Gm-Gg: AYBFou1+wmDv772Yv9jYNCcZDJWJL17MzCK2P440jXAF/djaA1ihZX+FlITOa07+dxT
	p+BUAb5KMpNkt/KCjWeqlEVOat99sDjHHkkrsNjF4kpGtPiEaBbPt8eBb9Dyy1ya+yOHyJFi8hY
	eV9JGEAAemTzC5CHSwaY8g7521vCr9PfEMabKtPzoks1M5VDd+98DDpLMErmDIZklRamn8wjyKI
	0gFUS4McbTzNmB7lgwTdvVY5Ac8SvDuLqouhanHyxSB6kIXAvEi4Zr7tJIzuTTlplWj0wPZ/1+w
	7jf8q/HaJaYdp5FsdIxYW9MMdolKkFcB8WyLi7MDr7vrX5MY/uL6IpeVhwpYN6E/6FyPXDGAu5Q
	SsAFnxlyu4wzV6p2Z6oSodT2q5M21QEYJCMHBMAQ=
X-Received: by 2002:a05:690c:d94:b0:854:27c3:5cd8 with SMTP id
 00721157ae682-884b387a6ecmr19566477b3.27.1789137239315; Fri, 11 Sep 2026
 07:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911104234.2276126-1-chris.lu@mediatek.com>
In-Reply-To: <20260911104234.2276126-1-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Sep 2026 10:33:48 -0400
X-Gm-Features: AcwNN1VOio-kJ1e73tLJ7cg4_i84qUwIWDri4lPL6COQQRrdpvIJBVG3J4WPA50
Message-ID: <CABBYNZ+SD=KAyMwGf_cBZARONqXhjTg2O-r5FHTqUyMrsprZMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Bluetooth: btmtk: firmware debug event routing and
 WMT FUNC_CTRL status fixes
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>, 
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Fri, Sep 11, 2026 at 6:42=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> This series bundles three independent MediaTek Bluetooth driver fixes:
>
> Patch 1 is a resend of a fix submitted on 25 Aug 2026
> ("Bluetooth: btmtk: Route firmware debug event to the diag channel")
> that received no review feedback. There are no code changes since
> that submission; resending it alongside the two related fixes below.
>
> Patches 2-3 fix how btmtk_usb_hci_wmt_sync() (and its btmtksdio.c /
> btmtkuart.c counterparts) interpret a WMT FUNC_CTRL event that carries
> only the WMT header and no trailing 2-byte status word. Such an event
> is a normal firmware ack for a plain enable/disable request, with the
> result carried in the header's own flag byte, not a failure as the
> current code assumes:
>
>   - Patch 2 fixes this for btmtk.c, where a bounds check already
>     existed (added by e3ac0d9f1a20) but defaulted to the wrong
>     result.
>   - Patch 3 applies the same fix to btmtksdio.c and btmtkuart.c, which
>     never had a bounds check for this event at all and read 2 bytes
>     past the end of the received SKB whenever firmware sent the short
>     form. While there, it also adds the missing base WMT header length
>     check that btmtk.c already has (skb_pull_data() before touching
>     wmt_evt->whdr.op), since these two files were unconditionally
>     dereferencing that field with no length validation at all.
>
> Chris Lu (3):
>   Bluetooth: btmtk: Route firmware debug event to the diag channel
>   Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events
>   Bluetooth: btmtksdio, btmtkuart: validate WMT event length before
>     struct access
>
>  drivers/bluetooth/btmtk.c     |  8 +++++++-
>  drivers/bluetooth/btmtksdio.c | 20 +++++++++++++++++++-
>  drivers/bluetooth/btmtkuart.c | 19 ++++++++++++++++++-
>  3 files changed, 44 insertions(+), 3 deletions(-)
>
> --
> 2.45.2

Sashiko flagged a problem regarding the usage of ACL connection handle
without masking the PB field:

https://sashiko.dev/#/patchset/20260911104234.2276126-1-chris.lu%40mediatek=
.com

If the HCI fragmentation doesn't apply to these handles, please add a
comment regarding it; otherwise, users like Sashiko will keep flagging
it going forward.


--=20
Luiz Augusto von Dentz
