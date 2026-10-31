Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475474;
	b=uEHt7613Rd0HNavZFNezGZg64IPpWDBLaLZYB0D90NhZIyOxK8B32AIxnHYJwEtZUOtf
	 qKXHnViyFWC+SW9kGs/xS0fG/3+U4o2VkVbRN6c9kVMEusF0QUtVR6UqKm7ChDxrGjAPl
	 CugAiuPEjiDKt6cZv10DQobmPB4gxY0lUdSg+p1j7nXk3Xo6MNmODDhl+zl0NT/aJjQkz
	 1DJVjHKJdlJmVnSM6OsWbBw5SLw2lPbNeYAt0vwfibyg35UNimzvom0oxzDf5h/lXVb4L
	 z7jcQmfH8a1XPtIqVPBBiQYVCEgGrsNUM3vKgrwYfY5ohZimnBZVWDUhYNznMdevq8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475474;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=AqX/71I3BVkJ2bhUJCuwzhp3QhME4/sK76PTNFIp4xs=;
	b=xIYMLmLD3jdlWbomRVWoXG00qOyjLckSVtX9XyxZK3L4YEJA2mt9sA2Yh3a8slnPfNx7
	 an8pnLIydBZdhhx/c2EEIPlZ+aY2uwfwLu5so5Q3dogunvOTnJOosBqKhH+oHl8qJ36+P
	 OuriUGfJVCm6i4dbaMpPjNYnroAA9AehZ0YRVR7eWam/8GCeSVyE8NiKg7br0eYfXs6vO
	 8EBUFQwG99WDDdfJ3F8gEZpDrvzy1tyX/4b2nMBP1XjjIVSCg7wIvJDDg5zgxi/8GTuKk
	 LXdwSMMsM1ZEMaIT7jBPKW0Xtvi6y3QMKfz5tk5zEg27fCvCeklbOrFijZulsLuxySA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=z6a6pao3p5b6rp2fohianifacu.protonmail2 header.b=sivJMMIE;
	arc=none smtp.remote-ip=109.224.244.18
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B44606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 19:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1B44606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=z6a6pao3p5b6rp2fohianifacu.protonmail2 header.b=sivJMMIE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=z6a6pao3p5b6rp2fohianifacu.protonmail2; t=1793475469;
	x=1793734669; bh=AqX/71I3BVkJ2bhUJCuwzhp3QhME4/sK76PTNFIp4xs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sivJMMIE00k7jQ97Z0zwaIpGoPGOYfoV5mqZ9zMiJFuZzaoKhSfbX8wOZcEc/wtV1
	 qdhIkQFO9qoGieU0uDlP97JVyGdJdvouMkuX3e7yo98lSYsUKYuXlQVx4xdRRz6rhE
	 QN9kuJevnnjA2Cxv1MRTAZ4D30D+bwfzYSL51d3gkxmQsNELYQs7jBdEhhOCNBegJ2
	 GCxs0Pa4thkpHhQ88qPmlqiu5II06sk4c5j2DrnJ2cFCzeb9lQ2Fzk/YQhs6f+fwTZ
	 L4aZwlQoZaIOE0nBi/kmjXmgrkrZcyw+UlpCBBkx/l5igfUIaEAZFl9yNdkuVv8qu0
	 bY6aYRZu92fgA==
Date: Sat, 31 Oct 2026 19:37:45 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC PATCH v2] l2cap-tester: Check compatible interval preferences
Message-ID: <20261031193734.189558-1-cochcoder@proton.me>
In-Reply-To: <20261031181244.123461-1-cochcoder@proton.me>
References: <20261031181244.123461-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 23331e5f59f54bf2d6eff25cdab65ee4bf42bce3
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

Load local connection preferences and check both the peer's L2CAP
response and the resulting HCI Connection Update range. Cover overlap,
fast HID and slow idle fallback, and an exact-range control.

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:GPT-6
---
Changes in v2:
- Use the tester I/O wrapper introduced since the original test was written=
.
- Wrap the long note reported by GitLint.

Companion Linux RFC v3:
https://lore.kernel.org/r/20261015181041.42873-1-cochcoder@proton.me

The overlap test requires the Linux soft-preference RFC. Its acceptance is
not established. With the earlier test source, the saved guest controls
passed 4/4 on that RFC, 3/4 on the unpatched kernel, and 2/4 with a strict
intersection control. The full guest L2CAP suite passed 115/115 with the
soft-preference kernel. These results predate the tester I/O conversion.

On BlueZ master 14bd6ab65f4a, this revision builds with bundled and externa=
l
ELL, passes all 35 ordinary unit tests, and passes checkpatch. A socketpair
control verifies that the tester wrapper keeps the socket until queue teard=
own.
The revised native interval tests have not been rerun: the saved guest pani=
cs
at init without KVM in this environment. No real-controller testing is clai=
med.

 tools/l2cap-tester.c | 159 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 4002ca5..758aeba 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -56,6 +56,7 @@ struct test_data {
 =09int step;
 =09struct queue *io_channels;
 =09struct tx_tstamp_data tx_ts;
+=09unsigned int interval_events;
 };
=20
 struct l2cap_conn_subrate {
@@ -134,6 +135,7 @@ struct l2cap_data {
=20
 =09/* Change security level to this after connecting */
 =09int change_sec_level;
+=09const struct interval_test *interval;
 };
=20
 static void print_debug(const char *str, void *user_data)
@@ -3522,6 +3524,154 @@ done:
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
@@ -3533,6 +3683,15 @@ int main(int argc, char *argv[])
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
--=20
2.56.0


