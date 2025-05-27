Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22638C2ED
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350131; cv=none; b=KL+0gyqaquctqFgQkBdrEff5tr0YokKwOSX/dB16AGoMZ/vz1FR09Cis/tmloEVWnXmkPpJuEYNTdrWpe+aT6hxcCedlCo5ECKwBjOC1UvVXmpvV0JaoK65pqCsBVgJHRKjW/T+O1T3iaot7NMr6OxIlrK4zD0ZGfi7Cv9m8bvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350131; c=relaxed/simple;
	bh=UeJ0WqBWcoxEkGGAKm4L4fEczw8lK5WTJMTXAdat050=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvXvxc6D51HsDx7LKI/SnTMxgq8TO0e57n0+Qvn1Dw92HHKMSRHmn9/iwr4bdUShIOTzHVgQz4R/ky5mhXq4I/oOkdD8D+XAYRsaHfWo4t4rTGUvWuK9P1is2AB86Il1uGuwHzwRR7x/eIotK+9eWhV8Uh+Gweurs+OFprzvJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpEDMaxJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpEDMaxJ"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso4217983e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748350128; x=1748954928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viauIbR/LL1dSDn8UcbxcCO6wVaapG27zEPjZH9eYN4=;
        b=lpEDMaxJvCU6x2nuLGbJ9FQEg3aQMlICKP8wCND9sesh42CZKTv5IB8Dh4nHMsvY1p
         y1MViaI5yvTJZu6cjmU7Fg8gDmQyrbR4hCM2o5N/G+RHgu1GvwB+QV05WlrQb1NC0jRM
         qu4zqneyve3qifNRKVZKAVfACdSJPslKPmystgdsOLbmG7E/tbbYV+Vyqg5+QGz3fFJ0
         /FGObyna8McoLT5sssVndj/cNpqqwIQs/VN7st7Tp+hUzWlkZsnExebgRhvTt5Ty7qE8
         V8M0m724jcBwjagtYwThEJ7JPUS/bA314+736+ToJ2EEy8HdjYhJbfipJ2sviYFQXnce
         4FcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748350128; x=1748954928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viauIbR/LL1dSDn8UcbxcCO6wVaapG27zEPjZH9eYN4=;
        b=po/vxHT2Y5BCDIKsg5p3ultnuG9VfR8kVLJ25DOpZ+zbwLO8Buz9LWZ55o5Cel0+8K
         zBJ0795LpN25QIQr0JyUGmf0gjezOP3S32QVsPDH+wgLWWSO12X1Xax4rWsbaRLic5D8
         2o8PSvQ3piyvJsGlvVwKHuSietFUoQ1vGNr/DPrjalu7fU607t6+0/grgqeEItba1MOe
         NYFvcEs9e5e7wymKgmKmNE/ZaC4I8V6HePt2zcSqL0A8t9env9gKvdd2VSIf0zQ3ynnB
         SFlmZhuN+GIhuBYeYAMZi4HTOvKwAC8f+zdjLqg8EeWvUhzJWh8YfleBpRzEOwHHtnoo
         xcig==
X-Gm-Message-State: AOJu0Yxlxjo98oMbpnngNXGSQumXDuDn8ZbgSj7/wjJGBAzl8C3WtkD3
	Z9S87UWScRqBOj09pSZ81sfJFZzk8cvjXI9IJfuVVCLD9UfKd/fhCfDDda4RR4z0WSqi3KshQSL
	YAbQwpB42WkYeviUNqBTqlQ/3QGz/LDFwdyJXGJI=
X-Gm-Gg: ASbGnctn8mXauilYT75gZU8HuwihxrCRqn+e4TdXDHUmhL9nAmgacJmIFC+2G46O3qD
	o7HJM2W9HltQ1qJbMrW8WqU9c6KojFxT4ido8K1jor6PMsv3ICUVGE3HLYz/f2kX8QbTxj9sAni
	gwFuLxLz4rKHBXcCza9UUD81c1QkLVnGET5BcvU8sZwA==
