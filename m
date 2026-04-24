Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A3324B1F
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059535; cv=pass; b=TvgOzjZX0wqrXYhZ/fhk9wbJuqoYxmSVKRYQZtXquKvrMY1C8V2/SLCElNUUhDKLkN7UYEJp02+fZSoY0ol5YihBgRXXisGMJJ8bcDQM0aJPxnej/TzkfQPe/AGCCX9TsAL5z4/RKDUiY8/Mu8ATQB6SOg4VmQByHDEtWmko5sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059535; c=relaxed/simple;
	bh=MRDIRfxvarOgW+ZYLrC+QQoe9hq0C/Aai/h+HM6/kak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLiRtx1YtaIhjxoMT1TTbbr/ShjoO77e0xm6SkL48Z6t64FrG5xFmFR6m+hdFSrRZKYBzegi0s0ihTUZFLmimpnE+XICF0/pKsbqwihQgatB0Sp9QvgsJEAjbDbjKXsWKw17BA/+vlRlLccWJHmq6NB6xkab3gQB8klceAZCH64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naHuPJlv; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naHuPJlv"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-652f220595fso8622035d50.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 12:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777059533; cv=none;
        d=google.com; s=arc-20240605;
        b=GaVf8OngMCYyYUvKdvPrP+2XR4E1WM+sS7Trautfvef8p3BjB9J8X3Ic80EOH6utKA
         lR+GgW5mhhqHh/6nGWyxvIGZeg+exzhhqYE/VoATuKDZyNYFhPXW9uhubn9jehSVGyaI
         C0/2DhKFX+ny5x/v2mUPB3TPyo+cVhGuHwZii+PPyvvjnwvtdWRhuj4kxG2aWKnqG+br
         XryC6uvoB7yn+oDYOu8I7iLdOaRKSkyJ5WpeShrAmzsofXhGVV6y20oYr2B12+v14mL4
         UBDbePBdeftf61uaP1HcihXh3oaUdV7lQ01yyXBcaQ3CjlYLqlMCGaIH84mPTD87RVTw
         nmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GCNnQDUxEchu4FNyI6KaJj/nrZ702FB7670JqnkUaFA=;
        fh=QfgfpuFyaxB1VtO+ysOEh2QCrtLl/vUzsERp/TyV/tM=;
        b=QuR71M2rEPVKBurIFYyPvc6AqMZTFcSxfX39eQTUVWxldtO6x0qp20feCtIpA6Ly8z
         q6+eYp4BECzjsjOZGs4/W+9U3Humf3TWOUEYFxDBE4Fi40uHCuTGEz3estp5tq4/2p/W
         95z2V4pT5WGI7XpuAhqbOLISmBihc8yGlF3w1j+vc0sCU2Oel+bemyLqiAbhjt9prOXQ
         +jSx/OWCOlZQLrFdfhq8e8nlER/abjllYjzf9oUmWyJu++E/0wNKoNEd8TLskKJksmDQ
         lJ8hZHBO3BB5gPvmkiwMD3nx9TTmUt15Bd5r5Pj3Un2XwjuEfRYaLmLNxTn9VAS2jOaY
         Q4Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777059533; x=1777664333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCNnQDUxEchu4FNyI6KaJj/nrZ702FB7670JqnkUaFA=;
        b=naHuPJlvvAjACF3fjx2zY7aEH9YyEXC9CJmhzI1kchOqqXslNewrIU7soR4RvLMcbl
         cTrYX/OQ5HzqfmYJnjxM+GrLaaRNDYs2d+g/d16N4ue+kgCYnGvAkCCQoB1FugaTkJqN
         /NeGOuEOujTVOL+6CHGdgcHzjSU3nvi9LEc2my4OxoVgHTGbF/GjBHVx1itd652zv3mR
         ee+1d2S6NKYT/5zdXhsdKGkTF0HqMC9LQSVqMqptRg9PUyyy1pKeNdoMtVaVqKLsLLO6
         qjAD1GSj7dU78SZplLPnplQayR255wM9il/Hf/rAsV33Me81OgBY4mLeDqtlnErYbS/k
         7/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777059533; x=1777664333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCNnQDUxEchu4FNyI6KaJj/nrZ702FB7670JqnkUaFA=;
        b=qH86KviEcJWu0udL7hfr/VxXUryW7J+dBGJwOaLa8HmMEHGQ0v9swjpnEfRu2VDu99
         aHiG7kQFuK9tKaBtjqYcACLiceXnXekInKl3+rnKT2XPUQvOPHPYKd4JP2avtJqY2IQN
         OKOxj0uyZDYe7kP5mphX0ra5cMM6HPsemZeakavD4dm0gBchboSVBe7PeYzfyKLDxxgg
         /D2+cspHHRTDY0OmYSxIREUbV/L76HK3ktTftyp8/gmB5ck0kOM/hB00Lm0FguQGYmAr
         2JUZomD1sVHnOZY5/crO51l+IRr62HRAmJC/XYXSB+5wbug2bk6K2D88SfRnsF51UCEE
         7VHw==
