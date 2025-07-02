Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C968A55
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461345; cv=none; b=q7Gn+r6Uwjo6e8w6nSsdby6Qyc1Y/uQTa5yg31o1ELRgcGLQvbtDasz2B+4UpkWEsAZqOq5ZklGRMTaQ6Uxzg0RtfgW55dJeBHnrW8NaomniEDffp2n3u1qCj6WF0DGoCf380dOyGmxSYGyzxJyzUWtsfrf3m0Vr3T+I98oIUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461345; c=relaxed/simple;
	bh=dHD6+VKYxVOg3w3JBF1YLYafUaxHSq3EfMI+XMJWy/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKepqI/Fln3ok4juxvLhdlPZ53Kcr+N9srNs96YB11X6vUTs+6a2QQDI51oPPZzdX2+KdOSPhoWRK/lTwxFGDH8J6/eNbodyA1ZLkUxFsJmuh8u6hMP/QmDNJYtcjNEAzddIHhiXE/t2yulTpHfOx9eMlQCcRMxevEdz5KYfQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP2nBg03; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP2nBg03"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b31d592bbe8so5195716a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751461343; x=1752066143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zth6+LNTo1T2PXsAFfPWk2oi1VQiR6s+X3T/rJS6TbY=;
        b=IP2nBg03+FI8U4n6CIE/yYJ9FyqSMN8sUZ7Ev9HFdQPzpvowC39VcJ/INuU89feW/R
         vZ3dby5+SgKJBTp4w4wVPGYQTWtShdlfiVor11vjDdU39Uj7iuWlQzIRX3PyvOmx+65v
         7u5ySDT2UNXo3fs4hygYT9paVSJrQdzRMmq2X64uAaBVD2MGuXinidEmTv9lbDZmlSXm
         ncLlN+x4WUzhqGFztsZ7XIjYWWkhLzB3tvQws6DhTTxSHi0zKFNDHCoqTHTEYbOEBpjm
         tV/5Gl+rugXHLONp5upwxf233apXFWjy8cFtILvPOYnZ8EUHYKorKXCvS0DKNf/VrDYw
         8H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751461343; x=1752066143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zth6+LNTo1T2PXsAFfPWk2oi1VQiR6s+X3T/rJS6TbY=;
        b=BTrtvZAI829aTFW4eA+r4a9Sa/zKJluLOf3ZfBGAB3yBwYNo81LkDS0kDB30v5k5UM
         af3FZBmf7mkoCwQOJf5+I2cU88PFQ/pwrePXIdUdSC2Ej+mIZeOv+qeLKhbd/MO5yFEX
         YMtLVjHCzfIMT2QKWFp+mEyMAAwNNRw1cXgOzZsAp8VOqsZx80j/9VW++SAnqBkZ/sfD
         WMVjpto3b6jUTScZ+LcxrG0apzvztLBJhOIcHWZEt4hQp4o8rgmKE4UCFalQXQXF+ipu
         /0pEYthyHPt4HPtyAfS92JEZrZt3Y+/xj+GsDkMZzbTCNkGx/B+OXeTqKCYgwlHFhPlj
         yg9w==
X-Gm-Message-State: AOJu0Yy9G6Mfx/jikBHcKqfQGqs2Q2DZY7aCqwFID5a0itLZxNKIeYB+
	//HXaNVXtYfQZbypVLwbOP4R+2q+0N2gasfGrB2cvTjFHw0qRW+T/lSvn3XdwGyoCWLQvw9cVCd
	5LeJ4Gmeb7xKzYmwntoEdLKKUz1EMkA+LfKqA8HM=
X-Gm-Gg: ASbGnctGU3M4z8gHzZ0JRpjiXSUX4jg+6h0OpnaGL+xUITdzw9HXh6kN3QDJSAPD9Fg
	OosnoyhKvRIEDmKAoZV8PFRNiA1zYpeJhK0JDWSwHgMB+1tziB/AMlz1d+EZBVH+TKP3R3Py9Kj
	97Z9/5NBtxS2aVQPJp4yIR0EyAl4nhzUD6J8Y7YXM8aQ==
X-Google-Smtp-Source: AGHT+IFjeGsy0D1cCj3atlF8+tAIPvCpyEi8lSBg1/KrfHQbLyTT9vhk6iQcDUceaMMtN4ECEvdpvAg7LoaiBkFXQRg=
X-Received: by 2002:a17:90b:39c4:b0:312:e9bd:5d37 with SMTP id
 98e67ed59e1d1-31a90afd9a1mr3591763a91.6.1751461342647; Wed, 02 Jul 2025
 06:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-bap_for_big_sync_lost-v3-1-d314b60abf7a@amlogic.com>
In-Reply-To: <20250702-bap_for_big_sync_lost-v3-1-d314b60abf7a@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Jul 2025 09:01:51 -0400
X-Gm-Features: Ac12FXzAK1PJxV2gcp9IBxxM4mtAbMBmxjUIljBuBAVH5cMvuPUfaGre_nsv6Wc
Message-ID: <CABBYNZLNdr5kW=AXYohCOp71CCmvir3hjeBungDHYq2gRD0xEg@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez v3] shared/bap: Add stream state check in stream_disable
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 1, 2025 at 9:19=E2=80=AFPM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> Add a state check so that stream_disable() is a no-op when the stream
> is not in ENABLING or STREAMING state. This prevents unexpected state
> transitions or redundant operations during cleanup.

What is the issue here, do you have traces, debug logs, etc?

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v3:
> - Optimizing the code
> - Link to v2: https://patch.msgid.link/20250630-bap_for_big_sync_lost-v2-=
0-1491b608cda5@amlogic.com
>
> bap for big sync lost
>
> To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
>
> Changes in v2:
> - Add state check in stream_disable.
> - Add type check in stream_io_disconnected.
> - Link to v1: https://patch.msgid.link/20250624-bap_for_big_sync_lost-v1-=
1-0df90a0f55d0@amlogic.com
> ---
>  src/shared/bap.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 40e1c974b..1790b277b 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2131,14 +2131,20 @@ static uint8_t stream_disable(struct bt_bap_strea=
m *stream, struct iovec *rsp)
>
>         ascs_ase_rsp_success(rsp, stream->ep->id);
>
> -       /* Sink can autonomously transit to QOS while source needs to go =
to
> -        * Disabling until BT_ASCS_STOP is received.
> -        */
> -       if (stream->ep->dir =3D=3D BT_BAP_SINK)
> -               stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
> -
> -       if (stream->ep->dir =3D=3D BT_BAP_SOURCE)
> -               stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
> +       switch (stream->ep->state) {
> +               case BT_ASCS_ASE_STATE_ENABLING:
> +               case BT_ASCS_ASE_STATE_STREAMING:
> +                       if (stream->ep->dir =3D=3D BT_BAP_SINK)
> +                               stream_set_state(stream, BT_BAP_STREAM_ST=
ATE_QOS);
> +                       else if (stream->ep->dir =3D=3D BT_BAP_SOURCE)
> +                               /* Sink can autonomously transit to QOS w=
hile source needs to go to
> +                               * Disabling until BT_ASCS_STOP is receive=
d.
> +                               */
> +                               stream_set_state(stream, BT_BAP_STREAM_ST=
ATE_DISABLING);
> +                       break;
> +               default:
> +                       break;
> +       }
>
>         return 0;
>  }
>
> ---
> base-commit: 55a6763cde8a2309fd23a96479ee4cf2fc23a442
> change-id: 20250624-bap_for_big_sync_lost-63476c679dbb
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
