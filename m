Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D0204680
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670863; cv=none; b=hkM1uqN5iQtb+R0/XTF6BgCeA492xZ6n7znhXT4+cgsNL/C1C3eJ+lv/lr5cUkiNZ4QyQ31Pncx7RG8zeu4w6T2siF9uMXPdxCMON5KY2zjjePHH78+isrtxuxL1Tq3tSB54snATlN+SO/NQQQfrBM0cUS3/5kNnR4DJvA4Eifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670863; c=relaxed/simple;
	bh=bp3154n0jb7J7nhVEM2yFXyRLllzbX+Ibp1a80U+DlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbsUiSAYoKk6zU4xBjyqo+mNoP+qx8N+kQ8UAKbBBTI5Wjevn8UJ++CGZjZAmYanA7dmzfWXfAgmPjlmoHpR6g4vjqGDzFvFc8zbhBCo1GKbnwxav2jB4DhDcMQJ+atejbdwvL+j2U2b0VA/++b3IRHDoDsdTL4+IYfFv70SZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faj1sqzH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faj1sqzH"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32a696ff4dcso1559571fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749670859; x=1750275659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxJIsxKEKWM0vWgMR0MsjRmtpsx0pt0CqFt6eTWnryA=;
        b=faj1sqzHg5yD4FLtn9z3yWC4R0RF2AxxMeyFDCHhlUZ7JZ2VsctweK4yWqbFI+fFoi
         BZWHrJ6SpxeHurzc5HWJV32ogoB1T+gJ3VTlIrY+rTPfWrO8kGYBzFVW053vlbg3z+C6
         hc29Smxr5kd2Vb+K4TmnDGdNk0718ottRDv0mS4tpTbo2mD/DoGEXiOpJTPJMyobHR0y
         StSssyUUj82LUhOp7CCqACz6QV5TX5mRNGyWkqF47tEdEhJ8QH4nzMzuq+JM+OqrFZz/
         8AxcMHJ8Gl5i3zxEY3I22SrCetnOYGkA2j3dv2X5F/MaBvDw0KqfUByTJUPDJz2v90Rv
         TveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749670859; x=1750275659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxJIsxKEKWM0vWgMR0MsjRmtpsx0pt0CqFt6eTWnryA=;
        b=O4xsn+qwaMezpqDM4iwpj8inQ3HW4ApiLNK1D/pYciqo5vQUQhig8Ut6tlO0iVmgru
         Q7lFx7elxGfKgeTcjfXrHpDcGadcyOEJvD7bTMq/ezWbFZ9pVWb7J0ZbVEfWepFbPLTa
         F2M2SpP8fEXjaNFQgywCiy/RVeX5IsObTRcmq8J8//nUE3hf5nS6dklyW7SBWWa4nzqr
         onUyTvK5Gx85IdcVOvnldjwUTWSKUtq4PUbBpzY8mukZk/wR9POE/i6/GyLnok/hcXtV
         32eNM625dYlpr5qKsTc43Tl4kSL4Sm+zgkppBgI72JYl8pdUXVhaErow2V1t/7GsolNg
         EErg==
X-Gm-Message-State: AOJu0YwlxU6tRQ53Q+XC3x80QIMZzWIJefgFQgDGKCTgNIQRR0wwL8XL
	IILSDN9tYVtxNA0yUI1saiko2YPvL1+rdyz07sWTC0psC8Srj7R2yH4yckzKwoGtmx+JZs+RqQ+
	A9PJ2qdBYavnWNtfAwdTOEIcls0i5aUlaIja4IY0=
X-Gm-Gg: ASbGncuOWw4QTAHomRGNLntwKJylVBuOPYpj6c5PhG1tJWAzDfiO3cKpwo60lOcyztT
	QwbrMiy84R1haB8bfiKyzyid25TAGXHoBLEGJRUO80H5vMY5bv72zJj+pZdcbJXk4wzDD4vAqH3
	hXHsWRmR6nhHKhiE4TbUd/AKM/tT923H/yjwRQgRnyMzYOjcTsGhHL
