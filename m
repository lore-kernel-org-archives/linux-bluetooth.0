Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A22A1CA
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Aug 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971339; cv=none; b=AmXjgP91q8SbQA4UwHgzxnqP8nVMUPfGyyAVVEnnVkCRhPnmBb7sNZ+GufJYBHt7eHK9wcXzd4ta5qq5RGtxZwYDLl8GuO+FbT6RXiwFZ+NUd9fLPc31ezvc1dNi+uVqXBsdQpdqXc3Uvg//zWq4hNHOxtFRTyzVgg04+He+JIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971339; c=relaxed/simple;
	bh=NizTV+fjibItL3luEMQDu9+ctgrr2JN1sriwpAsCZgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOwzhuYxXE18JLR/stn4dN4B0PxvL5ssc2hViLxF9YClxWO3F37DqVcj73DQPnWwXBfwAyuzVZ3lj9dyQRwgtaAAkjAsIHBEL3w2mjs3CwkS37SLQ2BNUgC66Nfk7hH9MPLhRjQAGK7y7KuxvJlSsZmRfDUVYmHDl/FIKPuOhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB8E4YtW; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB8E4YtW"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so12246741fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Aug 2024 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722971336; x=1723576136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbcYhzXkCHlZr63fVmgUULTDN8ddERbPpRTqoQqHuNc=;
        b=lB8E4YtWoCd4V7W3F4KDDPr9n2B68AlYAt4Cp39DbIYaeBBOfuxTTd8ybY+NNgjk6K
         /7Xj41UMT6EFxWjAT01KjeOYqBupfZYOnaGLu17rxsmMvw4sa5+zkl3jG7uYXqp2JUDg
         FUrrGJI+GG0KOxjCkUFD1Gox1n5Y9S93OgCGTKpvjk9nfZucvA+7AdisX5vdLO59sepF
         6hqGLvXvtO64btPMuCwbh1y73K2Svl5+NHcXyyfIdGZLmwCE09RyxkoxNNbnuvMGS5RY
         Os7NIPBjA0IXQDYH9AGV6Kyb4YB9hxT5/uaJlacS6TUA7n9VgqZ7TRh3/m7sSlN4P5US
         BpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722971336; x=1723576136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbcYhzXkCHlZr63fVmgUULTDN8ddERbPpRTqoQqHuNc=;
        b=BxdlcOZb0aY27+w8hSQ5mHmx1BMvMUsRiNceTqML8NrEXuQ1gMPCfhXQQGR/S9qE1u
         +xGWk8TKK5oaZnWTcME+A3BYkbxCm/NCg5b1/TTW1wzivezbcWA3htmh0ci+e5KYhZG+
         2yo6XilT0WS7zkeRJe/2wsUSWSHHHZFz/VGW98pibGtCNXo1KWQi5dDQ+fN8p5fpjvlY
         2pLEpwGhVLFCRtddltj/vB7WYddLyAfMDujI7Qq/F4odWo0js1x7fxD/FcqrrDNJBzhf
         IEbyHbJuOFUCmJ3f9xuZTM/fsNFJIj/7cM+vvM99aVkgDfuurk8NMKfRxOE4ChyfCuLy
         HvNw==
X-Gm-Message-State: AOJu0YxlLYeN2qs69w9vxHWBHXvwT1OmX84fKaQTwjsIgeSaPFcbVlk3
	OJM/NqhvpOW4rDl0HD1KSpp90/WkaarUw0+2HScI05SpncWOJd8PLctVQRhlIWSQfpG0nuMWRiq
	Dm9zU+aCAfi6ovWWIE275RkB56AHdoonJ
X-Google-Smtp-Source: AGHT+IF3ZL8W1pdEiwOaLZECW0QcfJzpsxQ9kahLIoMALUyzTHq377HktdB+rhD0/prl46HdrSOJ/F5QtdmLKieVsoA=
X-Received: by 2002:a2e:81c1:0:b0:2ef:2638:48cd with SMTP id
 38308e7fff4ca-2f15aafdbfcmr93926681fa.30.1722971335453; Tue, 06 Aug 2024
 12:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805140840.1606239-1-hadess@hadess.net> <20240805140840.1606239-7-hadess@hadess.net>
