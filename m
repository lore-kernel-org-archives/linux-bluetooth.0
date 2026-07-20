Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4034738F227
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573896; cv=pass; b=aNoD6fx0DEin2zB7/cLe+9hoLpAKO+a+RGixjFxdywoW7RkRonJ2g4ryCQIhcqZAlGehQ3RuVYYuuCC+aFMG2anVtJrQSCxtfGoevxrslPWR9oKjNfIXNhScG7bXTJY8c3MxRV95IW0bL/n3dm1gaHvCshftnp0a+eTTtIFyZjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573896; c=relaxed/simple;
	bh=5BaCLeEsW+JEvrVXsm4ZvsLyFs/NV4iIbdyNWZSxN0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCO38dCsLZtk6OPiOySHItTeLVFCProYj6qQpaN3YoA5T860JWdGfPaunPDAZ+P8XM7JHVugOizTnlLk9uCYCjTH7DB7CLVCIe0MESM8KOQZ1bilQh0If00y/AqShS5vHKQU/Ozl2MqBC7RxT9fjoMgWMOH5uoYzz88Rd4paUqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0R3OhAI; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0R3OhAI"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80e2cfe6918so59114907b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 11:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784573894; cv=none;
        d=google.com; s=arc-20260327;
        b=lgVy7SDdPMxj3q0r0TBmdk6JUY1XyJgigsw4YziRMvtpT8fzzY0xQuxNSgT4D/z6uZ
         gwQ1v/Jfk3Sg4mgOjE8RSY+N+YiIPH6twTRj7F2WHci1qN/nTWvb5zldo0o8rIxKLwOV
         dbsJXS1fbU/VDF/REn7A8tsS6DuDIR8BnSDb6piPGrRH7lqyq4mviQ/Id1EUXd2M85D/
         rocBG5NgUj7XGuLwE5XdXrmrVfsCMVQKj3jGWo3xagFmNWvI66DzQVgFFLfHf768i3L0
         1h8CM+EC9dFwXdV6cX9pJWUgB3BbxdGupl5cwv3MCJgZAkCH8toypLg7R73X0FKwFy+3
         PoIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcQfVm6sD6AmNgehNUy1OoDPrBVMT1KlGr1znsVrGfM=;
        fh=OVKswAkwWiYRiw4/jm1+w+lY4E/3x/2/3xjGrBhrIWo=;
        b=f8H+iL8CzPN9Do71KlC4dve8HTBAxL07yGk0Mx+WbRBLZng3HbohAcWprblw/E2Ifc
         7pT/tly9Yqp+bWBJGMa+9kfEIa03Ij3mHUkRcqgIBvZeqHdlcVYppAKDuXIOGxsRkMuB
         v6k2WTXeeyId0H0AQLKQYmD9BxiNwLTNRmEflfrgfe6/ISUcoMMc+pRITzI0FvpfFrve
         ckhpCanzXOyiS9JiH4cO+weKOMfAHsGzbwU9FtmmxI5eXB6sQFM7HdhSU8Y6OEfaOjT8
         sHImsi4Pib9XESt76Ew9ifnpnLNkMUsKUj2g8+jsjI/xV2Z7/VXeHqpKVJREhJ1GM17k
         ohIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784573894; x=1785178694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QcQfVm6sD6AmNgehNUy1OoDPrBVMT1KlGr1znsVrGfM=;
        b=S0R3OhAIn3e2LsBoL40KHxSNjDRHwq3//QNasZL6/hUY8CZbYqopsd0peEvqBb1Rip
         6xSsKfPC7H4O4VUSxXVzB9Be59rUjpu0f2D21aJrC7toSv52DPkUselEuHxmTJbbpPwh
         gGph+cjUMSrBQGJWJiAtzf96mcySMc/YUtqJRUkidpPGgikLG+ghuITobBEkRR9EP4aO
         9BM3k4Z4Lk/dDTC2td1+vWcG96YygczR5diGBRh5Uw3nn2zi3DrWIZ4zXI4QpbYR8aiu
         sIZURLt5jZJXS9rOSnlupUrQH+li1ZuIHOAz1nszPdR8ajuqkTDPxi71x70MDfRCp9Pm
         COyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784573894; x=1785178694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QcQfVm6sD6AmNgehNUy1OoDPrBVMT1KlGr1znsVrGfM=;
        b=eoNgd6SWfyKoYMTFPLd0FGSMsA37JOCI7yd47yQk6zVFCKUEKoEn6nd5zda+H3iM9S
         m6PR+s51ro5CdVodbDL7MKm4MpzxZ+5mVDldpij5K4Kf7UF7RudZn7X45YcneCzQGJZF
         /Uq5cOQ/24LkNC5Iz2CTCEJMbyO5q7PHkxEUsVT/UhjdJ3KGIyvJtZiRA5PzrH5CTdZJ
         bExBS8u1IAadjUvZbvdLf/LT5d9mpjJ51/F4IzAG8Crl5y/AGKjI217pjiMQOQsI9SQR
         GNyFg3NIx3EFzXBiDPpG22k7FMQOJU3yS5Fhc1fq06Niutl7dvfgTFDewwWF4bgTU6Q/
         g7+Q==
