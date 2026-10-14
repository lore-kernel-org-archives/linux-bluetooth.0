Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AC2931FB
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791955230; cv=none; b=dGnvvrqg9899A2SmSvCPpzmWL1Rl5GKY192kdcRNNrRXn7ouq77i+LeH5VDwmAoymNUR4ebdZjHQbNtocFirWvibqt8IOWf0UC2fSWPoWm1bUIsgP9uFpE8gdLD+Fyh/PG8BgWHWyNhodyapv+ZKSbDqTJrK+gmip3cFREI0LdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791955230; c=relaxed/simple;
	bh=afBs2UiEp97B3JFfbnDn+98D24CP5NF1UrdpN4SAA+k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JrsU2Pee3zW12opX2WJQzeAPn5Oh+TOLXUO2rBqrDaQi0UJbZhvGo8LjbWPPNiIZbrlaX4mi8Iboeq7rZQhJVyS7kj0FKGCF/8faVBKUjNpAdB6vVq+BpOcBMLoLnIiqyUKvPes9x0dKb5WFqFgX0M75qM8NLnp174ftRty7MuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NKBnJIY2; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NKBnJIY2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791955225; x=1792214425;
	bh=WDmxS6CHUbj0SiI1lZs7AAkvRZdgLPOBaS+NVOtvvqI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NKBnJIY2mVpCRtLzUrr7nA1XVqhJIA6+hFxOtfNM3gjjKJ71K0XnaW+dwB5fZ+50S
	 faxH3mXPWEt4ggpVASKRT9xuilcqDq0lNRwSJHRLTftGO+S7PhhS0CZshBW28PtpiH
	 3d6P17PwiFpiEw1U1eqinYSlGLE9XW6jytONTwRwvNJoQaEplWPbIRO4YK1BTeb9aL
	 2uaCIv4AqMnWYKi1lG2q1HO8/xpojx1vdQDY10WBPXo6vIP5a+65jxyUwY/wgeEU7F
	 zyqqDHbncVTzbLXEhbkjDUh2a3g/moJ43ZA5edx7fw0qQeyhg9Njw2upoDFzueEKf3
	 Vx7TpXztDt12Q==
Date: Wed, 14 Oct 2026 05:20:22 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC PATCH] mgmt-tester: Add host-resolved RPA scan checks
Message-ID: <20261014052008.413209-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 4aedb34c7cddf6214ad058d47ce347b5eb93466f
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Check unfiltered passive scanning for IRK peers on controllers without
LL Privacy, with auto-connect and background-report controls.

Assisted-by: OpenCode:gpt-6.1-sol
---
Companion to the kernel v2 "Bluetooth: hci_sync: scan unfiltered for
host-resolved RPAs", responding to Luiz's mgmt-tester request in:
https://lore.kernel.org/linux-bluetooth/20261013031329.483597-1-cochcoder@p=
roton.me/

This is the first submission of these BlueZ tests, not a v2 and not a
cross-project apply-order series. It applies independently on BlueZ
9dc7e40962f1. The IRK cases intentionally fail on an unfixed kernel.

Native results on bluetooth-next 609a23989d63, KASAN/lockdep enabled:
                                upstream   revised kernel
  Auto-connect with IRK           FAIL       PASS
  Background report with IRK      FAIL       PASS
  Auto-connect without IRK        PASS       PASS
  Background report without IRK   PASS       PASS

These assert passive-scan programming, not physical address rotation or
successful radio reconnect. On the complete 512-case mgmt run, upstream
has 503 pass/four fail/five not run; revision has 506 pass/one fail/five
not run. Both have the "Set Static Address - Success 2" timeout. The
upstream run also fails the two new IRK tests and the already-listed
flaky "LL Privacy - Set Flags 3 (2 Devices to RL)" test. The latter's
pass is not attributed to the RPA fix. No captured KASAN/lockdep alerts.

Maintainer-mode sanitizer build and 35/35 unit binaries pass. The
complete mgmt suite is not clean; no physical hardware test is claimed.

 tools/mgmt-tester.c | 119 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 992351e2e3..850d38e4ce 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -10667,6 +10667,114 @@ static const char load_irks_le_public_param_1[] =
=3D {
 =090x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
 };
