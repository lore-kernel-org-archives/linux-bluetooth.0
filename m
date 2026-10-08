Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13683AAF55
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476271; cv=pass; b=aKYiquo8G3GYHjtEZ0ftsLcFZOBLNB055sQS0wCjQLjWsY5nBj+x4vDcU+4fX6pb9OcGdiQr98FeFtBvF4MmSWk8v5XtzeUSMF9cw2mL2SVCTkF/wua248GRmO2pUQag4K/o52NwaVdFVvNdiE4mcwJ7L8wH82km+8TToPH77lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476271; c=relaxed/simple;
	bh=YD5Zk2+iTaJ4IX+4uZHg0/DRAluh5rhgdjjO2MhEgWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMGXOWTxrFTomWjRUgQkDzReEn9OVB1M4aK0ItjQo+UncJJYvQAYWLl5M6/Hu8fAR+j+xxSBnB6oZ4k+ijnAm/pMNVb2LgoH3xEn7RXAG7dUtlutkaHh8B5NTQdNJo1mZDhvck6gUv8T2SFUzViQETRS3TZ6QBh91/RdLU/oJIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uhg+WfgH; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uhg+WfgH"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ac9d666d4eso54771317b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 09:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791476267; cv=none;
        d=google.com; s=arc-20260327;
        b=Z5n8KU177XV1ePvbt7RINT/w/4fyXDeuhgL8qAjgZtQ/IGkk9sCjHTXSROkOXyT9oe
         LwYlY27jtroiE9INSmoVw+eJcyJ3HTYnV9zTy8OfTJAcTeR5Fqc8YydnqC53wkP/Ku/F
         NwPNbGJPGd/3QSO5Rviw4fdohTyPIYPCwtBjx7kWR0difB/n8GqyEI4PHy7WFkBTRxst
         krBn8hha96YaoxnMG/u2mPIS6tS7TAxlAGSoip5V4XNeUN+Iu8bfp6tQClF+nGLVkiTE
         aLzyi/ROQHdOjMBqELfndcpyy7tV8TxHdsRKTrD2z6d7JzrT6rajXJGGKEoQZ3VijV2Z
         47lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HYj+9PiUv2ypfZN7nLYBpdJiWthMiSa2+H81JZdT99U=;
        fh=OTtSNNm3oCNIyAZRPy+ZWF1xTfl5Mt4Fu/bK64MKdNc=;
        b=kYLqkzf8OZcKEcEla1urGYuShtSBNjGPLK/zKMPJbXk5tfY5l8J5iYJnP6nB9rDm4m
         lLEwCQ6bOEm+MN7jkxxSB29HpaxHodHNGFv7W4SVwNmpBVbU+s35fw1AlINpSLuWomKX
         rEaBNaaus6CoX2/sR8qiGgQavYT+UsRdDZDGaJc4EmePIfTVVJg7JLcLkuwJw4QsRTAE
         0WO6SwQMvx4zyogOVO5d8+x5XDlNZl2/v8mwUayOeHjnoC/W1zQgw7mg6euRG/OHDAF6
         /8ohOVgb9XzCdzsKRR7SZ2CP2e40NlaXnIxisD7YUMqSxC/dFE8XIWT/yswgMhTjAXVP
         5NFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791476267; x=1792081067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HYj+9PiUv2ypfZN7nLYBpdJiWthMiSa2+H81JZdT99U=;
        b=Uhg+WfgHnjcoY1zS+oASXi83GttaMCdWlLBQjY506kieTrPFDH77YUMI8fKSnr/ibD
         kplsxLYbAW6pqPF57Kexr2Lrw/hgXq7S8mwoPTx3v5bTonqzkRXl+Kfl89MHRgw9HGYb
         OQ2gjf5fE2zH0EMeFWGV/ypVS5xQhZPB0CPuQ2pIOV3XyRewc6Fq2CUrad5Pka8BjlVr
         8zkkcR/A1MiLzTlECD7AXUcyM6g0KzwLLcMlcbxjvb9O2rH2VszvGjmfPCPcDhqw1t30
         6mlgB79dSPWkyQbIXiOUk+pvRwJ0vYDVPv9SkCKQ+2Y1ZVADNknzzenLGjKj7Sy/tJrf
         ZKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791476267; x=1792081067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HYj+9PiUv2ypfZN7nLYBpdJiWthMiSa2+H81JZdT99U=;
        b=hJPCd9WGZDGgoI/u2iOqBhOBaYdHC7MHo1R41/GCSVUxJJUdUIjxPPb8e+k0H8Pnhn
         EQ+/a1DrzreIgXEA+xAdkqbi4O+C3RNLF2Sgp+JyEOROgEwGC2A6QZ6u/OtcHqsDFyxY
         7kbf/Rsma+4H2L2Jqo5Ofma/sVnLwyVccVujet/Wnbl190HAxijYCf+i2sGZCUu+XQPA
         jXfu63lND9R1p39Rt4Ew4/jLPiMP5QnfUCbs6WHudUgOyfy++GiNRH55wwBw313m0vMW
         C2fmonZCnmuK8NxqjTvQ1v5p+yewpyyFmKpYXSzK52fHlSwU8kHBeQd/EIJNJChZ02Gb
         IOEg==
