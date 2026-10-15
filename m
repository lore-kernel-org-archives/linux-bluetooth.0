Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB022561A2
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 04:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039393; cv=none; b=QVOWgEwtIKQqax96kUQf8MV7seGnEzJ9k+YkrQtD8dVSf0PnnVgpKqXkypeiD1qZSsxcPFRN8Leg99WAzs/VO+410yIfXHbKuFXaqBiAqnegES2UHqpgwW6z8OqqLKrIgG6pWKq2XdyAZzpVGeyEBRgawNrkAQ9hrzjmXiXZV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039393; c=relaxed/simple;
	bh=6oymaU4R7mjtXFcGZmUK4dy5D9t+S1Sd2brjoHMiJsw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qGRISEUIcwYcYwFBYZQquqr1YriNFfbre/XwyI8l2f5m/+YxcitvbfskYWaGuQyGAx4AGfpAdfpTuwPoQVHrcDZUoyNC4qde2OkB5O2RiGcXjoEn//nEXoIpGGx+nFqSfqHCOLf83FTaUidjuN1rgZdgV/HG4YH84bQoH12kMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dD6i2dFE; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dD6i2dFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792039381; x=1792298581;
	bh=+tXR1g/pgnL+a/66q8VQaLlpEymkWb1T1+rOU7W851k=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dD6i2dFEYvHFegNbUTmIBlKxwPKv8aGq0YHBKBnD0HHwMr6Qgue+z1wr+XI1Z0CID
	 gbJsf5ZKv7AoNO+/eaiI1hR0Nj4PapAbQkW9Fst8MrxfCLMvPFIubr9m3b4Lmuo53E
	 bajFcgX6+Xfb5pR3ww1tjHmfCUldEXu+KwNuzj1gtoag9YzLOfqmZPgCPfrN+nQH/d
	 BwYN/Mz3ne7nls0PE0f+XN8HIIq7Iep3S1I453Pt6ypHc7AL7sMTBpBYBtEBwPAthQ
	 4EByw9b9SNHxOEq96Ao34dhkgzrpt7QhaR9KKW06SF3LiQ/A4zYg+zD3i2z44w3mEd
	 KE3h5AYrv3BvQ==
Date: Thu, 15 Oct 2026 04:42:56 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC PATCH] l2cap-tester: Check compatible interval preferences
Message-ID: <20261015044221.55631-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 7cd01854b29db44833ddb674e465065c1c1ac306
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Load local connection preferences and check both the peer's L2CAP
response and the resulting HCI Connection Update range. Cover overlap,
fast HID and slow idle fallback, and an exact-range control.

Assisted-by: OpenCode:gpt-6.1-sol
---
Companion Linux RFC v2:
https://lore.kernel.org/linux-bluetooth/20261015043336.47734-1-cochcoder@pr=
oton.me/

This standalone BlueZ test patch requires that Linux soft-preference change
for the overlap case to pass. It is independent of ASHA STATUS, STOP, the
stream gate and credit changes. It does not add a BlueZ runtime fix.

Each case loads local preferences through MGMT, sends a peer L2CAP paramete=
r
request, and checks both an accepted peer response and the selected HCI
Connection Update range. The cases cover overlap preference, fast HID and
slow idle outside the local preference, and an exact match.

Saved native controls:
- Unpatched kernel: 3/4, failing only the expected narrower-overlap selecti=
on.
- Strict-bound negative control: 2/4, rejecting the HID and idle requests.
- Soft-preference revision: 4/4; full reference-guest L2CAP suite 115/115,
  without skips or captured KASAN/lockdep alerts.

This standalone source also passes 35/35 ordinary unit binaries. The newer
combined Arch package port passes all four interval controls on the saved
soft-preference guest, but that package port is not this submission's sourc=
e.
No real-controller, firmware, acoustic, paired-device or remote-CI claim is
made for this standalone test patch. Archive rendering of the Linux link ha=
s
not been independently verified; confirm the thread before sending.

 tools/l2cap-tester.c | 159 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index f2d3e56b87..a4701071e7 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -54,6 +54,7 @@ struct test_data {
 =09int step;
 =09struct queue *io_channels;
 =09struct tx_tstamp_data tx_ts;
+=09unsigned int interval_events;
 };
