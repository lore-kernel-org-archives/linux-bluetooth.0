Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196218;
	b=Hf+s7qEWVtCbUfD7vIBHl5cSmJqstzz2Al2Y5ts3ceyJwqwiwbrfVaLXODD5khmn9oiA
	 1cR1ISBDhQbPb+EXf8p+3P/qtibUKgqGmwH/8y5vb/aS6xxHCLGZ9Bmm+6dbmJleod3Og
	 XXdGTRJbgIsKiZp9oCNXr9KpR/d7AhSlgFQdwToz39/SnrSUX1G1tdVNoZfKjpFU8UHGb
	 ZPrGw47hf/6tCXzlL/QC3u9ap/c6wUf+ECPA425O2wbXlZoGOOqPt8apDHDJuCgI8b6Gs
	 CDOhBYjzfnzFNBGluqnoiGExgzjq1jN3yDt5FsAYemw//hRxGFaMcHFZu2VzF33B5Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196218;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=iN/XgE1rZE+tLI7WBXbXVJ7Jbr/lSN90jQVqSpgxGII=;
	b=UT/BeYBuXdVQEQqaeoSf9+UNWbSTdnpj1UMrNbBvFAeHtb/7MpEMe534x3EAaHxYcgcm
	 s5BjFItjObfkQkSrCEB5sgMhBa15Zw/UZnN9dTfJqgY+QIj5EfvthyYtSFlbFQ2u7ji36
	 rKN6vnDzltbrtpWI7rw+uQNa2/th659jTDR9DcaIt/okiH7ig76CMyZi99CGM86EwAIZm
	 OAqh+SIx9Vh9D8O4i5ebjrer3EZ1t631X55YnbTZKw3eQEZ5Hfk0M0GoY0Wr2j3DAdCei
	 0ww3TvnOvzjxTY0RFhv9Mw567V3xYmSFzRkX+MbGIxxTv5Q9jLZjY7LFcXsbdzRZ+Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=CO+sIMnp;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B967606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 14:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B967606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=CO+sIMnp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793196214; x=1793455414;
	bh=iN/XgE1rZE+tLI7WBXbXVJ7Jbr/lSN90jQVqSpgxGII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CO+sIMnpS8O9LcRTn/PHeYCm9akwAg97VIza2xsjNYuxsWFJRfxnP0fc12oEpD1E6
	 iR2tyCzeK/t4akMTm8hN++7Pq66Z1szaWFAYEUm9RYwtuYqTpiWm5pgKbwirzN+zBo
	 ICmELRqvnuOBwYEHb57vpjYWCJdlDaFbS6M6PkesiPyCJit6fCsKcIh7lBtjwwW9AW
	 opMKDsH+3cQsKeuyGM7ZfotU/XkiBe6Ii75LkSM2fk8at0k/XHA8AmtmSgMlIxw92u
	 6o/+QqoHiB9C7SFgYQ8REcLPp7XGEo9PMwkRdX6h3/iyCu/qE1Y2zDOxZnik3tfcC8
	 96hlHS3rjTRnw==
Date: Wed, 28 Oct 2026 14:03:30 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [RFC PATCH v2] asha: Notify connection interval changes
Message-ID: <XUjy0EVSoa9fmlNiJuKK_9S6yh2ubNuy6F_PmzI4uMQuCKg0b-WleDDGMNEnItLwWvmXm7nIPnMts6kXEmoGYHFBCyoJ7aG84qU5EZ-i_Pg=@proton.me>
In-Reply-To: <20261013222556.513513-1-cochcoder@proton.me>
References: <20261013035559.527818-1-cochcoder@proton.me> <20261013222556.513513-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 14ff12274f81397ee935a6976a9c1ff1947e81c5
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Just checking in on this patch. Is there anything else I can do to help it =
move forward?



On Tuesday, October 13th, 2026 at 6:26 PM, Kyle Pepper <cochcoder@proton.me=
> wrote:

