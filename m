Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6D26B948
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858955; cv=pass; b=lv2yDvQaPfqYAQkiBcCha5+/mTi/hZrhZfhuwncdcUPyYwdBl76ZqW4BjNqQmVMeSqVnPY4u9+4+LGR/bQyUe9US7DXT2bi38P3nhRaK65TTMkP67NAN8MXtrq86knX1B/cHJKQOO30CTb3Mjrhl+9FuYaav0m1HzufPhgGYQC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858955; c=relaxed/simple;
	bh=R0lXGlQTNnxloAeYZjBlFaSuut7qPLX4HsUyJhwqDCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyA843hPHn+2y4M/xHiGqbK3oCtnOtmhtBogyKJ8p/5y6I/fVlM1oQxsfTtA/hrlex2wpF7qN6wfBOdaiQcyuRMksuiLjULoH96nfql5rNAjJTysQsts4tewnR6/8ST5pS23iTpKC/TaXI4uOs+YsiBiEH7K1eIcmFoWUvf7jaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Wc+z72TZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Wc+z72TZ"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZmTtM5sDnz49QDQ;
	Mon, 28 Apr 2025 19:48:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745858940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=twYSX0NhIg/S95mCTm1MyyxVFcRidWRr1uZNfbRioHY=;
	b=Wc+z72TZy4rgjk+EMZLlIA3/NNbz8qABkVc1B0PMOoObiKG7I8mtAO/BQlqTZd1hTNs4V/
	oxR/QbDrhzmGmPIfluAJjFsBB/q4+ouMXvGCPS+4KAgz3QHKU1FD9GPQGynoE0/rxyfeHW
	ALVlYJQdHFJI/qrYatD6l8JvQDDaCbPtfk9kxeggRnPxaZv0jGb4gJUE5KkvlxyqMVQ1sW
	ey6+mFwC3VWuPcwWM2kgcF6g1UizmfGgibCxJRRZdDLGVsUV1uVKunSV8sPjxpmiOb8yxU
	xsDzMLR057ItPtHUoxwa2VXSF7hmLAT7f63R5AN2n8imcksGWYddKaPFEJ7bcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745858940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=twYSX0NhIg/S95mCTm1MyyxVFcRidWRr1uZNfbRioHY=;
	b=fjuXk+zvS80rUS4zdgCT+IWZkACrWBo1BkxoGJnzQH2Dcte0BmXDnv+b92J6HgxquFFTfq
	SkcBWSkKnz/esqmHq9sE9wbmOP1n0ESXBgd63sm822XPOsIRzgAennjgXdLwKYvmfoyBjH
	DASHsooN5HjRUDCXD2WFi+sRJcRxJ7rNqEROd+mljcHeClH6jcH278ekpo9BwwEOUj1gc2
	5+cMcmUVFLirve8yPHiAEQzAPWZv380g0BaUhDQt0Uilka8QbUewIjUe1y3q3JctoBPhWT
	p/LT/xa+O3omoQVyzCoQsFgA5oFlW0YMLntx00xCRaCdyvDgpabXgmA2tRWWSg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745858940; a=rsa-sha256;
	cv=none;
	b=a3zEiKD9aHc4IvmWVBs5YN+SuFq2YIrcjFkJF0Wg3tLeboJU9ksZX297QjupoaGeqX6CFI
	CTwU4RBHThSIQzoVI232T/kaxDdmLKuch5id1ORIXGPHwi/n9gVSu7fqgiNM0JH6w/I02+
	2ThrJUv7gIGvkcnOM16ZP2C671djAyVYd9eDTVB9HmA50Rf96gNaos5IDxW1aOE1GR6ROn
	WGloIU5/um7MWYZyPFYlSCc9cKslI6HUHzNW25BsrUo3xtcsLLHp9f8/v7ccTJPnCWcTsL
	hZiMgveagOHiBSMfNN63CFtdAUk8076/W24jNWJaprIPIT+vLIBuMVdW6xf3Ww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <65fb49d0d91795fb6ca73a4b6e7ffd5de58016b3.camel@iki.fi>
Subject: Re: [PATCH BlueZ v3 2/2] media: implement SupportedFeatures property
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 28 Apr 2025 19:48:57 +0300
In-Reply-To: <CABBYNZJhtui6-dzeqUqPfeV=C27QGQNJMsgyRnQeLG1TFP3vBw@mail.gmail.com>
References:
	 	<c304d0b98ed0ce4504549e43a99adcfcaca77521.1745771127.git.pav@iki.fi>
		 <ed970951e6eaef866ebec82f47fb49929a9f1ea2.1745771127.git.pav@iki.fi>
		 <CABBYNZJhtui6-dzeqUqPfeV=C27QGQNJMsgyRnQeLG1TFP3vBw@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2025-04-28 kello 10:49 -0400, Luiz Augusto von Dentz kirjoitti:
