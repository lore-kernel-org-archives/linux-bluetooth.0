Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793236968;
	b=tGHZc2bpO1rBRzMSpvtGbMrNf6ABpGoaLivXEAJXLl84BmctX4I6BnBKvmzvOVOfm0S+
	 2Uw0KxU8ii/bVvL+ktksMgHKWtjmRTiWAPE8Bt6cqdzOzjVtv4ueIpF0DSUTf8dd5sCpb
	 WmBcTuYj+ieuNHjbpjyxzx+WxZD0lqPkIWZLYYDLhMcfl/uR1fG62Zj3wQvyU9alzINwg
	 R68AHsXaE8mabbUSabpgchwqjoFD0GSOGEmvrj63g7lyPfgGMAzh6hSz5RjrUHsgzGCwO
	 7Hs60v4vJdPzefvZ4Xl1XPF8ZTOcprmx87eJTBAgdNMqSwlf/UANn6Ii431fFTFwF3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=7HkyMH6vJZtiar+Vz0lmNtpgBh6jnx1zShTHB5YrUKM=;
	b=1/KxDuQRcut0ZCivizTzU4a0VNf/BY5voA+RKfLf2P/q/SgNX++jEREniQeMhvxhh6pE
	 xC+LeYWniU96aZ8xsKbKTWg4yWe1XYyi38UP0SYcE08dCVca/2Bnep7RD1SkfzhxSAX8E
	 7pjdKosx2jrCCaWj1NuxTkS3Sq3wewxbV6OLka2SbuSsPNRlhBysZslLH9zILyota/cqE
	 9ekGpkgS9k79qeX9NQzlu9+vU5R5DA1k+DQEM7rWjVj8ybZ8GLJwpAn9N5qEPemH95Tx5
	 tFuuouc5S73F6SVyitHLAXSeIuGLsH9tFEgrefUiAE+jYy5WWVGGTlRq+Dt6sF0tAaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="b63u/+KU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1631D606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 01:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1631D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b63u/+KU
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b09e07e149so14765007b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 18:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793236967; cv=none;
        d=google.com; s=arc-20260327;
        b=pDqHue20fCGF5eZifItQeJO+IKO1l4XUCg2x1rQJrgceYLweQIYTyhSyTsCE/e2DOx
         8AtSALDH0C1zfKclgL2EfN9SHqWk1E/Lffhdldzp+4ji9G9UT9gxfBydXlhN8jTygxjx
         S1MFebjRBWrJONAmtLjs53i47ElpWKVoSo//LH1rD70ic1gMjH4FskV99cbsrD0Bm5x6
         Sc4yhsWinwOfw/JLz0izAZdvIKwPunEAEKnsmjlqqSNsv9f5CcJb8zlaxDyAjXnSPEQ/
         +nhqvT3MFK6cnk9jgJdBxckzOSeWZXI5/W1O04GBIRjZg+aVsFIO7ouA11JFleHY+eI3
         st6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7HkyMH6vJZtiar+Vz0lmNtpgBh6jnx1zShTHB5YrUKM=;
        fh=3nimXdHGQOcjfBt8iP5+b0Ollu0eBkOgKmJ6MQm4IgM=;
        b=p1k4cmjbDYfEWirUDR85rER5n1kKoSzeZ4ZQ+Jhxe0pDna9KtTuWPCykT8rOBZy9PF
         O4K6rhpZCKa6ndX9GCTb4Cgri06mCVkIL4GhGDPXRP5SuOf6lV13y5L6xgTv2huyCE4s
         V3ZCt4k13fCybGf/va6rqAvjLgtU70IxOlydbUe0uN61aBb1EU6hpZpSrG5jnZQyMlDO
         KHMvE3kDVtM92EU4v/ewzHn47uy1yPnXySD8cLczBQ3XX/NiZMG6k781VeB/WlgPLOlc
         ygItF0IpbvBDPcAAmZHqCztEWnMMQw7rYIZkG8i7oPQK8VduaHxA9RsiMz+g89ryFLvk
         yhMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793236967; x=1793841767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7HkyMH6vJZtiar+Vz0lmNtpgBh6jnx1zShTHB5YrUKM=;
        b=b63u/+KUwTimEL/hn4NGQu/OcnqpFE8ZB9PNqx0yH/V85CssJK6ZLV69IOW34W0UG5
         Q5gIjRmIuzU10vlmyMcXxLDdBNW2duQ1VOD12w6DFQLvNv8iONa2vzT5jkC9JU7vqUJY
         yMSbMO70uLfCfR1OnvSe4s8yO2YnYZTgEkR1b2Shtif2D60gVvLcK8s+NKz6BsG+nhCq
         1VK46vyZYk3FbzNKeRt7tAXrZ8zRgOppw57TB8z6/0xbU84nYGn3CFFyzyGRJMD7geDl
         m6DFzTLkATTKP9fKTFWYBkHa3FZadzAILQsf1KP5Lzm9kge+sWZ71vEXJeY8vf/E7OG/
         oTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236967; x=1793841767;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HkyMH6vJZtiar+Vz0lmNtpgBh6jnx1zShTHB5YrUKM=;
        b=ZHw8U0Qblxf9OVAsgtmcAamXCtZTmTm9M7fmA93LZxOGZLZ2dsbszufWDPppwF9u6P
         fp79xuMFKcpD46GtxUq3nXYX8fe3lCzqOSkVoN00dMmBOq9DrgGxGYHJgr2O5Ct5FAmB
         FKH0KdKWjCLuFVstFjgDB9XlwkY8HdNcILJaXPkhBs+8PAsMHmLwr1+fc6liIO3s7vpz
         8bhKQQH5l32BzPP5NEQWuF676rLIxv4ky2b0mBYEfp3zdvWyZfIllXJ+gBtUFMW+U0An
         yybEr0E9xVilR0eKeNjqXoUoDfbdMOBmKg/K+wtoYv74bXBSWw75IXjx6nhDB8DaonW5
         2ZiA==