X-Gm-Message-State: AOJu0Ywj2vXCZ6epE7XjIofeBdSzZygnUl/+pELM1P9mFolbOAYaxUBo
	pvUEIPlfa9cx2RW0HelB+ZK5yvJMa6WvRnJy3NYW2uCyyTRp9BbJtg5RJFvmCJZPod+mfkIoang
	NcZ9tUwAmbmb0IBAtWBDXy/dn7gFVhXeM0HxvVGE=
X-Gm-Gg: AR+sD117USl+Ukceh/iokQGLtjCc/JTV0JHfAynvhUEZkgSJDk0xTW+tkVwCJw8AQ+H
	4k6Sd9k0wYbz+lMZmGHKfUEu6zX188aKzyGAMC5myBHLVX+lYWuWMK2sp/RIbvjwGDPNrgNQ4Lk
	B10IfnDsdc5LPFd6PPUTBDj6DaAHE+GvF6qK0gg570+i82fGgO5e37Dh+zCydlGButT7jCu3Ftr
	YEVnJisUzLXDk8ABb9Hd3gq7dSgRVUaFB8DVKbYguMyZG2RdKSMNiXNc3D4/CQnBtyoBT3eC3HE
	nfWkdDtd9fk6CPhX/kJEZiEyM/GKngNAUubpwzi5SCmSwQ==
X-Received: by 2002:a05:690c:368f:b0:7f4:fad5:2087 with SMTP id
 00721157ae682-81ef25e0e38mr53195217b3.38.1784573894025; Mon, 20 Jul 2026
 11:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718194230.35959-1-pip@pipobscure.com>
In-Reply-To: <20260718194230.35959-1-pip@pipobscure.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 14:58:01 -0400
X-Gm-Features: AUfX_mzl1Vpzfrk5Ipct78iTYdtfwHyCArYVkW0fYdxIyiaSiVRSeYoZc2B8Q4Q
Message-ID: <CABBYNZKLqADWu4rAmg9K_MbtXiLE6Xwr=QVYJva2PxGGKE4TvA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] Don't auto-bond on reactive GATT security elevation
To: Philipp Dunkel <pip@pipobscure.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Sat, Jul 18, 2026 at 3:43=E2=80=AFPM Philipp Dunkel <pip@pipobscure.com>=
 wrote:
>
> bluetoothd probes every freshly connected LE peer as a GATT client
> through its built-in profiles (battery, mcp, ...). When such a probe
> reads a characteristic the peer has protected, the peer answers with
> Insufficient Authentication (0x05), and change_security() reacts by
> raising BT_SECURITY on the ATT socket. On an unbonded LE link that
> starts SMP pairing, so the user is shown a pairing prompt for a device
> that merely came into range -- a bond nobody requested, logged as a
> device_bonding_complete() bond with a (nil) requestor.

You will need to determine which plugins are discovering attributes
that may require encryption and disable them since they won't function
otherwise and are probably just dead weight at that point. Also I
don't think there is an easy policy to determine the roles of each
side since "client" doesn't necessarily mean central, nor does
peripheral necessarily mean server.

> The existing opt-out does not help: change_security() only bails when
> chan->sec_level !=3D BT_ATT_SECURITY_AUTO, but sec_level is recorded for
> BT_ATT_LOCAL channels only, so an L2CAP/LE channel stays at AUTO for its
> whole lifetime and always elevates.
>
> Patch 1 adds bt_att_set_no_auto_sec(), a per-bt_att flag that makes
> change_security() refuse to elevate, and sets it from gatt_client_init()
> for any link that is neither bonded nor in a requested bonding.
> In-progress Pair() and already-bonded devices keep their existing
> elevation paths untouched.
>
> Patch 2 adds a unit test: it arms AUTO security and then forbids
> elevation, asserting the auth error is delivered to the caller with no
> retry on the wire. Without patch 1 the client retries and the test
> aborts on the unexpected Read Request.
>
> Tested against Android (Galaxy Z Flip 4), iOS (iPhone) and macOS
> (MacBook): each connects and is probed with no unsolicited pairing
> prompt, while explicit pairing continues to work.

Why are you connecting in the first place? Who is advertising?
Actually if you end up with an encrypted link, that's a win in terms
of security, so why would it be a bad thing?

> Both patches were developed with the assistance of an AI model
> (Claude Opus 4.8), disclosed per-patch with an Assisted-by: trailer.
> Every line was reviewed by me and the result was built, run and tested
> on the hardware above -- behaviour observed, not inferred.
>
> Philipp Dunkel (2):
>   shared/att: don't auto-bond on reactive elevation
>   unit/test-gatt: cover no-auto-sec on auth error
>
>  src/device.c     | 13 +++++++++++++
>  src/shared/att.c | 20 ++++++++++++++++++++
>  src/shared/att.h |  1 +
>  unit/test-gatt.c | 28 ++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+)
>
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