X-Google-Smtp-Source: AGHT+IG+hIXvl6V/ZLDGKWcLA9jeOtslr2HAp6WLjXZp6w2fihL10Pv9eC1tnLMnX6j6AQi21uTkOPPuRBUY6mvt/l8=
X-Received: by 2002:a05:651c:325b:b0:32a:6aa0:217c with SMTP id
 38308e7fff4ca-32a6aa0242bmr12542841fa.34.1748350127808; Tue, 27 May 2025
 05:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-att-read-blob-rsp-err-v2-1-23c7f749e8d8@amlogic.com>
In-Reply-To: <20250527-att-read-blob-rsp-err-v2-1-23c7f749e8d8@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 May 2025 08:48:35 -0400
X-Gm-Features: AX0GCFvtAf6WkeyYtFOxQNTcImaTEB4FfNK2Yr-oUxUu0bWlVQPUx-OC8Q6Bd_Q
Message-ID: <CABBYNZ+hpnZ-1SzDKFNrUkqssDQANNUf7nOKE89RzKetcUDAfQ@mail.gmail.com>
Subject: Re: [PATCH bluez v2] shared/gatt-db: Add read offset to record the
 progress of att read blob request
To: ye.he@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 27, 2025 at 4:13=E2=80=AFAM Ye He via B4 Relay
<devnull+ye.he.amlogic.com@kernel.org> wrote:
>
> From: Ye He <ye.he@amlogic.com>
>
> When processing the att read blob request packet sent
> by the mobile phone, Bluez ignores the offset and the
> payload of each att read blob response is the same.
>
> This patch add read offset to record the progress of
> att read blob request.
>
> Fixes: https://github.com/bluez/bluez/issues/1294
>
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
> Changes in v2:
> - Fix build error.
> - Link to v1: https://patch.msgid.link/20250527-att-read-blob-rsp-err-v1-=
1-75d3bc498862@amlogic.com
> ---
>  src/shared/gatt-db.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 8951079beef1a8af7e46e87043f320640d4109f7..06af4f65bacaac39cdf9641e4=
0fac902653c4b9c 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -109,6 +109,7 @@ struct gatt_db_attribute {
>         uint32_t permissions;
>         uint16_t value_len;
>         uint8_t *value;
> +       uint16_t read_offset;
>
>         gatt_db_read_t read_func;
>         gatt_db_write_t write_func;
> @@ -151,7 +152,8 @@ static void pending_read_result(struct pending_read *=
p, int err,
>         if (p->timeout_id > 0)
>                 timeout_remove(p->timeout_id);
>
> -       p->func(p->attrib, err, data, length, p->user_data);
> +       p->func(p->attrib, err, data + p->attrib->read_offset,
> +                       length - p->attrib->read_offset, p->user_data);
>
>         free(p);
>  }
> @@ -2126,6 +2128,8 @@ bool gatt_db_attribute_read(struct gatt_db_attribut=
e *attrib, uint16_t offset,
>         if (!attrib || !func)
>                 return false;
>
> +       attrib->read_offset =3D offset;
> +
>         /* Check boundaries if value_len is set */
>         if (attrib->value_len && offset > attrib->value_len) {
>                 func(attrib, BT_ATT_ERROR_INVALID_OFFSET, NULL, 0, user_d=
ata);

This is not quite right, first there is the problem that you are
storing it in the gatt_db_attribute itself, so it will affect
subsequent requests, rather than storing the offset at pending_read,
but even then this would be wrong since the intention is that the
offset is handled by the read_func otherwise we wouldn't bother
passing the offset to the it.

> ---
> base-commit: c888c682fbd4e02dce6bf4c1f9a47328ceb02716
> change-id: 20250527-att-read-blob-rsp-err-c30db15efd30
>
> Best regards,
> --
> Ye He <ye.he@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