> On Sun, Apr 27, 2025 at 12:25=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >=20
> > Add org.bluez.Media.SupportedFeatures. Add feature tx-timestamping.
> > ---
> >=20
> > Notes:
> >     v3:
> >     - fix #includes
> >=20
> >     v2:
> >     - use SIOCETHTOOL to get kernel support
> >=20
> >  profiles/audio/media.c | 74 ++++++++++++++++++++++++++++++++++++++++++
> >  src/adapter.h          |  3 ++
> >  2 files changed, 77 insertions(+)
> >=20
> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > index 69c6dc671..07264cfa1 100644
> > --- a/profiles/audio/media.c
> > +++ b/profiles/audio/media.c
> > @@ -18,6 +18,17 @@
> >  #include <errno.h>
> >  #include <inttypes.h>
> >=20
> > +#include <time.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <linux/errqueue.h>
> > +#include <linux/net_tstamp.h>
> > +#include <linux/ethtool.h>
> > +#include <linux/sockios.h>
> > +#include <net/if.h>
> > +#include <sys/socket.h>
> > +#include <sys/ioctl.h>
> > +
> >  #include <glib.h>
> >=20
> >  #include "lib/bluetooth.h"
> > @@ -81,6 +92,7 @@ struct media_adapter {
> >  #ifdef HAVE_AVRCP
> >         GSList                  *players;       /* Players list */
> >  #endif
> > +       int                     so_timestamping;
> >  };
> >=20
> >  struct endpoint_request {
> > @@ -3340,8 +3352,69 @@ static gboolean supported_uuids(const GDBusPrope=
rtyTable *property,
> >         return TRUE;
> >  }
>=20
> One thing that just occurred to me, can ETHTOOL_GET_TS_INFO be written
> as well? If it can we could make this just an ioctl operation where we
> attempt to enable so_timestamping field and then the kernel checks if
> it can be enabled, that way we don't have to introduce another to
> D-Bus since so_timestamping would only be enabled if bluetoothd had
> enabled it, that said we need to confirm that would fail with older
> kernels.

There does not appear to be ETHTOOL_SET_TS_INFO or equivalent for
netdev, the information comes from drivers where it is hardcoded.

So if we want that, it would be a new API. Designing new APIs, one
might want instead to take another shot at the NO_POLL_ERRQUEUE thing,
but maybe lower in the netdev core stack.

> > +static bool probe_tx_timestamping(struct media_adapter *adapter)
> > +{
> > +       struct ifreq ifr =3D {};
> > +       struct ethtool_ts_info cmd =3D {};
> > +       int sk =3D -1;
> > +
> > +       if (adapter->so_timestamping !=3D -1)
> > +               goto done;
> > +
> > +       snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "hci%u",
> > +                               btd_adapter_get_index(adapter->btd_adap=
ter));
> > +       ifr.ifr_data =3D (void *)&cmd;
> > +       cmd.cmd =3D ETHTOOL_GET_TS_INFO;
> > +
> > +       sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
> > +       if (sk < 0)
> > +               goto error;
> > +       if (ioctl(sk, SIOCETHTOOL, &ifr))
> > +               goto error;
> > +       close(sk);
> > +
> > +       adapter->so_timestamping =3D cmd.so_timestamping;
> > +
> > +done:
> > +       return adapter->so_timestamping & SOF_TIMESTAMPING_TX_SOFTWARE;
> > +
> > +error:
> > +       if (sk >=3D 0)
> > +               close(sk);
> > +       adapter->so_timestamping =3D 0;
> > +       return false;
> > +}
> > +
> > +static const struct {
> > +       const char *name;
> > +       bool (*probe)(struct media_adapter *adapter);
> > +} features[] =3D {
> > +       { "tx-timestamping", probe_tx_timestamping },
> > +};
> > +
> > +static gboolean supported_features(const GDBusPropertyTable *property,
> > +                                       DBusMessageIter *iter, void *da=
ta)
> > +{
> > +       struct media_adapter *adapter =3D data;
> > +       DBusMessageIter entry;
> > +       size_t i;
> > +
> > +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> > +                               DBUS_TYPE_STRING_AS_STRING, &entry);
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(features); ++i)
> > +               if (features[i].probe(adapter))
> > +                       dbus_message_iter_append_basic(&entry, DBUS_TYP=
E_STRING,
> > +                                                       &features[i].na=
me);
> > +
> > +       dbus_message_iter_close_container(iter, &entry);
> > +
> > +       return TRUE;
> > +}
> > +
> >  static const GDBusPropertyTable media_properties[] =3D {
> >         { "SupportedUUIDs", "as", supported_uuids },
> > +       { "SupportedFeatures", "as", supported_features },
> >         { }
> >  };
> >=20
> > @@ -3383,6 +3456,7 @@ int media_register(struct btd_adapter *btd_adapte=
r)
> >         adapter =3D g_new0(struct media_adapter, 1);
> >         adapter->btd_adapter =3D btd_adapter_ref(btd_adapter);
> >         adapter->apps =3D queue_new();
> > +       adapter->so_timestamping =3D -1;
> >=20
> >         if (!g_dbus_register_interface(btd_get_dbus_connection(),
> >                                         adapter_get_path(btd_adapter),
> > diff --git a/src/adapter.h b/src/adapter.h
> > index 6b2bc28f6..9371cdefb 100644
> > --- a/src/adapter.h
> > +++ b/src/adapter.h
> > @@ -262,6 +262,9 @@ bool btd_le_connect_before_pairing(void);
> >=20
> >  bool btd_adapter_has_settings(struct btd_adapter *adapter, uint32_t se=
ttings);
> >=20
> > +int btd_adapter_get_so_timestamping(struct btd_adapter *adapter, int p=
roto,
> > +                                                       int *so_timesta=
mping);
> > +
> >  enum experimental_features {
> >         EXP_FEAT_DEBUG                  =3D 1 << 0,
> >         EXP_FEAT_LE_SIMULT_ROLES        =3D 1 << 1,
> > --
> > 2.49.0
> >=20
> >=20
>=20

--=20
Pauli Virtanen