> Omitting the connection-update STATUS notification causes repeated N8
> supervision timeouts even with a negotiated 20 ms interval. Restoring
> the notification alone prevents the reported link failures.
>=20
> Observe successful LE connection and update events per adapter, associate
> them with the ATT socket's handle, and announce the observed interval
> before START and on subsequent successful updates. Clear the observation
> on disconnect so a reused handle cannot inherit another link's interval.
> Notify the attached HiSyncId peer as well, matching Android's
> connection-update STATUS handling, without truncating the interval byte.
>=20
> Reuse the verified socket handle when delivering a live update.
>=20
> Add tests for event delivery, controller isolation, disconnect/reuse,
> pre-START ordering, failed updates and peer notification.
> Use source-level mocks so the tests remain valid with link-time
> optimization enabled.
>=20
> Fixes: c26389c466a0 ("profiles/audio: Add an ASHA plugin")
> Assisted-by: OpenCode:gpt-6.1-sol
> ---
> Changes since v1: fix sanitizer-retained daemon references with
> fail-fast test stubs. Declare socket wrappers in a test header.
> Refreshed to BlueZ 9dc7e40962f11d1d9a5568f8a7633a695288329c.
> Strict non-LTO ASan/UBSan build and make check pass; ordinary LTO
> build and make check pass. Strict LTO has an unchanged upstream
> peripheral/btsensor warning failure, reproduced without this topic.
> No new hardware trial or remote functional-lab result is claimed.
>=20
> Submission review notes (not part of the commit message):
> Removing interval STATUS previously caused N8 timeouts; the tested
> combined package restores it. The observer sends completed values, not
> requested constants. Raw-HCI access, missed events, startup coordination
> and observer/connection lifecycle need review. A link predating observer
> creation remains unknown until a later successful update.
>=20
>  .gitignore                |   4 +
>  Makefile.am               |  17 ++
>  profiles/audio/asha.c     | 237 +++++++++++++++++++
>  src/shared/asha.c         |  28 +++
>  src/shared/asha.h         |   1 +
>  unit/test-asha-conn.c     | 469 ++++++++++++++++++++++++++++++++++++++
>  unit/test-asha-conn.h     |  11 +
>  unit/test-asha-interval.c | 104 +++++++++
>  8 files changed, 871 insertions(+)
>  create mode 100644 unit/test-asha-conn.c
>  create mode 100644 unit/test-asha-conn.h
>  create mode 100644 unit/test-asha-interval.c
>=20
> diff --git a/.gitignore b/.gitignore
> index 06b24735df..3543bd815b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -99,6 +99,8 @@ unit/test-tester
>  unit/test-mainloop
>  unit/test-ringbuf
>  unit/test-queue
> +unit/test-asha-conn
> +unit/test-asha-interval
>  unit/test-util
>  unit/test-eir
>  unit/test-uuid
> @@ -112,6 +114,8 @@ unit/test-lib
>  unit/test-mgmt
>  unit/test-uhid
>  unit/test-hfp
> +unit/test-asha-interval
> +unit/test-asha-conn
>  unit/test-crypto
>  unit/test-ecc
>  unit/test-hog
> diff --git a/Makefile.am b/Makefile.am
> index f742458d11..9ba8b93625 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -706,6 +706,23 @@ unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.=
la \
> =20
>  unit_tests +=3D unit/test-hfp
> =20
> +unit_tests +=3D unit/test-asha-interval
> +
> +unit_test_asha_interval_SOURCES =3D unit/test-asha-interval.c
> +unit_test_asha_interval_LDADD =3D src/libshared-glib.la \
> +=09lib/libbluetooth-internal.la $(GLIB_LIBS)
> +
> +unit_tests +=3D unit/test-asha-conn
> +
> +unit_test_asha_conn_SOURCES =3D unit/test-asha-conn.c unit/test-asha-con=
n.h
> +unit_test_asha_conn_CFLAGS =3D $(AM_CFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
> +=09-ffunction-sections -fdata-sections
> +unit_test_asha_conn_LDADD =3D src/libshared-glib.la \
> +=09lib/libbluetooth-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
> +unit_test_asha_conn_LDFLAGS =3D -Wl,--gc-sections \
> +=09-Wl,--wrap=3Dsocket -Wl,--wrap=3Dbind -Wl,--wrap=3Dsetsockopt \
> +=09-Wl,--wrap=3Dgetsockopt
> +
>  unit_test_hfp_SOURCES =3D unit/test-hfp.c
>  unit_test_hfp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
> =20
> diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> index 8e625fdca3..6596ff3633 100644
> --- a/profiles/audio/asha.c
> +++ b/profiles/audio/asha.c
> @@ -39,6 +39,11 @@
>  #include "src/profile.h"
>  #include "src/service.h"
>  #include "src/shared/util.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/hci.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-client.h"
> +#include "monitor/bt.h"
> =20
>  #include "profiles/audio/asha.h"
>  #include "profiles/audio/media.h"
> @@ -51,6 +56,18 @@
>  /* The default of 672 does not work */
>  #define ASHA_CONNECTION_MTU 512
> =20
> +/* HCI connection handles occupy 0x0000 through 0x0eff. Zero is unknown.=
 */
> +#define ASHA_NUM_HANDLES 0x0f00
> +
> +struct asha_adapter {
> +=09struct btd_adapter *adapter;
> +=09struct bt_hci *hci;
> +=09uint16_t intervals[ASHA_NUM_HANDLES];
> +};
> +
> +static struct queue *asha_adapters;
> +static struct queue *asha_streams;
> +
>  struct bt_asha_device {
>  =09struct bt_asha *asha;
>  =09struct btd_device *device;
> @@ -62,6 +79,209 @@ struct bt_asha_device {
>  =09unsigned int resume_id;
>  };
> =20
> +static bool match_adapter(const void *data, const void *user_data)
> +{
> +=09const struct asha_adapter *data_adapter =3D data;
> +
> +=09return data_adapter->adapter =3D=3D user_data;
> +}
> +
> +static bool asha_get_handle(struct bt_asha_device *asha_dev, uint16_t *h=
andle)
> +{
> +=09struct bt_att *att;
> +=09struct l2cap_conninfo info;
> +=09socklen_t len =3D sizeof(info);
> +=09int fd;
> +
> +=09if (!asha_dev->asha->client)
> +=09=09return false;
> +
> +=09att =3D bt_gatt_client_get_att(asha_dev->asha->client);
> +=09fd =3D bt_att_get_fd(att);
> +
> +=09/* The ATT socket identifies this link even when CoC is not open. */
> +=09if (fd < 0 || getsockopt(fd, SOL_L2CAP, L2CAP_CONNINFO,
> +=09=09=09=09=09=09=09&info, &len) < 0) {
> +=09=09DBG("Could not read ASHA connection handle");
> +=09=09return false;
> +=09}
> +
> +=09if (len !=3D sizeof(info) || info.hci_handle >=3D ASHA_NUM_HANDLES)
> +=09=09return false;
> +
> +=09*handle =3D info.hci_handle;
> +=09return true;
> +}
> +
> +static void asha_notify_interval(struct bt_asha_device *asha_dev,
> +=09=09=09=09=09uint16_t handle, uint16_t interval)
> +{
> +=09/* Only announce an interval observed on this connection. */
> +=09if (!interval)
> +=09=09return;
> +
> +=09DBG("ASHA connection h%u interval %u", handle, interval);
> +
> +=09if (!bt_asha_set_connection_interval(asha_dev->asha, interval))
> +=09=09DBG("Could not send ASHA connection interval notification");
> +}
> +
> +static void asha_send_interval(struct bt_asha_device *asha_dev)
> +{
> +=09struct asha_adapter *data;
> +=09uint16_t handle;
> +
> +=09data =3D queue_find(asha_adapters, match_adapter,
> +=09=09=09=09=09device_get_adapter(asha_dev->device));
> +=09if (!data || !asha_get_handle(asha_dev, &handle))
> +=09=09return;
> +
> +=09asha_notify_interval(asha_dev, handle, data->intervals[handle]);
> +}
> +
> +struct interval_update {
> +=09struct asha_adapter *adapter;
> +=09uint16_t handle;
> +};
> +
> +static void asha_update_stream(void *data, void *user_data)
> +{
> +=09struct bt_asha_device *asha_dev =3D data;
> +=09struct interval_update *update =3D user_data;
> +=09uint16_t handle;
> +
> +=09if (device_get_adapter(asha_dev->device) !=3D update->adapter->adapte=
r ||
> +=09=09=09!asha_get_handle(asha_dev, &handle) ||
> +=09=09=09handle !=3D update->handle)
> +=09=09return;
> +
> +=09asha_notify_interval(asha_dev, handle,
> +=09=09=09=09=09update->adapter->intervals[handle]);
> +}
> +
> +static void asha_conn_update(const void *param, uint8_t size, void *user=
_data)
> +{
> +=09const struct bt_hci_evt_le_conn_update_complete *ev =3D param;
> +=09struct asha_adapter *data =3D user_data;
> +=09struct interval_update update;
> +=09uint16_t handle;
> +
> +=09if (size !=3D sizeof(*ev) || ev->status)
> +=09=09return;
> +
> +=09handle =3D get_le16(&ev->handle);
> +
> +=09if (handle >=3D ASHA_NUM_HANDLES)
> +=09=09return;
> +
> +=09data->intervals[handle] =3D get_le16(&ev->interval);
> +=09update.adapter =3D data;
> +=09update.handle =3D handle;
> +=09queue_foreach(asha_streams, asha_update_stream, &update);
> +}
> +
> +static void asha_conn_complete(const void *param, uint8_t size, void *us=
er_data)
> +{
> +=09const struct bt_hci_evt_le_conn_complete *ev =3D param;
> +=09struct asha_adapter *data =3D user_data;
> +=09uint16_t handle;
> +
> +=09if (size !=3D sizeof(*ev) || ev->status)
> +=09=09return;
> +
> +=09handle =3D get_le16(&ev->handle);
> +
> +=09if (handle < ASHA_NUM_HANDLES)
> +=09=09data->intervals[handle] =3D get_le16(&ev->interval);
> +}
> +
> +static void asha_enhanced_conn_complete(const void *param, uint8_t size,
> +=09=09=09=09=09=09=09void *user_data)
> +{
> +=09const struct bt_hci_evt_le_enhanced_conn_complete *ev =3D param;
> +=09struct asha_adapter *data =3D user_data;
> +=09uint16_t handle;
> +
> +=09if (size !=3D sizeof(*ev) || ev->status)
> +=09=09return;
> +
> +=09handle =3D get_le16(&ev->handle);
> +
> +=09if (handle < ASHA_NUM_HANDLES)
> +=09=09data->intervals[handle] =3D get_le16(&ev->interval);
> +}
> +
> +static void asha_disconn_complete(const void *param, uint8_t size,
> +=09=09=09=09=09=09=09void *user_data)
> +{
> +=09const struct bt_hci_evt_disconnect_complete *ev =3D param;
> +=09struct asha_adapter *data =3D user_data;
> +=09uint16_t handle;
> +
> +=09if (size !=3D sizeof(*ev) || ev->status)
> +=09=09return;
> +
> +=09handle =3D get_le16(&ev->handle);
> +
> +=09if (handle < ASHA_NUM_HANDLES)
> +=09=09data->intervals[handle] =3D 0;
> +}
> +
> +static int asha_adapter_probe(struct btd_profile *profile,
> +=09=09=09=09=09=09struct btd_adapter *adapter)
> +{
> +=09struct asha_adapter *data;
> +
> +=09data =3D new0(struct asha_adapter, 1);
> +=09data->adapter =3D adapter;
> +=09data->hci =3D bt_hci_new_raw_device(btd_adapter_get_index(adapter));
> +
> +=09if (!data->hci)
> +=09=09goto fail;
> +
> +=09if (!bt_hci_register_subevent(data->hci, BT_HCI_EVT_LE_CONN_COMPLETE,
> +=09=09=09=09=09asha_conn_complete, data, NULL) ||
> +=09=09!bt_hci_register_subevent(data->hci,
> +=09=09=09=09=09BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE,
> +=09=09=09=09asha_enhanced_conn_complete, data, NULL) ||
> +=09=09!bt_hci_register_subevent(data->hci,
> +=09=09=09=09=09BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE,
> +=09=09=09=09=09asha_conn_update, data, NULL) ||
> +=09=09!bt_hci_register(data->hci, BT_HCI_EVT_DISCONNECT_COMPLETE,
> +=09=09=09=09=09asha_disconn_complete, data, NULL))
> +=09=09goto fail;
> +
> +=09if (!asha_adapters)
> +=09=09asha_adapters =3D queue_new();
> +
> +=09queue_push_tail(asha_adapters, data);
> +=09return 0;
> +
> +fail:
> +=09bt_hci_unref(data->hci);
> +=09free(data);
> +=09return -EIO;
> +}
> +
> +static void asha_adapter_remove(struct btd_profile *profile,
> +=09=09=09=09=09=09struct btd_adapter *adapter)
> +{
> +=09struct asha_adapter *data;
> +
> +=09data =3D queue_remove_if(asha_adapters, match_adapter, adapter);
> +
> +=09if (!data)
> +=09=09return;
> +
> +=09bt_hci_unref(data->hci);
> +=09free(data);
> +
> +=09if (queue_isempty(asha_adapters)) {
> +=09=09queue_destroy(asha_adapters, NULL);
> +=09=09asha_adapters =3D NULL;
> +=09}
> +}
> +
>  static char *make_endpoint_path(struct bt_asha_device *asha_dev)
>  {
>  =09char *path;
> @@ -107,6 +327,8 @@ static void connect_cb(GIOChannel *io, GError *err, g=
pointer user_data)
> =20
>  =09asha_dev->io =3D io;
> =20
> +=09asha_send_interval(asha_dev);
> +
>  =09bt_asha_start(asha_dev->asha, conn_data->cb,
>  =09=09=09=09=09conn_data->cb_user_data);
>  }
> @@ -350,6 +572,11 @@ static int asha_source_device_probe(struct btd_servi=
ce *service)
>  =09asha_dev->asha =3D bt_asha_new();
>  =09asha_dev->io =3D NULL;
> =20
> +=09if (!asha_streams)
> +=09=09asha_streams =3D queue_new();
> +
> +=09queue_push_tail(asha_streams, asha_dev);
> +
>  =09btd_service_set_user_data(service, asha_dev);
> =20
>  =09return 0;
> @@ -371,6 +598,13 @@ static void asha_source_device_remove(struct btd_ser=
vice *service)
>  =09=09return;
>  =09}
> =20
> +=09queue_remove(asha_streams, asha_dev);
> +
> +=09if (queue_isempty(asha_streams)) {
> +=09=09queue_destroy(asha_streams, NULL);
> +=09=09asha_streams =3D NULL;
> +=09}
> +
>  =09bt_asha_free(asha_dev->asha);
>  =09g_free(asha_dev);
>  }
> @@ -503,6 +737,9 @@ static struct btd_profile asha_source_profile =3D {
>  =09.remote_uuid=09=3D ASHA_PROFILE_UUID,
>  =09.experimental=09=3D true,
> =20
> +=09.adapter_probe=09=3D asha_adapter_probe,
> +=09.adapter_remove=09=3D asha_adapter_remove,
> +
>  =09.device_probe=09=3D asha_source_device_probe,
>  =09.device_remove=09=3D asha_source_device_remove,
> =20
> diff --git a/src/shared/asha.c b/src/shared/asha.c
> index 79bb29bf9a..6d0323fb24 100644
> --- a/src/shared/asha.c
> +++ b/src/shared/asha.c
> @@ -244,6 +244,34 @@ static int asha_send_acp_without_response(struct bt_=
asha *asha,
>  =09return 0;
>  }
> =20
> +bool bt_asha_set_connection_interval(struct bt_asha *asha, uint16_t inte=
rval)
> +{
> +=09struct bt_asha_set *set;
> +=09struct bt_asha *other =3D NULL;
> +=09uint8_t cmd[] =3D { 0x03, 0x02, 0x00 };
> +=09bool success;
> +
> +=09/* The connection-update STATUS encodes 1.25 ms units in one byte. */
> +=09if (!asha || !asha->client || !asha->acp_handle ||
> +=09=09=09=09interval < 0x0006 || interval > UINT8_MAX)
> +=09=09return false;
> +
> +=09cmd[2] =3D interval;
> +=09success =3D asha_send_acp_without_response(asha, cmd, sizeof(cmd)) =
=3D=3D 0;
> +=09set =3D find_asha_set(asha);
> +
> +=09if (set)
> +=09=09other =3D asha->right_side ? set->left : set->right;
> +
> +=09/* Notify an attached peer even if it has not started streaming yet. =
*/
> +=09if (other && other !=3D asha && other->client && other->acp_handle) {
> +=09=09if (asha_send_acp_without_response(other, cmd, sizeof(cmd)) < 0)
> +=09=09=09success =3D false;
> +=09}
> +
> +=09return success;
> +}
> +
>  unsigned int bt_asha_start(struct bt_asha *asha, bt_asha_cb_t cb,
>  =09=09=09=09=09=09=09=09void *user_data)
>  {
> diff --git a/src/shared/asha.h b/src/shared/asha.h
> index 9e62fcde89..e6b2e7a0d2 100644
> --- a/src/shared/asha.h
> +++ b/src/shared/asha.h
> @@ -66,6 +66,7 @@ unsigned int bt_asha_start(struct bt_asha *asha, bt_ash=
a_cb_t cb,
>  unsigned int bt_asha_stop(struct bt_asha *asha);
> =20
>  bool bt_asha_set_volume(struct bt_asha *asha, int8_t volume);
> +bool bt_asha_set_connection_interval(struct bt_asha *asha, uint16_t inte=
rval);
> =20
>  bool bt_asha_attach(struct bt_asha *asha, struct gatt_db *db,
>  =09=09struct bt_gatt_client *client, bt_asha_attach_cb_t probe_cb,
> diff --git a/unit/test-asha-conn.c b/unit/test-asha-conn.c
> new file mode 100644
> index 0000000000..4b0354c67e
> --- /dev/null
> +++ b/unit/test-asha-conn.c
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <assert.h>
> +#include <fcntl.h>
> +#include <stdarg.h>
> +#include "test-asha-conn.h"
> +
> +/* Internal calls can be resolved before GNU ld --wrap when LTO is enabl=
ed. */
> +#define bt_gatt_client_get_att test_get_att
> +#define bt_att_get_fd test_att_fd
> +#define bt_asha_set_connection_interval test_set_interval
> +#define bt_asha_start test_start
> +#define bt_io_get test_io_get
> +#include "profiles/audio/asha.c"
> +#undef bt_gatt_client_get_att
> +#undef bt_att_get_fd
> +#undef bt_asha_set_connection_interval
> +#undef bt_asha_start
> +#undef bt_io_get
> +#include "bluetooth/hci.h"
> +#include "src/shared/tester.h"
> +
> +/* Sanitizers retain the plugin's globals, including unused daemon callb=
acks. */
> +int btd_profile_register(struct btd_profile *profile)
> +{
> +=09assert(false);
> +}
> +
> +void btd_profile_unregister(struct btd_profile *profile)
> +{
> +=09assert(false);
> +}
> +
> +const char *device_get_path(const struct btd_device *device)
> +{
> +=09assert(false);
> +}
> +
> +const bdaddr_t *device_get_address(struct btd_device *device)
> +{
> +=09assert(false);
> +}
> +
> +const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter)
> +{
> +=09assert(false);
> +}
> +
> +void btd_device_set_conn_param(struct btd_device *device,
> +=09=09=09=09uint16_t min_interval, uint16_t max_interval,
> +=09=09=09=09=09uint16_t latency, uint16_t timeout)
> +{
> +=09assert(false);
> +}
> +
> +struct gatt_db *btd_device_get_gatt_db(struct btd_device *device)
> +{
> +=09assert(false);
> +}
> +
> +struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *dev=
ice)
> +{
> +=09assert(false);
> +}
> +
> +struct btd_device *btd_service_get_device(const struct btd_service *serv=
ice)
> +{
> +=09assert(false);
> +}
> +
> +void *btd_service_get_user_data(const struct btd_service *service)
> +{
> +=09assert(false);
> +}
> +
> +void btd_service_set_user_data(struct btd_service *service, void *user_d=
ata)
> +{
> +=09assert(false);
> +}
> +
> +void btd_service_connecting_complete(struct btd_service *service, int er=
r)
> +{
> +=09assert(false);
> +}
> +
> +void btd_service_disconnecting_complete(struct btd_service *service, int=
 err)
> +{
> +=09assert(false);
> +}
> +
> +DBusConnection *btd_get_dbus_connection(void)
> +{
> +=09assert(false);
> +}
> +
> +gboolean g_dbus_register_interface(DBusConnection *connection,
> +=09=09=09=09const char *path, const char *name,
> +=09=09=09=09const GDBusMethodTable *methods,
> +=09=09=09=09const GDBusSignalTable *signals,
> +=09=09=09=09const GDBusPropertyTable *properties,
> +=09=09=09=09void *user_data, GDBusDestroyFunction destroy)
> +{
> +=09assert(false);
> +}
> +
> +gboolean g_dbus_unregister_interface(DBusConnection *connection,
> +=09=09=09=09=09const char *path, const char *name)
> +{
> +=09assert(false);
> +}
> +
> +const struct media_endpoint *media_endpoint_get_asha(void)
> +{
> +=09assert(false);
> +}
> +
> +struct media_transport *media_transport_create(struct btd_device *device=
,
> +=09=09=09=09const char *remote_endpoint,
> +=09=09=09=09uint8_t *configuration, size_t size,
> +=09=09=09=09void *data, void *stream)
> +{
> +=09assert(false);
> +}
> +
> +void media_transport_destroy(struct media_transport *transport)
> +{
> +=09assert(false);
> +}
> +
> +const char *media_transport_get_path(struct media_transport *transport)
> +{
> +=09assert(false);
> +}
> +
> +GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
> +=09=09=09=09GDestroyNotify destroy, GError **gerr,
> +=09=09=09=09=09=09=09BtIOOption opt1, ...)
> +{
> +=09assert(false);
> +}
> +
> +static int peer_fd[2];
> +static int observer_fd[2];
> +static int pending_peer;
> +static unsigned int writes;
> +static uint16_t last_interval;
> +static struct bt_asha *last_asha;
> +static bool socket_ready =3D true;
> +static bool fail_socket;
> +static int att_fd =3D 100;
> +static unsigned int handle_reads;
> +static socklen_t conninfo_length =3D sizeof(struct l2cap_conninfo);
> +
> +int __wrap_socket(int domain, int type, int protocol)
> +{
> +=09int fds[2];
> +
> +=09assert(domain =3D=3D PF_BLUETOOTH);
> +=09assert(protocol =3D=3D BTPROTO_HCI);
> +
> +=09if (fail_socket)
> +=09=09return -1;
> +
> +=09assert(!socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0, fds));
> +=09pending_peer =3D fds[1];
> +=09return fds[0];
> +}
> +
> +int __wrap_bind(int fd, const struct sockaddr *addr, socklen_t length)
> +{
> +=09const struct sockaddr_hci *hci =3D (void *) addr;
> +
> +=09/* Ignore tester's optional logging channel. */
> +=09if (hci->hci_dev =3D=3D HCI_DEV_NONE) {
> +=09=09close(pending_peer);
> +=09=09return -1;
> +=09}
> +
> +=09assert(hci->hci_dev < 2);
> +=09peer_fd[hci->hci_dev] =3D pending_peer;
> +=09observer_fd[hci->hci_dev] =3D fd;
> +=09return 0;
> +}
> +
> +int __wrap_setsockopt(int fd, int level, int opt, const void *value,
> +=09=09=09=09=09=09=09socklen_t length)
> +{
> +=09if (level =3D=3D SOL_HCI)
> +=09=09return 0;
> +
> +=09return __real_setsockopt(fd, level, opt, value, length);
> +}
> +
> +int __wrap_getsockopt(int fd, int level, int opt, void *value,
> +=09=09=09=09=09=09=09socklen_t *length)
> +{
> +=09struct l2cap_conninfo *info =3D value;
> +
> +=09assert(level =3D=3D SOL_L2CAP && opt =3D=3D L2CAP_CONNINFO);
> +=09handle_reads++;
> +
> +=09if (!socket_ready)
> +=09=09return -1;
> +
> +=09assert(*length =3D=3D sizeof(*info));
> +=09info->hci_handle =3D 16;
> +=09*length =3D conninfo_length;
> +=09return 0;
> +}
> +
> +struct bt_att *test_get_att(struct bt_gatt_client *client)
> +{
> +=09return (void *) client;
> +}
> +
> +int test_att_fd(struct bt_att *att)
> +{
> +=09return att_fd;
> +}
> +
> +struct btd_adapter *device_get_adapter(struct btd_device *device)
> +{
> +=09return (void *) device;
> +}
> +
> +uint16_t btd_adapter_get_index(struct btd_adapter *adapter)
> +{
> +=09return PTR_TO_UINT(adapter) - 1;
> +}
> +
> +void btd_debug(uint16_t index, const char *format, ...)
> +{
> +}
> +
> +void btd_error(uint16_t index, const char *format, ...)
> +{
> +}
> +
> +bool test_set_interval(struct bt_asha *asha,
> +=09=09=09=09=09=09=09uint16_t interval)
> +{
> +=09writes++;
> +=09last_asha =3D asha;
> +=09last_interval =3D interval;
> +=09return true;
> +}
> +
> +unsigned int test_start(struct bt_asha *asha, bt_asha_cb_t cb,
> +=09=09=09=09=09=09=09void *user_data)
> +{
> +=09assert(writes =3D=3D 1 && last_asha =3D=3D asha && last_interval =3D=
=3D 24);
> +=09asha->state =3D ASHA_STARTING;
> +=09return 0;
> +}
> +
> +gboolean test_io_get(GIOChannel *io, GError **err, BtIOOption opt1, ...)
> +{
> +=09return TRUE;
> +}
> +
> +static void event(unsigned int adapter, uint8_t subevent, const void *va=
lue,
> +=09=09=09=09=09=09=09uint8_t length)
> +{
> +=09uint8_t packet[260] =3D { BT_H4_EVT_PKT, BT_HCI_EVT_LE_META_EVENT,
> +=09=09=09=09=09=09length + 1, subevent };
> +
> +=09memcpy(packet + 4, value, length);
> +=09assert(write(peer_fd[adapter], packet, length + 4) =3D=3D length + 4)=
;
> +
> +=09while (g_main_context_iteration(NULL, FALSE))
> +=09=09;
> +}
> +
> +static void test_connection(const void *user_data)
> +{
> +=09struct bt_asha asha =3D { .client =3D (void *) 1, .acp_handle =3D 0x7=
9 };
> +=09struct bt_asha other =3D { .client =3D (void *) 2, .acp_handle =3D 0x=
79 };
> +=09struct bt_asha_device dev =3D { .asha =3D &asha, .device =3D (void *)=
 1 };
> +=09struct bt_asha_device dev2 =3D { .asha =3D &other, .device =3D (void =
*) 2 };
> +=09struct connect_data conn =3D { .asha_dev =3D &dev };
> +=09GIOChannel *io;
> +=09int io_fds[2];
> +=09struct asha_adapter *adapter;
> +=09unsigned int before;
> +=09struct bt_hci_evt_le_conn_complete complete =3D {
> +=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(24),
> +=09};
> +=09struct bt_hci_evt_le_enhanced_conn_complete enhanced =3D {
> +=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(32),
> +=09};
> +=09struct bt_hci_evt_le_conn_update_complete update =3D {
> +=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(40),
> +=09};
> +=09struct bt_hci_evt_disconnect_complete disconnect =3D {
> +=09=09.handle =3D cpu_to_le16(16),
> +=09};
> +=09uint8_t packet[7] =3D { BT_H4_EVT_PKT, BT_HCI_EVT_DISCONNECT_COMPLETE=
,
> +=09=09=09=09=09=09=09sizeof(disconnect) };
> +
> +=09assert(!pipe(io_fds));
> +=09io =3D g_io_channel_unix_new(io_fds[0]);
> +=09assert(!asha_adapter_probe(NULL, (void *) 1));
> +=09assert(!asha_adapter_probe(NULL, (void *) 2));
> +=09asha_streams =3D queue_new();
> +=09queue_push_tail(asha_streams, &dev);
> +=09queue_push_tail(asha_streams, &dev2);
> +=09writes =3D 0;
> +=09asha_send_interval(&dev);
> +=09assert(writes =3D=3D 0);
> +
> +=09/* Cache the initial event before GATT discovery/CoC. */
> +=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
> +=09assert(writes =3D=3D 0);
> +=09connect_cb(io, NULL, &conn);
> +=09assert(writes =3D=3D 1 && last_interval =3D=3D 24);
> +
> +=09/* Identical handles on different controllers are separate links. */
> +=09event(1, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &enhanced,
> +=09=09=09=09=09=09=09sizeof(enhanced));
> +=09before =3D handle_reads;
> +=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update))=
;
> +=09assert(handle_reads =3D=3D before + 1);
> +=09assert(writes =3D=3D 2 && last_asha =3D=3D &asha && last_interval =3D=
=3D 40);
> +=09other.state =3D ASHA_STOPPED;
> +=09event(1, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update))=
;
> +=09assert(writes =3D=3D 3 && last_asha =3D=3D &other);
> +
> +=09/* Failed/malformed updates leave the last successful value intact. *=
/
> +=09update.status =3D 1;
> +=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update))=
;
> +=09update.status =3D 0;
> +=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update,
> +=09=09=09=09=09=09=09sizeof(update) - 1);
> +=09update.handle =3D cpu_to_le16(ASHA_NUM_HANDLES);
> +=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update))=
;
> +=09assert(writes =3D=3D 3);
> +=09asha_send_interval(&dev);
> +=09assert(writes =3D=3D 4 && last_interval =3D=3D 40);
> +
> +=09/* Closed ATT sockets cannot be associated with a cached handle. */
> +=09socket_ready =3D false;
> +=09asha_send_interval(&dev);
> +=09assert(writes =3D=3D 4);
> +=09socket_ready =3D true;
> +
> +=09memcpy(packet + 3, &disconnect, sizeof(disconnect));
> +=09assert(write(peer_fd[0], packet, sizeof(packet)) =3D=3D sizeof(packet=
));
> +
> +=09while (g_main_context_iteration(NULL, FALSE))
> +=09=09;
> +
> +=09asha_send_interval(&dev);
> +=09assert(writes =3D=3D 4);
> +=09asha_send_interval(&dev2);
> +=09assert(writes =3D=3D 5 && last_interval =3D=3D 40);
> +
> +=09/* Reused handle gets the new connection's value, never the old one. =
*/
> +=09complete.interval =3D cpu_to_le16(16);
> +=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
> +=09asha_send_interval(&dev);
> +=09assert(writes =3D=3D 6 && last_interval =3D=3D 16);
> +
> +=09adapter =3D queue_find(asha_adapters, match_adapter, (void *) 1);
> +=09assert(adapter->intervals[16] =3D=3D 16);
> +=09queue_remove(asha_streams, &dev);
> +=09update.handle =3D cpu_to_le16(16);
> +=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update))=
;
> +=09assert(writes =3D=3D 6);
> +=09asha_adapter_remove(NULL, (void *) 1);
> +=09asha_adapter_remove(NULL, (void *) 2);
> +=09assert(!asha_adapters);
> +=09queue_destroy(asha_streams, NULL);
> +=09asha_streams =3D NULL;
> +=09close(peer_fd[0]);
> +=09close(peer_fd[1]);
> +=09g_io_channel_unref(io);
> +=09close(io_fds[0]);
> +=09close(io_fds[1]);
> +=09dev.io =3D NULL;
> +
> +=09fail_socket =3D true;
> +=09assert(asha_adapter_probe(NULL, (void *) 1) =3D=3D -EIO);
> +=09assert(!asha_adapters);
> +=09fail_socket =3D false;
> +=09tester_test_passed();
> +}
> +
> +static void test_observer_lifecycle(const void *user_data)
> +{
> +=09struct bt_asha asha =3D { .client =3D (void *) 1, .acp_handle =3D 0x7=
9 };
> +=09struct bt_asha_device dev =3D { .asha =3D &asha, .device =3D (void *)=
 1 };
> +=09struct bt_hci_evt_le_conn_complete complete =3D {
> +=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(24),
> +=09};
> +=09struct bt_hci_evt_le_conn_update_complete update =3D {
> +=09=09.handle =3D cpu_to_le16(16), .interval =3D cpu_to_le16(32),
> +=09};
> +=09uint8_t pending[] =3D { BT_H4_EVT_PKT, BT_HCI_EVT_LE_META_EVENT,
> +=09=09=09=09sizeof(update) + 1,
> +=09=09=09=09BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE };
> +=09uint8_t packet[sizeof(pending) + sizeof(update)];
> +=09uint8_t byte;
> +
> +=09writes =3D 0;
> +=09assert(!asha_adapter_probe(NULL, (void *) 1));
> +=09asha_streams =3D queue_new();
> +=09queue_push_tail(asha_streams, &dev);
> +=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
> +=09asha_send_interval(&dev);
> +=09assert(writes =3D=3D 1 && last_interval =3D=3D 24);
> +
> +=09/* Failed/truncated events cannot replace a successful interval. */
> +=09complete.status =3D 1;
> +=09complete.interval =3D cpu_to_le16(40);
> +=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete));
> +=09complete.status =3D 0;
> +=09event(0, BT_HCI_EVT_LE_CONN_COMPLETE, &complete, sizeof(complete) - 1=
);
> +=09asha_send_interval(&dev);
> +=09assert(writes =3D=3D 2 && last_interval =3D=3D 24);
> +
> +=09conninfo_length--;
> +=09asha_send_interval(&dev);
> +=09conninfo_length +=3D 2;
> +=09asha_send_interval(&dev);
> +=09conninfo_length--;
> +=09att_fd =3D -1;
> +=09asha_send_interval(&dev);
> +=09att_fd =3D 100;
> +=09assert(writes =3D=3D 2);
> +
> +=09/* The passive observer must never transmit controller commands. */
> +=09assert(read(peer_fd[0], &byte, 1) =3D=3D -1);
> +=09assert(errno =3D=3D EAGAIN);
> +=09asha_adapter_remove(NULL, (void *) 1);
> +=09assert(fcntl(observer_fd[0], F_GETFD) =3D=3D -1 && errno =3D=3D EBADF=
);
> +=09close(peer_fd[0]);
> +=09assert(!asha_adapter_probe(NULL, (void *) 1));
> +
> +=09/* After restart, existing links stay unknown until a new update. */
> +=09asha_send_interval(&dev);
> +=09assert(writes =3D=3D 2);
> +=09event(0, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &update, sizeof(update))=
;
> +=09assert(writes =3D=3D 3 && last_interval =3D=3D 32);
> +
> +=09/* Drop queued callbacks when their adapter and device are removed. *=
/
> +=09memcpy(packet, pending, sizeof(pending));
> +=09memcpy(packet + sizeof(pending), &update, sizeof(update));
> +=09assert(write(peer_fd[0], packet, sizeof(packet)) =3D=3D sizeof(packet=
));
> +=09queue_remove(asha_streams, &dev);
> +=09asha_adapter_remove(NULL, (void *) 1);
> +
> +=09while (g_main_context_iteration(NULL, FALSE))
> +=09=09;
> +
> +=09assert(writes =3D=3D 3 && !asha_adapters);
> +=09assert(fcntl(observer_fd[0], F_GETFD) =3D=3D -1 && errno =3D=3D EBADF=
);
> +=09close(peer_fd[0]);
> +=09queue_destroy(asha_streams, NULL);
> +=09asha_streams =3D NULL;
> +=09tester_test_passed();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +=09tester_init(&argc, &argv);
> +=09tester_add("ASHA/interval/HCI", NULL, NULL, test_connection, NULL);
> +=09tester_add("ASHA/interval/observer-lifecycle", NULL, NULL,
> +=09=09=09=09=09=09test_observer_lifecycle, NULL);
> +=09return tester_run();
> +}
> diff --git a/unit/test-asha-conn.h b/unit/test-asha-conn.h
> new file mode 100644
> index 0000000000..5e88aed490
> --- /dev/null
> +++ b/unit/test-asha-conn.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include <sys/socket.h>
> +
> +int __wrap_socket(int domain, int type, int protocol);
> +int __wrap_bind(int fd, const struct sockaddr *addr, socklen_t length);
> +int __wrap_setsockopt(int fd, int level, int opt, const void *value,
> +=09=09=09=09=09=09=09socklen_t length);
> +int __wrap_getsockopt(int fd, int level, int opt, void *value,
> +=09=09=09=09=09=09=09socklen_t *length);
> +int __real_setsockopt(int fd, int level, int opt, const void *value,
> +=09=09=09=09=09=09=09socklen_t length);
> diff --git a/unit/test-asha-interval.c b/unit/test-asha-interval.c
> new file mode 100644
> index 0000000000..8cb77c07d3
> --- /dev/null
> +++ b/unit/test-asha-interval.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +#include <assert.h>
> +
> +/* Redirect source-level calls so LTO cannot bypass the GATT mock. */
> +#define bt_gatt_client_write_without_response test_gatt_write
> +#include "src/shared/asha.c"
> +#undef bt_gatt_client_write_without_response
> +#include "src/shared/tester.h"
> +
> +static unsigned int writes;
> +static struct bt_gatt_client *failed_client;
> +static uint8_t expected_interval;
> +
> +void btd_error(uint16_t index, const char *format, ...)
> +{
> +}
> +
> +void btd_debug(uint16_t index, const char *format, ...)
> +{
> +}
> +
> +unsigned int test_gatt_write(
> +=09struct bt_gatt_client *client, uint16_t handle, bool signed_write,
> +=09=09=09=09const uint8_t *value, uint16_t length)
> +{
> +=09assert(client);
> +=09assert(handle =3D=3D 0x79);
> +=09assert(!signed_write);
> +=09assert(length =3D=3D 3);
> +=09assert(value[0] =3D=3D 0x03 && value[1] =3D=3D 0x02);
> +=09assert(value[2] =3D=3D expected_interval);
> +=09writes++;
> +=09return client !=3D failed_client;
> +}
> +
> +static void test_interval(const void *user_data)
> +{
> +=09struct bt_asha left =3D {
> +=09=09.client =3D (void *) 1, .acp_handle =3D 0x79, .hisyncid =3D { 1 },
> +=09};
> +=09struct bt_asha right =3D {
> +=09=09.client =3D (void *) 2, .acp_handle =3D 0x79, .hisyncid =3D { 1 },
> +=09=09.right_side =3D true,
> +=09};
> +=09struct bt_asha unrelated =3D {
> +=09=09.client =3D (void *) 3, .acp_handle =3D 0x79, .hisyncid =3D { 2 },
> +=09};
> +
> +=09asha_devices =3D queue_new();
> +=09update_asha_set(&left, true);
> +=09update_asha_set(&right, true);
> +=09update_asha_set(&unrelated, true);
> +=09writes =3D 0;
> +=09expected_interval =3D 16;
> +
> +=09/* Both attached sides, including a stopped peer, receive the update.=
 */
> +=09assert(bt_asha_set_connection_interval(&left, expected_interval));
> +=09assert(writes =3D=3D 2);
> +=09assert(bt_asha_set_connection_interval(&right, expected_interval));
> +=09assert(writes =3D=3D 4);
> +=09assert(bt_asha_set_connection_interval(&unrelated, expected_interval)=
);
> +=09assert(writes =3D=3D 5);
> +
> +=09assert(!bt_asha_set_connection_interval(&left, 5));
> +=09assert(!bt_asha_set_connection_interval(&left, 256));
> +=09assert(!bt_asha_set_connection_interval(NULL, 16));
> +=09assert(writes =3D=3D 5);
> +
> +=09expected_interval =3D 6;
> +=09assert(bt_asha_set_connection_interval(&left, expected_interval));
> +=09assert(writes =3D=3D 7);
> +=09expected_interval =3D 255;
> +=09assert(bt_asha_set_connection_interval(&right, expected_interval));
> +=09assert(writes =3D=3D 9);
> +
> +=09/* Failure on either side does not suppress the other side's attempt.=
 */
> +=09failed_client =3D left.client;
> +=09assert(!bt_asha_set_connection_interval(&left, expected_interval));
> +=09assert(writes =3D=3D 11);
> +=09assert(!bt_asha_set_connection_interval(&right, expected_interval));
> +=09assert(writes =3D=3D 13);
> +=09failed_client =3D NULL;
> +
> +=09right.client =3D NULL;
> +=09assert(bt_asha_set_connection_interval(&left, expected_interval));
> +=09assert(writes =3D=3D 14);
> +=09assert(!bt_asha_set_connection_interval(&right, expected_interval));
> +=09assert(writes =3D=3D 14);
> +
> +=09update_asha_set(&right, false);
> +=09assert(bt_asha_set_connection_interval(&left, expected_interval));
> +=09assert(writes =3D=3D 15);
> +=09update_asha_set(&left, false);
> +=09update_asha_set(&unrelated, false);
> +=09assert(!asha_devices);
> +=09tester_test_passed();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +=09tester_init(&argc, &argv);
> +=09tester_add("ASHA/interval/pair", NULL, NULL, test_interval, NULL);
> +=09return tester_run();
> +}
>=20
> base-commit: 9dc7e40962f11d1d9a5568f8a7633a695288329c
> --=20
> 2.56.0
>=20
> 
