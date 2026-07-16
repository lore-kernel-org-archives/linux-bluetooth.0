Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D9309F09
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218561; cv=pass; b=Ebk1JPmdBbW5m3Oh8BgU0/l3yauVTr651c11MRKUdm30WlQc7QMYrt7kWttCkQp15gAuydf2oFbjPkSJ5UFeiXCYfZehfohqLrqt/k3Y1z15fnnOXP6SNilYf+Y87AA4nb8BLZPGymxgwJohov/dsb2BhHrDNR71RgHywQ/9KFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218561; c=relaxed/simple;
	bh=PyqSTUVi0t55NTu/1fM3B6tspFvaI7sivoOL74IhSQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWrd+sr7yOs0XCQtlGviTjbPBDxBD0KKqF6OdglzCXL/TZAnxySGrjIQyO1FwuG8tgtVrkQoZYaDtaeWIbClZoN19cIvPKrWgt5mt1Zh8MMbW+QX7NYyhb5K5LXHy9SsHbJ4aTVHumm9ROIIBsGomww80h7RVkdEIAXLOMxefsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2YqkaPx; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2YqkaPx"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e86df8987so8399997b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784218551; cv=none;
        d=google.com; s=arc-20260327;
        b=YbntNH5Y9Kcw0GBfw7BCSQ6UMLzKySKVqWneFHdfIe/oSazrg0Fb4qs+GdegCeUzzZ
         VXp5/W8wZacyrEdGNB1ToSNVLTDjqIQnAQhh8r3vYnAROwNIF3mMMoSZRn7+rkrUAytV
         bJ0zLglQg8UiIySOYSFosMdKfOjC23st40ZbGzFwt4hE0nJLgY2Lv2VDuSeuV9sTwn4T
         b+hT9J4xDhHTLZKMy7U4I5YIBSiI3HvgaDjGtmZ/4Qd0Vk4R8yPZ3ZKG5cwd5HWpFky6
         B68im797U/25ZDvR1p79AvtkYG6gx4hP03wZASeDiPTq5l6ZyTtBFW5d0yNkrEYV7T6y
         WN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CIe4X2WFP2lbbyHTjGkVLGguNGQHLvS6YDIiUWYL34Q=;
        fh=TxHmgKhQfYbogoK+vmJQIDCo2t34N8xamZxfQlSL1ls=;
        b=d+49R5U60l64wWfA02k/mNRcO9aqSgt9AQJ9KIlkLlcIoZIAfp4BQpg1BneCJgH2z3
         AT8I7PJH8HXkM6fSXzYaUtUpwnXCIsmsv7lWaLIptIWuHo3mIokZvyuzs0z75+Fb1TQ8
         N8hhALT7a6TU/DpbPYtH1SwxsFqUGBgRPqOAkOiqHiZMfuBDfZzr5JDbnW9l7yW5D6e7
         mN7gIrTzfiwZGwIfoXbPtFiMiicAyjFIesQZ1tfiySI5zTDta/zeJvUq3FSORbJF2w+b
         6q4m1lgDLpqWoRSOk/ONOnBKYhQozZBp/C2+ugllnoXfD5RdfrAEJnfDl56hzk9ZGX/o
         8npw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784218551; x=1784823351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CIe4X2WFP2lbbyHTjGkVLGguNGQHLvS6YDIiUWYL34Q=;
        b=V2YqkaPxWTqeH2Cc9os93COCL4Pz9kqDJ0h9tPzTI8Ds+z+1sWSvRm4L0btJ9yXrZY
         P4vVNN7lAvPmF6935pNoUR0pzkh2EDkibymBjkEJGFY33g0PHSmAX7r9Pl+s896jsCeb
         XGeozW1cF0M/kWz9V+8Za4r099Rx3zkoMoz/UP1l1ROFep97Xm2zF+iR2CxMVkoJnt+J
         4GzGymkNdjuVMu+bjpcOkEfCjH3VPoIOpAuCkZqjvNa+o4FxBR46Y4nWqGyhomvW9uDO
         /PcYDL/vDrhLn0dQ7r9GgVMDMF7+UO2FRH2qtvwgXKWRSF7vKWl7PXBiaY8XylCRmNPB
         XyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218551; x=1784823351;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CIe4X2WFP2lbbyHTjGkVLGguNGQHLvS6YDIiUWYL34Q=;
        b=lkPFBT0zlDswoBUGNEHybsm6NSFJQNPR/FWYS5K2N9yq/BOehwcFIAWjLlS0MDuTj6
         J+ZPiU5J0isz4sqffjCj/LCkuy4gmZNPwFwuhrBFNAMFdCp5aRAzwfZvfVcwHZCn8ttB
         q2QnM69ceJU58HJW1Q3YnN1BHCGuTwtXcTP2DXskbSiqNGybJsXSqas71ZO5lOQljP7q
         HYtUmUG+ZxCTVIAn9KhjcW5ZyvKvonV5y80LTGpdi2Jg9cm3ZXCx6GGkNFBOrEFnaESZ
         WYfBukdGG1V2RPZcJUv62pTrJKQHvoTJPai0k20JSkxsvvFIWuNrq/PSiUJLn6fKRWYW
         extw==
