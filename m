Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C43F0760
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972583; cv=pass; b=Tyj1WMtdVQHxThzaulwaESdIOCpdChNVES9WdB1rBk1Hs7mONfwePQsOfpn+oCK+XhlYxtg8IZ7n4GITuefQ58BuJieXOImpWezqkr6qSlaSPHMWoNjLrjP2MdLu333O4rwSfwIJ0khSFhbmWQr1RmNeeKyvjlO+kjZixfCahWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972583; c=relaxed/simple;
	bh=O1leBfAjhLl+B296quJwQjTQO/EbHkB/vXIeJe35+OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZI2t3YT1ceXkG26KoewKMcnxc2WlN5Y53Zw9P/XF+JBDX2D1YstXNqH23mmyq3w7PvHqMkZMAwky9O/JhgCOm1E1ifAqqPvuvNf7HQDtEdjEGIbnGcvFM0R2MtKLZBgFyK7xB9J17rQAhwMDfjdO8DBgieWv1Iqz5OyL9BBl+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrhiELhQ; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrhiELhQ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7ca947f9b00so123349197b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 05:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779972579; cv=none;
        d=google.com; s=arc-20240605;
        b=bDPUubKVnoJtE0fu27438dQCMpQhvMjSb1xBulw9j4lRi+7lzj4/mEipizWV7lMKPS
         /kRHvUu9e4nj3351T81sT+HphRaEgdcX9Ga1fvzG8K4MQgi5a/PMjzKJFTEuMx/vXFOU
         SufX6LQfjfGQMdO2J0OrjVoniMEyNpJJGow5Nh/kuGQFdceba5ZibDLTiuOg6TGGYV6E
         4VempmIM36dV+vLQUr5D9XtA/1oXN1w5/QUQ8VkDmIsnDKQG8m2T2f5HPqtYgwyyGpqx
         eiVQGecSjEL+Uao08LmEzTerrwazTvx/MJz3yTZ0H9P1HlQDjmLatf5QJkCr7qjZfKWU
         QANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+6REFe2jdBaVPIX3Z2aJKta6DVmaqsM4BMxZnOJa2yY=;
        fh=dUmHEemyYuc3Eb0D3RaanUMvUwy9Pgt3mLtTUynpT0I=;
        b=OKPhnIK4Ehv7VAwB11wPoc5HOKp/YKvzWWbKOfTU8Y8vYreDfVv05xlPB9jOkfeSmg
         yYWmPBZ8tv3DCAn/AThd57Vs/uiHRpJVIvCHlrYdpsVpYULGUEwbarHcfCsiA2BHbAiO
         wtBXWUERb3FTjfOs5TuCtpUaCxOVp+Rx3xtLIaYt3zIa31gR0DxhMt1A7oycfWU5xjOM
         Uq3HH3dXSd8nLLGHtMVUh/wp/+AwiuGVq6pZDtX0iN8Tt/IuwOaxt+A5Emxs3bZJB5CX
         A3B86REPO68X6tALn+VQRPokiFzxW8WRe4gIeAu8Yd59zaS6pHofjfti5C34wXyP9Xn8
         0yIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779972579; x=1780577379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6REFe2jdBaVPIX3Z2aJKta6DVmaqsM4BMxZnOJa2yY=;
        b=hrhiELhQMWGMmPu1lCUrvB1VMTbqARmdASbAuWJ+TU6uV0Yp//suIOvWeOUNQ8Vg9Q
         KaXI2++5yq3/m4bf0QToPWgBQV9sPFLoYyivg71N/z3gP3ltbPa8nVvoJVDlS9RyCu/N
         LLc0LCEaxCIGf9bXcENPz62WKo5bxGd1tNY94TBZVr5/prNLMq1zOd0GlgeOjc6eB0fh
         ZaO0f8tbavQHGYPWGg7BXtVEJutlYhSZTTKHe8wJxb0Gc9TpLp+f74T15CwBALR8mmW4
         cKAOl/9NVkQ1boJqoBLTtkcF619wSprJxUMmh5cQCr9bDaYJDJ1pbvyoQcjQxBB705va
         jvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779972579; x=1780577379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6REFe2jdBaVPIX3Z2aJKta6DVmaqsM4BMxZnOJa2yY=;
        b=r10MrpyM8/3TLasP0NxbzJ81eHBchM+O2aplnDfylFdbKaQrYbTTCqPF6hCiPnHqXF
         C8x7/bzmLsrcVkpR8uB1povLhqiWjPHcPUwbJzNLI7oG/6EJ7qys9hen3SgFY5ClkqXc
         28UMOkmtAOmnaj1LN/jXS80hJ5K07smVzlJLuhSjArScNMSDdUcPTU6DMwZdJTAYfqFS
         FHDO1wrq3r/+0HDEFcEYQgwGqXig514xMWHSxmJa0hB41eB7x631GFsRMg2HSXRAWTtE
         A+oad7/vR8VcGfj6Ef6wovcg45rnoB1GDA4SXPjSVlbxzhbp+Gn8Mr28QlDBIgtRJjYa
         RAqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Xg4w/gDtnlmnzL0rViwDbHz91xQMiTY+kBesJ3MUU6NWIVoJA6DyY0IZJvctCzPrnbsxCXpRgPWDdvLGJNiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/7gtCvLtqQP/kZ7hDEt4eRGIXv/jDJwmuBXs6t2Wsw5TKhdo
	c0QOfjVwyoMA/kzIngctx4+U1MLatvhJIevrZQ0SCy+tcQ2g2exUckJ61C6Xwr9vbCUTTpqKsZM
	KqTwCQacxXTSUF7O94PLaqR7QlusfQwruFw==
