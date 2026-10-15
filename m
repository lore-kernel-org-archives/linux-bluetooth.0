Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5242931CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029922; cv=none; b=CVPdq4H8bxXgFOleMkC2iEWhUfJg9VUYYCE2RmkyfvAAKpSTUGNYKrjvRghBShsEOiLAwgBuFQRboUYk8kSw5MW6Y/M1W7nfWNmI10S2zqEYXe2iNnq6sAfkvbHQcfQOKwf0COf5OtVC8HVhiwM+M4gSyhyNfgxiKMkAWjr7Jfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029922; c=relaxed/simple;
	bh=ufWq5L3/BL5cjrIR4vlMLhcjdB1xYJUacdwwzgOk7eQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D739b2l7Zi6KsFuB1XayZiUpudUAaCHG0VezMyhUGe50YqUmBakEpVyln8K/RBbDQKzMdND+UkKQkDzkfndsoYvTya3Btgk6ED4paronD8KyDS/EfS910raEASvgBGBIE+uoh+meUkf55fZqQuqOrj4larhOLWR4K3Qov7K1Nys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QNgFcoac; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QNgFcoac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792029914; x=1792289114;
	bh=fO1TsDwsa6Y1FT3f/FoGwJK7vazCApHdZbGEYw191OU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QNgFcoachK5Rle1mkM4SdZIT8EyDH9tcFAbK4mzcb6F8Xve0ZAM53tCKJ6zo37FzR
	 aSjs6DCe1yFrIPWJxExPSDwvhX7U4Xh//sbvKC/oYs1JrOiPnjbuklB4VLMojITUf+
	 X8I3ZyW/A9VpjhmVZY2OEYsV+sl+7gmAbSR837pdHOEPMTZT6100YbhI1lWj7a4dlL
	 CgVmyhm2OvcYV1elJbcMuBrM8688qsaaI7N7gHuuy/D6vJKd41pBCKXUbk0JXdQ75Y
	 C4EzRF5oMtCVixwllFdnsl/KTZ+/LGvdtSdqC5RU8RBdGmwURqRq8/+ZysGdS+L9yj
	 Nanukz4z5ol/A==
Date: Thu, 15 Oct 2026 02:05:11 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] shared/asha: send STOP without waiting for a response
Message-ID: <djSUbslnBleSZJxke9cRFP0mb6UxEYT5hkZ1rCMmzGaO6gIZkV6HWEUYdoL6FkQ4JwabQSI_8lGffW3Ep7uMQ6FlaNARltG5Kimkgj9TwaE=@proton.me>
In-Reply-To: <20261013034345.513789-1-cochcoder@proton.me>
References: <20261013034345.513789-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 6d84cba73ad575c971d5ec59e1b960938bf4be08
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

CI: https://github.com/bluez/bluez/pull/2664

On Monday, October 12th, 2026 at 11:44 PM, Kyle Pepper <cochcoder@proton.me=
> wrote:

