Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06559D604
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655973; cv=none; b=SCm6wdaCST09DMdzfftxFiPiHmnEeLO248JcH0umeUWJTUab1XvNjaY1lj2JNOP9UuLTXrms4N90DXXDfOZHFbBSarOf135q2u2Pm6yFiYTW+KXL+Vkwvwb8CHgPIqPhIbne+yNK5tuopmKEKUWvzga8Bn5rcG83IDVFGeU7zTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655973; c=relaxed/simple;
	bh=yb9QIPnkRxDuvGtCQecAlF/iMXetvsR3mEZt27uS+UA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fytCFku4H/rIrkB1bG/t+bHjTj1QMuq/Oo8bSpcC98cQ6q2YT6ekLi0w+75lV6J5DD9HkgxupRARUNWIA3d++AHZRYkJQJ9Yr7Zzxi2rYoKcQpype/+RF9A1QNz8R9Dl4NlTBAhFqkDd9dDIHVc9LYnqbfDhGcYHi96bqEDWg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=B98jRI7b; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="B98jRI7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789655954; x=1789915154;
	bh=NYYfMfcygdRl2u/CncW5zSswH5zpomJ77aB/EFhxN1U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B98jRI7bsIpj+YrFmhsrikrt83ltbw3fU3g1ivlE8aJEX6TXEnFtBjbztJSXpS2yZ
	 h12pESrQnO7bsKERR+5OgMy25ahc1q8WB94EPrh+LxdEoEy586SQj0I8q3lZaLyGsU
	 LsIk/G+9+ko0iFnoeJejaZADjaLTzKv6Gq5nQ76QspogK7W/BGKpJyBiGxzgjLpTMd
	 CbKmtvGE1+p/pIcp/6VHINdmPlfwl0dWXY3Jr/a/XPuS8KkToS+OiC/Jg+xxePsNl7
	 bL733yffD4mmpeopcdEtvVmes5AKALgSjF0VFs5SesR2yah1mLGfT3Bjhpz3ceDwC2
	 Cp8nCTxttkrDw==
Date: Thu, 17 Sep 2026 14:39:09 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v2 2/2] unit: Test metadata during BAP client reconfig
Message-ID: <uIUsY-bF3Pt28MquXpDWsmTdi0sRTp2SQQlddqTh483oiV9swypcqqaiU9f5fY7DVF5PiF_Mm6c7FwkTW3ZydrYKyk7qsZ5KAPaL92TrM-Y=@proton.me>
In-Reply-To: <jqqyJM7RdaKVlEMJ4PZERpmPxyPBru6C9bQXb9ycHNKYLueOCkf0-7VQY6eXP6d4insUcrxuJfEw-nvKLEfieSqZfNWpj-vxmAgUKpCLH20=@proton.me>
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me> <VPeeCvkuNkEcQo9M5HlwGnyftq-hu4hT1wqkc3pjPtao6HWEoFu2rWyFMtz0K6vG4l2DDbyg4ZfvO5CQb2zR44-UcNh3l6qOfjf90ThTyxg=@proton.me> <CABBYNZ+tf1SZb3ONdaySGEk=n27XofWepzfg2y_VTujTUc4eCg@mail.gmail.com> <jqqyJM7RdaKVlEMJ4PZERpmPxyPBru6C9bQXb9ycHNKYLueOCkf0-7VQY6eXP6d4insUcrxuJfEw-nvKLEfieSqZfNWpj-vxmAgUKpCLH20=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 5a74ac1ee128736b8b1abe27223345321f0b586b
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

Add client tests for both remote Sink and Source ASEs. Reuse an actual
configured stream, start a second Codec Configuration, and cache local
metadata before the peer responds.

Check metadata retention and absence of an extra local CONFIG callback.
Require QoS to remain blocked after reuse and after the successful
control point response. Only the fresh peer CONFIG notification may
make the stream ready for a nonzero QoS request and the subsequent
exchange.

