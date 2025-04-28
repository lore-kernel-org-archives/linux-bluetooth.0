Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC85268FEB
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851387; cv=none; b=cp9GnRMM6jjTU9Md5W29ZtvzlRqgN3Xfc4WoeXowAvLdZn1qIx0qA42XOvZxKMMhCtvWeaN6sWxSBxASxFwv5Sjn0avA+QKHadJjq/REZG2kxJzqlam95yb7dPy0mr4Aux1f641aI27jNwcvurHP1fUt6KNo4uNo5KSJWXED0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851387; c=relaxed/simple;
	bh=9MEe2xsLAD5VohhZf0T3IXQHM7kYfxjlC8JVpRjhoHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeQsl0gvpKizsGnlv7ZavhcwnSCC6S3PJ3k4FFm2rO4JcVuNKGhGhtHRaPnTn5ZE+1topEjHShIkZ8SiQD/MtaEs2TLGbZrWwrWfrIYJhIhxzhkMSZQCVjm0WApX2vN5gVjO12ZuJaUr3w1aegIqIGtfY3oc23kN7tLuTAp2FZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7eOLUog; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7eOLUog"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30beedb99c9so44666741fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745851383; x=1746456183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YBDSjQ3kbEmlzZN/ppeZXpZpCseuiUW1esPcJHn3Ns=;
        b=K7eOLUogdurIXU+v2sC4/PoiqQ1BsO14PrcaqPYo4X1RtsZmalRspfBTTEeM3DzVU6
         Zd7kfQIFT5TR6ewSZQWOuGOj2bqZrlkhLZ2t11S6Klk3r/UsF1l2KC11NY/JGZkjIclY
         cl+AHo1ovp3b4K1vcoMjHBLFbjJum1w8larkf+ZuKyutTfk3MfGDyZOJiwjqiUUtvwMu
         l5GRZl5i8T/beA/8OWrpSnjBnf/LAKPKjcpQGyiTXMY7lvy+/okRzn538DMbG07bLztx
         gNVUdT3cYJ44MGYJjW9r1ozDYJwWmw3mQOV9o75EEKlFEbPn1bqfzMu5eaVE6h4/yVLD
         OeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851383; x=1746456183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YBDSjQ3kbEmlzZN/ppeZXpZpCseuiUW1esPcJHn3Ns=;
        b=buod9i4VRf0ovxJyZ2GB9MvawKTqZ3nG15jgDNulDcTnBWF2mY04Fjq5BGDtA1px0f
         bXYKTAGeh0Q8P1IUqQ8Qkmjkuzc4I09eGcQ2Yg46sf+IxNX0Oo56AfdFuWUGQrOZ0EE7
         3ZJlRnNQFqLZdI+hM/wJ7VW8R77VxrmIJEh6WQoXbpx1nnMNDp/zc4ZESbt9kQI64JmW
         BmFVcJVUvNhWzRe998U/6NCjkL/Ia5SulqKE94UqdGu7xGaWaaoUZrAbFa4Zo7ZrSQkM
         dYaS73ri6Yiu+h8JGuFhbquc3hUfClCJCLkKG8eTCmnDpgLbkFQCTe+PopmxR5ugwSOv
         fWBA==
X-Gm-Message-State: AOJu0YzJU0D0c6RcvGwbMCjqyRBNas9EY85/O2s2KMGuv5OdKEtWuPRQ
	f9TxqGjoHIIRBElxg/R1PSQByrgbloaBo/Ak/AjoJk+WQ1V7HekNFOra66ETXoG4tqssEmPSGdW
	cO1lXyNiTVYpTEVpEKHta57bluTpIRRsf7EEM0Q==
X-Gm-Gg: ASbGncvD4gnX8/LPI71kD627zhKg39DIdiat2b5LX0GUaSZGEw5yQt1ro7PGLRQcvBj
	sRDEg4QODWM4gv2bqcl3qWzteE9VkuQOji5yCC5gEj4dW9hDFEZSF8gS8Gq1YHLHAEoQztxpjPO
	wvmiLV/FVyrF+5HouqX3r4
X-Google-Smtp-Source: AGHT+IG9o7Q00pKnpSKFrXZ0Gku9CsKfZbTFiJhx0IpbsZWycncBNsZT4XqHCjMfLv8YOTM9ryBqaNekzXVqt1ZwNd8=
X-Received: by 2002:a2e:bc19:0:b0:30b:d073:9e7d with SMTP id
 38308e7fff4ca-319086bb338mr39498961fa.37.1745851382903; Mon, 28 Apr 2025
 07:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c304d0b98ed0ce4504549e43a99adcfcaca77521.1745771127.git.pav@iki.fi>
 <ed970951e6eaef866ebec82f47fb49929a9f1ea2.1745771127.git.pav@iki.fi>
