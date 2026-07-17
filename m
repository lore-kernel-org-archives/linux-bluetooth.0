Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6F30C366
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296993; cv=pass; b=sO2isf9PPOQ7NrMPz/Ocf9LFDHfpvkxSmGCr976zjQDhY2tjReyBVmpgmFLitpVSeuQaTRYxlvbbHMjGuSWIGk3mmIy4UP3vIObYJ+qH9wNE2Jg16PUWybiwyy1cG1FBmy1kxCaTGpznsv230CmasoukHvSQBbA1BOgwUgDix7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296993; c=relaxed/simple;
	bh=j1Kpf847v8VM8bUoijHHnMhp3wscTNv9LYq+dvTS/bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZ6eZvFJ2eUKVFHWmihj5EXgThsawDHKAjuSY6JDzXZYfEJ0ifObBG0s8n1YWB75UkHZPN+ls18fYmv3U5E++czspHsfIX+ff7uarioDx9mdhBdhcMW97uxCa9FqMV86xJIjvMRp47pHWq0rcmTePuuKq0ejYjDivc4DkCxoH34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBgj0D/S; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBgj0D/S"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80dc4a68e4aso64054627b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296991; cv=none;
        d=google.com; s=arc-20260327;
        b=kZ+ZV7EQlYbYciqou2AjM7Zjm/c76iahvWidiClqJ1kz1VMVTBBFLKTv8HvKB/AzR6
         NfiiJZG7quUS6PHIFEOvzY0cYYFhezDaF1XEIoyLMEl0E8fgSo7MrLmEeZwkdvUHDH6A
         Zxa6wX8lzMPFRpCWfncixIGeaWqpD4pUqcdnb67/p6TFGZozvYsu+TzsKZdZE60sZ54A
         0zkmnrZx1w1FeuNDtIPYAulPW+6Gk1LENrYGjEi/QuC90FU6FE435dKxWFe9S4T/gh6D
         hWorvjkFZOrxwHZ2TwRR6xTnYjN0UfCVvAjhLPoyRtcgN8IitnSBZirY4hQwVILP7/dD
         lQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vK+hcGwCHRtAD4o2ewsAaJdxSZlmDDHrO8oYXh8Zd3c=;
        fh=TxHmgKhQfYbogoK+vmJQIDCo2t34N8xamZxfQlSL1ls=;
        b=SdkHVRDS0lKcwImRMb7jlKWNJgWTg3aZcWuLpfkzDvzsJr8nfz+GR0KH4DTkexOEYh
         BryTlWILtwyDeZD6dydgIkvWp3XNybPwf4Lr7mikH8PhyoKpLzQdImJrA/ytF+uGAduD
         21J35bq74Q5vFgnlPLnqLght5T95X9fdK2zJgqkzGZsf6NgH0ROB35BHNFl0OAHqfdp8
         +1zuWNYlkzakYRKI6oF/ne9vNHJHX3y27eKHsp7HEEA5xypeWfN9JZHMecC4erzm/F9t
         1hzNfYt/sJDJPbnWGJLT86Q1Y5q2ATMBod14tTgmF4u/nRIb11CiJ6zJxSdWvhjHJiTm
         KBqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296991; x=1784901791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vK+hcGwCHRtAD4o2ewsAaJdxSZlmDDHrO8oYXh8Zd3c=;
        b=PBgj0D/SgDBf0nwqq6cvGawFMIw3Umb6ZCYS6J/IsuNHi1onlrmKFGZbSjjY+VYnBO
         igoG6L24bf/nQv38dE5C9AUOHX53eCmd/zKLoDTIRo7fwbh5AfCgFvhvpO9vIi7NcTOe
         6Mp8xEq42ZFeSIkqb7VyyN1Ut/xg8GVwgLu3EGGT289QOZw/U7hd+ElBuQoGhMQJTMyt
         dYvAJeiEkg7ixQ37JGhoEp67Xw4w2lAFjQCFHU6x6hEuuN59AxJXZrIk4dlvyNps4RT7
         k9PY1LVHPnLV0LSyBk3Qq57cNpDhgkx1n1KtzHqnNtvZsrvtewHoJk3k41Rk5Kq+fTPx
         gCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296991; x=1784901791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK+hcGwCHRtAD4o2ewsAaJdxSZlmDDHrO8oYXh8Zd3c=;
        b=VSGJcrkir7dqbhPE42awG4EgHDugxCnHTfhoLCVUlV9eCOa/RjIKgVkZM4/xayuDuD
         lLlA+k57M3HZk3Ma9tK8AacPcMSI7au2AR+Q1tQ1T3PFzT+bZ+56jinSimyH93qL5ovP
         ahinoYPyZqn2RnT8rdxfere+HWT794rixPJAmayVYB8UPE1ldL4LVr8huRt99PBlXJIg
         b+4K4YeOeGU1pm/Nhmd4DGXq/YMWKH+PDeO8NZQilWzaKX5Kg+HFRfQ2xAl787NeL187
         ZD4azfG7Fmn+H7pFKxV/LX6Y6EndR4vb38HH2ac4wKLFPWfo4G8v36uZrctfkYXQSwKM
         mh2w==