Without the shared/bap fix, the premature local CONFIG callback attempts
QoS before the stream is ready and both tests fail at that assertion.
---
 unit/test-bap.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 4e89ba6af..5fcf0262d 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -82,6 +82,11 @@ struct test_data {
 =09size_t iovcnt;
 =09struct iovec *iov;
 =09int fds[8][2];
+=09unsigned int metadata_config_count;
+=09struct bt_bap_stream *metadata_stream;
+=09bool metadata_reused;
+=09bool metadata_config_replied;
+=09unsigned int metadata_qos_id;
 };
=20
 struct notify {
@@ -4215,6 +4220,129 @@ static void test_scc_release(void)
 =09test_usr_scc_release();
 }
=20
+static bool metadata_reuse_pac(struct bt_bap_pac *lpac,
+=09=09=09=09struct bt_bap_pac *rpac, void *user_data)
+{
+=09struct test_data *data =3D user_data;
+=09struct bt_bap_stream *stream;
+
+=09stream =3D bt_bap_stream_new(data->bap, lpac, rpac, &data->cfg->qos,
+=09=09=09=09=09=09=09&data->cfg->cc);
+=09g_assert(stream =3D=3D data->metadata_stream);
+=09data->metadata_reused =3D true;
+
+=09return false;
+}
+
+static void metadata_config_response(struct bt_bap_stream *stream,
+=09=09=09=09=09uint8_t code, uint8_t reason,
+=09=09=09=09=09void *user_data)
+{
+=09struct test_data *data =3D user_data;
+=09unsigned int id;
+
+=09g_assert_cmpuint(code, =3D=3D, 0);
+=09g_assert_cmpuint(reason, =3D=3D, 0);
+=09g_assert_cmpuint(data->metadata_config_count, =3D=3D, 1);
+
+=09/* A successful CP response has not confirmed the new ASE status. */
+=09id =3D bt_bap_stream_qos(stream, &data->cfg->qos, bap_qos, data);
+=09g_assert_cmpuint(id, =3D=3D, 0);
+=09data->metadata_config_replied =3D true;
+}
+
+/* Local metadata must not replace the peer's Codec Configured notificatio=
n. */
+static void state_cc_metadata(struct bt_bap_stream *stream,
+=09=09=09=09=09uint8_t old_state, uint8_t new_state,
+=09=09=09=09=09void *user_data)
+{
+=09struct test_data *data =3D user_data;
+=09uint8_t value[] =3D { 0x03, 0x02, 0x02, 0x00 };
+=09struct iovec metadata =3D {
+=09=09.iov_base =3D value,
+=09=09.iov_len =3D sizeof(value),
+=09};
+=09struct iovec *cached;
+=09unsigned int id;
+
+=09if (new_state =3D=3D BT_BAP_STREAM_STATE_QOS) {
+=09=09g_assert_cmpuint(data->metadata_config_count, =3D=3D, 2);
+=09=09g_assert(data->metadata_config_replied);
+=09=09g_assert(data->metadata_qos_id);
+=09=09id =3D bt_bap_stream_release(stream, bap_release, data);
+=09=09g_assert(id);
+=09=09return;
+=09}
+
+=09if (new_state !=3D BT_BAP_STREAM_STATE_CONFIG)
+=09=09return;
+
+=09data->metadata_config_count++;
+
+=09if (data->metadata_config_count =3D=3D 2) {
+=09=09/* The peer notification makes the reused stream QoS-ready. */
+=09=09g_assert_cmpuint(old_state, =3D=3D, BT_BAP_STREAM_STATE_CONFIG);
+=09=09id =3D bt_bap_stream_qos(stream, &data->cfg->qos, bap_qos, data);
+=09=09g_assert(id);
+=09=09g_assert(data->metadata_config_replied);
+=09=09data->metadata_qos_id =3D id;
+=09=09return;
+=09}
+
+=09g_assert_cmpuint(data->metadata_config_count, =3D=3D, 1);
+
+=09/* Reuse the actual configured ASE, setting internal need_reconfig. */
+=09data->metadata_stream =3D stream;
+=09bt_bap_foreach_pac(data->bap, bt_bap_stream_get_dir(stream),
+=09=09=09=09=09=09metadata_reuse_pac, data);
+=09g_assert(data->metadata_reused);
+=09id =3D bt_bap_stream_qos(stream, &data->cfg->qos, bap_qos, data);
+=09g_assert_cmpuint(id, =3D=3D, 0);
+
+=09id =3D bt_bap_stream_config(stream, &data->cfg->qos, &data->cfg->cc,
+=09=09=09=09=09=09metadata_config_response, data);
+=09g_assert(id);
+
+=09id =3D bt_bap_stream_metadata(stream, &metadata, NULL, NULL);
+=09g_assert_cmpuint(id, =3D=3D, 0);
+=09g_assert_cmpuint(data->metadata_config_count, =3D=3D, 1);
+
+=09cached =3D bt_bap_stream_get_metadata(stream);
+=09g_assert(cached);
+=09g_assert_cmpuint(cached->iov_len, =3D=3D, metadata.iov_len);
+=09g_assert(!memcmp(cached->iov_base, value, sizeof(value)));
+}
+
+static struct test_config cfg_snk_cc_metadata =3D {
+=09.cc =3D LC3_CONFIG_16_2,
+=09.qos =3D LC3_QOS_16_2_1,
+=09.snk =3D true,
+=09.state_func =3D state_cc_metadata,
+};
+
+static struct test_config cfg_src_cc_metadata =3D {
+=09.cc =3D LC3_CONFIG_16_2,
+=09.qos =3D LC3_QOS_16_2_1,
+=09.src =3D true,
+=09.state_func =3D state_cc_metadata,
+};
+
+#define SCC_SNK_CC_METADATA \
+=09SCC_SNK_16_2, \
+=09SCC_SNK(LC3_CODEC_ID_DATA, 0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, \
+=09=09=090x01, 0x03, 0x04, 0x28, 0x00), \
+=09QOS_SNK(0x10, 0x27, 0x00, 0x00, 0x02, 0x28, 0x00, 0x02, 0x0a, 0x00, \
+=09=090x40, 0x9c, 0x00), \
+=09ASE_SNK_RELEASE
+
+#define SCC_SRC_CC_METADATA \
+=09SCC_SRC_16_2, \
+=09SCC_SRC(LC3_CODEC_ID_DATA, 0x0a, 0x02, 0x01, 0x03, 0x02, 0x02, \
+=09=09=090x01, 0x03, 0x04, 0x28, 0x00), \
+=09QOS_SRC(0x10, 0x27, 0x00, 0x00, 0x02, 0x28, 0x00, 0x02, 0x0a, 0x00, \
+=09=090x40, 0x9c, 0x00), \
+=09ASE_SRC_RELEASE
+
 static void bap_metadata(struct bt_bap_stream *stream,
 =09=09=09=09=09uint8_t code, uint8_t reason,
 =09=09=09=09=09void *user_data)
@@ -4341,6 +4469,12 @@ static struct test_config cfg_src_metadata_streaming=
 =3D {
  */
 static void test_ucl_scc_metadata(void)
 {
+=09define_test("BAP/UCL/SCC/Metadata-Configured-Sink",
+=09=09=09test_setup, test_client, &cfg_snk_cc_metadata,
+=09=09=09SCC_SNK_CC_METADATA);
+=09define_test("BAP/UCL/SCC/Metadata-Configured-Source",
+=09=09=09test_setup, test_client, &cfg_src_cc_metadata,
+=09=09=09SCC_SRC_CC_METADATA);
 =09define_test("BAP/UCL/SCC/BV-115-C [UCL SNK Update Metadata in Enabling =
"
 =09=09=09"State]",
 =09=09=09test_setup, test_client, &cfg_src_metadata,
--=20
2.55.0


