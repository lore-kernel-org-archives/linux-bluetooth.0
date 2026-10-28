Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196350;
	b=myBy+GGODzpK63qGY5yo+nrEgerRfnt1CVssKw/g8gk3XRLIC11bm3pvYiGHwbVQ+XCH
	 NVmVd93UGtcjfqE3J4f2SBf00PzTwgdVjmX9n+NiSrp85d4b5vsNGW3CoPx730EbJUWny
	 eqDYHl/t8bRoIekINevc2AAqZikO4aowJQ/0yOoD72MJQZXNNqObnKvHcFsrw86hxQ0B+
	 5LJxRto5zT4I8mypruVEKUK6XhTFlBzNRbkiva71/Qzh4Ym1ZmQIe3XNY0+3Aq1KEHbN8
	 HbXJnv+3OS9kMED2FXyD8uyw0MxckZidLl2XirAoqloTH5BsYmi6d6Ij37UbTiyUOtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196350;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=O1/J+kaNShq80w9shHctpBGI4lPnDdN0hctLUNkIl5g=;
	b=d2ls14vwKVd3ca4rwB496gM+75RsQS9w1Jhil+Nks3nQuiLVVAZGy8zkfIm3fW+vQ2Xg
	 kzOAqurBnsae/owkP4e3WmfQd4bUisqyN0mqQHF9fEt5GRKQHpXEbR3ALL1gUeyHxUVhS
	 yRX3dHcNoDReDDgde9qnbleD6cOnDvUssJKu5HCaMg1e6NLIyO/W6SaxpZ1nGTJPmTR/W
	 F2Ikmm7N1zog1iOKYn0bviDcGs84SH4kUNWn4MpJz5964VtnnZepfjzmyHtbXGLATHaKm
	 ogkoykKL+jJNjo7Hv7ZVjRUFwKkV/1rA9Y5IjYTUm99emznbfJSeirzV4nL9iRsgX6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=u8EO6pAF;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14405606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 14:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14405606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=u8EO6pAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793196348; x=1793455548;
	bh=O1/J+kaNShq80w9shHctpBGI4lPnDdN0hctLUNkIl5g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=u8EO6pAFgo9QaIsz9wY2u8uGc1G/LR4vzP+7tydOA0thIzIVmlMCrLbf7vG1Cd9Ma
	 4Us3eCNy1yRBiJIklpPjIchvJTB7pL2HowmXK4eczCt7WmNxm7ypWSEnck62pYV4gD
	 YEIMLAmz4xQcbbaJVsSWVJCu1vHkBUciTC5XTdPxIlEWw0e6ym1wE/Y7H2AHUywxFy
	 UYOjiboMCbVEC5JWZd5RnCLbzMBKq+3dj0ek+yh31x4XSbXxJ7NOsqEeapipfgMTsI
	 rqxAzq98E+/9Z3u0uAYua2jcQ7Yked0V/c3Wp4aJwN3B8UIFtGHNElwNMY0QMy2u1x
	 l+QEKHFVunX1A==
Date: Wed, 28 Oct 2026 14:05:44 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [RFC PATCH] mgmt-tester: Add host-resolved RPA scan checks
Message-ID: <W4oT9LNPKdNNAzhftMlCpyvcs_aogHGz_IyCJwURlkhIrxfhp1qvKSAImKBorEBrhtO0F0ZArWoXRzBrwtKViqTKDQarF9ASqKWsnEO_Z_o=@proton.me>
In-Reply-To: <20261014052008.413209-1-cochcoder@proton.me>
References: <20261014052008.413209-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: fbc5354ba54055dee72a6d4588b26013b2f3c4e6
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

Just checking in on this patch. Is there anything else I can do to help it =
move forward?



On Wednesday, October 14th, 2026 at 1:20 AM, Kyle Pepper <cochcoder@proton.=
me> wrote:

> Check unfiltered passive scanning for IRK peers on controllers without
> LL Privacy, with auto-connect and background-report controls.
>=20
> Assisted-by: OpenCode:gpt-6.1-sol
> ---
> Companion to the kernel v2 "Bluetooth: hci_sync: scan unfiltered for
> host-resolved RPAs", responding to Luiz's mgmt-tester request in:
> https://lore.kernel.org/linux-bluetooth/20261013031329.483597-1-cochcoder=
@proton.me/
>=20
> This is the first submission of these BlueZ tests, not a v2 and not a
> cross-project apply-order series. It applies independently on BlueZ
> 9dc7e40962f1. The IRK cases intentionally fail on an unfixed kernel.
>=20
> Native results on bluetooth-next 609a23989d63, KASAN/lockdep enabled:
>                                 upstream   revised kernel
>   Auto-connect with IRK           FAIL       PASS
>   Background report with IRK      FAIL       PASS
>   Auto-connect without IRK        PASS       PASS
>   Background report without IRK   PASS       PASS
>=20
> These assert passive-scan programming, not physical address rotation or
> successful radio reconnect. On the complete 512-case mgmt run, upstream
> has 503 pass/four fail/five not run; revision has 506 pass/one fail/five
> not run. Both have the "Set Static Address - Success 2" timeout. The
> upstream run also fails the two new IRK tests and the already-listed
> flaky "LL Privacy - Set Flags 3 (2 Devices to RL)" test. The latter's
> pass is not attributed to the RPA fix. No captured KASAN/lockdep alerts.
>=20
> Maintainer-mode sanitizer build and 35/35 unit binaries pass. The
> complete mgmt suite is not clean; no physical hardware test is claimed.
>=20
>  tools/mgmt-tester.c | 119 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>=20
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 992351e2e3..850d38e4ce 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -10667,6 +10667,114 @@ static const char load_irks_le_public_param_1[]=
 =3D {
>  =090x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
>  };
> =20
> +static const uint8_t host_rpa_report_param[] =3D {
> +=090x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
> +=090x01,
> +=090x00,
> +};
> +
> +static const struct bt_hci_cmd_le_set_scan_parameters host_rpa_unfiltere=
d =3D {
> +=09.filter_policy =3D 0x00,
> +};
> +
> +static const struct bt_hci_cmd_le_set_scan_parameters host_rpa_filtered =
=3D {
> +=09.filter_policy =3D 0x01,
> +};
> +
> +static int host_rpa_unfiltered_check(const void *param, uint16_t length)
> +{
> +=09const struct bt_hci_cmd_le_set_scan_parameters *cp =3D param;
> +
> +=09if (length !=3D sizeof(*cp))
> +=09=09return -EINVAL;
> +
> +=09return cp->type !=3D 0x00 || cp->filter_policy !=3D 0x00;
> +}
> +
> +static int host_rpa_filtered_check(const void *param, uint16_t length)
> +{
> +=09const struct bt_hci_cmd_le_set_scan_parameters *cp =3D param;
> +
> +=09if (length !=3D sizeof(*cp))
> +=09=09return -EINVAL;
> +
> +=09return cp->type !=3D 0x00 || cp->filter_policy !=3D 0x01;
> +}
> +
> +static const struct generic_data host_rpa_autoconnect =3D {
> +=09.setup_settings =3D settings_powered_le,
> +=09.setup_send_opcode =3D MGMT_OP_LOAD_IRKS,
> +=09.setup_send_param =3D load_irks_le_public_param_1,
> +=09.setup_send_len =3D sizeof(load_irks_le_public_param_1),
> +=09.send_opcode =3D MGMT_OP_ADD_DEVICE,
> +=09.send_param =3D add_device_le_public_param_1,
> +=09.send_len =3D sizeof(add_device_le_public_param_1),
> +=09.expect_param =3D add_device_rsp_le_public,
> +=09.expect_len =3D sizeof(add_device_rsp_le_public),
> +=09.expect_status =3D MGMT_STATUS_SUCCESS,
> +=09.expect_alt_ev =3D MGMT_EV_DEVICE_ADDED,
> +=09.expect_alt_ev_param =3D add_device_le_public_param_1,
> +=09.expect_alt_ev_len =3D sizeof(add_device_le_public_param_1),
> +=09.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
> +=09.expect_hci_param =3D &host_rpa_unfiltered,
> +=09.expect_hci_len =3D sizeof(host_rpa_unfiltered),
> +=09.expect_hci_param_check_func =3D host_rpa_unfiltered_check,
> +};
> +
> +static const struct generic_data host_rpa_report =3D {
> +=09.setup_settings =3D settings_powered_le,
> +=09.setup_send_opcode =3D MGMT_OP_LOAD_IRKS,
> +=09.setup_send_param =3D load_irks_le_public_param_1,
> +=09.setup_send_len =3D sizeof(load_irks_le_public_param_1),
> +=09.send_opcode =3D MGMT_OP_ADD_DEVICE,
> +=09.send_param =3D host_rpa_report_param,
> +=09.send_len =3D sizeof(host_rpa_report_param),
> +=09.expect_param =3D add_device_rsp_le_public,
> +=09.expect_len =3D sizeof(add_device_rsp_le_public),
> +=09.expect_status =3D MGMT_STATUS_SUCCESS,
> +=09.expect_alt_ev =3D MGMT_EV_DEVICE_ADDED,
> +=09.expect_alt_ev_param =3D host_rpa_report_param,
> +=09.expect_alt_ev_len =3D sizeof(host_rpa_report_param),
> +=09.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
> +=09.expect_hci_param =3D &host_rpa_unfiltered,
> +=09.expect_hci_len =3D sizeof(host_rpa_unfiltered),
> +=09.expect_hci_param_check_func =3D host_rpa_unfiltered_check,
> +};
> +
> +static const struct generic_data host_rpa_no_irk_autoconnect =3D {
> +=09.setup_settings =3D settings_powered_le,
> +=09.send_opcode =3D MGMT_OP_ADD_DEVICE,
> +=09.send_param =3D add_device_le_public_param_1,
> +=09.send_len =3D sizeof(add_device_le_public_param_1),
> +=09.expect_param =3D add_device_rsp_le_public,
> +=09.expect_len =3D sizeof(add_device_rsp_le_public),
> +=09.expect_status =3D MGMT_STATUS_SUCCESS,
> +=09.expect_alt_ev =3D MGMT_EV_DEVICE_ADDED,
> +=09.expect_alt_ev_param =3D add_device_le_public_param_1,
> +=09.expect_alt_ev_len =3D sizeof(add_device_le_public_param_1),
> +=09.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
> +=09.expect_hci_param =3D &host_rpa_filtered,
> +=09.expect_hci_len =3D sizeof(host_rpa_filtered),
> +=09.expect_hci_param_check_func =3D host_rpa_filtered_check,
> +};
> +
> +static const struct generic_data host_rpa_no_irk_report =3D {
> +=09.setup_settings =3D settings_powered_le,
> +=09.send_opcode =3D MGMT_OP_ADD_DEVICE,
> +=09.send_param =3D host_rpa_report_param,
> +=09.send_len =3D sizeof(host_rpa_report_param),
> +=09.expect_param =3D add_device_rsp_le_public,
> +=09.expect_len =3D sizeof(add_device_rsp_le_public),
> +=09.expect_status =3D MGMT_STATUS_SUCCESS,
> +=09.expect_alt_ev =3D MGMT_EV_DEVICE_ADDED,
> +=09.expect_alt_ev_param =3D host_rpa_report_param,
> +=09.expect_alt_ev_len =3D sizeof(host_rpa_report_param),
> +=09.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
> +=09.expect_hci_param =3D &host_rpa_filtered,
> +=09.expect_hci_len =3D sizeof(host_rpa_filtered),
> +=09.expect_hci_param_check_func =3D host_rpa_filtered_check,
> +};
> +
>  static const uint8_t add_device_le_public_param_2[] =3D {
>  =090x11, 0x22, 0x33, 0x44, 0x55, 0x66,=09/* BDADDR */
>  =090x01,=09=09=09=09=09/* Type - LE Public */
> @@ -15737,6 +15845,17 @@ int main(int argc, char *argv[])
>  =09=09=09=09&set_exp_feat_unknown,
>  =09=09=09=09NULL, test_command_generic);
> =20
> +=09/* Bluetooth 4.0 has no controller-side address resolution. */
> +=09test_bredrle("Host RPA - Auto-connect with IRK", &host_rpa_autoconnec=
t,
> +=09=09=09=09setup_command_generic, test_command_generic);
> +=09test_bredrle("Host RPA - Background report with IRK", &host_rpa_repor=
t,
> +=09=09=09=09setup_command_generic, test_command_generic);
> +=09test_bredrle("Host RPA - Auto-connect without IRK",
> +=09=09=09=09&host_rpa_no_irk_autoconnect, NULL,
> +=09=09=09=09=09=09=09test_command_generic);
> +=09test_bredrle("Host RPA - Background report without IRK",
> +=09=09=09&host_rpa_no_irk_report, NULL, test_command_generic);
> +
>  =09/* LL Privacy
>  =09 * Setup: Enable LE and Power On
>  =09 * Run: Add new device
>=20
> base-commit: 9dc7e40962f11d1d9a5568f8a7633a695288329c
> 