X-Gm-Message-State: AFq9FYLEwdQYQ5d0pVgIlEFO+wgmxRUNiO7nx905pYOq1LX+hfh0jCxa
	jy7q9j0rILpxPkovk+3tyzrAEiOhjrNXJTkjloztPqZXCwWaVnR9t2s1LI7OVTHc5GJCFU7i5VM
	pEoCO24zeh2ZDJfxN1n4f+N30lo65y/MEqA==
X-Gm-Gg: AYBFou1+EizzgZrSsNt5lxa4cCKma2sBVWYEOyRcpHI5qpdTb+fAisb82S7u9eP699h
	Qrt12ut1OB3HFs6UReknxWgn3KXt0DgozEkaB3aQjIskXon4JyQDEseEP2rJ8ka0tds/rdmCU2R
	WIOVXztMsqq9WjH3HYNK9QxmEV651qSOuwYaDT1edjr4lD619f/Zs7xnnVoQ89yor5BqzYcflvX
	I7dTH04l+I/QhNALAY2wkjO55wDb1sfaCEE/EnLQdU66BuT4jxO3YBgvSlo4lP2rbynFZGJWImc
	WjnA5xzKiM8m1F7NGwlIMdR6+ZbNR0Qh8wYzngT7tZT0fCubEEiCjdNM39eytW87I6BkblZFhll
	y0tzWG6+YD8BEJW4k9akfrY77c3nNJPiSf7h5U14m+V/DIQNR6+wv3B7qmv4ATht392qt67ooBO
	7d06DRETh/emXhlyVolM7a
X-Received: by 2002:a05:690c:c50d:b0:8b0:ad16:7234 with SMTP id
 00721157ae682-8b1b5d5b992mr27112807b3.73.1793236966992; Wed, 28 Oct 2026
 18:22:46 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029002132.1035888-1-cochcoder@proton.me>