X-Google-Smtp-Source: AGHT+IFfZtTqiwDqMNGTSsceVrNdVDLmseuqbWX9/aIaxHq1XTiwluW6dYEIdfIWvfurpLNeYMvP5iQ7tnnkxttaP0s=
X-Received: by 2002:a2e:a58f:0:b0:32a:69c7:7b0b with SMTP id
 38308e7fff4ca-32b21cb6e8amr12828781fa.12.1749670858984; Wed, 11 Jun 2025
 12:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-bass_for_encrypted_broadcast_source-v1-1-69b8b156488c@amlogic.com>
In-Reply-To: <20250611-bass_for_encrypted_broadcast_source-v1-1-69b8b156488c@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Jun 2025 15:40:45 -0400
X-Gm-Features: AX0GCFsxQv78fHvmYofF-_uAwSziiI9Q4MMfgDm-Td4nKWplGyEBCLf7rAnmnZ8
Message-ID: <CABBYNZK7LdWs1WmrtC1cB3RCZtHJOjH7Pm4Vxf63RegLfLJEhw@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] BASS: support for encrypted broadcast source
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 11, 2025 at 4:57=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> If the BIS is encrypted as indicated in the BIG Info Report, the
> broadcast code needs to be requested from the Assistant.
>
> step 1: Broadcast_Code required
>   > HCI Event: LE Meta Event (0x3e) plen 20                 #631 [hci0] 2=
7.176606
>         LE Broadcast Isochronous Group Info Advertising Report (0x22)
>           Sync Handle: 0x0000
>           Number BIS: 2
>           NSE: 8
>           ISO Interval: 20.00 msec (0x0010)
>           BN: 2
>           PTO: 2
>           IRC: 2
>           Maximum PDU: 60
>           SDU Interval: 10000 us (0x002710)
>           Maximum SDU: 60
>           PHY: LE 2M (0x02)
>           Framing: Unframed (0x00)
>           Encryption: 0x01
>   < ACL Data TX: Handle 16 flags 0x00 dlen 44               #633 [hci0] 2=
7.184478
>         ATT: Handle Value Notification (0x1b) len 39
>           Handle: 0x005f Type: Broadcast Receive State (0x2bc8)
>             Data[37]: 01016698a411bb13019f103b02010100000000110d035069786=
56c20395f32303938020502
>             Source_ID: 1
>             Source_Address_Type: 1
>             Source_Address: 13:BB:11:A4:98:66
>             Source_Adv_SID: 1
>             Broadcast_ID: 0x3b109f
>             PA_Sync_State: Synchronized to PA
>             BIG_Encryption: Broadcast_Code required
>             Num_Subgroups: 1
>             Subgroup #0:
>               BIS_Sync State: 0x00000000
>               Metadata: #0: len 0x0d type 0x03
>               Metadata:   50 69 78 65 6c 20 39 5f 32 30 39 38            =
  Pixel 9_2098
