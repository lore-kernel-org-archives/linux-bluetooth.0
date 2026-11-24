Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497849;
	b=Kn6RMbA8uHLDyYvOX79nV08VcOpJAw/yc47vsylGBDz1wGvBUG4DG7ey38Mm9ahtrgO7
	 wGWZKgyPj87eQXa71H5NCbPQRIMFot6XVL4dmRDiULJ7r70jBDOzgRKVLV5S2IHqlyRRL
	 q1YM9qS3GQlCJ+Uy9oCgtp3YS9o7fzjHvyr/ltxKMQswiPhTA0jfcuOQV48FAId0HwBQG
	 FAL6/DoEaIK8d2Zt3twA+WXzYEuMdRRkiz3t61wrOmpXgNlwU8oJkpU+TKLFT73m50/Oy
	 UY6TKYXW5b4sAr1Agibg+1gpUc47Jy/rWx1LFH8JgeY/t3lB5Yxx/aoQeWafCxqAEeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497849;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=mbaD/pWtmj7iDTCxyqw2wtl+ZcsD8CZAwGKqPfoEaI8=;
	b=oUBpuEdF8lKRJIbSpAgpD/PTuOFwKJBq3EL7XVwqvjLnoa+Dxn13BTn3cM5zjBougfJZ
	 LE3siV0IjUNvYSBwqyuk0o7XDUvlPx/YFYmW2mTBq5Exi+fy1jeb1dbKHzNytOMl7wcdr
	 JeJlStll498k1M47ruTabeGkmZpoK2iicRVi1bznuus7MSYtmW/j/XZn9ZUoqDRd6cbAz
	 yOUzkU3NwVaX55FjlX+7lE/fDu//JBZprO2wqkoXeSf06N1o29xo9r0VGpo3r8kuPg91i
	 3/6fJ85s2ONn5k7tvUw/SPOPa2xCMA6xYAKgs6SbmmMghwRLcMYC6oWxLXtXvmc3lbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=gsDjIUIC;
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E1606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F3E1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=gsDjIUIC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795497847; x=1795757047;
	bh=mbaD/pWtmj7iDTCxyqw2wtl+ZcsD8CZAwGKqPfoEaI8=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gsDjIUICpTfPWEe9HrGVjqPTLAC9IZ14inLG69+HQcfkYtK9S/j+aQr7lj57BX28d
	 jSRfurHt0UXQsXcpZersRe2oJ0dQ84W7Nby8orwyM8XapdwgSXj4lcKp3s4aWLSnEU
	 s2qYV/ssGIYcswtr6P9stZHf4cQA5U80M3C8v1PUi1RfToff4mzKFal1/XrqO8gXDo
	 rGa9RqUMsjxzuJ8rSOBKf8Af4hE75tmiFvZBs+BiNkvjVGvv4Y6lGJtJXVpR35iGxg
	 sHM6H4xGWvAEyD4PY5X+OgvloUH2MVA5u5PnDpD2LCg/Zbqu2i7jdhEWV3SPqtry2u
	 DvBNfn+Fkwpjw==
Date: Tue, 24 Nov 2026 05:24:03 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v3] l2cap-tester: Check compatible interval preferences
Message-ID: <ee66ad17c264d1db6b42eb97d359f134817c6750.1795497229.git.cochcoder@proton.me>
In-Reply-To: <20261031193734.189558-1-cochcoder@proton.me>
References: <20261031181244.123461-1-cochcoder@proton.me> <20261031193734.189558-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 6c53360255855811ab171c2fbbca55ca29553664
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

Load local connection preferences and check the peer's L2CAP response
and the resulting HCI Connection Update parameters. Cover overlapping
and disjoint ranges, containment, a shared endpoint, and preservation
of peer latency and timeout.

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:GPT-6
---
Previous version: https://lore.kernel.org/r/20261031193734.189558-1-cochcod=
er@proton.me

Changes since v2:
- Cover asymmetric overlap, containment, endpoint contact, and peer
  latency/timeout preservation with ten cases.
- Use typed packets, named events, checked hook setup and diagnostics.

Overlap cases require the companion Linux preference policy:
https://lore.kernel.org/r/b6847b841127362e423b49f9e48118f97985865d.17954972=
29.git.cochcoder@proton.me
(Submitted alongside this RFC; archive receipt is not yet verified.)