In-Reply-To: <20261029002132.1035888-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Oct 2026 21:22:33 -0400
X-Gm-Features: AclHuK_qTWE0ozyA7C1cf63f3jkxCyFHkdycntXxmcUQ48j3ETAy1vJ5h91Z_zY
Message-ID: <CABBYNZ+PpZzxJJB75noKrK2eF-P2f2PSZ0cvXbqodxv1tzD_VA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] asha: allow LE 2M PHY on the audio channel
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Wed, Oct 28, 2026 at 8:21=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> w=
rote:
>
> Allow LE 2M on the CoC socket to increase available throughput for
> capable peers. Retain LE 1M fallback and treat BT_PHY as best effort
> for older kernels.
>
> Test the PHY mask and continued startup when the preference is rejected.
>
> Assisted-by: OpenCode:gpt-6.1-sol
> ---
> Resending unchanged v2 after inactivity closure of the prior CI PR
> (closure reported October 28). Original source and attribution retained.
> Prior v2 CI passed as reported; not independently reverified.
> No new hardware or remote CI result is claimed.
>
> Changes since v1: fix sanitizer-retained daemon references with
> fail-fast test stubs.
> Refreshed to BlueZ 9dc7e40962f11d1d9a5568f8a7633a695288329c.
> Strict non-LTO ASan/UBSan build and make check pass; ordinary LTO
> build and make check pass. Strict LTO has an unchanged upstream
> peripheral/btsensor warning failure, reproduced without this topic.
> No new hardware trial or remote functional-lab result is claimed.
>
> Submission review notes (not part of the commit message):
> N8/UB500 completes 2M in the downstream stack. N7/1M-only hardware
> is unavailable; fallback has focused unit coverage, not new hardware proo=
f.
>
>  .gitignore            |   1 +
>  Makefile.am           |   9 ++
>  profiles/audio/asha.c |  11 ++
>  unit/test-asha-phy.c  | 241 ++++++++++++++++++++++++++++++++++++++++++

Don't create new test files, just reuse test-asha.

