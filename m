Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63F4C91
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851790; cv=none; b=L1WWwJcYVC110t/7oyzQ5FOzxAUAbfoTVgEv+VX2CdGDDpM3sLVyiE8NZTla+CVIJljy3Mh4vLhPeRxD6GUka6S85b2Z0/leSe69/cJLIUz69rE1NFIEclB6awKjHtVBJqeBcU/MFcw0HD5/AD/w3aw47g5sT8y1ssFxf8Wme3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851790; c=relaxed/simple;
	bh=pv0gp6NiwW2nisCUHvwqAd99zZmNT6KzNOy11fyEyho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WY5K0/kKo9QXcsg7LCrBkx0j5YhzZCc2HV/uIKrCQDhdDx3F/Vhvajb03jm9hiAmv4UWtit9arMKasy9jQpD6F+c027Gf2NX7JwN32YjITqL+lBnB5sjgAIpZjtatH5uz7TPCn+aROeSRczDBQUeWN5gKNqjO7K0D9wZDJIiJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+c/qQs9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+c/qQs9"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30c461a45f8so47005211fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745851787; x=1746456587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4PjYJhC4kipD4OwhU5FiptGG5pnIgyg6OsPn8oyfeA=;
        b=C+c/qQs9FbcXqbKwb31ygb+pwESk6DiBuQH0X/jYRrNIScpWjrLoRLwgh0vRt0xPCf
         n3R1ZWlmWtRq2RjzIc9pCS+R0FsW6O/ULHTtYuZEHwpSv9nwLbAc7rjD5u2WNO0IdswE
         xOFlBw9FKhsaeLhvQToI66EojubnrrsrJnAn/S0aJ1tD7JqdoViCbw+p4f2TQqafR5aG
         YGYN0636SZjCUGXK3o2bcP24Bbjq6IgY5560Fg2j35XTpBPdXk2m6s9ukKOa5RXXYBPH
         kwtDGP+y0tugB4KptbSbWElZwWTvHP4KQOY6KrVOcdYPxNJpzHkuhGsR+iDPoVjEfDh5
         UUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851787; x=1746456587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4PjYJhC4kipD4OwhU5FiptGG5pnIgyg6OsPn8oyfeA=;
        b=EUKn1E84hcM+99pCgZESQ4R2xY+CsFjc+yvX7Vl8RrjoneOHm8gjoJr9w5SC2kzWiy
         h4h2rZ1VKSpNdgb/aC+xbqTUG4Rd4fThqbwvxNXjnRZot6CF1pOgYVlJX8YAeuoT7t/g
         I+GxrJ8wjk/faRR5uPB2ZKEHiaVLriHcV93y0MoG9hrgYXBXFvF02HnZCFhzxKgWKFgK
         sBY5qxa5/HuiumlaLcR2aI1z3HJScAbGtwLyHWgRO+c8Man82w8ySmPLkrz3HFdHiaV6
         OpyH2AGa7bzuBpV5Kn1yK3wvCvYTnkTG/63uhwDHkTbJlF9Za2xkFaORVerdZO1XcqDM
         cAhA==
X-Gm-Message-State: AOJu0YzHcbWJBOjEFiYoyXdXd0SrG36WpvCluCGvTypoE0u2Yr2iusNq
	vTDMVmMHtHjJMKrjL7Iz+myeND81MQvYTU0DlWDNxMJbSWpN8ZHygaYnxq9eva+AuX2c1xVuCt5
	8mh5qM87JKDidtneByJ1+PDUOq2Nil4qBMifHwA==
X-Gm-Gg: ASbGncvqFEG/zbIpMrlx0AkM6WmnFB2EoLfHWQiiYDWFfEkBZlPbz4/VwawnFnVvoug
	Zbwq+HTdBHbE6mAcix6gJre6DT7Qt4aMzTgc+cA3k6SLLQeO5kgecqVg2RuL9d3An+F5ljkOqne
	DatkZ68nLgb276EUrftZuv
X-Google-Smtp-Source: AGHT+IFBITbxXjLpK2pHRjOr91krbyc4UKn21cIGewNFmedovruH59Gpjv9iRNcOkLl5l7gJCJNI3fGRpbnZzu9pO0g=
X-Received: by 2002:a05:651c:1509:b0:30d:e104:b67c with SMTP id
 38308e7fff4ca-31907bec1f7mr36243871fa.39.1745851786560; Mon, 28 Apr 2025
 07:49:46 -0700 (PDT)
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
Date: Mon, 28 Apr 2025 10:49:33 -0400
X-Gm-Features: ATxdqUGk1e2aouEnI-qOn3jbz-dWxRWTcBAvdu_8PIoIVIj3XUTnUw14jhqK2jc
Message-ID: <CABBYNZJhtui6-dzeqUqPfeV=C27QGQNJMsgyRnQeLG1TFP3vBw@mail.gmail.com>
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

One thing that just occurred to me, can ETHTOOL_GET_TS_INFO be written
as well? If it can we could make this just an ioctl operation where we
attempt to enable so_timestamping field and then the kernel checks if
it can be enabled, that way we don't have to introduce another to
D-Bus since so_timestamping would only be enabled if bluetoothd had
enabled it, that said we need to confirm that would fail with older
kernels.

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
> +
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
