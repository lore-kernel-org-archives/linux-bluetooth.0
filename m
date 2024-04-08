Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6D219F0
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561582; cv=pass; b=DK0D1CiiUcErAoco0/9WTJrHEPEkmvMlp4RjKVIu4HRjLjOsHlPMdY52IT13g4WfbuNa9nHBsUEF5eqfgJho1Hx9u9zy3KuVPnEdB3VqnxEGNroeTGf+P0xKyFVKk46sKudyUPcxFleQ6t8KEzIYbYYPKFRi66duiunT9Ykxj/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561582; c=relaxed/simple;
	bh=LDw8sHRxFh2C/WVmlDKjziYZoIuaXCvhqLU4TXz2omU=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pnxBYv0XEfu3bKfs/S7mSEJrWZtZtiszHqv4g2+wMgoAAKHurXK2q/h2Sl2BfOTj6X6MUhBkgSXtIxT+DMHS0sJrvOcRDw4hHhEgePzj6MrH0NOOxEQ7QMjMbAMydxsVaP2y6y1xRemRt/phTEEiLoddtdvSEz//nY+JUltwwqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=c4VzIIg5; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="c4VzIIg5"
Received: from [127.0.0.1] (unknown [193.138.7.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VCgmL4rrHzySf
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 10:32:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712561570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIaVRtZjU/bvyCUCb8NBfTF54DKva3abiScu/64ObmY=;
	b=c4VzIIg5+09JlT8j43+4664xMjFdZaVHsTcdSC7ClGX+dwhZ8tb/1uJrDTmWdgkgeNSm19
	spVi6FtMW6IOCDL4ILnVdTcwNUsvtqTK3vaV2x2xnrXZRiLhAhTOc/dOS56CxPogtV9GSq
	YpxeXq8XDsfjRFpIs65EcAqogCdiiKk=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712561570; a=rsa-sha256; cv=none;
	b=tfrySNMys3HvsPATo9vDnfm2kZjtyLVU1/4owRcTjlzmRWI2lMvGOUqI1nxlWEi6DRPwxU
	keUfqriTG6ClvmpyUEeptpKQXO2B9/ghkhYNTSPqtXzUWEMrItVHxxRMmKT5PA9v4H+u62
	EKxcHFHEjrIB+eTqvrPGzBN0npius4M=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712561570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIaVRtZjU/bvyCUCb8NBfTF54DKva3abiScu/64ObmY=;
	b=bvzETr55PBMoRqpO6omjTzswuJlJPEftZVtuJd26/V0vtIjtMeI2ZRwXYKPYXUaIv1xXwo
	L13De5IVwyFlDECrmKMrQ1LYu8WRrP5A7HWZEZsHfVGY0N2wUzFD6EziW5tEx7jV4OClOI
	Z39wDcHDhBOWNIbKp3EdWm5S2YxpTTU=
Date: Mon, 08 Apr 2024 10:32:47 +0300
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/5] iso-tester: add test for BT_POLL_ERRQUEUE
User-Agent: K-9 Mail for Android
In-Reply-To: <1a56b2769c23485127587ab245b6b9e84cccdde3.1712503074.git.pav@iki.fi>
References: <cover.1712503073.git.pav@iki.fi> <1a56b2769c23485127587ab245b6b9e84cccdde3.1712503074.git.pav@iki.fi>
Message-ID: <8BB1BAC3-B082-4179-9310-A4DB377A347B@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



7=2E huhtikuuta 2024 18=2E18=2E37 GMT+03:00 Pauli Virtanen <pav@iki=2Efi> =
kirjoitti:
>Also test BT_POLL_ERRQUEUE is experimental feature=2E
>
>Add test:
>
>ISO Send - TX No Poll Timestamping
>---
> tools/iso-tester=2Ec | 124 ++++++++++++++++++++++++++++++++++++++++++++-
> tools/tester=2Eh     |   3 ++
> 2 files changed, 125 insertions(+), 2 deletions(-)
>
>diff --git a/tools/iso-tester=2Ec b/tools/iso-tester=2Ec
>index c29fedd1d=2E=2E046606068 100644
>--- a/tools/iso-tester=2Ec
>+++ b/tools/iso-tester=2Ec
>@@ -470,7 +470,7 @@ struct test_data {
> 	uint16_t handle;
> 	uint16_t acl_handle;
> 	struct queue *io_queue;
>-	unsigned int io_id[3];
>+	unsigned int io_id[4];
> 	uint8_t client_num;
> 	int step;
> 	bool reconnect;
>@@ -513,6 +513,9 @@ struct iso_client_data {
> 	 * Used for testing TX timestamping OPT_ID=2E
> 	 */
> 	unsigned int repeat_send;
>+
>+	/* Disable BT_POLL_ERRQUEUE before enabling TX timestamping */
>+	bool no_poll_errqueue;
> };
>=20
> typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *i=
o);
>@@ -648,6 +651,18 @@ static const uint8_t reset_iso_socket_param[] =3D {
> 	0x00,						/* Action - disable */
> };
>=20
>+static const uint8_t set_poll_errqueue_param[] =3D {
>+	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b, /* UUID */
>+	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
>+	0x01,						/* Action - enable */
>+};
>+
>+static const uint8_t reset_poll_errqueue_param[] =3D {
>+	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b, /* UUID */
>+	0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
>+	0x00,						/* Action - disable */
>+};
>+
> static void set_iso_socket_callback(uint8_t status, uint16_t length,
> 					const void *param, void *user_data)
> {
>@@ -659,9 +674,21 @@ static void set_iso_socket_callback(uint8_t status, =
uint16_t length,
> 	tester_print("ISO socket feature is enabled");
> }
>=20
>+static void set_poll_errqueue_callback(uint8_t status, uint16_t length,
>+					const void *param, void *user_data)
>+{
>+	if (status !=3D MGMT_STATUS_SUCCESS) {
>+		tester_print("Poll Errqueue feature could not be enabled");
>+		return;
>+	}
>+
>+	tester_print("Poll Errqueue feature is enabled");
>+}
>+
> static void test_pre_setup(const void *test_data)
> {
> 	struct test_data *data =3D tester_get_data();
>+	const struct iso_client_data *isodata =3D test_data;
>=20
> 	data->mgmt =3D mgmt_new_default();
> 	if (!data->mgmt) {
>@@ -677,6 +704,13 @@ static void test_pre_setup(const void *test_data)
> 		  sizeof(set_iso_socket_param), set_iso_socket_param,
> 		  set_iso_socket_callback, NULL, NULL);
>=20
>+	if (isodata && isodata->no_poll_errqueue) {
>+		mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
>+			  sizeof(set_poll_errqueue_param),
>+			  set_poll_errqueue_param,
>+			  set_poll_errqueue_callback, NULL, NULL);
>+	}
>+
> 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL=
,
> 					read_index_list_callback, NULL, NULL);
> }
>@@ -684,11 +718,19 @@ static void test_pre_setup(const void *test_data)
> static void test_post_teardown(const void *test_data)
> {
> 	struct test_data *data =3D tester_get_data();
>+	const struct iso_client_data *isodata =3D test_data;
>=20
> 	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
> 		  sizeof(reset_iso_socket_param), reset_iso_socket_param,
> 		  NULL, NULL, NULL);
>=20
>+	if (isodata && isodata->no_poll_errqueue) {
>+		mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
>+			  sizeof(reset_poll_errqueue_param),
>+			  reset_poll_errqueue_param,
>+			  NULL, NULL, NULL);
>+	}
>+
> 	hciemu_unref(data->hciemu);
> 	data->hciemu =3D NULL;
> }
>@@ -1044,6 +1086,16 @@ static const struct iso_client_data connect_send_t=
x_cmsg_timestamping =3D {
> 	=2Ecmsg_timestamping =3D true,
> };
>=20
>+static const struct iso_client_data connect_send_tx_no_poll_timestamping=
 =3D {
>+	=2Eqos =3D QOS_16_2_1,
>+	=2Eexpect_err =3D 0,
>+	=2Esend =3D &send_16_2_1,
>+	=2Eso_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
>+					SOF_TIMESTAMPING_TX_SOFTWARE),
>+	=2Erepeat_send =3D 1,
>+	=2Eno_poll_errqueue =3D true,
>+};
>+
> static const struct iso_client_data listen_16_2_1_recv =3D {
> 	=2Eqos =3D QOS_16_2_1,
> 	=2Eexpect_err =3D 0,
>@@ -2162,6 +2214,37 @@ static gboolean iso_recv_errqueue(GIOChannel *io, =
GIOCondition cond,
> 	return FALSE;
> }
>=20
>+static gboolean iso_fail_errqueue(GIOChannel *io, GIOCondition cond,
>+							gpointer user_data)
>+{
>+	struct test_data *data =3D user_data;
>+
>+	tester_warn("Unexpected POLLERR");
>+	tester_test_failed();
>+
>+	data->io_id[3] =3D 0;
>+	return FALSE;
>+}
>+
>+static gboolean iso_timer_errqueue(gpointer user_data)
>+{
>+	struct test_data *data =3D user_data;
>+	GIOChannel *io;
>+	gboolean ret;
>+
>+	io =3D queue_peek_head(data->io_queue);
>+	g_assert(io);
>+
>+	ret =3D iso_recv_errqueue(io, G_IO_IN, data);
>+	if (!ret) {
>+		if (data->io_id[3])
>+			g_source_remove(data->io_id[3]);
>+		data->io_id[3] =3D 0;
>+	}
>+
>+	return ret;
>+}
>+
> static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
> {
> 	const struct iso_client_data *isodata =3D data->test_data;
>@@ -2182,7 +2265,39 @@ static void iso_tx_timestamping(struct test_data *=
data, GIOChannel *io)
>=20
> 	sk =3D g_io_channel_unix_get_fd(io);
>=20
>-	data->io_id[2] =3D g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue, data=
);
>+	if (isodata->no_poll_errqueue) {
>+		uint32_t flag =3D 0;
>+
>+		err =3D setsockopt(sk, SOL_BLUETOOTH, BT_POLL_ERRQUEUE,
>+							&flag, sizeof(flag));
>+		if (err < 0) {
>+			tester_warn("setsockopt BT_POLL_ERRQUEUE: %s (%d)",
>+						strerror(errno), errno);
>+			tester_test_failed();
>+			return;
>+		}
>+
>+		if (!data->io_queue)
>+			data->io_queue =3D queue_new();
>+		queue_push_head(data->io_queue, g_io_channel_ref(io));
>+
>+		data->io_id[2] =3D g_timeout_add(100, iso_timer_errqueue, data);
>+		data->io_id[3] =3D g_io_add_watch(io, G_IO_ERR, iso_fail_errqueue,
>+									data);
>+	} else {
>+		uint32_t flag =3D 1;
>+
>+		err =3D setsockopt(sk, SOL_BLUETOOTH, BT_POLL_ERRQUEUE,
>+							&flag, sizeof(flag));
>+		if (err >=3D 0) {
>+			tester_warn("BT_POLL_ERRQUEUE available");
>+			tester_test_failed();
>+			return;
>+		}
>+
>+		data->io_id[2] =3D g_io_add_watch(io, G_IO_ERR, iso_recv_errqueue,
>+									data);
>+	}
>=20
> 	if (isodata->cmsg_timestamping)
> 		so &=3D ~SOF_TIMESTAMPING_TX_RECORD_MASK;
>@@ -3407,6 +3522,11 @@ int main(int argc, char *argv[])
> 			&connect_send_tx_cmsg_timestamping, setup_powered,
> 			test_connect);
>=20
>+	/* Test TX timestamping and disabling POLLERR wakeup */
>+	test_iso("ISO Send - TX No Poll Timestamping",
>+			&connect_send_tx_no_poll_timestamping, setup_powered,
>+			test_connect);
>+
> 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
> 							test_listen);
>=20
>diff --git a/tools/tester=2Eh b/tools/tester=2Eh
>index 617de842e=2E=2Eb6de084a4 100644
>--- a/tools/tester=2Eh
>+++ b/tools/tester=2Eh
>@@ -89,6 +89,9 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data =
*data, int sk, int len)
>=20
> 	ret =3D recvmsg(sk, &msg, MSG_ERRQUEUE);
> 	if (ret < 0) {
>+		if (ret =3D=3D EAGAIN || ret =3D=3D EWOULDBLOCK)

This should have been errno, not ret=2E

-> v2

>+			return data->count - data->pos;
>+
> 		tester_warn("Failed to read from errqueue: %s (%d)",
> 							strerror(errno), errno);
> 		return -EINVAL;