> STOP resets local state without consuming the ATT response. Use a Write
> Command so an unresponsive renderer does not hold the request queue
> until timeout.
>=20
> Test command semantics, failure handling and peer STATUS notification.
>=20
> Fixes: 9948168cca15 ("shared/asha: Don't wait for status notification on =
stop")
> Assisted-by: OpenCode:gpt-6.1-sol
> ---
> Submission review notes (not part of the commit message):
> Local validation is for base 7428ca2df9356363079db0f48412c20cbdb9471f.
> Compatibility with newer upstream tips has not been verified locally.
> This topic uses the verified STOP introducing commit as its Fixes tag.
> Existing N8 blocking-STOP failure evidence is retained; the new unit test
> mocks setup and GATT writes, not hardware or daemon concurrency.
>=20
>  .gitignore            |  1 +
>  Makefile.am           |  6 +++
>  src/shared/asha.c     |  5 ++-
>  unit/test-asha-stop.c | 97 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 107 insertions(+), 2 deletions(-)
>  create mode 100644 unit/test-asha-stop.c
>=20
> diff --git a/.gitignore b/.gitignore
> index 06b24735df..8a4195c05a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -112,6 +112,7 @@ unit/test-lib
>  unit/test-mgmt
>  unit/test-uhid
>  unit/test-hfp
> +unit/test-asha-stop
>  unit/test-crypto
>  unit/test-ecc
>  unit/test-hog
> diff --git a/Makefile.am b/Makefile.am
> index f742458d11..6016913145 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -706,6 +706,12 @@ unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.=
la \
> =20
>  unit_tests +=3D unit/test-hfp
> =20
> +unit_tests +=3D unit/test-asha-stop
> +
> +unit_test_asha_stop_SOURCES =3D unit/test-asha-stop.c
> +unit_test_asha_stop_LDADD =3D src/libshared-glib.la \
> +=09lib/libbluetooth-internal.la $(GLIB_LIBS)
> +
>  unit_test_hfp_SOURCES =3D unit/test-hfp.c
>  unit_test_hfp_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
> =20
> diff --git a/src/shared/asha.c b/src/shared/asha.c
> index 79bb29bf9a..0e6261d37d 100644
> --- a/src/shared/asha.c
> +++ b/src/shared/asha.c
> @@ -284,8 +284,9 @@ unsigned int bt_asha_stop(struct bt_asha *asha)
> =20
>  =09asha->state =3D ASHA_STOPPED;
> =20
> -=09ret =3D asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd), NULL,
> -=09=09=09NULL);
> +=09/* State is reset below without waiting for an ATT response. */
> +=09ret =3D asha_send_acp_without_response(asha, acp_stop_cmd,
> +=09=09=09sizeof(acp_stop_cmd));
>  =09asha_set_send_status(asha, false);
> =20
>  =09/* We reset our state without waiting for a response */
> diff --git a/unit/test-asha-stop.c b/unit/test-asha-stop.c
> new file mode 100644
> index 0000000000..5ef6d03623
> --- /dev/null
> +++ b/unit/test-asha-stop.c
> @@ -0,0 +1,97 @@
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
> +static unsigned int commands, requests, peer_updates;
> +static bool command_ok;
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
> +=09assert(client && handle =3D=3D 0x79 && !signed_write);
> +
> +=09if (value[0] =3D=3D 0x02) {
> +=09=09assert(length =3D=3D 1);
> +=09=09commands++;
> +=09=09return command_ok;
> +=09}
> +
> +=09assert(length =3D=3D 2 && value[0] =3D=3D 0x03 && value[1] =3D=3D 0x0=
0);
> +=09peer_updates++;
> +=09return 1;
> +}
> +
> +unsigned int test_write_request(struct bt_gatt_client *client, uint16_t =
handle,
> +=09=09=09=09const uint8_t *value, uint16_t length,
> +=09=09=09=09bt_gatt_client_callback_t callback, void *data,
> +=09=09=09=09bt_gatt_client_destroy_func_t destroy)
> +{
> +=09requests++;
> +=09return 1;
> +}
> +
> +static void state_callback(int status, void *data)
> +{
> +=09assert(false);
> +}
> +
> +static void test_stop(const void *user_data)
> +{
> +=09unsigned int fail;
> +
> +=09for (fail =3D 0; fail < 2; fail++) {
> +=09=09struct bt_asha left =3D {
> +=09=09=09.client =3D (void *) 1, .acp_handle =3D 0x79,
> +=09=09=09.hisyncid =3D { 1 }, .state =3D ASHA_STARTED,
> +=09=09=09.state_cb =3D state_callback, .state_cb_data =3D (void *) 1,
> +=09=09};
> +=09=09struct bt_asha right =3D {
> +=09=09=09.client =3D (void *) 2, .acp_handle =3D 0x79,
> +=09=09=09.hisyncid =3D { 1 }, .right_side =3D true,
> +=09=09=09.state =3D ASHA_STARTED,
> +=09=09};
> +
> +=09=09asha_devices =3D queue_new();
> +=09=09update_asha_set(&left, true);
> +=09=09update_asha_set(&right, true);
> +=09=09commands =3D requests =3D peer_updates =3D 0;
> +=09=09command_ok =3D !fail;
> +=09=09assert(bt_asha_stop(&left) =3D=3D (fail ? (unsigned int) -1 : 0));
> +=09=09assert(commands =3D=3D 1 && requests =3D=3D 0 && peer_updates =3D=
=3D 1);
> +=09=09assert(left.state =3D=3D ASHA_STOPPED);
> +=09=09assert(right.state =3D=3D ASHA_STARTED);
> +=09=09assert(!left.state_cb && !left.state_cb_data);
> +
> +=09=09/* Repeated stop must not send another control command. */
> +=09=09assert(bt_asha_stop(&left) =3D=3D 0);
> +=09=09assert(commands =3D=3D 1 && requests =3D=3D 0 && peer_updates =3D=
=3D 1);
> +=09=09update_asha_set(&left, false);
> +=09=09update_asha_set(&right, false);
> +=09=09assert(!asha_devices);
> +=09}
> +
> +=09tester_test_passed();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +=09tester_init(&argc, &argv);
> +=09tester_add("ASHA/stop/command", NULL, NULL, test_stop, NULL);
> +=09return tester_run();
> +}
>=20
> base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f
> 