X-Gm-Message-State: AOJu0YxusjIYR5aHo2DaWHS+rNR2RnlyXYXo7iDMvBE4HzdFTpe56dlS
	clZPt+BpENij0Ay4mzZVCI0UFFu6xRZS/gw7q44ODmSZvvU9DaHsIrXrIglCzeCi0IEi6+ptiRF
	JtAqOzDUwR/xWT+npMFiEyAlYWKw0tBY=
X-Gm-Gg: AfdE7cnzv2NoMs0CLZw+wTiWQ0UpeK3nT/9hn5cYdqiNzCyEQVpyA+3En7AOMWWYi/0
	hMfVi8NPY8u8mIbMa9/CclGt8coQrjtk4bCOcF30va5QjOnKXHDJP4CTvLou8OylVugVhHFesfr
	XJhIBkDdRCGD2kZwyjccFtMghLFTaqzlXGLiCHSqDy2yyW7NatQJaaIGieKLwBtQqRdoVhVdsMu
	JCJJoujtnarnCyRD4hmU3FDxV5QTJqIIzytZfZ6n7+z8EJETyDmzsWzJS9uau7dpP/e2d2amg/B
	jEzQViq2x7CVjOGLZaaiFfGTE25ubx1ENAAQSkDASHMR71md
X-Received: by 2002:a05:690c:dc5:b0:81e:9b09:7263 with SMTP id
 00721157ae682-81ef22ef2d4mr8316197b3.10.1784296990823; Fri, 17 Jul 2026
 07:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717124111.3296537-1-naga.akella@oss.qualcomm.com> <20260717124111.3296537-3-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260717124111.3296537-3-naga.akella@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jul 2026 10:02:58 -0400
X-Gm-Features: AUfX_myQRU-EtpyqtYrRDsCIHXVb91bQ3fDLY_LUGPr6p4OfO6_UCZaJk_faOSA
Message-ID: <CABBYNZJuitiNCz_COYYvUEY6_TbB=d6dZet=XEmHUkh=ENrzSg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 2/2] profiles: Register RAS UUID reactively
 instead of probing
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Fri, Jul 17, 2026 at 8:41=E2=80=AFAM Naga Bhavani Akella
<naga.akella@oss.qualcomm.com> wrote:
>
> Replace the unconditional reflector-role GATT_UUID probe in
> gatt_client_init() with a reactive registration driven by actual
> remote RAS access, using the notification API added in shared/rap.

It seems you already have something like that in bt_rap_register
attached callback, it is just never used, which explains why
rap_attached is never called and you need the likes of probe in order
to create rap_data_new.

> ---
>  profiles/ranging/rap.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
> index 3ffc0da76..4f6d7f2db 100644
> --- a/profiles/ranging/rap.c
> +++ b/profiles/ranging/rap.c
> @@ -308,6 +308,27 @@ static void rap_attached(struct bt_rap *rap, void *u=
ser_data)
>         rap_data_add(data);
>  }
>
> +static void rap_ras_accessed(struct bt_att *att, void *user_data)
> +{
> +       struct btd_device *device;
> +       struct btd_service *service;
> +
> +       device =3D btd_adapter_find_device_by_fd(bt_att_get_fd(att));
> +       if (!device) {
> +               error("unable to find device for RAS access");
> +               return;
> +       }
> +
> +       service =3D btd_device_get_service(device, GATT_UUID);
> +       if (!service) {
> +               btd_device_add_uuid(device, GATT_UUID);
> +               service =3D btd_device_get_service(device, GATT_UUID);
> +       }
> +
> +       if (service)
> +               service_accept(service, btd_device_is_initiator(device));
> +}
> +
>  enum cs_dict_target {
>         CS_TARGET_SETTINGS,
>         CS_TARGET_CFG,
> @@ -830,6 +851,7 @@ static struct btd_profile rap_profile =3D {
>  };
>
>  static unsigned int rap_id;
> +static unsigned int rap_ras_accessed_id;
>
>  static int rap_init(void)
>  {
> @@ -840,6 +862,8 @@ static int rap_init(void)
>                 return err;
>
>         rap_id =3D bt_rap_register(rap_attached, rap_detached, NULL);
> +       rap_ras_accessed_id =3D bt_rap_ras_accessed_register(rap_ras_acce=
ssed,
> +                                                                       N=
ULL);
>
>         return 0;
>  }
> @@ -848,6 +872,7 @@ static void rap_exit(void)
>  {
>         btd_profile_unregister(&rap_profile);
>         bt_rap_unregister(rap_id);
> +       bt_rap_ras_accessed_unregister(rap_ras_accessed_id);
>  }
>
>  BLUETOOTH_PLUGIN_DEFINE(rap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
> --
>


--=20
Luiz Augusto von Dentz