X-Gm-Message-State: AOJu0Ywstr1cX4V+eTup+kBtuY7kem4QT2JTbfLGXHDR+T8sVezmIQFV
	MI8rfaX4WF278ItfDZ2kxnL26Pyt3Omkd5GSTogyzycfSREKMhQkefiinh5T0yHSq7QgTvzS3gP
	4VDNkwpaShCjG+/55qDTfVpnEpOtnqoQ=
X-Gm-Gg: AeBDievuUWDxdVgM5s5zfENqVLhMQkMgGUL1D3/xQ3UisLM45PxAp1r8C76JqF+t99q
	NoPeg5RGIA6hpFMIt5Q4bENgbSMlS9ukuZWD9pSC3Z1smEZAaVB3HVHGlxo/xHBsiKe8Kfkchio
	QNoOP6GyIYs8T7a+VVLVj2f6qYlHVVnZvyYKPg3LgV9DiYYQ+agYHA4xumeN5/4hPQrWgDB+NVx
	KkEjhW8lAI/sWhdtmHFwPAswbS+mzqjfBZo4TLt4enHIsPwoBh1VdwIf2y7B+kICdrjomjOcARp
	ORDxA6mcbBPQC4sXChF9kZVDkAg8KbO68EVbw6NpaNoHwmN2sMDiVY/HuU3LF6CovvAa+T8QM1S
	hHnSLDjRzC/Jr4kM=
X-Received: by 2002:a05:690e:d56:b0:64c:af3f:e2a3 with SMTP id
 956f58d0204a3-65310a7e203mr25561744d50.55.1777059533014; Fri, 24 Apr 2026
 12:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
In-Reply-To: <770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Apr 2026 15:38:41 -0400
X-Gm-Features: AQROBzDhDYXNch-tOMSEEQLPsmr7KizOzoNUP3VoVe7ksdz9u-pNewyslVDZrso
Message-ID: <CABBYNZ+jM+2BQ4Fek87OCKbyvuxjsyeCG0qpGRkAO4LA=pj4xw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	tristan@talencesecurity.com, linux-mediatek@lists.infradead.org, 
	sean.wang@mediatek.com, mark-yw.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli, Tristan,

On Fri, Apr 24, 2026 at 3:25=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> MT7925 (USB ID 0e8d:e025) on fw version 20260106153314 sends WMT
> FUNC_CTRL events that are missing the status field.
>
> Prior to commit 006b9943b982 ("Bluetooth: btmtk: validate WMT event SKB
> length before struct access") the status was read from out-of-bounds of
> SKB data, which usually would result to success with
> BTMTK_WMT_ON_UNDONE, although I don't know the intent here.  The bounds
> check added in that commit returns with error instead, producing
> "Bluetooth: hci0: Failed to send wmt func ctrl (-22)" and makes the
> device unusable.
>
> Fix the regression by interpreting too short packet as status
> BTMTK_WMT_ON_UNDONE, which makes the device work normally again.
>
> Fixes: 006b9943b982 ("Bluetooth: btmtk: validate WMT event SKB length bef=
ore struct access")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     AFAICS the commit is not yet pulled and is only in bluetooth-next, so
>     maybe this should be just fixup?

Yeah, I'll most likely fix it in place and add your Signed-off-by.

>  drivers/bluetooth/btmtk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index ab34f1dd42bc..68a32d11e5ec 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -719,8 +719,8 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hde=
v,
>         case BTMTK_WMT_FUNC_CTRL:
>                 if (!skb_pull_data(data->evt_skb,
>                                    sizeof(wmt_evt_funcc->status))) {
> -                       err =3D -EINVAL;
> -                       goto err_free_skb;
> +                       status =3D BTMTK_WMT_ON_UNDONE;
> +                       break;

This probably means the original change was never tested on real
hardware. We likely need input from the MediaTek team on how to handle
these events, as I don't think a public spec exists.

>                 }
>
>                 wmt_evt_funcc =3D (struct btmtk_hci_wmt_evt_funcc *)wmt_e=
vt;
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