X-Gm-Gg: Acq92OFVJ9ogetKMoxxLAiyK1yVRL0MQRtC/qgOBl0hwLiEWimQltTo+y3oNac8f/ML
	5m1bTIMeEANEvhJvimdCh53o0skkOx4sZnIpjYowE/fHn1+lUDA1ESLq36gB0D1urNTd8rjtIR/
	/a3PIc2W6hEKjZHdevpowmyzgQtmUWE92OI6m9D8hyUzrKhiLiVUpO3hhYIEuDBjfHLnk96CSxn
	ORbbcflh3O5MLyBraAkPDXBbxcLrT2D+bf61IkPY/qjrPXBpmQvC036E7L51gemyvyJE+zrrjfW
	J7c7si5bg/lWURpbde/NxFbJbsg3dw/z3m8/bNhJvjpoSkv3tL2nRuT/0VMPj6jQqa/n0iLfA05
	UnwmaY3Yx6CcIJn0=
X-Received: by 2002:a05:690c:6c87:b0:7cf:c382:c70e with SMTP id
 00721157ae682-7d330cd5cc8mr294744517b3.0.1779972579187; Thu, 28 May 2026
 05:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527211246.371451-1-luiz.dentz@gmail.com> <20260527192430.1b490571@kernel.org>
In-Reply-To: <20260527192430.1b490571@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 28 May 2026 08:49:28 -0400
X-Gm-Features: AVHnY4IsTfqqjVFEkEIh-kXmxc2mA-_lWLHMnywwxXXJ6FcFD18NpOg6IgHAeuY
Message-ID: <CABBYNZ+wWpHZ6v-T+Ov8fiC4q4prDp54DFQcOWOnf6iBzKxXmQ@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-27
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub

Yeah, I'm still rebasing. Will amend that commit to add the missing sign-of=
f.

--=20
Luiz Augusto von Dentz

On Wed, May 27, 2026 at 10:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 27 May 2026 17:12:46 -0400 Luiz Augusto von Dentz wrote:
> > The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48=
e022:
> >
> >   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()=
 (2026-05-20 16:35:47 -0400)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git=
 tags/for-net-2026-05-27
> >
> > for you to fetch changes up to df35e8e0c8c4160c881bb673e3c7ee010824fbd5=
:
> >
> >   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2=
026-05-27 16:44:02 -0400)
>
> Are you still rebasing? Or did Linus convince you not to? :)
> Looks like we are missing your sign-off on:
>
> Commit c3d01980c64a ("Bluetooth: l2cap: clear chan->ident on ECRED reconf=
iguration success")
>         committer Signed-off-by missing
>         author email:    kipreyyy@gmail.com
>         committer email: luiz.von.dentz@intel.com
>         Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
>
> If you're planning to no longer rebase your tress - don't worry about
> it. It's not a deal breaker. If you are rebasing anyway - could you
> amend?



--=20
Luiz Augusto von Dentz
