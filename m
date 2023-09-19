Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DC7CE79A8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 20:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjISUKz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjISUKy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 16:10:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5944D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 13:10:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so99903601fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695154246; x=1695759046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxamuXa++dHcUm/bgd8P4v81tqGt/XvCU4ZkO3B8Uko=;
        b=hIc4EXW3qy76IbYCqDPKa6XY3gO/k9yygNLIa3mZ3Ttp/1N957JHzxw4iXnYrKj04A
         Y38qMRFYdkMtq5hwbcJ3UGBNQ/kGY82FbbbR5jXnz07TSRn8Y06u1Gk4UDldjI+v9jK9
         dlT1+/6Ep2IjLH6VPpe88K/mjcp0jFiUTn/vFE9fss+r3NtQXDs+2iLZ1qG3isuKdO8D
         ehxpwq1656HjB4Cz9snIwyD+9377r3mEGNJy11fjdv6vnbPjKUkWm8/DH2aygYNKaLnz
         Ge4eD7NW+08i1JdXRZF6NB9nZkV2/XG0h5EpsCjMdGIrXPoG7VXuTS/dbCwpc4vpxYTs
         XDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695154246; x=1695759046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxamuXa++dHcUm/bgd8P4v81tqGt/XvCU4ZkO3B8Uko=;
        b=ob4qtR34N5AWpvIKJ+6D6iPCMs2gM2XUM6o7SJ5sg5K3GvfzkFojitt7Ekgy9Dxvb/
         EgMUzG1xDSE8gjppEVgA/S5Yf53Tl9M1kTjJVIALJz434kWAoUrx49P3SvMsXn2ce2dF
         qJJ6kT1XRC6I5Oqd3A1RCMdAXvfB/Kkni/GQcp+6gcPJHzdTTCWT+grqUKvB+JAvNL0a
         t4E2fwc8+DpD2dpVfW6/wx8q6y0qyHKL36uYWU/TNFZt/NuXx65m+ukg8CXiwpLoXvjg
         wOGN4MpD2EYeu7Rqzg/617Ee9DxbNzHbFbrfeTl5z5G7E5VPjGi4WaoRvt/7J/79Xqf5
         GnhA==
X-Gm-Message-State: AOJu0YxF12COUEGa8+Ex+0rFM3dkyhuSrj+PRDTgzn51xdZKxgQNsxpt
        xxHfnfII/evQQzBpIQzHeUORj2ryhiIAzJF/xXBuFhLqB60=
X-Google-Smtp-Source: AGHT+IGMqP4DSphhNe5pLFl1x5nJqVdIJBY6Vno1pxvbtaBAE8MWFHMbAMvkhGp5BaRnWmVnAcbr2B1MQuqt34EcOtw=
X-Received: by 2002:a2e:9dcc:0:b0:2bc:b694:6d6e with SMTP id
 x12-20020a2e9dcc000000b002bcb6946d6emr401837ljj.27.1695154245954; Tue, 19 Sep
 2023 13:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <89ceb9e5d67485c19d0f139ac0825cf008491ebb.camel@gmail.com>
In-Reply-To: <89ceb9e5d67485c19d0f139ac0825cf008491ebb.camel@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 Sep 2023 13:10:33 -0700
Message-ID: <CABBYNZJHv8iw0ZvgWFCTpe6EAj0d92ghbimtAqzej+Jf7a9Bmw@mail.gmail.com>
Subject: Re: [PATCH BlueZ]: adapter: Add Version and Manufacturer props to org.bluez.Adapter1.
To:     vibhavp@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vibhav,

On Tue, Sep 19, 2023 at 12:59=E2=80=AFPM <vibhavp@gmail.com> wrote:
>
> From: Vibhav Pant <vibhavp@gmail.com>
>
> This allows DBus clients to find an adapter's version and
> manufacturer company code without querying the management API.

We don't use Signed-off-by on userspace.

> Signed-off-by: Vibhav Pant <vibhavp@gmail.com>
> ---
>  doc/adapter-api.txt | 11 +++++++++++
>  src/adapter.c       | 28 ++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index d38ce7171..10c290c62 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -360,3 +360,14 @@ Properties string Address [readonly]
>
>                         List of 128-bit UUIDs that represents the
> experimental
>                         features currently enabled.
> +
> +               uint16 Manufacturer [readonly]
> +
> +                       The manufacturer of the device, as a uint16
> company
> +                       identifier defined by the Core Bluetooth
> Specification.
> +
> +               byte Version [readonly]
> +
> +                       The Bluetooth version supported by the device,
> as a
> +                       core version code defined by the Core
> Bluetooth
> +                       Specification.

Documentation should be submitted in a separate patch.

> diff --git a/src/adapter.c b/src/adapter.c
> index 5ebfc4752..8f67a6826 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -260,6 +260,7 @@ struct btd_adapter {
>
>         bdaddr_t bdaddr;                /* controller Bluetooth
> address */
>         uint8_t bdaddr_type;            /* address type */
> +       uint8_t version;                /* controller core spec
> version */
>         uint32_t dev_class;             /* controller class of device
> */
>         char *name;                     /* controller device name */
>         char *short_name;               /* controller short name */
> @@ -3540,6 +3541,29 @@ static gboolean
> property_experimental_exists(const GDBusPropertyTable *property,
>         return !queue_isempty(adapter->exps);
>  }
>
> +static gboolean property_get_manufacturer(const GDBusPropertyTable
> *property,
> +                                         DBusMessageIter *iter,
> +                                         void *user_data)
> +{
> +       struct btd_adapter *adapter =3D user_data;
> +       dbus_uint16_t val =3D adapter->manufacturer;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &val);
> +
> +       return TRUE;
> +}
> +
> +static gboolean property_get_version(const GDBusPropertyTable
> *property,
> +                                    DBusMessageIter *iter, void
> *user_data)
> +{
> +       struct btd_adapter *adapter =3D user_data;
> +       uint8_t val =3D adapter->version;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &val);
> +
> +       return TRUE;
> +}
> +
>  static DBusMessage *remove_device(DBusConnection *conn,
>                                         DBusMessage *msg, void
> *user_data)
>  {
> @@ -3898,6 +3922,8 @@ static const GDBusPropertyTable
> adapter_properties[] =3D {
>         { "Roles", "as", property_get_roles },
>         { "ExperimentalFeatures", "as", property_get_experimental,
> NULL,
>                                         property_experimental_exists
> },
> +       { "Manufacturer", "q", property_get_manufacturer },
> +       { "Version", "y", property_get_version },
>         { }
>  };
>
> @@ -10162,6 +10188,8 @@ static void read_info_complete(uint8_t status,
> uint16_t length,
>         adapter->supported_settings =3D btohl(rp->supported_settings);
>         adapter->current_settings =3D btohl(rp->current_settings);
>
> +       adapter->version =3D rp->version;
> +
>         clear_uuids(adapter);
>         clear_devices(adapter);
>
> --
> 2.42.0
>
>
>


--=20
Luiz Augusto von Dentz