Validation:
- GCC/Clang ASan+UBSan: 397,723 source-extracted kernel parameter
  cases, framing/role and rejection controls; 310 tester callback controls.
- GCC/Clang W=3D1 kernel object builds; BlueZ GCC build and make check
  (35/35); ten interval cases register.
Fresh native interval/VM/controller runs are unavailable on this host.
The callback fixtures mock peer I/O and reporting; they do not replace
native integration testing. Remote CI and interoperability remain open.

The stock mail checker rejects the required Assisted-by tag format;
source-only checkpatch passes. Attribution is retained.

AI assistance: source review, test coverage, simplification and wording.

 tools/l2cap-tester.c | 211 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 4d2c5cd..1a1f587 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -59,6 +59,7 @@ struct test_data {
 =09int step;
 =09struct queue *io_channels;
 =09struct tx_tstamp_data tx_ts;
+=09unsigned int interval_events;
 };
=20
 struct l2cap_conn_subrate {
@@ -154,6 +155,7 @@ struct l2cap_data {
=20
 =09/* Change security level to this after connecting */
 =09int change_sec_level;
+=09const struct interval_test *interval;
 };
=20
 static void print_debug(const char *str, void *user_data)
@@ -4428,6 +4430,193 @@ done:
 =09close(sk);
 }
