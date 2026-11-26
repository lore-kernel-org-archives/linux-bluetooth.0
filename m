Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795652279;
	b=fcYJcmtQpA6M19Z5/sK6Cj0CyNDXZa05M3LM/pVt4JVcVRSK4XV7jWMkpqyhIifXPqYh
	 sIyaM3RGMBXz1cIv9tqty4fLKnEqP2vOXs34glUk0g021bgY+JlYYMh5Eo/sG+bSAfu1Q
	 dRTx/XDqPW12p91KbJ6aWHfDSBvLC+0drl5oLaJ/wjydBGODpkKOI8TVR1OGpxE79ZF1V
	 XuApHk6CdusRKwJD0F9JM+SpsNrpa96L8QoRMLJLiOgglpoWM45hRlmRKOgZXndov6BO8
	 poqbvrt2w+62Tmdp+fR6UFAXXGtvIr51UEGq9VmHEmdLxUFeA+Gyb0MxptWOjASfiKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795652279;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=cGyYjtdJLDPZe4O6i4XavUGd/lBFZH277wryqEVx55I=;
	b=IL7kPdPywlqu4G4oK2d1DssIXi1B9KGVla7O6gapIQ0282UFrpU5ikFkCiGeMzXKbklc
	 4Nv/N9/5FYa/T7gBarqOLMSyiBVkVa70i4Vjtgng8UTp+0n5dd2yhUMwM80toLRCpgMqJ
	 y0C8BacUGwwtD9EgX23Dzn7Ck5NKXLw9FYcjCvQo9pePJjLRItpK1kvL7UgVbys9CiCpI
	 Rpew08AOgHj8ENrS5skoCjPPru/TWJHgS1NYu8BZx2J/1gauW38i9mco3+uPZIliC2LuM
	 ZwUdRQbx7jIKiPbQKf28wkYAdDQYXmGi9798DnUUbzoPCvTFYA4GC8rZrePHcVJ/LZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="W/lFewgH";
	arc=none smtp.remote-ip=185.70.43.103
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B487606A323
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 00:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B487606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=W/lFewgH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795652275; x=1795911475;
	bh=cGyYjtdJLDPZe4O6i4XavUGd/lBFZH277wryqEVx55I=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W/lFewgHYmVNR+tT0HLjTfGUJm3e5/HyeOAoqFzhxSlOkbdcEeB0VLQ0eo9fYoUf9
	 XBISZReHNdYhjuuPh7/o6hPjA3CfQeikd1eoBMuBTmJT3UnwpXONzAl9miHjfksuQc
	 r7sZm4ZY2SFP8fg5p1iV7f4ymPNZFGsDy9R7TP0Mw8zYWmu6ouF25RDP4IdMtYbhf0
	 nOcrx5PRbR1t62cT6QYEkY3A0uDabBNE7/czy3iV8wLZU4K4cJCGT7ErpZozapDEjl
	 8ZZ935DH/LiRRAtHfOyEPo1/1IDGNJnQ1y99n34UpUYzaWubciMabWRIg7g6NgXMfX
	 P0GRXH+Lssk1w==
Date: Thu, 26 Nov 2026 00:17:49 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Subject: Re: [RFC PATCH BlueZ v4] l2cap-tester: Check compatible interval preferences
Message-ID: <2qA5MM8cgOoJxL_dqVBP1UFjp3NVMCWcucmjj94Yk3d0xkbBoBhIK0gIFdW_BlRHDEi3289S-GQB07UvxnVnnHciXNphOmlGwTTHWNX9yzE=@proton.me>
In-Reply-To: <e9181806a0382a9ed0312caaf39048c222476fc3.1795528108.git.cochcoder@proton.me>
References: <20261031181244.123461-1-cochcoder@proton.me> <20261031193734.189558-1-cochcoder@proton.me> <ee66ad17c264d1db6b42eb97d359f134817c6750.1795497229.git.cochcoder@proton.me> <e9181806a0382a9ed0312caaf39048c222476fc3.1795528108.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: c73e3e6d952650aef135ffd471c412f1f7573cd0
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

Hi,=20
Please consider this patch as withdrawen since the=20
patch it relied on has been withdrawen.
https://lore.kernel.org/linux-bluetooth/20261124140405.3096828-1-cochcoder@=
proton.me/=20
Thanks,
Kyle


On Tuesday, November 24th, 2026 at 8:51 AM, Kyle Pepper <cochcoder@proton.m=
e> wrote:

> Load local connection preferences and check the peer's L2CAP response
> and the resulting HCI Connection Update parameters. Cover overlapping
> and disjoint ranges, containment, a shared endpoint, and preservation
> of peer latency and timeout.
>=20
> Assisted-by: OpenCode:gpt-6.1-sol
> Assisted-by: Codex:GPT-6
> ---
> Previous version: https://lore.kernel.org/r/ee66ad17c264d1db6b42eb97d359f=
134817c6750.1795497229.git.cochcoder@proton.me
> CI report: https://github.com/bluez/bluez/pull/2892
>=20
> Changes since v3:
> - Wrap three lines to satisfy the 80-column CI check. No behavior change.
>=20
> Overlap cases require the companion Linux preference policy:
> https://lore.kernel.org/r/b6847b841127362e423b49f9e48118f97985865d.179549=
7229.git.cochcoder@proton.me
>=20
> Validation: whitespace-only comparison against v3 and source checkpatch
> with --max-line-length=3D80. V3 remote CI passed all eight other jobs.
> Fresh native interval/controller execution remains unavailable locally.
>=20
>  tools/l2cap-tester.c | 214 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 214 insertions(+)
>=20
> diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
> index 4d2c5cd..a17c67d 100644
> --- a/tools/l2cap-tester.c
> +++ b/tools/l2cap-tester.c
> @@ -59,6 +59,7 @@ struct test_data {
>  =09int step;
>  =09struct queue *io_channels;
>  =09struct tx_tstamp_data tx_ts;
> +=09unsigned int interval_events;
>  };
> =20
>  struct l2cap_conn_subrate {
> @@ -154,6 +155,7 @@ struct l2cap_data {
> =20
>  =09/* Change security level to this after connecting */
>  =09int change_sec_level;
> +=09const struct interval_test *interval;
>  };
> =20
>  static void print_debug(const char *str, void *user_data)
> @@ -4428,6 +4430,194 @@ done:
>  =09close(sk);
>  }
> =20
> +enum interval_event {
> +=09INTERVAL_EVENT_UPDATE =3D 0x01,
> +=09INTERVAL_EVENT_RESPONSE =3D 0x02,
> +};
> +
> +struct interval_test {
> +=09uint16_t local_min;
> +=09uint16_t local_max;
> +=09uint16_t peer_min;
> +=09uint16_t peer_max;
> +=09uint16_t expect_min;
> +=09uint16_t expect_max;
> +=09uint16_t peer_latency;
> +=09uint16_t peer_timeout;
> +};
> +
> +/* Local, peer and selected ranges (1.25 ms), peer latency, timeout (10 =
ms). */
> +static const struct interval_test interval_cases[] =3D {
> +=09{ 16, 16, 16, 24, 16, 16, 0, 600 },
> +=09{ 24, 40, 6, 6, 6, 6, 0, 600 },
> +=09{ 16, 24, 80, 160, 80, 160, 0, 600 },
> +=09{ 16, 16, 16, 16, 16, 16, 0, 600 },
> +=09{ 16, 32, 8, 24, 16, 24, 0, 600 },
> +=09{ 8, 24, 16, 32, 16, 24, 0, 600 },
> +=09{ 16, 24, 8, 32, 16, 24, 0, 600 },
> +=09{ 8, 32, 16, 24, 16, 24, 0, 600 },
> +=09{ 16, 24, 24, 32, 24, 24, 0, 600 },
> +=09{ 16, 16, 16, 24, 16, 16, 4, 200 },
> +};
> +
> +static const struct l2cap_data interval_data[] =3D {
> +=09{ .interval =3D &interval_cases[0] },
> +=09{ .interval =3D &interval_cases[1] },
> +=09{ .interval =3D &interval_cases[2] },
> +=09{ .interval =3D &interval_cases[3] },
> +=09{ .interval =3D &interval_cases[4] },
> +=09{ .interval =3D &interval_cases[5] },
> +=09{ .interval =3D &interval_cases[6] },
> +=09{ .interval =3D &interval_cases[7] },
> +=09{ .interval =3D &interval_cases[8] },
> +=09{ .interval =3D &interval_cases[9] },
> +};
> +
> +static void interval_complete(struct test_data *data, enum interval_even=
t event)
> +{
> +=09data->interval_events |=3D event;
> +
> +=09if (data->interval_events =3D=3D (INTERVAL_EVENT_UPDATE |
> +=09=09=09=09=09=09INTERVAL_EVENT_RESPONSE))
> +=09=09tester_test_passed();
> +}
> +
> +static void interval_command(uint16_t opcode, const void *param, uint8_t=
 len,
> +=09=09=09=09=09=09=09void *user_data)
> +{
> +=09struct test_data *data =3D user_data;
> +=09const struct l2cap_data *l2data =3D data->test_data;
> +=09const struct interval_test *test =3D l2data->interval;
> +=09const struct bt_hci_cmd_le_conn_update *cp =3D param;
> +
> +=09if (opcode !=3D BT_HCI_CMD_LE_CONN_UPDATE)
> +=09=09return;
> +
> +=09if (len !=3D sizeof(*cp)) {
> +=09=09tester_warn("Invalid LE Connection Update length %u", len);
> +=09=09tester_test_failed();
> +=09=09return;
> +=09}
> +
> +=09tester_print("LE update: interval %u-%u, latency %u, timeout %u",
> +=09=09=09get_le16(&cp->min_interval),
> +=09=09=09get_le16(&cp->max_interval),
> +=09=09=09get_le16(&cp->latency), get_le16(&cp->supv_timeout));
> +
> +=09if (get_le16(&cp->min_interval) !=3D test->expect_min ||
> +=09=09=09get_le16(&cp->max_interval) !=3D test->expect_max ||
> +=09=09=09get_le16(&cp->latency) !=3D test->peer_latency ||
> +=09=09=09get_le16(&cp->supv_timeout) !=3D test->peer_timeout) {
> +=09=09tester_warn("Expected interval %u-%u, latency %u, timeout %u",
> +=09=09=09=09test->expect_min, test->expect_max,
> +=09=09=09=09test->peer_latency, test->peer_timeout);
> +=09=09tester_test_failed();
> +=09=09return;
> +=09}
> +
> +=09interval_complete(data, INTERVAL_EVENT_UPDATE);
> +}
> +
> +static void interval_response(uint8_t code, const void *param, uint16_t =
len,
> +=09=09=09=09=09=09=09void *user_data)
> +{
> +=09struct test_data *data =3D user_data;
> +=09const struct bt_l2cap_pdu_conn_param_rsp *rsp =3D param;
> +
> +=09if (code !=3D BT_L2CAP_PDU_CONN_PARAM_RSP || len !=3D sizeof(*rsp) ||
> +=09=09=09=09=09=09get_le16(&rsp->result)) {
> +=09=09tester_warn("Connection Parameter Update was not accepted");
> +=09=09tester_test_failed();
> +=09=09return;
> +=09}
> +
> +=09interval_complete(data, INTERVAL_EVENT_RESPONSE);
> +}
> +
> +static void interval_connected(uint16_t handle, void *user_data)
> +{
> +=09struct test_data *data =3D user_data;
> +=09const struct l2cap_data *l2data =3D data->test_data;
> +=09const struct interval_test *test =3D l2data->interval;
> +=09struct bthost *host =3D hciemu_client_get_host(data->hciemu);
> +=09struct bt_l2cap_pdu_conn_param_req req =3D {
> +=09=09.min_interval =3D cpu_to_le16(test->peer_min),
> +=09=09.max_interval =3D cpu_to_le16(test->peer_max),
> +=09=09.latency =3D cpu_to_le16(test->peer_latency),
> +=09=09.timeout =3D cpu_to_le16(test->peer_timeout),
> +=09};
> +
> +=09if (!bthost_l2cap_req(host, handle, BT_L2CAP_PDU_CONN_PARAM_REQ,
> +=09=09=09=09&req, sizeof(req), interval_response, data))
> +=09=09tester_test_failed();
> +}
> +
> +static void interval_loaded(uint8_t status, uint16_t len, const void *pa=
ram,
> +=09=09=09=09=09=09=09void *user_data)
> +{
> +=09struct test_data *data =3D user_data;
> +=09struct bthost *host =3D hciemu_client_get_host(data->hciemu);
> +=09struct tester_io *io;
> +=09int sk;
> +
> +=09if (status) {
> +=09=09tester_warn("Could not load connection preferences");
> +=09=09tester_test_failed();
> +=09=09return;
> +=09}
> +
> +=09bthost_set_connect_cb(host, interval_connected, data);
> +=09bthost_add_l2cap_server(host, 0x0080, NULL, NULL, NULL);
> +
> +=09if (!hciemu_add_central_post_command_hook(data->hciemu,
> +=09=09=09=09=09=09interval_command, data)) {
> +=09=09tester_test_failed();
> +=09=09return;
> +=09}
> +
> +=09sk =3D create_l2cap_sock(data, 0, 0, 0, BT_MODE_LE_FLOWCTL);
> +
> +=09if (sk < 0) {
> +=09=09tester_test_failed();
> +=09=09return;
> +=09}
> +
> +=09if (connect_l2cap_sock(data, sk, 0x0080, 0) < 0) {
> +=09=09close(sk);
> +=09=09tester_test_failed();
> +=09=09return;
> +=09}
> +
> +=09io =3D tester_io_new(sk);
> +=09tester_io_set_close_on_unref(io, true);
> +=09data->io_channels =3D queue_new();
> +=09queue_push_tail(data->io_channels, io);
> +}
> +
> +static void test_interval_preferences(const void *test_data)
> +{
> +=09struct test_data *data =3D tester_get_data();
> +=09const struct l2cap_data *l2data =3D data->test_data;
> +=09const struct interval_test *test =3D l2data->interval;
> +=09uint8_t buf[sizeof(struct mgmt_cp_load_conn_param) +
> +=09=09=09=09=09=09sizeof(struct mgmt_conn_param)];
> +=09struct mgmt_cp_load_conn_param *cp =3D (void *) buf;
> +=09struct mgmt_conn_param *param =3D cp->params;
> +
> +=09memset(buf, 0, sizeof(buf));
> +=09cp->param_count =3D cpu_to_le16(1);
> +=09memcpy(&param->addr.bdaddr, hciemu_get_client_bdaddr(data->hciemu),
> +=09=09=09=09=09=09sizeof(param->addr.bdaddr));
> +=09param->addr.type =3D BDADDR_LE_PUBLIC;
> +=09param->min_interval =3D cpu_to_le16(test->local_min);
> +=09param->max_interval =3D cpu_to_le16(test->local_max);
> +=09param->timeout =3D cpu_to_le16(600);
> +
> +=09if (!mgmt_send(data->mgmt, MGMT_OP_LOAD_CONN_PARAM, data->mgmt_index,
> +=09=09=09=09sizeof(buf), buf, interval_loaded, data, NULL))
> +=09=09tester_test_failed();
> +}
> +
>  static void test_l2cap_ethtool_get_ts_info(const void *test_data)
>  {
>  =09struct test_data *data =3D tester_get_data();
> @@ -4439,6 +4629,30 @@ int main(int argc, char *argv[])
>  {
>  =09tester_init(&argc, &argv);
> =20
> +=09test_l2cap_le("L2CAP Interval - Prefer overlap", &interval_data[0],
> +=09=09=09setup_powered_client, test_interval_preferences);
> +=09test_l2cap_le("L2CAP Interval - Fast HID fallback", &interval_data[1]=
,
> +=09=09=09setup_powered_client, test_interval_preferences);
> +=09test_l2cap_le("L2CAP Interval - Slow idle fallback", &interval_data[2=
],
> +=09=09=09setup_powered_client, test_interval_preferences);
> +=09test_l2cap_le("L2CAP Interval - Exact match", &interval_data[3],
> +=09=09=09setup_powered_client, test_interval_preferences);
> +=09test_l2cap_le("L2CAP Interval - Lower overlap", &interval_data[4],
> +=09=09=09setup_powered_client, test_interval_preferences);
> +=09test_l2cap_le("L2CAP Interval - Upper overlap", &interval_data[5],
> +=09=09=09setup_powered_client, test_interval_preferences);
> +=09test_l2cap_le("L2CAP Interval - Local range contained",
> +=09=09=09&interval_data[6], setup_powered_client,
> +=09=09=09test_interval_preferences);
> +=09test_l2cap_le("L2CAP Interval - Peer range contained",
> +=09=09=09&interval_data[7], setup_powered_client,
> +=09=09=09test_interval_preferences);
> +=09test_l2cap_le("L2CAP Interval - Shared endpoint", &interval_data[8],
> +=09=09=09setup_powered_client, test_interval_preferences);
> +=09test_l2cap_le("L2CAP Interval - Preserve latency and timeout",
> +=09=09=09&interval_data[9], setup_powered_client,
> +=09=09=09test_interval_preferences);
> +
>  =09test_l2cap_bredr("Basic L2CAP Socket - Success", NULL,
>  =09=09=09=09=09setup_powered_client, test_basic);
>  =09test_l2cap_bredr("Non-connected getpeername - Failure", NULL,
>=20
> base-commit: 1608f836188610aabeff5a3164169ebe0360e443
> 