X-Gm-Message-State: AOJu0Yzg6tGNRFXD/VYUGILaVxyhyKRtmZt8L2BeRM1XO6lubR+SNy54
	rBXkV/KPalNjppqaEfRiNKozZWbEtz3s8nwcWGifQ8sKiXaFypUkO33wQWTQBB01NXDF51YpFdY
	xO4jDGA8S9ki2aA14z64MzTTD1dyzWG5FvSxI2cg=
X-Gm-Gg: AfdE7ckmo9PZtYvs1jSgpZ6+CkZE+eCbf+Qvo+wzb1fdK/uMxHKMGHUh3tl/V9goKxO
	SuKWPuvzuwfBKVjHZdVcCr+YcZaUGk85bY1yCx99WK+gEZPbL5mLmaS1Y5gpLRD0VVXPsqc4L7s
	EMLPDnsKjbWOAa6RitgMySITfqgK4zekewEAIyXe5nzd0Zr83R2x/rsDPo6CUf8Y4vpIVAEHrr1
	XyustglhvmcxPxGW6429s17EbTUcwYY4ymRd+6OBc7ASQ+eJ53O9ABcKV9M2gePBnMO30pY0y3/
	jRqz7rQWlcLYBVw9TGJi04Rm/2SEtNMiRoMgKIwWAsykOq8l
X-Received: by 2002:a05:690c:c452:b0:815:bc6a:2e48 with SMTP id
 00721157ae682-81ecf776c61mr60679277b3.14.1784218551141; Thu, 16 Jul 2026
 09:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com> <20260712121743.2842547-3-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260712121743.2842547-3-naga.akella@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 Jul 2026 12:15:39 -0400
X-Gm-Features: AUfX_mx_gUZt4EItDMLSBDgbsIAqy20ooZKY4m-1SnQbfkBKiP2TM8l453z8I2k
Message-ID: <CABBYNZJF7ucGh-CLT0YVkgZkU-bVzY_t2-D9Luvodx4dpzDEug@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 2/4] src: Register GATT profiles for Channel
 Sounding reflector
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Sun, Jul 12, 2026 at 8:18=E2=80=AFAM Naga Bhavani Akella
<naga.akella@oss.qualcomm.com> wrote:
>
> Probe and accept GATT_UUID profiles on non-initiator (reflector)
> devices before gatt_client discovery checks,
> ensuring RAP's org.bluez.ChannelSounding1 DBus interface is registered
> even when GATT client discovery is skipped.

This is not how it should be done, what you do is to detect that if
the remote side discover/read any of RAS attributes then you add its
UUID via btd_device_add_uuid.

> ---
>  src/device.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 65d84be56..cedfe3a20 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -6301,17 +6301,31 @@ static void gatt_debug(const char *str, void *use=
r_data)
>  static void gatt_client_init(struct btd_device *device)
>  {
>         uint8_t features;
> +       GSList *uuid_list;
>
>         gatt_client_cleanup(device);
>
> -       if (!btd_device_is_initiator(device) && !btd_opts.reverse_discove=
ry) {
> -               DBG("Reverse service discovery disabled: skipping GATT cl=
ient");
> -               return;
> -       }
> +       if (!btd_device_is_initiator(device)) {
> +               /*
> +                * For the reflector role GATT client discovery is skippe=
d, but
> +                * profiles that match GATT_UUID still need to be probed =
and
> +                * accepted so they can register their D-Bus interfaces (=
e.g.
> +                * org.bluez.ChannelSounding1).
> +                */
> +               uuid_list =3D g_slist_append(NULL, (char *)GATT_UUID);
> +               device_probe_profiles(device, uuid_list);
> +               g_slist_free(uuid_list);
> +               device_accept_gatt_profiles(device);
>
> -       if (!btd_device_is_initiator(device) && !btd_opts.gatt_client) {
> -               DBG("GATT client disabled: skipping GATT client");
> -               return;
> +               if (!btd_opts.reverse_discovery) {
> +                       DBG("Reverse srvc disc disabled: skip GATT client=
");
> +                       return;
> +               }
> +
> +               if (!btd_opts.gatt_client) {
> +                       DBG("GATT client disabled: skipping GATT client")=
;
> +                       return;
> +               }
>         }
>
>         features =3D  BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING
> --
>


--=20
Luiz Augusto von Dentz