=20
+enum interval_event {
+=09INTERVAL_EVENT_UPDATE =3D 0x01,
+=09INTERVAL_EVENT_RESPONSE =3D 0x02,
+};
+
+struct interval_test {
+=09uint16_t local_min;
+=09uint16_t local_max;
+=09uint16_t peer_min;
+=09uint16_t peer_max;
+=09uint16_t expect_min;
+=09uint16_t expect_max;
+=09uint16_t peer_latency;
+=09uint16_t peer_timeout;
+};
+
+/* Local, peer and selected ranges (1.25 ms), peer latency, timeout (10 ms=
). */
+static const struct interval_test interval_cases[] =3D {
+=09{ 16, 16, 16, 24, 16, 16, 0, 600 },
+=09{ 24, 40, 6, 6, 6, 6, 0, 600 },
+=09{ 16, 24, 80, 160, 80, 160, 0, 600 },
+=09{ 16, 16, 16, 16, 16, 16, 0, 600 },
+=09{ 16, 32, 8, 24, 16, 24, 0, 600 },
+=09{ 8, 24, 16, 32, 16, 24, 0, 600 },
+=09{ 16, 24, 8, 32, 16, 24, 0, 600 },
+=09{ 8, 32, 16, 24, 16, 24, 0, 600 },
+=09{ 16, 24, 24, 32, 24, 24, 0, 600 },
+=09{ 16, 16, 16, 24, 16, 16, 4, 200 },
+};
+
+static const struct l2cap_data interval_data[] =3D {
+=09{ .interval =3D &interval_cases[0] },
+=09{ .interval =3D &interval_cases[1] },
+=09{ .interval =3D &interval_cases[2] },
+=09{ .interval =3D &interval_cases[3] },
+=09{ .interval =3D &interval_cases[4] },
+=09{ .interval =3D &interval_cases[5] },
+=09{ .interval =3D &interval_cases[6] },
+=09{ .interval =3D &interval_cases[7] },
+=09{ .interval =3D &interval_cases[8] },
+=09{ .interval =3D &interval_cases[9] },
+};
+
+static void interval_complete(struct test_data *data, enum interval_event =
event)
+{
+=09data->interval_events |=3D event;
+
+=09if (data->interval_events =3D=3D (INTERVAL_EVENT_UPDATE |
+=09=09=09=09=09=09INTERVAL_EVENT_RESPONSE))
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
+=09if (len !=3D sizeof(*cp)) {
+=09=09tester_warn("Invalid LE Connection Update length %u", len);
+=09=09tester_test_failed();
+=09=09return;
+=09}
+
+=09tester_print("LE update: interval %u-%u, latency %u, timeout %u",
+=09=09=09get_le16(&cp->min_interval), get_le16(&cp->max_interval),
+=09=09=09get_le16(&cp->latency), get_le16(&cp->supv_timeout));
+
+=09if (get_le16(&cp->min_interval) !=3D test->expect_min ||
+=09=09=09get_le16(&cp->max_interval) !=3D test->expect_max ||
+=09=09=09get_le16(&cp->latency) !=3D test->peer_latency ||
+=09=09=09get_le16(&cp->supv_timeout) !=3D test->peer_timeout) {
+=09=09tester_warn("Expected interval %u-%u, latency %u, timeout %u",
+=09=09=09=09test->expect_min, test->expect_max,
+=09=09=09=09test->peer_latency, test->peer_timeout);
+=09=09tester_test_failed();
+=09=09return;
+=09}
+
+=09interval_complete(data, INTERVAL_EVENT_UPDATE);
+}
+
+static void interval_response(uint8_t code, const void *param, uint16_t le=
n,
+=09=09=09=09=09=09=09void *user_data)
+{
+=09struct test_data *data =3D user_data;
+=09const struct bt_l2cap_pdu_conn_param_rsp *rsp =3D param;
+
+=09if (code !=3D BT_L2CAP_PDU_CONN_PARAM_RSP || len !=3D sizeof(*rsp) ||
+=09=09=09=09=09=09get_le16(&rsp->result)) {
+=09=09tester_warn("Connection Parameter Update was not accepted");
+=09=09tester_test_failed();
+=09=09return;
+=09}
+
+=09interval_complete(data, INTERVAL_EVENT_RESPONSE);
+}
+
+static void interval_connected(uint16_t handle, void *user_data)
+{
+=09struct test_data *data =3D user_data;
+=09const struct l2cap_data *l2data =3D data->test_data;
+=09const struct interval_test *test =3D l2data->interval;
+=09struct bthost *host =3D hciemu_client_get_host(data->hciemu);
+=09struct bt_l2cap_pdu_conn_param_req req =3D {
+=09=09.min_interval =3D cpu_to_le16(test->peer_min),
+=09=09.max_interval =3D cpu_to_le16(test->peer_max),
+=09=09.latency =3D cpu_to_le16(test->peer_latency),
+=09=09.timeout =3D cpu_to_le16(test->peer_timeout),
+=09};
+
+=09if (!bthost_l2cap_req(host, handle, BT_L2CAP_PDU_CONN_PARAM_REQ,
+=09=09=09=09&req, sizeof(req), interval_response, data))
+=09=09tester_test_failed();
+}
+
+static void interval_loaded(uint8_t status, uint16_t len, const void *para=
m,
+=09=09=09=09=09=09=09void *user_data)
+{
+=09struct test_data *data =3D user_data;
+=09struct bthost *host =3D hciemu_client_get_host(data->hciemu);
+=09struct tester_io *io;
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
+
+=09if (!hciemu_add_central_post_command_hook(data->hciemu,
+=09=09=09=09=09=09interval_command, data)) {
+=09=09tester_test_failed();
+=09=09return;
+=09}
+
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
+=09io =3D tester_io_new(sk);
+=09tester_io_set_close_on_unref(io, true);
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
+=09memcpy(&param->addr.bdaddr, hciemu_get_client_bdaddr(data->hciemu),
+=09=09=09=09=09=09sizeof(param->addr.bdaddr));
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
@@ -4439,6 +4628,28 @@ int main(int argc, char *argv[])
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
+=09test_l2cap_le("L2CAP Interval - Lower overlap", &interval_data[4],
+=09=09=09setup_powered_client, test_interval_preferences);
+=09test_l2cap_le("L2CAP Interval - Upper overlap", &interval_data[5],
+=09=09=09setup_powered_client, test_interval_preferences);
+=09test_l2cap_le("L2CAP Interval - Local range contained", &interval_data[=
6],
+=09=09=09setup_powered_client, test_interval_preferences);
+=09test_l2cap_le("L2CAP Interval - Peer range contained", &interval_data[7=
],
+=09=09=09setup_powered_client, test_interval_preferences);
+=09test_l2cap_le("L2CAP Interval - Shared endpoint", &interval_data[8],
+=09=09=09setup_powered_client, test_interval_preferences);
+=09test_l2cap_le("L2CAP Interval - Preserve latency and timeout",
+=09=09=09&interval_data[9], setup_powered_client,
+=09=09=09test_interval_preferences);
+
 =09test_l2cap_bredr("Basic L2CAP Socket - Success", NULL,
 =09=09=09=09=09setup_powered_client, test_basic);
 =09test_l2cap_bredr("Non-connected getpeername - Failure", NULL,

base-commit: 1608f836188610aabeff5a3164169ebe0360e443

