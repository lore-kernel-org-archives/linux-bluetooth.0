Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F6259C96
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Apr 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709804; cv=none; b=LaVfel0o/7qfUCIYJAmTnB5mKZUSY3Q5KeH5QY1y4VtVDgKoYgdeemSPqeyF29MZRzLrv6x/hKVEajn4oK3i2f9Pufja51ZjqjE0J6gjzirYxWsPayWV+BOYlkA6JY1UbV0gbeEP2ZXY4z83SOwOfcz/YV3Sp0J7Ur+aQ1i9PdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709804; c=relaxed/simple;
	bh=XmqYaxehJePhYgBOM9e2FSYZIGWMxaI9ZA6LdW16FVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC0cxP+dapjnxOadwKH24QFCsfJjqtAEZ4JwUxAB+bSuRx7DuC5MsLuv2hZwuUMReM+B65ppe04xazklWHIbo9RHynEFkM5ad94ilUbC6jOm3Jn6O14nUVcjI/2qM2XUtROXs2rJ93krRa7VZRC3zC6UXXb4/lh3to8P3kjLGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbxdF7zs; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbxdF7zs"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bd21f887aso9615081fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Apr 2025 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743709800; x=1744314600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SICcoNlF4Pp0klZv3GbtZTgi9LJ5tjvYEFUCwA42y0M=;
        b=AbxdF7zskHOHDxCpU/URyaqRBCpBhJNqHdEusSLsh0FGMFmLb0xsIw5fUntfXKRV7e
         XaNi8WeOu1cmc4m4rjW+u+ZAAoeic+79pa0Sg1Fn0YVDxWKAgfE370bhudcgxZQ/vUPe
         TV/igwrs+VvabM7wNAMrBlbrDVGRquqPqaKOk/5GyDampZjJgFps47wn3oL/7pulZTAW
         L/LXjaVOBPIrI9s9BWfyzDMebuo8ezORQJH32p0zxy09t2wxWTGt/G+NqBEexQp+Oa+r
         oTxRxO8nJF4uZIpGeJImQdauvmBeyqE4dpu1r9f/om8ftvuepcp8suMPo3iPt2Gil5oN
         vYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709800; x=1744314600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SICcoNlF4Pp0klZv3GbtZTgi9LJ5tjvYEFUCwA42y0M=;
        b=r/1yN44HJF6T2gDo09eADcfou5bm9Of+uPRKa8qrZ8DxYxPQMtExLK+peTXANlKopE
         OfVqsybp+GHX2YeoWX16QwZYMDbM9pI+XURcCKsGuiBiXtlUcD1KSPuCOLiDkeFiSgcy
         b5E97RvY3bk3ERwUDX1nxND3uDqAn+mfLYF79ldAc3GRKqSHm5cAhiltxb9iyw3Ih+yS
         f5e1KxXdf6d41dTiIUX1ZkX8T7X0KjHShHRGemToqs94i3bInD2hFJbVcFjgd/w8rCV8
         ctUGA24XS994ySU/23895STG9snDB6o/K1d0JEbbxy3FoSitymr/EV0wK5xvIl8pu/Et
         vp9w==
X-Gm-Message-State: AOJu0YyLpdw52wId4g6y/ozK0NBaaNFFcf8thCFd4Z7r0soszIe4BplE
	Wqg5xVkmot7bN9a1SZOTCByC/J1JU8BtRcCLxpTouSZWFpvRrudgVgnIDJ6H8N8H6YqS/v2Z/Vy
	/Kaf4lhmlcLUS/hSd9DVFC2ADTxmFifhAn/Q=
X-Gm-Gg: ASbGnctFFcJt79UEuX1eDGoiUtJg32nywNztUrifGdHQ8x0JaxnXpgN1oq+Dfn2MEJQ
	WLWNaTtbxQ+on0tGa2KSOPMiNopMJIpDG9ztBb6KzpLyOly5KlKS6nCUIBtd1Cs2lRl8Vx6XsKn
	rWTOT79LZ1Ytm7L6IvYVk6+eZh
X-Google-Smtp-Source: AGHT+IHl/hSAL6iJII9K1ebnLHmkmMgTHCrV3ckigGWCvkTD19fDit0TIrxh1Yl0MbLXyhI1nlTqDqpIMG9/aUy9xg4=
X-Received: by 2002:a2e:bc84:0:b0:30b:a92e:8b42 with SMTP id
 38308e7fff4ca-30f0a171700mr2903561fa.26.1743709800298; Thu, 03 Apr 2025
 12:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-bass-v2-1-7925bb16468a@amlogic.com>
In-Reply-To: <20250403-bass-v2-1-7925bb16468a@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Apr 2025 15:49:47 -0400
X-Gm-Features: ATxdqUHJSNun84Rh9LSJbGKa4M3JxkJ6TcJ-ALRaEqrKbk_PgqYXi7Pho9F5erU
Message-ID: <CABBYNZKW23-P_8OZGTz-bQ2b2vZX_SbxA_hEJ=BAbk6Bkmwsrw@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez v2] bass: Set the service connection flag when
 BASS connected
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Wed, Apr 2, 2025 at 11:37=E2=80=AFPM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> When BASS serice connected, set the service states to
> BTD_SERVICE_STATE_CONNECTED. Otherwise, the device will
> timeout and be removed, triggering the automatic termination
>  of BIG.
>
> issue: https://github.com/bluez/bluez/issues/1144
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v2:
> - Set the BASS service connection success flag in the connect_cb function=
.
> - Link to v1: https://patch.msgid.link/20250402-bass-v1-1-3e753841faa5@am=
logic.com
> ---
>  profiles/audio/bass.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> index c36f43277..c28d9d1ad 100644
> --- a/profiles/audio/bass.c
> +++ b/profiles/audio/bass.c
> @@ -321,6 +321,8 @@ static void connect_cb(GIOChannel *io, GError *err, v=
oid *user_data)
>         if (bt_bap_stream_set_io(stream, fd)) {
>                 g_io_channel_set_close_on_unref(io, FALSE);
>         }
> +
> +       btd_service_connecting_complete(setup->dg->service, 0);

Ok, do we mark it as disconnected when the BIS is disconnected? In
case we are acting as assistante then there is probably no reason to
keep the device object around after it has been pushed to the remote
sink.

>  }
>
>  static bool link_enabled(const void *data, const void *match_data)
>
> ---
> base-commit: 0efa20cbf3fb5693c7c2f14ba8cf67053ca029e5
> change-id: 20250402-bass-66200bb7eba1
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