X-Gm-Message-State: AFq9FYIqmUReglciKabgDfWZq1pgiFfLa6ZWt+BngGfM3lFIXRB/zT44
	MmRK2LIKSd2p6JRnfSu+bQJF9vrgwhIkZc0gLSAEPD8EbYBOj9/TjoJFPbwDM+ev9yYz2+jVq2f
	6cALn17JZA0P0dvPH+RZxNVcKbCbeRE/JnCsN
X-Gm-Gg: AYBFou2fuMMDHCt8WyaLtjX2ZcwEB5AbSEhZQVbktZw9FgaFxaj7hcsOnP0CcfyPyz+
	i+HZ3oZc/KXURhV6uQmh9YpkHyUbewm+LNK3gvH8a0mWWsSkwh3jFNAoAFSfjNcVaXSjChPUKQ0
	DjdEEtAi341zXJADkf4EX/9o+4HvTIUnT9oYWHkOlHZ9QL8jNq4pNwEKPQLwhMC/w8yg1Si8aVh
	R4CIXd0Rb+u4V4PpFC1r7/YSztteF/DJSouO7SD7yjYmATDQtxlG96xTzPFSksJgGhtJwFD/JMK
	msFqhsjwi12q4CKwNLdpZSwruzOvxjUVSUuZfIbHvB4I1GlrWIcZB9fZOPdpKpvPRtsJbOPciyu
	Q5EMiqHwuJ+A0eSQ1LCFmNn6iUZ2eq8KuTrpIwaM=
X-Received: by 2002:a05:690c:c50d:b0:8aa:3a3a:1fcb with SMTP id
 00721157ae682-8b05b1445b5mr31121987b3.67.1791476266849; Thu, 08 Oct 2026
 09:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007154353.148223-1-enghitalo@gmail.com> <20261007154353.148223-4-enghitalo@gmail.com>
 <CABBYNZKoSV1_cVJRrdonHT=gKtS6pgoWDM3R5nj5aR0D17SqRg@mail.gmail.com> <20261008152826.2162209-1-enghitalo@gmail.com>
In-Reply-To: <20261008152826.2162209-1-enghitalo@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Oct 2026 12:17:35 -0400
X-Gm-Features: AclHuK-XLzciTkZ03lbRdpXrW52bdi738TY5WQvhuHfZzWnaGA9vG3v7KvyyZUg
Message-ID: <CABBYNZK9Oy2iL5PosxRy1KPup0PgYDfPUxeHemjYjKyAUu4+=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Don't leave abandoned SCO links up in the controller
To: Hitalo Souza <enghitalo@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hitalo,

On Thu, Oct 8, 2026 at 11:28=E2=80=AFAM Hitalo Souza <enghitalo@gmail.com> =
wrote:
>
> Hi Luiz,
>
> On Wed, Oct 7, 2026 at 2:15 PM Luiz Augusto von Dentz <luiz.dentz@gmail.c=
om> wrote:
> > Sashiko flagged quite a few problems:
> >
> > https://sashiko.dev/#/patchset/20261007154353.148223-1-enghitalo%40gmai=
l.com
> >
> > We need to check if the logic of hci_sco_disconnect_orphan couldn't be
> > made more generically, so in case the connection was aborted but we
> > received the connection complete that shall always result in
> > HCI_OP_DISCONNECT so the handle don't stay active in the controller.
>
> Thanks, agreed. v2 does that in two patches:
>
> - when hci_conn_set_handle() refuses the handle because the connection
>   is being aborted, the Connection Complete, Synchronous Connection
>   Complete and LE Connection Complete handlers now disconnect the link,
>   with the abort reason;
> - an ACL link that completes after its connection was already aborted
>   and deleted (an incoming connection, where Create Connection Cancel
>   fails at once) is disconnected too, as SCO links already are.
>
> Both reproduce in an emulator (ACL outgoing and incoming, and LE):
> without them the link stays up. The SCO patch now uses the same helper.

I don't see any new test cases though, so I would appreciate it if you
include them (e.g. l2cap-tester, iso-tester, sco-tester that attempts
to abort the connection in between receiving connection complete
events).

> The other two Sashiko findings are addressed as well: the legacy
> Connection Complete path in the SCO patch, and the air mode
> notification of a SCO link that failed in a separate patch, as it
> predates this series (1f8330ea1692).
>
> v2 is here:
> https://lore.kernel.org/linux-bluetooth/20261008151238.2138665-1-enghital=
o@gmail.com/
>
> Hitalo



--=20
Luiz Augusto von Dentz