In-Reply-To: <ed970951e6eaef866ebec82f47fb49929a9f1ea2.1745771127.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Apr 2025 10:42:50 -0400
X-Gm-Features: ATxdqUGgCLy6LUs_bNKA8iuqv6EfAyUcTQ-E9DtNRSsT14QgSB7MO0Mg8rz_wZc
Message-ID: <CABBYNZ+xmemjzWenom10ENv4LKsoECb7W_Qa34=gJdnz4dmyKQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 2/2] media: implement SupportedFeatures property
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Apr 27, 2025 at 12:25=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add org.bluez.Media.SupportedFeatures. Add feature tx-timestamping.
> ---
>
> Notes:
>     v3:
>     - fix #includes
>
>     v2:
>     - use SIOCETHTOOL to get kernel support
>
>  profiles/audio/media.c | 74 ++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.h          |  3 ++
>  2 files changed, 77 insertions(+)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 69c6dc671..07264cfa1 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -18,6 +18,17 @@
>  #include <errno.h>
>  #include <inttypes.h>
>
> +#include <time.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <linux/errqueue.h>
> +#include <linux/net_tstamp.h>
> +#include <linux/ethtool.h>
> +#include <linux/sockios.h>
> +#include <net/if.h>
> +#include <sys/socket.h>
> +#include <sys/ioctl.h>
> +
>  #include <glib.h>
>
>  #include "lib/bluetooth.h"
> @@ -81,6 +92,7 @@ struct media_adapter {
>  #ifdef HAVE_AVRCP
>         GSList                  *players;       /* Players list */
>  #endif
> +       int                     so_timestamping;
>  };
>
>  struct endpoint_request {
> @@ -3340,8 +3352,69 @@ static gboolean supported_uuids(const GDBusPropert=
yTable *property,
>         return TRUE;
>  }

I would add a comment regarding the assumption that this depends on
bluetoothd not threatening the errqueue events as errors, which is why
it is important to have this exposed otherwise the clients don't know
it can be safely enabled with use of ETHTOOL_GET_TS_INFO.

> +static bool probe_tx_timestamping(struct media_adapter *adapter)
> +{
> +       struct ifreq ifr =3D {};
> +       struct ethtool_ts_info cmd =3D {};
> +       int sk =3D -1;
> +
> +       if (adapter->so_timestamping !=3D -1)
> +               goto done;
> +
> +       snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "hci%u",
> +                               btd_adapter_get_index(adapter->btd_adapte=
r));
> +       ifr.ifr_data =3D (void *)&cmd;
> +       cmd.cmd =3D ETHTOOL_GET_TS_INFO;

I'd probably add a comment here saying that if one does support
SIOCETHTOOL over L2CAP then it must be enabled to other
MediaTransports, e.g. ISO.

> +       sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
> +       if (sk < 0)
> +               goto error;
> +       if (ioctl(sk, SIOCETHTOOL, &ifr))
> +               goto error;
> +       close(sk);
> +
> +       adapter->so_timestamping =3D cmd.so_timestamping;
> +
> +done:
> +       return adapter->so_timestamping & SOF_TIMESTAMPING_TX_SOFTWARE;
> +
> +error:
> +       if (sk >=3D 0)
> +               close(sk);
> +       adapter->so_timestamping =3D 0;
> +       return false;
> +}
> +
> +static const struct {
> +       const char *name;
> +       bool (*probe)(struct media_adapter *adapter);
> +} features[] =3D {
> +       { "tx-timestamping", probe_tx_timestamping },
> +};
> +
> +static gboolean supported_features(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_adapter *adapter =3D data;
> +       DBusMessageIter entry;
> +       size_t i;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                               DBUS_TYPE_STRING_AS_STRING, &entry);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(features); ++i)
> +               if (features[i].probe(adapter))
> +                       dbus_message_iter_append_basic(&entry, DBUS_TYPE_=
STRING,
> +                                                       &features[i].name=
);
> +
> +       dbus_message_iter_close_container(iter, &entry);
> +
> +       return TRUE;
> +}
> +
>  static const GDBusPropertyTable media_properties[] =3D {
>         { "SupportedUUIDs", "as", supported_uuids },
> +       { "SupportedFeatures", "as", supported_features },
>         { }
>  };
>
> @@ -3383,6 +3456,7 @@ int media_register(struct btd_adapter *btd_adapter)
>         adapter =3D g_new0(struct media_adapter, 1);
>         adapter->btd_adapter =3D btd_adapter_ref(btd_adapter);
>         adapter->apps =3D queue_new();
> +       adapter->so_timestamping =3D -1;
>
>         if (!g_dbus_register_interface(btd_get_dbus_connection(),
>                                         adapter_get_path(btd_adapter),
> diff --git a/src/adapter.h b/src/adapter.h
> index 6b2bc28f6..9371cdefb 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -262,6 +262,9 @@ bool btd_le_connect_before_pairing(void);
>
>  bool btd_adapter_has_settings(struct btd_adapter *adapter, uint32_t sett=
ings);
>
> +int btd_adapter_get_so_timestamping(struct btd_adapter *adapter, int pro=
to,
> +                                                       int *so_timestamp=
ing);
> +
>  enum experimental_features {
>         EXP_FEAT_DEBUG                  =3D 1 << 0,
>         EXP_FEAT_LE_SIMULT_ROLES        =3D 1 << 1,
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