=20
+static const uint8_t host_rpa_report_param[] =3D {
+=090x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
+=090x01,
+=090x00,
+};
+
+static const struct bt_hci_cmd_le_set_scan_parameters host_rpa_unfiltered =
=3D {
+=09.filter_policy =3D 0x00,
+};
+
+static const struct bt_hci_cmd_le_set_scan_parameters host_rpa_filtered =
=3D {
+=09.filter_policy =3D 0x01,
+};
+
+static int host_rpa_unfiltered_check(const void *param, uint16_t length)
+{
+=09const struct bt_hci_cmd_le_set_scan_parameters *cp =3D param;
+
+=09if (length !=3D sizeof(*cp))
+=09=09return -EINVAL;
+
+=09return cp->type !=3D 0x00 || cp->filter_policy !=3D 0x00;
+}
+
+static int host_rpa_filtered_check(const void *param, uint16_t length)
+{
+=09const struct bt_hci_cmd_le_set_scan_parameters *cp =3D param;
+
+=09if (length !=3D sizeof(*cp))
+=09=09return -EINVAL;
+
+=09return cp->type !=3D 0x00 || cp->filter_policy !=3D 0x01;
+}
+
+static const struct generic_data host_rpa_autoconnect =3D {
+=09.setup_settings =3D settings_powered_le,
+=09.setup_send_opcode =3D MGMT_OP_LOAD_IRKS,
+=09.setup_send_param =3D load_irks_le_public_param_1,
+=09.setup_send_len =3D sizeof(load_irks_le_public_param_1),
+=09.send_opcode =3D MGMT_OP_ADD_DEVICE,
+=09.send_param =3D add_device_le_public_param_1,
+=09.send_len =3D sizeof(add_device_le_public_param_1),
+=09.expect_param =3D add_device_rsp_le_public,
+=09.expect_len =3D sizeof(add_device_rsp_le_public),
+=09.expect_status =3D MGMT_STATUS_SUCCESS,
+=09.expect_alt_ev =3D MGMT_EV_DEVICE_ADDED,
+=09.expect_alt_ev_param =3D add_device_le_public_param_1,
+=09.expect_alt_ev_len =3D sizeof(add_device_le_public_param_1),
+=09.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
+=09.expect_hci_param =3D &host_rpa_unfiltered,
+=09.expect_hci_len =3D sizeof(host_rpa_unfiltered),
+=09.expect_hci_param_check_func =3D host_rpa_unfiltered_check,
+};
+
+static const struct generic_data host_rpa_report =3D {
+=09.setup_settings =3D settings_powered_le,
+=09.setup_send_opcode =3D MGMT_OP_LOAD_IRKS,
+=09.setup_send_param =3D load_irks_le_public_param_1,
+=09.setup_send_len =3D sizeof(load_irks_le_public_param_1),
+=09.send_opcode =3D MGMT_OP_ADD_DEVICE,
+=09.send_param =3D host_rpa_report_param,
+=09.send_len =3D sizeof(host_rpa_report_param),
+=09.expect_param =3D add_device_rsp_le_public,
+=09.expect_len =3D sizeof(add_device_rsp_le_public),
+=09.expect_status =3D MGMT_STATUS_SUCCESS,
+=09.expect_alt_ev =3D MGMT_EV_DEVICE_ADDED,
+=09.expect_alt_ev_param =3D host_rpa_report_param,
+=09.expect_alt_ev_len =3D sizeof(host_rpa_report_param),
+=09.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
+=09.expect_hci_param =3D &host_rpa_unfiltered,
+=09.expect_hci_len =3D sizeof(host_rpa_unfiltered),
+=09.expect_hci_param_check_func =3D host_rpa_unfiltered_check,
+};
+
+static const struct generic_data host_rpa_no_irk_autoconnect =3D {
+=09.setup_settings =3D settings_powered_le,
+=09.send_opcode =3D MGMT_OP_ADD_DEVICE,
+=09.send_param =3D add_device_le_public_param_1,
+=09.send_len =3D sizeof(add_device_le_public_param_1),
+=09.expect_param =3D add_device_rsp_le_public,
+=09.expect_len =3D sizeof(add_device_rsp_le_public),
+=09.expect_status =3D MGMT_STATUS_SUCCESS,
+=09.expect_alt_ev =3D MGMT_EV_DEVICE_ADDED,
+=09.expect_alt_ev_param =3D add_device_le_public_param_1,
+=09.expect_alt_ev_len =3D sizeof(add_device_le_public_param_1),
+=09.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
+=09.expect_hci_param =3D &host_rpa_filtered,
+=09.expect_hci_len =3D sizeof(host_rpa_filtered),
+=09.expect_hci_param_check_func =3D host_rpa_filtered_check,
+};
+
+static const struct generic_data host_rpa_no_irk_report =3D {
+=09.setup_settings =3D settings_powered_le,
+=09.send_opcode =3D MGMT_OP_ADD_DEVICE,
+=09.send_param =3D host_rpa_report_param,
+=09.send_len =3D sizeof(host_rpa_report_param),
+=09.expect_param =3D add_device_rsp_le_public,
+=09.expect_len =3D sizeof(add_device_rsp_le_public),
+=09.expect_status =3D MGMT_STATUS_SUCCESS,
+=09.expect_alt_ev =3D MGMT_EV_DEVICE_ADDED,
+=09.expect_alt_ev_param =3D host_rpa_report_param,
+=09.expect_alt_ev_len =3D sizeof(host_rpa_report_param),
+=09.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
+=09.expect_hci_param =3D &host_rpa_filtered,
+=09.expect_hci_len =3D sizeof(host_rpa_filtered),
+=09.expect_hci_param_check_func =3D host_rpa_filtered_check,
+};
+
 static const uint8_t add_device_le_public_param_2[] =3D {
 =090x11, 0x22, 0x33, 0x44, 0x55, 0x66,=09/* BDADDR */
 =090x01,=09=09=09=09=09/* Type - LE Public */
@@ -15737,6 +15845,17 @@ int main(int argc, char *argv[])
 =09=09=09=09&set_exp_feat_unknown,
 =09=09=09=09NULL, test_command_generic);
=20
+=09/* Bluetooth 4.0 has no controller-side address resolution. */
+=09test_bredrle("Host RPA - Auto-connect with IRK", &host_rpa_autoconnect,
+=09=09=09=09setup_command_generic, test_command_generic);
+=09test_bredrle("Host RPA - Background report with IRK", &host_rpa_report,
+=09=09=09=09setup_command_generic, test_command_generic);
+=09test_bredrle("Host RPA - Auto-connect without IRK",
+=09=09=09=09&host_rpa_no_irk_autoconnect, NULL,
+=09=09=09=09=09=09=09test_command_generic);
+=09test_bredrle("Host RPA - Background report without IRK",
+=09=09=09&host_rpa_no_irk_report, NULL, test_command_generic);
+
 =09/* LL Privacy
 =09 * Setup: Enable LE and Power On
 =09 * Run: Add new device

base-commit: 9dc7e40962f11d1d9a5568f8a7633a695288329c

