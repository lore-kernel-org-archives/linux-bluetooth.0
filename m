Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0A3F787C
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965670; cv=pass; b=uWuiwJvzozP9GgdmYwIzc54WqWcfg1A9gXsFtT5MyS0YkSdX+3dn0b8s+4A/ltJcShnNlvv8u425xhR/7sLuwzVShndj9voH8Jt4BqhQ5QNUwni/BLAtazK6Gx0z2cZY6hVFkbug/Wo5pqgAip1fFvH1hrcMYZw1y3J1MAhn6NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965670; c=relaxed/simple;
	bh=/EGeXi0tSLb53N6mJazS0D1a+VCbFBZRHCvJBfoqULg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGsSclcTbusRYg3vK6AGE1A4cqpgE7qXYH6gtD8vRfhyJ84QGFH1Qvr/J8WIgYswvAi7zTxvpjzsmQerooUjzo7cPqgGJczwljcjrgqo1GEB8hKfbtnb80cgdV3691V9XmF2GTn+qjVup69lBuioJQghCzDED7ideBkiQhvjwxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W502r166; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W502r166"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6501d242e2fso3924022d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 07:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774965666; cv=none;
        d=google.com; s=arc-20240605;
        b=S1pzxD4Ifw7yM2HkPOFOyk+m05uTY+6jZqUXX7c0+X70t/hCUOJH/hOdEF/QkE8wPQ
         W2Gx2gjGVBXE3wvKghToQQPNS28hFy2lCoZ00XhFoXIVgBaqCf7yXXo6raLVf8UJLpq9
         JYERyFeI5JDZjfcFjuv/sH+yuVxIuRP5z5Pzqw/cbB8jC4u6VTWGVnnsEUuCD4zhty87
         OOat97p5vgeSaJYwj9q+/VSgA+UYCs0mz5jUFRcrp8R+//D4Xml4LmTBBSNgPSCJs5uM
         HU71b/cjEqsYpUDllxpsOFNW+ApSfOx/M7dMWxQy9YNHHw1DOwUfdNdL0KY0p2Zpjh4z
         4lQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fkBbNucK1sItaHRmkDI0IHgeNuWHC70roWoz9I8jxDc=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=kykCJUNzphtFCbPLS2mK7hf6bdILg3RVM6LyDNDS5UMSdCAD+7RCb3YYxzak1sOgsu
         K4j6oWtNxQhbr5XTgaVPPsPksfD4MgB6WdHpJkqBmR05h10j9UDROUPsFgw9zUAeyxwW
         yXP1uRbGOkMEl53kaRIbL919qHN3GxLUJJmvhvkt0PAcSsYb2Ftfef1lT7+2xvzRlllW
         oWTbpC9nl0gXP3thmrUyX81jHdWOnLpg4ViAalBxT60PO6DPXFrHurAdxAhr9pTHnguk
         BUxSfypCIG1/mTHCovkFSIuMMwMCYvK+kmLRbNiO5pHldqPY2mxr0tRbFauRTUKBiGvB
         tu3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774965666; x=1775570466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkBbNucK1sItaHRmkDI0IHgeNuWHC70roWoz9I8jxDc=;
        b=W502r1663NGJGqPdWKo86ku3hmd0osm5WimzAXIMr+41+uwdARZdEHOhQN8GDX6vHq
         eCh620aPZGl7H+sEHA39OIW7YsaHqjWs5phDwgqw17d9P+ExLs1JkoQ9MLeLMcBpkED4
         z0Oip/rTgkRsdTYF9DPrqX9x3coM9dnQm886nt3Vf+edSyS+VutAz4cpssbI53pPzvgH
         kaAu/D8otk2vyufXxkF2kJhCxVwkVK4T1HPIY7DarMrhGg6eRMuR/hmJmiDAM+1MPFaG
         EV4QqConY6K/Jhi5/Kvok5aY4d+8XW5cQw7i4j1FnvtwbH3nS44JIUsfFghVJhuYQjY4
         D/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965666; x=1775570466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fkBbNucK1sItaHRmkDI0IHgeNuWHC70roWoz9I8jxDc=;
        b=WbwvMLpPo3aBhCpdvz8NxOl86Lisp3YL3hkHDbRM4g0N4FXo964oqUiHytay5EdoIm
         686+Cex/6hm5qC/I8Ct7DxN27FHACCGua/YCfb/i+GFJYetWjYxbCtkTelG9X0DMbl0a
         Y1VIhkn2Kq9EfMKS9SUVkEftUaNEsbaapa6bmYfsG/jOy0yk608U7kd4oII6E4enAzPk
         2SKuNqeOQah6aldP6TWUlSvgXve1IAFxh1SIZ405iPyw0k0WxMvClPW3kmE/LffZY5uo
         +TG2oqJdWHWf/pthn24hAdj+gnQajKNmgM3q3r9bts+PBuBXE/UXCUFEyXWQVaCxqdfi
         +bUg==
