Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD63DDCD
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462456; cv=none; b=cYAzIkE3dvOakSn3aQ7dQhpsqW0nqa7xAYs4AdnbOwrpJarQGNQ4oTFejyK7NyA5lH/wc80iMfLtPvUYR9BUlG8tZffBkyZLW+DC3U8qmrBe/dzQSblSN/M/H10cuhtdcLDkK83jzwhwX/dgqre2B7cB4hWGtXHtnEllziLELwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462456; c=relaxed/simple;
	bh=btPHVcon9YDMqNYfKwngWcxA0cQhn3eBU0q38HMpFXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZ4a/oHBNVlF3o76s8Km3mKBKvq6g07L1XIOvFEIh5AEFul8v5dZSaOngSxYWzueSY5bjAC10gOil5f/SFcPz1Jf39SDBjf1KoohB9Agj3g+I8vSEEyVuL4xCADScRUtz58T/DXbawtXB9nauBlXK5XzL4djGeZitmjLS6YGloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0ag7gRt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0ag7gRt"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20536dcc6e9so33023315ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Sep 2024 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462454; x=1726067254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zruJ6SZ514YkU4YtSRS/cKRhklgyaoz5jEj/cbFjhE=;
        b=X0ag7gRtHIWTF2N1EbDYQ/rEh4nB3Dlnzchg9NYXORt3HRDrYFHIgftrTvIBF43oZU
         EaYXSpO5JrkW4VUVFrTFpAqG3WBAcVrzMkrQreesHNZx3z8e1JwD5Y9HoJ9XZxFVcDgw
         pJGvSlJRBW3jFp9LoKWXaKpmaN8BRsDfTLa+OUFPQqqRC4Xh57HJG+e9bfLFo0fjWOTf
         3TkR+ybP1bsvvvqknndPOAmQRgXFMJoyJprSEhQzASM8AUR/pRfmtP1+KNrNUZTvC2MK
         yI0K2vO/zAl+pOM+VxR/KoxJCjp6LL+I+RGMx7FDkPv3FjXJXoTisMbnGVONTR5MZwPX
         1DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462454; x=1726067254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zruJ6SZ514YkU4YtSRS/cKRhklgyaoz5jEj/cbFjhE=;
        b=JNio9ccEsAJse80Y68Cc7R5CkPYmNknBAEowUydB8ttlJRrqhZeeu2cKbEtaDGWNIV
         e5+SDBVWvSGb5eDdZv0o7VgaHfXT7w8B3rI39h89UHzp+5LTh5N+HcQwIlCz7QLKU+s5
         PWsHlX0zE3/il3Q2XjniEP7wFAIFF9FoIgCxAnLiQXRtBdGb7mzgW1Gd+9rwRHeBqsOi
         Bx7NXfyqKsDumIICEvbK2LrP0FkdAOOhqlU/emr5yvXxICjOryG9cXdLE3dpN1Io4dXe
         kX19nf9+VjQBeTk0d8WMO6GtHI/z8NIHgNwtocz/XCWQnA+43EWKQzrZqq23MCfpx5A9
         NKUg==
X-Gm-Message-State: AOJu0Yw+O2yUhuStBn5g0NO/UT+Mm8KRpDsOZEByhW0I57YBnGk1OMJZ
	9GzEK/2ReBdbHsTAfC5R8gyZ+n+ghUScohIgwA232S30YA1IrBWal5rmQOu5+D3f9KiZ/Yhkvhb
	Biut7p+NQUStWJH8NjBtsva6Wj6AxhA==
X-Google-Smtp-Source: AGHT+IHFN6kilRyILjXabU0KDmhYmaMC9tNazEwG57fVM3jumakgrbHs1NA8FdY0wfZHNvH6kCBO3RhBFPnc7CflUdg=
X-Received: by 2002:a17:902:ef0f:b0:1f7:1655:825c with SMTP id
 d9443c01a7336-2050c37b310mr176553745ad.36.1725462454155; Wed, 04 Sep 2024
 08:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904140421.283166-1-frederic.danis@collabora.com> <20240904140421.283166-4-frederic.danis@collabora.com>
In-Reply-To: <20240904140421.283166-4-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Sep 2024 11:07:05 -0400
Message-ID: <CABBYNZKS501DW21KcjKVEhKV5CkvFdpb256=DQ=y6Xb87km=XA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/7] player: Add image handle support property
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Sep 4, 2024 at 10:04=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This is part of the metadata when the AVRCP target supports covert
> art download and a OBEX BIP session is connected.
> The image handle references the cover art associated to the track,
> and is valid only during OBEX BIP session.
> ---
>  doc/org.bluez.MediaPlayer.rst | 4 ++++
>  monitor/avctp.c               | 3 +++
>  profiles/audio/avrcp.c        | 7 ++++++-
>  profiles/audio/avrcp.h        | 3 ++-
>  tools/parser/avrcp.c          | 3 +++
>  5 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/doc/org.bluez.MediaPlayer.rst b/doc/org.bluez.MediaPlayer.rs=
t
> index f1e999bdf..5bb38e7c2 100644
> --- a/doc/org.bluez.MediaPlayer.rst
> +++ b/doc/org.bluez.MediaPlayer.rst
> @@ -237,6 +237,10 @@ dict Track [readonly]
>
>                 Track duration in milliseconds
>
> +       :string ImgHandle:
> +
> +               Track image handle

