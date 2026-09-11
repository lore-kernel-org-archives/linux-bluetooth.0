Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185373DD526
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095424; cv=pass; b=TcThIoiJrczcnifnDkRjPs0yKjcb5fwKoiiymapGdslPI4GTFSx5CGI/oSoAqr4hBPQWajoIiqhvx5mD9WZXyjPCz0EgR/wFVRSp2j+KaB2WdjhjGrWifMRxwkbe0pRssefKrr74WG9COxAedOb4y2LP4eBX/YQKbBf1VNgSF48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095424; c=relaxed/simple;
	bh=cjFVbWr0n2PHwZEZYXTrr8FI/1Tll+OCkxuLUvZ3xws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJfGDzY22oLhhmtbK43zmN2FRwcpA6EiWFn9oyQbjeNSJlCmMGSyx6ANiZI0YGJmPpUvOAxzBqpbWopeLnMvH9GKaycPIPkb4Ur0lFbDsuw+Z/KfDMCbGvpiNXSwEBHQSuli39vzbWQbrroTt9/tkZ8DagsuzPJgwNThny2JeqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjN1hGJx; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjN1hGJx"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b568dae0e8so450766e87.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789095420; cv=none;
        d=google.com; s=arc-20260327;
        b=iiTCv3Yj712TeFBBKGEt7msusEiq0BHOAzN7ZM75/eL61n5UMHQlvoub7D31plSENu
         SkoxFou/Y2siMIXM7VEaiQQucPXAkVoQUUiUIy07ytakwCEDziBQpJNRWoRATuHv5xag
         prKiQHZqg0kOyFCxPy7YZd22Vfo5EIJt3HjvUiq8cb4gXN1YpE0y4GvqPUeh3tKAruU8
         E1sTQAyGdFk6LXWTeY5/AlGr6x1Lu2mFegY63Wlbbt2PO/Gj9CTt52cOstY37686Dqgm
         S/StnehREh4jtGlhUj9k+Q14SeMDYY5pw1If3hMEzCdeLChyEhSzg/B1m4eEu2KP9pcI
         xAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yO3bAnLYqUUnMiJVzUh/kgUvHixuF89y5iw3GDpzNnU=;
        fh=b+vYqsvc1k4Z5hjAPm2K4bZJasGvbb0pj1ZeSx+i5wk=;
        b=q4zUeXheo49msR7LVMCY7kxa62oesE2sY5NhVR6qO0CJnz1BdXR7ftQgjT415np5qF
         AhG8JGFqae50iYJKz2fc2p9QWzO6L2r3M9FSordthuFEc+D3sYfgGdESaPTXbTHCmYDl
         wqK96B5uEUofp7MWtp+VZkOTG+MZqV3IjzfjsrXkzMKlmHxGbr62+BEw7DjZtTYwaf1h
         YaiULKfzOwYq1Y4p/FfAPTt2lygxhwfs8eILZXJDGSZkmzE1dmNrHOl2u8KyvNU92U5G
         nzxWdNhPGrims18YKEMstS5OLZVQAOyAK311XS5fnBjA2haqAJeT/uFSElScYcp66qxg
         zNlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095420; x=1789700220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yO3bAnLYqUUnMiJVzUh/kgUvHixuF89y5iw3GDpzNnU=;
        b=OjN1hGJxa1eV0wS1zsAxDaK9Cv4e1UWYfPQm4+dK8vsDP5h+f8zLvfnmNQPVrEgt6i
         NuuTruMJlmVtGmpnppBZuBFisqJuxtgyE/KlCSkKsS1IA6NH8j0n/LVC6/VGQ7g3V5W3
         NDTNQ7rV4k9U+RGLtNf7WkpjrLSf/szw0WWXkGCXYctyfT8yPfNQt5khQ9crkAlVHgfn
         bRANcA4m6yjVYWvhhqH2dhj6cKhfL60h4blWo8OKfgVwNa5PNufe+ZRQqmf+Xp3qrj5X
         fz0VHFFHoAihPXhMq/eNzkyhp6kuC6hCLoPBmNTi2du55QZoj2OyooO/KOnKbbdNhf1Y
         Zbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095420; x=1789700220;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yO3bAnLYqUUnMiJVzUh/kgUvHixuF89y5iw3GDpzNnU=;
        b=NMasD4ITKvUagwueUBFL8hQiqneM9+W5dmMZ5I3wPeTCWg1K+3Sb2OrcrfhWBMxuaH
         lcyb5z2mtqfluML3ZvfgRE8Fx82kMSybUS885slBY65GHWoLNtxW0vcKxykivdbeIQkF
         imhgkGT1X+D9byWM+/8wnFJtfmLrKRCQ8AMDQr4wb9JxrvV6OvCCTYP3nbDpKQgGgSMq
         ISc95fe0xy6fad9R4m6n7PfVndQ3AEe+esKDiVAIczQdoSzZxDhcvw5mAzTODqp/n5fW
         AwrgTeEO3JzJFwdf+mtJG/D+Lr0uORCu5fjiDrulaDYcOq1de1ccGuIMRUvEaobxF67y
         JJXg==