X-Gm-Message-State: AOJu0Yx3yQtfk1Rycr04KQLE8mH1dFaE8yNP8iKJk9ueP47gO/inf5tQ
	g4y25gmNw72h8O4jSF9cXHOpHSiDPShMDcn8V1ZRzs3PDeso9onIjVvmyoO8Lw+xn2JMZhKbTsK
	OV2ONy5css8AtxVly9L7ex60K8Tv9YsyNMYMX
X-Gm-Gg: ATEYQzyyo4ewUcA/3ONEvmAocJ+MU5u8WGmFXNsGQR6sSG8SMZKWcH2j43SMyH/qW1F
	7IO9CtXyYpWGZ+eM6s4IrwfmvyBFfzV+YGju+yaZbuadBDxfAgvyhW8KGjymzouwxgAKv78/SQn
	m6oNErEEjju9Lc2MZitHzT3LGf96S6EbwRCOtVSVj2TyfL5H44Q23Ht1H0yxQDePE4lLvNb4s/e
	sKQYD329CM6z0Jn7S8NmZVL3/Kp8JfFOlZYQhfZ8w5lGwFfZ72y/FkVj8Ny6LRhM3fwTbMZlyBt
	Hta4IgEUsg6g4gN3shoULAa6O19ZY7UqtuM0p8+9ozgL2xX/mnnAyJ5JbeOaCo+fJsJ2iv5+nz/
	rNmXQ
X-Received: by 2002:a05:690e:14cf:b0:64e:e90c:5682 with SMTP id
 956f58d0204a3-64ff742d9d1mr16176620d50.66.1774965666136; Tue, 31 Mar 2026
 07:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330143046.3497403-1-hadess@hadess.net>
In-Reply-To: <20260330143046.3497403-1-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 31 Mar 2026 10:00:52 -0400
X-Gm-Features: AQROBzCAdU4Z7WIfVJbCBXgRI2dMR4tls1lwWS8SQWyLKGMettIbI34e-ckpK04
Message-ID: <CABBYNZ+mm1q0gKCajcv4AnuNn13j5DXKzWAmDvCRj1LuGTfRag@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/util: Add MIN/MAX implementations
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Mar 30, 2026 at 10:42=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> And remove it from src/sdpd-request.c to avoid a redefinition warning
> at compile-time.
> ---
>  src/sdpd-request.c | 2 --
>  src/shared/util.h  | 6 ++++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/src/sdpd-request.c b/src/sdpd-request.c
> index 1fc07e97bfe0..7c632c2aaf62 100644
> --- a/src/sdpd-request.c
> +++ b/src/sdpd-request.c
> @@ -40,8 +40,6 @@ typedef struct {
>
>  #define SDP_CONT_STATE_SIZE (sizeof(uint8_t) + sizeof(sdp_cont_state_t))
>
> -#define MIN(x, y) ((x) < (y)) ? (x): (y)
> -
>  typedef struct sdp_cont_info sdp_cont_info_t;
>
>  struct sdp_cont_info {
> diff --git a/src/shared/util.h b/src/shared/util.h
> index c480351d6e9f..99a5aa2daf32 100644
> --- a/src/shared/util.h
> +++ b/src/shared/util.h
> @@ -22,6 +22,12 @@
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>  #define BIT(n)  (1 << (n))
>
> +#undef MIN
> +#define MIN(a, b) ((a) > (b) ? (a) : (b))
> +
> +#undef MAX
> +#define MAX(a, b) ((a) < (b) ? (a) : (b))

This is causing many tests to fail with `make check`. It looks like
the conditions are wrong, so MIN works as MAX and vice versa.

>  #if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
>  #define le16_to_cpu(val) (val)
>  #define le32_to_cpu(val) (val)
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