=20
 struct l2cap_conn_subrate {
@@ -132,6 +133,7 @@ struct l2cap_data {
=20
 =09/* Change security level to this after connecting */
 =09int change_sec_level;
+=09const struct interval_test *interval;
 };
=20
 static void print_debug(const char *str, void *user_data)
@@ -3497,6 +3499,154 @@ done:
 =09close(sk);
 }
=20
+struct interval_test {
+=09uint16_t local_min;
+=09uint16_t local_max;
+=09uint16_t peer_min;
+=09uint16_t peer_max;
+=09uint16_t expect_min;
+=09uint16_t expect_max;
+};
+
+static const struct interval_test interval_cases[] =3D {
+=09{ 16, 16, 16, 24, 16, 16 },
+=09{ 24, 40, 6, 6, 6, 6 },
+=09{ 16, 24, 80, 160, 80, 160 },
+=09{ 16, 16, 16, 16, 16, 16 },
+};
+
+static const struct l2cap_data interval_data[] =3D {
+=09{ .interval =3D &interval_cases[0] },
+=09{ .interval =3D &interval_cases[1] },
+=09{ .interval =3D &interval_cases[2] },
+=09{ .interval =3D &interval_cases[3] },
+};
+
+static void interval_complete(struct test_data *data, unsigned int event)
+{
+=09data->interval_events |=3D event;
+
+=09if (data->interval_events =3D=3D 3)
+=09=09tester_test_passed();
+}
+
+static void interval_command(uint16_t opcode, const void *param, uint8_t l=
en,
+=09=09=09=09=09=09=09void *user_data)
+{
+=09struct test_data *data =3D user_data;
+=09const struct l2cap_data *l2data =3D data->test_data;
+=09const struct interval_test *test =3D l2data->interval;
+=09const struct bt_hci_cmd_le_conn_update *cp =3D param;
+
+=09if (opcode !=3D BT_HCI_CMD_LE_CONN_UPDATE)
+=09=09return;
+
+=09if (len !=3D sizeof(*cp) ||
+=09=09=09get_le16(&cp->min_interval) !=3D test->expect_min ||
+=09=09=09get_le16(&cp->max_interval) !=3D test->expect_max ||
+=09=09=09get_le16(&cp->latency) ||
+=09=09=09get_le16(&cp->supv_timeout) !=3D 600) {
+=09=09tester_warn("Unexpected LE Connection Update parameters");
+=09=09tester_test_failed();
+=09=09return;
+=09}
+
+=09interval_complete(data, 1);
+}
+
+static void interval_response(uint8_t code, const void *param, uint16_t le=
n,
+=09=09=09=09=09=09=09void *user_data)
+{
+=09struct test_data *data =3D user_data;
+
+=09if (code !=3D 0x13 || len !=3D 2 || get_le16(param)) {
+=09=09tester_warn("Connection Parameter Update was not accepted");
+=09=09tester_test_failed();
+=09=09return;
+=09}
+
+=09interval_complete(data, 2);
+}
+
+static void interval_connected(uint16_t handle, void *user_data)
+{
+=09struct test_data *data =3D user_data;
+=09const struct l2cap_data *l2data =3D data->test_data;
+=09const struct interval_test *test =3D l2data->interval;
+=09struct bthost *host =3D hciemu_client_get_host(data->hciemu);
+=09uint8_t request[8];
+
+=09put_le16(test->peer_min, request);
+=09put_le16(test->peer_max, request + 2);
+=09put_le16(0, request + 4);
+=09put_le16(600, request + 6);
+
+=09if (!bthost_l2cap_req(host, handle, 0x12, request, sizeof(request),
+=09=09=09=09=09=09interval_response, data))
+=09=09tester_test_failed();
+}
+
+static void interval_loaded(uint8_t status, uint16_t len, const void *para=
m,
+=09=09=09=09=09=09=09void *user_data)
+{
+=09struct test_data *data =3D user_data;
+=09struct bthost *host =3D hciemu_client_get_host(data->hciemu);
+=09GIOChannel *io;
+=09int sk;
+
+=09if (status) {
+=09=09tester_warn("Could not load connection preferences");
+=09=09tester_test_failed();
+=09=09return;
+=09}
+
+=09bthost_set_connect_cb(host, interval_connected, data);
+=09bthost_add_l2cap_server(host, 0x0080, NULL, NULL, NULL);
+=09hciemu_add_central_post_command_hook(data->hciemu,
+=09=09=09=09=09=09interval_command, data);
+=09sk =3D create_l2cap_sock(data, 0, 0, 0, BT_MODE_LE_FLOWCTL);
+
+=09if (sk < 0) {
+=09=09tester_test_failed();
+=09=09return;
+=09}
+
+=09if (connect_l2cap_sock(data, sk, 0x0080, 0) < 0) {
+=09=09close(sk);
+=09=09tester_test_failed();
+=09=09return;
+=09}
+
+=09io =3D g_io_channel_unix_new(sk);
+=09g_io_channel_set_close_on_unref(io, TRUE);
+=09data->io_channels =3D queue_new();
+=09queue_push_tail(data->io_channels, io);
+}
+
+static void test_interval_preferences(const void *test_data)
+{
+=09struct test_data *data =3D tester_get_data();
+=09const struct l2cap_data *l2data =3D data->test_data;
+=09const struct interval_test *test =3D l2data->interval;
+=09uint8_t buf[sizeof(struct mgmt_cp_load_conn_param) +
+=09=09=09=09=09=09sizeof(struct mgmt_conn_param)];
+=09struct mgmt_cp_load_conn_param *cp =3D (void *) buf;
+=09struct mgmt_conn_param *param =3D cp->params;
+
+=09memset(buf, 0, sizeof(buf));
+=09cp->param_count =3D cpu_to_le16(1);
+=09memcpy(&param->addr.bdaddr,
+=09=09=09hciemu_get_client_bdaddr(data->hciemu), 6);
+=09param->addr.type =3D BDADDR_LE_PUBLIC;
+=09param->min_interval =3D cpu_to_le16(test->local_min);
+=09param->max_interval =3D cpu_to_le16(test->local_max);
+=09param->timeout =3D cpu_to_le16(600);
+
+=09if (!mgmt_send(data->mgmt, MGMT_OP_LOAD_CONN_PARAM, data->mgmt_index,
+=09=09=09=09sizeof(buf), buf, interval_loaded, data, NULL))
+=09=09tester_test_failed();
+}
+
 static void test_l2cap_ethtool_get_ts_info(const void *test_data)
 {
 =09struct test_data *data =3D tester_get_data();
@@ -3508,6 +3658,15 @@ int main(int argc, char *argv[])
 {
 =09tester_init(&argc, &argv);
=20
+=09test_l2cap_le("L2CAP Interval - Prefer overlap", &interval_data[0],
+=09=09=09setup_powered_client, test_interval_preferences);
+=09test_l2cap_le("L2CAP Interval - Fast HID fallback", &interval_data[1],
+=09=09=09setup_powered_client, test_interval_preferences);
+=09test_l2cap_le("L2CAP Interval - Slow idle fallback", &interval_data[2],
+=09=09=09setup_powered_client, test_interval_preferences);
+=09test_l2cap_le("L2CAP Interval - Exact match", &interval_data[3],
+=09=09=09setup_powered_client, test_interval_preferences);
+
 =09test_l2cap_bredr("Basic L2CAP Socket - Success", NULL,
 =09=09=09=09=09setup_powered_client, test_basic);
 =09test_l2cap_bredr("Non-connected getpeername - Failure", NULL,

base-commit: dd9d5ba1fa4f682b082b1275a8c38523d95a58fd