>  4 files changed, 262 insertions(+)
>  create mode 100644 unit/test-asha-phy.c
>
> diff --git a/.gitignore b/.gitignore
> index 06b24735df..d214ba0591 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -112,6 +112,7 @@ unit/test-lib
>  unit/test-mgmt
>  unit/test-uhid
>  unit/test-hfp
> +unit/test-asha-phy
>  unit/test-crypto
>  unit/test-ecc
>  unit/test-hog
> diff --git a/Makefile.am b/Makefile.am
> index f742458d11..2041ac87db 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -706,6 +706,15 @@ unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.=
la \
>
>  unit_tests +=3D unit/test-hfp
>
> +unit_tests +=3D unit/test-asha-phy
> +
> +unit_test_asha_phy_SOURCES =3D unit/test-asha-phy.c
> +unit_test_asha_phy_CFLAGS =3D $(AM_CFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
> +       -ffunction-sections -fdata-sections
> +unit_test_asha_phy_LDADD =3D src/libshared-glib.la \
> +       lib/libbluetooth-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
> +unit_test_asha_phy_LDFLAGS =3D -Wl,--gc-sections
> +
>  unit_test_hfp_SOURCES =3D unit/test-hfp.c
>  unit_test_hfp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
>
> diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> index 8e625fdca3..d86224764d 100644
> --- a/profiles/audio/asha.c
> +++ b/profiles/audio/asha.c
> @@ -88,6 +88,8 @@ static void connect_cb(GIOChannel *io, GError *err, gpo=
inter user_data)
>         struct connect_data *conn_data =3D user_data;
>         struct bt_asha_device *asha_dev =3D conn_data->asha_dev;
>         GError *gerr =3D NULL;
> +       uint32_t phys;
> +       int fd;
>
>         if (err) {
>                 error("%s", err->message);
> @@ -105,6 +107,15 @@ static void connect_cb(GIOChannel *io, GError *err, =
gpointer user_data)
>                 g_error_free(gerr);
>         }
>
> +       /*
> +        * Allow LE 2M with LE 1M fallback. Older kernels may lack BT_PHY=
.
> +        */
> +       phys =3D BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
> +                       BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX;
> +       fd =3D g_io_channel_unix_get_fd(io);
> +       if (setsockopt(fd, SOL_BLUETOOTH, BT_PHY, &phys, sizeof(phys)) < =
0)
> +               DBG("Could not set LE 2M PHY preference: %s", strerror(er=
rno));
> +
>         asha_dev->io =3D io;
>
>         bt_asha_start(asha_dev->asha, conn_data->cb,
> diff --git a/unit/test-asha-phy.c b/unit/test-asha-phy.c
> new file mode 100644
> index 0000000000..c58101ebfd
> --- /dev/null
> +++ b/unit/test-asha-phy.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <assert.h>
> +#include <stdarg.h>
> +#include <sys/socket.h>
> +
> +int test_setsockopt(int fd, int level, int option, const void *value,
> +                                                       socklen_t length)=
;
> +
> +/* Source-level mocks remain effective with link-time optimization. */
> +#define setsockopt test_setsockopt
> +#define bt_io_get test_io_get
> +#define bt_asha_start test_start
> +#include "profiles/audio/asha.c"
> +#undef setsockopt
> +#undef bt_io_get
> +#undef bt_asha_start
> +#include "src/shared/tester.h"
> +
> +static unsigned int preferences, starts;
> +static bool mtu_ok;
> +static int preference_error, expected_fd;
> +
> +/* Sanitizers retain the plugin's globals, including unused daemon callb=
acks. */
> +int btd_profile_register(struct btd_profile *profile)
> +{
> +       assert(false);
> +}
> +
> +void btd_profile_unregister(struct btd_profile *profile)
> +{
> +       assert(false);
> +}
> +
> +const char *device_get_path(const struct btd_device *device)
> +{
> +       assert(false);
> +}
> +
> +const bdaddr_t *device_get_address(struct btd_device *device)
> +{
> +       assert(false);
> +}
> +
> +struct btd_adapter *device_get_adapter(struct btd_device *device)
> +{
> +       assert(false);
> +}
> +
> +const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter)
> +{
> +       assert(false);
> +}
> +
> +void btd_device_set_conn_param(struct btd_device *device,
> +                               uint16_t min_interval, uint16_t max_inter=
val,
> +                                       uint16_t latency, uint16_t timeou=
t)
> +{
> +       assert(false);
> +}
> +
> +struct gatt_db *btd_device_get_gatt_db(struct btd_device *device)
> +{
> +       assert(false);
> +}
> +
> +struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *dev=
ice)
> +{
> +       assert(false);
> +}
> +
> +struct btd_device *btd_service_get_device(const struct btd_service *serv=
ice)
> +{
> +       assert(false);
> +}
> +
> +void *btd_service_get_user_data(const struct btd_service *service)
> +{
> +       assert(false);
> +}
> +
> +void btd_service_set_user_data(struct btd_service *service, void *user_d=
ata)
> +{
> +       assert(false);
> +}
> +
> +void btd_service_connecting_complete(struct btd_service *service, int er=
r)
> +{
> +       assert(false);
> +}
> +
> +void btd_service_disconnecting_complete(struct btd_service *service, int=
 err)