In-Reply-To: <20240805140840.1606239-7-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Aug 2024 15:08:43 -0400
Message-ID: <CABBYNZLeuUw5nO-nw65nccSCKXcf-KLMxqDfPTObk-S3NP+tTQ@mail.gmail.com>
Subject: Re: [BlueZ 6/8] shared/gatt-db: Fix possible buffer overrun
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Aug 5, 2024 at 10:09=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> uuid_to_le() returns one of the possible values from bt_uuid_len().
> bt_uuid_len() returns "type / 8".
> type is a value between 0 and 128, but could be something else
> depending on the validity of the UUID that's parsed. So an invalid
> value of type between 128 and 256 would trigger an overrun.
>
> Add a check to make sure that an invalid type isn't used to calculate
> the length.
>
> Error: OVERRUN (CWE-119): [#def6] [important]
> bluez-5.77/src/shared/gatt-db.c:612:2: assignment: Assigning: "len" =3D "=
uuid_to_le(uuid, value)". The value of "len" is now between 0 and 31 (inclu=
sive).
> bluez-5.77/src/shared/gatt-db.c:614:2: overrun-buffer-arg: Overrunning ar=
ray "value" of 16 bytes by passing it to a function which accesses it at by=
te offset 30 using argument "len" (which evaluates to 31).
> 612|    len =3D uuid_to_le(uuid, value);
> 613|
> 614|->  service->attributes[0] =3D new_attribute(service, handle, type, v=
alue,
> 615|                                                                    l=
en);
> 616|    if (!service->attributes[0]) {
> ---
>  src/shared/gatt-db.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b35763410d17..cd0eba6bf1d0 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -560,9 +560,14 @@ static int uuid_to_le(const bt_uuid_t *uuid, uint8_t=
 *dst)
>                 return bt_uuid_len(uuid);
>         }
>
> -       bt_uuid_to_uuid128(uuid, &uuid128);
> -       bswap_128(&uuid128.value.u128, dst);
> -       return bt_uuid_len(&uuid128);
> +       if (uuid->type =3D=3D BT_UUID32 ||

BT_UUID32 is not really valid in LE, so Id leave this check to be:

switch (uuid->type) {
case BT_UUID16:
        put_le16(uuid->value.u16, dst);
        return bt_uuid_len(uuid);
case BT_UUID128:
         bt_uuid_to_uuid128(uuid, &uuid128);
         bswap_128(&uuid128.value.u128, dst);
         return bt_uuid_len(&uuid128);
}

return 0;

We do however have bt_uuid_to_le with the only difference being that
it is more generic and it doesn't return the actual bytes written to
the dst, anyway we could replace the code above with:

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b35763410d17..71976de48569 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -553,16 +553,9 @@ bool gatt_db_isempty(struct gatt_db *db)

 static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
 {
-       bt_uuid_t uuid128;
+       bt_uuid_to_le(uuid, dst);

-       if (uuid->type =3D=3D BT_UUID16) {
-               put_le16(uuid->value.u16, dst);
-               return bt_uuid_len(uuid);
-       }
-
-       bt_uuid_to_uuid128(uuid, &uuid128);
-       bswap_128(&uuid128.value.u128, dst);
-       return bt_uuid_len(&uuid128);
+       return bt_uuid_len(uuid) =3D=3D 4 ? 16 : bt_uuid_len(uuid);
 }


> +           uuid->type =3D=3D BT_UUID128) {
> +               bt_uuid_to_uuid128(uuid, &uuid128);
> +               bswap_128(&uuid128.value.u128, dst);
> +               return bt_uuid_len(&uuid128);
> +       }
> +
> +       return 0;
>  }
>
>  static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t *uuid)
> --
> 2.45.2
>
>


--=20
Luiz Augusto von Dentz