X-Forwarded-Encrypted: i=1; AKwUvBzgA0Qqrb2m/XLOX8TluYiNgtuIDkOf2ZdXyY+K/9y0IrgCCY3zrgeb405EdcUAVCcFUgiqb2RnO9vaeMaEXFs=@vger.kernel.org
X-Gm-Message-State: AFuF++le5GvNK05rXEhrKqswzdwVNtJajt4cINTJyO5NypWjx7pPlL3v
	yNuil7thHihYzc7j6rAcWZahRwZKZVmlZ6GvQ4Xur1d9UzW70lKH73A2zG4Ei/btVFvu/xpDlKV
	BCDvIUZsepI0ApTqacI3385gQ2JQgkyI=
X-Gm-Gg: AYBFou0T3PTqYJwJ8QC/NrVl+gH2rsOyTb6PkevFYNvDgq+GKPDlevywVz5Q0IZfxsL
	jIp1QRUaeQzamv8Cixxit2D0Ds1lJ/z3McBGlNIe18FVe0E0FcNKUP46gMmzIqM+d5TaKQAd94e
	6V8//eRfMdXt8+yemyjTheztK0V5gemwb4HlFpv/dsWhejPxyf16lYAAe3kdM/5YaQhy+bk6+Wj
	EKY7XZySgl2NCSul4YdV0gIVP3WhxAIFk4RaByoRjp8W8qEB8nIj5mUybqKfhMMRaXv6ROqTOmU
	zelG36rClh9GhtB05vFZgwOR5eEyjCPbFsCqyuh1OQZxjjSGh/5o9yUbNk676qRKC9Duhhd+VhU
	ypLUmzlbFYqoU4ggV3aDfhtpIZTc71IULPsKICJ3AxHQ=
X-Received: by 2002:a05:6512:a8d:b0:5b6:1a7c:fd96 with SMTP id
 2adb3069b0e04-5b8a0341041mr462708e87.60.1789095420245; Thu, 10 Sep 2026
 19:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-bcm4356a3-bt-v1-1-ffa2d5233360@gmail.com>
 <CALHNRZ9ofDZ61YW-ZN07sf8sZ6gx4n-8SusSR_vop7R_vqbGFA@mail.gmail.com> <CALHNRZ-D1Yz1bgp5hJjwBW32Lhd4Lbt0dQj=3wq-xWqp6uSC7g@mail.gmail.com>
In-Reply-To: <CALHNRZ-D1Yz1bgp5hJjwBW32Lhd4Lbt0dQj=3wq-xWqp6uSC7g@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 10 Sep 2026 21:56:48 -0500
X-Gm-Features: AcwNN1Uzag0xYPXA-kXRdUNQgxzuc2IOdjhNleIZ3o4xeQ4SLLPf_0AlDlCQ3sw
Message-ID: <CALHNRZ80CF9Rp0SaDzfgSPSBMWMG+QQ-7FphLAYadt=dRv+qGA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
To: webgeek1234@gmail.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 1:16=E2=80=AFAM Aaron Kling <webgeek1234@gmail.com> =
wrote:
>
> On Tue, Aug 25, 2026 at 5:34=E2=80=AFPM Aaron Kling <webgeek1234@gmail.co=
m> wrote:
> >
> > On Fri, Jul 17, 2026 at 4:41=E2=80=AFPM Aaron Kling via B4 Relay
> > <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > >
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > This patch adds the device ID for the bluetooth chip used in the
> > > Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  drivers/bluetooth/btbcm.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> > > index 463d59890befe..14acea7325478 100644
> > > --- a/drivers/bluetooth/btbcm.c
> > > +++ b/drivers/bluetooth/btbcm.c
> > > @@ -506,6 +506,7 @@ static const struct bcm_subver_table bcm_uart_sub=
ver_table[] =3D {
> > >         { 0x6606, "BCM4345C5"   },      /* 003.006.006 */
> > >         { 0x230f, "BCM4356A2"   },      /* 001.003.015 */
> > >         { 0x2310, "BCM4343A2"   },      /* 001.003.016 */
> > > +       { 0x2409, "BCM4356A3"   },      /* 001.004.009 */
> > >         { 0x220e, "BCM20702A1"  },      /* 001.002.014 */
> > >         { 0x420d, "BCM4349B1"   },      /* 002.002.013 */
> > >         { 0x420e, "BCM4349B1"   },      /* 002.002.014 */
> > >
> > > ---
> > > base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
> > > change-id: 20260717-bcm4356a3-bt-cd78cc0f42e8
> > >
> > > Best regards,
> > > --
> > > Aaron Kling <webgeek1234@gmail.com>
> >
> > Are there any thoughts on this change? If not, could it get picked up p=
lease?
>
> I see other changes were picked up a few days ago. Is there a reason
> this one hasn't been picked up yet?

Something appears to have gone very wrong with the automation related
to this change. Patchwork reports the id as archived. The
auto-generated github pr shows as closed with unmerged changes, and
appears to have been pushed over with completely unrelated changes.
Can someone please take a look at this?

Aaron