> +{
> +       assert(false);
> +}
> +
> +DBusConnection *btd_get_dbus_connection(void)
> +{
> +       assert(false);
> +}
> +
> +gboolean g_dbus_register_interface(DBusConnection *connection,
> +                               const char *path, const char *name,
> +                               const GDBusMethodTable *methods,
> +                               const GDBusSignalTable *signals,
> +                               const GDBusPropertyTable *properties,
> +                               void *user_data, GDBusDestroyFunction des=
troy)
> +{
> +       assert(false);
> +}
> +
> +gboolean g_dbus_unregister_interface(DBusConnection *connection,
> +                                       const char *path, const char *nam=
e)
> +{
> +       assert(false);
> +}
> +
> +const struct media_endpoint *media_endpoint_get_asha(void)
> +{
> +       assert(false);
> +}
> +
> +struct media_transport *media_transport_create(struct btd_device *device=
,
> +                               const char *remote_endpoint,
> +                               uint8_t *configuration, size_t size,
> +                               void *data, void *stream)
> +{
> +       assert(false);
> +}
> +
> +void media_transport_destroy(struct media_transport *transport)
> +{
> +       assert(false);
> +}
> +
> +const char *media_transport_get_path(struct media_transport *transport)
> +{
> +       assert(false);
> +}
> +
> +GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
> +                               GDestroyNotify destroy, GError **gerr,
> +                                                       BtIOOption opt1, =
...)
> +{
> +       assert(false);
> +}
> +
> +void btd_error(uint16_t index, const char *format, ...)
> +{
> +}
> +
> +void btd_debug(uint16_t index, const char *format, ...)
> +{
> +}
> +
> +int test_setsockopt(int fd, int level, int option, const void *value,
> +                                                       socklen_t length)
> +{
> +       const uint32_t *phys =3D value;
> +
> +       assert(fd =3D=3D expected_fd && level =3D=3D SOL_BLUETOOTH && opt=
ion =3D=3D BT_PHY);
> +       assert(length =3D=3D sizeof(*phys));
> +       assert(*phys =3D=3D (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
> +                                       BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX=
));
> +       assert(starts =3D=3D 0);
> +       preferences++;
> +       errno =3D preference_error;
> +       return preference_error ? -1 : 0;
> +}
> +
> +gboolean test_io_get(GIOChannel *io, GError **error, BtIOOption first, .=
..)
> +{
> +       va_list args;
> +       uint16_t *imtu, *omtu;
> +
> +       if (!mtu_ok) {
> +               *error =3D g_error_new(G_IO_CHANNEL_ERROR,
> +                               G_IO_CHANNEL_ERROR_FAILED, "MTU failure")=
;
> +               return FALSE;
> +       }
> +
> +       assert(first =3D=3D BT_IO_OPT_IMTU);
> +       va_start(args, first);
> +       imtu =3D va_arg(args, uint16_t *);
> +       assert(va_arg(args, int) =3D=3D BT_IO_OPT_OMTU);
> +       omtu =3D va_arg(args, uint16_t *);
> +       assert(va_arg(args, int) =3D=3D BT_IO_OPT_INVALID);
> +       va_end(args);
> +       *imtu =3D 512;
> +       *omtu =3D 163;
> +       return TRUE;
> +}
> +
> +unsigned int test_start(struct bt_asha *asha, bt_asha_cb_t callback, voi=
d *data)
> +{
> +       assert(preferences =3D=3D 1);
> +       starts++;
> +       return 0;
> +}
> +
> +static void test_phy(const void *user_data)
> +{
> +       const int errors[] =3D { 0, ENOPROTOOPT, EINVAL };
> +       unsigned int i;
> +       int fds[2];
> +       GIOChannel *io;
> +       GError *error;
> +       struct bt_asha asha =3D { 0 };
> +       struct bt_asha_device device =3D { .asha =3D &asha };
> +       struct connect_data data =3D { .asha_dev =3D &device };
> +
> +       assert(!pipe(fds));
> +       io =3D g_io_channel_unix_new(fds[0]);
> +       expected_fd =3D fds[0];
> +
> +       for (i =3D 0; i < ARRAY_SIZE(errors); i++) {
> +               preferences =3D starts =3D 0;
> +               preference_error =3D errors[i];
> +               mtu_ok =3D i !=3D 2;
> +               connect_cb(io, NULL, &data);
> +               assert(preferences =3D=3D 1 && starts =3D=3D 1 && device.=
io =3D=3D io);
> +               assert(device.imtu =3D=3D 512 && device.omtu =3D=3D 163);
> +       }
> +
> +       preferences =3D starts =3D 0;
> +       error =3D g_error_new(G_IO_CHANNEL_ERROR, G_IO_CHANNEL_ERROR_FAIL=
ED,
> +                                                       "mock connection =
failure");
> +       connect_cb(io, error, &data);
> +       assert(preferences =3D=3D 0 && starts =3D=3D 0);
> +       g_error_free(error);
> +       g_io_channel_unref(io);
> +       close(fds[0]);
> +       close(fds[1]);
> +       tester_test_passed();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       tester_init(&argc, &argv);
> +       tester_add("ASHA/PHY/preference", NULL, NULL, test_phy, NULL);
> +       return tester_run();
> +}
>
> base-commit: 9dc7e40962f11d1d9a5568f8a7633a695288329c
> --
> 2.56.0
>
>
>


--=20
Luiz Augusto von Dentz