I guess we want something more descriptive here, as ThumbnailURL or
something .e.g obex://<handle>, that said I don't know if perhaps we
could load it automatically via plugin.

>  object Device [readonly]
>  ````````````````````````
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index c59e93b20..4da448750 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -156,6 +156,7 @@
>  #define AVRCP_MEDIA_ATTRIBUTE_TOTAL    0x05
>  #define AVRCP_MEDIA_ATTRIBUTE_GENRE    0x06
>  #define AVRCP_MEDIA_ATTRIBUTE_DURATION 0x07
> +#define AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE       0x08
>
>  /* play status */
>  #define AVRCP_PLAY_STATUS_STOPPED      0x00
> @@ -582,6 +583,8 @@ static const char *mediattr2str(uint32_t attr)
>                 return "Genre";
>         case AVRCP_MEDIA_ATTRIBUTE_DURATION:
>                 return "Track duration";
> +       case AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE:
> +               return "Imaging handle";
>         default:
>                 return "Reserved";
>         }
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 61558e492..fe24b5a92 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -417,7 +417,8 @@ static sdp_record_t *avrcp_ct_record(bool browsing)
>         uint16_t feat =3D ( AVRCP_FEATURE_CATEGORY_1 |
>                                                 AVRCP_FEATURE_CATEGORY_2 =
|
>                                                 AVRCP_FEATURE_CATEGORY_3 =
|
> -                                               AVRCP_FEATURE_CATEGORY_4)=
;
> +                                               AVRCP_FEATURE_CATEGORY_4 =
|
> +                                               AVRCP_FEATURE_CT_GET_THUM=
BNAIL);
>
>         record =3D sdp_record_alloc();
>         if (!record)
> @@ -883,6 +884,8 @@ static const char *metadata_to_str(uint32_t id)
>                 return "NumberOfTracks";
>         case AVRCP_MEDIA_ATTRIBUTE_DURATION:
>                 return "Duration";
> +       case AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE:
> +               return "ImgHandle";
>         }
>
>         return NULL;
> @@ -1197,6 +1200,8 @@ static uint32_t str_to_metadata(const char *str)
>                 return AVRCP_MEDIA_ATTRIBUTE_N_TRACKS;
>         else if (strcasecmp(str, "Duration") =3D=3D 0)
>                 return AVRCP_MEDIA_ATTRIBUTE_DURATION;
> +       else if (strcasecmp(str, "ImgHandle") =3D=3D 0)
> +               return AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE;
>
>         return 0;
>  }
> diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
> index dcc580e37..59117e946 100644
> --- a/profiles/audio/avrcp.h
> +++ b/profiles/audio/avrcp.h
> @@ -46,7 +46,8 @@
>  #define AVRCP_MEDIA_ATTRIBUTE_N_TRACKS 0x05
>  #define AVRCP_MEDIA_ATTRIBUTE_GENRE    0x06
>  #define AVRCP_MEDIA_ATTRIBUTE_DURATION 0x07
> -#define AVRCP_MEDIA_ATTRIBUTE_LAST     AVRCP_MEDIA_ATTRIBUTE_DURATION
> +#define AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE       0x08
> +#define AVRCP_MEDIA_ATTRIBUTE_LAST     AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE
>
>  /* play status */
>  #define AVRCP_PLAY_STATUS_STOPPED      0x00
> diff --git a/tools/parser/avrcp.c b/tools/parser/avrcp.c
> index e73a6317e..d574c7ee3 100644
> --- a/tools/parser/avrcp.c
> +++ b/tools/parser/avrcp.c
> @@ -160,6 +160,7 @@
>  #define AVRCP_MEDIA_ATTRIBUTE_TOTAL    0x5
>  #define AVRCP_MEDIA_ATTRIBUTE_GENRE    0x6
>  #define AVRCP_MEDIA_ATTRIBUTE_DURATION 0x7
> +#define AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE       0x08
>
>  /* play status */
>  #define AVRCP_PLAY_STATUS_STOPPED      0x00
> @@ -933,6 +934,8 @@ static const char *mediattr2str(uint32_t attr)
>                 return "Genre";
>         case AVRCP_MEDIA_ATTRIBUTE_DURATION:
>                 return "Track duration";
> +       case AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE:
> +               return "Imaging handle";
>         default:
>                 return "Reserved";
>         }
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