>               Metadata: #1: len 0x02 type 0x05
>               Metadata:   02
>   > ACL Data RX: Handle 16 flags 0x02 dlen 25               #636 [hci0] 2=
7.455744
>         ATT: Write Command (0x52) len 20
>           Handle: 0x0065 Type: Broadcast Audio Scan Control Point (0x2bc7=
)
>             Data[18]: 04013a4931614b3a2b7c4b7431722b666724
>               Opcode: Set Broadcast_Code (0x04)
>               Source_ID: 1
>               Broadcast_Code[16]: 3a4931614b3a2b7c4b7431722b666724
>
> step 2: Set Broadcast Code when BIG Create Sync
>   < HCI Command: LE Broadcast Isoc.. (0x08|0x006b) plen 26  #641 [hci0] 2=
7.669211
>           BIG Handle: 0x00
>           BIG Sync Handle: 0x0000
>           Encryption: Encrypted (0x01)
>           Broadcast Code[16]: 3a4931614b3a2b7c4b7431722b666724
>           Maximum Number Subevents: 0x00
>           Timeout: 20000 ms (0x07d0)
>           Number of BIS: 2
>           BIS ID: 0x01
>           BIS ID: 0x02
>
> Fixes: https://github.com/bluez/bluez/issues/1306
> ---
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  profiles/audio/bass.c | 29 +++++++++++++++++++++++++++++
>  src/shared/bass.c     | 29 ++++++++++++++---------------
>  2 files changed, 43 insertions(+), 15 deletions(-)
>
> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> index b27a3fc12..53fde43d6 100644
> --- a/profiles/audio/bass.c
> +++ b/profiles/audio/bass.c
> @@ -427,13 +427,42 @@ static void bap_state_changed(struct bt_bap_stream =
*stream, uint8_t old_state,
>         }
>  }
>
> +static void bass_req_bcode_cb(void *user_data, int err)
> +{
> +       struct bass_setup *setup =3D user_data;
> +
> +       if (!err) {
> +               if (asprintf(&setup->path, "%s/bis%d",
> +                       device_get_path(setup->dg->device),
> +                       setup->bis) < 0)
> +                       return;
> +
> +               bt_bap_stream_set_user_data(setup->stream, setup->path);
> +
> +               bt_bap_stream_config(setup->stream, &setup->qos,
> +                               setup->config, NULL, NULL);
> +               bt_bap_stream_metadata(setup->stream, setup->meta,
> +                               NULL, NULL);
> +       }
> +}
> +
>  static void setup_configure_stream(struct bass_setup *setup)
>  {
> +       uint8_t empty_bcode[BT_BASS_BCAST_CODE_SIZE] =3D {0};
> +
>         setup->stream =3D bt_bap_stream_new(setup->dg->bap, setup->lpac, =
NULL,
>                                         &setup->qos, setup->config);
>         if (!setup->stream)
>                 return;
>
> +       if ((setup->qos.bcast.encryption) &&
> +           (!memcmp(setup->qos.bcast.bcode->iov_base,
> +                 empty_bcode,
> +                 sizeof(empty_bcode)))) {
> +               bass_req_bcode(setup->stream, bass_req_bcode_cb, setup, N=
ULL);
> +               return;
> +       }

Let's add a comment on why we should ask for the bcode at this stage.

> +
>         if (asprintf(&setup->path, "%s/bis%d",
>                         device_get_path(setup->dg->device),
>                         setup->bis) < 0)
> diff --git a/src/shared/bass.c b/src/shared/bass.c
> index 7b9e0da63..11ad59e3b 100644
> --- a/src/shared/bass.c
> +++ b/src/shared/bass.c
> @@ -964,6 +964,20 @@ static void bass_handle_set_bcast_code_op(struct bt_=
bass *bass,
>
>         gatt_db_attribute_write_result(attrib, id, 0x00);
>
> +       for (entry =3D queue_get_entries(bass->cp_handlers); entry;
> +                                               entry =3D entry->next) {
> +               struct bt_bass_cp_handler *cb =3D entry->data;
> +
> +               if (cb->handler) {
> +                       ret =3D cb->handler(bcast_src,
> +                                       BT_BASS_SET_BCAST_CODE,
> +                                       params, cb->data);
> +                       if (ret)
> +                               DBG(bass, "Unable to handle Set "
> +                                               "Broadcast Code operation=
");
> +               }
> +       }
> +
>         if (!bass_trigger_big_sync(bcast_src)) {
>                 bcast_src->enc =3D BT_BASS_BIG_ENC_STATE_DEC;
>
> @@ -977,21 +991,6 @@ static void bass_handle_set_bcast_code_op(struct bt_=
bass *bass,
>
>                 free(notif->iov_base);
>                 free(notif);
> -               return;
> -       }
> -
> -       for (entry =3D queue_get_entries(bass->cp_handlers); entry;
> -                                               entry =3D entry->next) {
> -               struct bt_bass_cp_handler *cb =3D entry->data;
> -
> -               if (cb->handler) {
> -                       ret =3D cb->handler(bcast_src,
> -                                       BT_BASS_SET_BCAST_CODE,
> -                                       params, cb->data);
> -                       if (ret)
> -                               DBG(bass, "Unable to handle Set "
> -                                               "Broadcast Code operation=
");
> -               }
>         }
>  }

Changes to shared shall be on its own patch, also please add some
explanation why you are moving the code above on the patch
description.

>
> ---
> base-commit: 95b72bbf1fe42216d02a5ebb99bd18e9b69b6064
> change-id: 20250611-bass_for_encrypted_broadcast_source-f68417fdee73
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
