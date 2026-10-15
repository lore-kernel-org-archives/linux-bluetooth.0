Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7C3BADBD
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030410; cv=none; b=jaFomxSDUj84/CH4af76hARB+hzEkKHjB2dC8ksK0VQCrZQ0rUoRVm4dId6qwOJV1jrv+84UjE42QqdFrGu4wHHIz59MpekmCmYcbx6OltawVf9108P7PWIYQ5sRqSigXOqT+nKk5rozojVRjrSznYKfW5DuhKmRvh5t++XEQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030410; c=relaxed/simple;
	bh=7T3tcPZIzcrSxn1HyaqOjB+NtIdhaE51pkDF8RhfBEk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpX3JjDn5AJlujlarMPzzboYSx0r3FQterQhKK4wKdM+xLVb3Qk4SB/GqwcfALqw/ZpAZXe9e6/9Ok2WfM2R4ZO/eh6unn7erxp+pr+YO9cdbbIAcL3bTnyFYeW2fsP5TGn2dc8fnMSjkk7e0jVAyKs13MKCOsTl72qJJ5Vbk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ew/Moc9h; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ew/Moc9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792030395; x=1792289595;
	bh=NBfiCJ/H4BVwx/k9PfoKv7ye0hus9Uv0qgGGzSnJutY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ew/Moc9hm5uAi/oIwQ8GBJG40VL1odcTOq/RbYIT/c3Z38v97VeTKt34fpgzvcRMy
	 yQ/8USLPr9xAIosDSkcI4lJkLQKkkZIfS3kUJsYxY1rFNlwHmK3JINFJwM4srsPWj7
	 e8lg5nDN6TFshe8Pu/KzdgmptCOKwnFzEZ/xltYvMmxRqBe+DFJgMI4k+2oukV74t1
	 WP9BmBTrHUdSXY3C1d39NIe5vyJdEEUDD9Zwslkiv3m58l9+7NrfNhvRsTvIQ1C++Y
	 o0SQeSrjQVMF7MowI8q+cb7uRHxYUNm3IGYI7WmS2PWrzA15AAuo/hYau4vI36Mnfw
	 K/lLOsuXWGwmQ==
Date: Thu, 15 Oct 2026 02:13:10 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] shared/asha: prime volume before starting audio
Message-ID: <eMlv0EAFmUzqfD3UmUY2Z77LdaqNXu5K73OCDqMZ6Hm88C_FuZy-V4GeOielY97ZCCxdo8x2bnCg4W0tyGIqbCAKcCCYmmrzqrz_odVRZyw=@proton.me>
In-Reply-To: <20261013034613.516771-1-cochcoder@proton.me>
References: <20261013034613.516771-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 55cced33d8055abfda6e8bb7e36db3c46e394b0b
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Could the failed TestFunctional CI check for this patch be reran? The match=
ing checks pass locally.

CI: https://github.com/bluez/bluez/pull/2665



On Monday, October 12th, 2026 at 11:46 PM, Kyle Pepper <cochcoder@proton.me=
> wrote:

> Some tested renderers remain silent unless the Volume characteristic is
> written before START. Prime it with the selected volume and keep the
> write best effort.
>=20
> Test volume-before-START ordering and best-effort failure handling.
>=20
> Assisted-by: OpenCode:gpt-6.1-sol
> ---
> Submission review notes (not part of the commit message):
> Local validation is for base 7428ca2df9356363079db0f48412c20cbdb9471f.
> Compatibility with newer upstream tips has not been verified locally.
> N8 startup evidence is from the combined downstream stack, not a
> volume-only hardware ablation. Native ordering/failure unit tests are
> included; other renderer coverage and human contribution review remain.
>=20
>  .gitignore             |  1 +
>  Makefile.am            |  6 +++
>  src/shared/asha.c      |  4 ++
>  unit/test-asha-start.c | 99 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 110 insertions(+)
>  create mode 100644 unit/test-asha-start.c
>=20
> diff --git a/.gitignore b/.gitignore
> index 06b24735df..adff1ea84a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -112,6 +112,7 @@ unit/test-lib
>  unit/test-mgmt
>  unit/test-uhid
>  unit/test-hfp
> +unit/test-asha-start
>  unit/test-crypto
>  unit/test-ecc
>  unit/test-hog
> diff --git a/Makefile.am b/Makefile.am
> index f742458d11..a56d66873b 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -706,6 +706,12 @@ unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.=
la \
> =20
>  unit_tests +=3D unit/test-hfp
> =20
> +unit_tests +=3D unit/test-asha-start
> +
> +unit_test_asha_start_SOURCES =3D unit/test-asha-start.c
> +unit_test_asha_start_LDADD =3D src/libshared-glib.la \
> +=09lib/libbluetooth-internal.la $(GLIB_LIBS)
> +
>  unit_test_hfp_SOURCES =3D unit/test-hfp.c
>  unit_test_hfp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
> =20
> diff --git a/src/shared/asha.c b/src/shared/asha.c
> index 79bb29bf9a..b5e8d67567 100644
> --- a/src/shared/asha.c
> +++ b/src/shared/asha.c
> @@ -262,6 +262,10 @@ unsigned int bt_asha_start(struct bt_asha *asha, bt_=
asha_cb_t cb,
>  =09=09return 0;
>  =09}
> =20
> +=09/* Some renderers require a Volume write before START. */
> +=09if (!bt_asha_set_volume(asha, asha->volume))
> +=09=09DBG("ASHA volume priming failed, continuing with START");
> +
>  =09ret =3D asha_send_acp(asha, acp_start_cmd, sizeof(acp_start_cmd), cb,
>  =09=09=09user_data);
>  =09if (ret < 0)
> diff --git a/unit/test-asha-start.c b/unit/test-asha-start.c
> new file mode 100644
> index 0000000000..49df54c1f3
> --- /dev/null
> +++ b/unit/test-asha-start.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +#include <assert.h>
> +
> +/* Source-level mocks remain effective with link-time optimization. */
> +#define bt_gatt_client_write_without_response test_write_command
> +#define bt_gatt_client_write_value test_write_request
> +#include "src/shared/asha.c"
> +#undef bt_gatt_client_write_without_response
> +#undef bt_gatt_client_write_value
> +#include "src/shared/tester.h"
> +
> +static unsigned int commands, requests;
> +static bool volume_ok, start_ok;
> +static int8_t selected_volume;
> +
> +void btd_error(uint16_t index, const char *format, ...)
> +{
> +}
> +
> +void btd_debug(uint16_t index, const char *format, ...)
> +{
> +}
> +
> +unsigned int test_write_command(struct bt_gatt_client *client, uint16_t =
handle,
> +=09=09=09=09=09bool signed_write,
> +=09=09=09=09=09const uint8_t *value, uint16_t length)
> +{
> +=09assert(client && handle =3D=3D 0x82 && !signed_write);
> +=09assert(length =3D=3D 1 && (int8_t) value[0] =3D=3D selected_volume);
> +=09assert(requests =3D=3D 0);
> +=09commands++;
> +=09return volume_ok;
> +}
> +
> +unsigned int test_write_request(struct bt_gatt_client *client, uint16_t =
handle,
> +=09=09=09=09const uint8_t *value, uint16_t length,
> +=09=09=09=09bt_gatt_client_callback_t callback, void *data,
> +=09=09=09=09bt_gatt_client_destroy_func_t destroy)
> +{
> +=09assert(client && handle =3D=3D 0x79);
> +=09assert(commands =3D=3D 1 && requests =3D=3D 0);
> +=09assert(length =3D=3D 5 && value[0] =3D=3D 0x01 && value[1] =3D=3D 0x0=
1);
> +=09assert((int8_t) value[3] =3D=3D selected_volume);
> +=09assert(callback && data && !destroy);
> +=09requests++;
> +=09return start_ok;
> +}
> +
> +static void test_start(const void *user_data)
> +{
> +=09const int8_t volumes[] =3D { -128, -127, -64, 0 };
> +=09unsigned int i, fail;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(volumes); i++) {
> +=09=09for (fail =3D 0; fail < 2; fail++) {
> +=09=09=09struct bt_asha asha =3D {
> +=09=09=09=09.client =3D (void *) 1, .acp_handle =3D 0x79,
> +=09=09=09=09.volume_handle =3D 0x82, .volume =3D volumes[i],
> +=09=09=09};
> +
> +=09=09=09selected_volume =3D volumes[i];
> +=09=09=09commands =3D requests =3D 0;
> +=09=09=09volume_ok =3D !fail;
> +=09=09=09start_ok =3D true;
> +=09=09=09assert(bt_asha_start(&asha, NULL, NULL) =3D=3D 0);
> +=09=09=09assert(commands =3D=3D 1 && requests =3D=3D 1);
> +=09=09=09assert(asha.state =3D=3D ASHA_STARTING);
> +=09=09=09assert(asha.volume =3D=3D selected_volume);
> +
> +=09=09=09/* A repeated start must not write the volume again. */
> +=09=09=09bt_asha_start(&asha, NULL, NULL);
> +=09=09=09assert(commands =3D=3D 1 && requests =3D=3D 1);
> +=09=09}
> +=09}
> +
> +=09{
> +=09=09struct bt_asha asha =3D {
> +=09=09=09.client =3D (void *) 1, .acp_handle =3D 0x79,
> +=09=09=09.volume_handle =3D 0x82, .volume =3D -64,
> +=09=09};
> +
> +=09=09commands =3D requests =3D 0;
> +=09=09selected_volume =3D asha.volume;
> +=09=09volume_ok =3D true;
> +=09=09start_ok =3D false;
> +=09=09assert(bt_asha_start(&asha, NULL, NULL) =3D=3D (unsigned int) -1);
> +=09=09assert(asha.state =3D=3D ASHA_STOPPED);
> +=09=09assert(commands =3D=3D 1 && requests =3D=3D 1);
> +=09}
> +
> +=09tester_test_passed();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +=09tester_init(&argc, &argv);
> +=09tester_add("ASHA/start/volume", NULL, NULL, test_start, NULL);
> +=09return tester_run();
> +}
>=20
> base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f
> 
