Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: =?utf-8?B?TWljaGHFgg==?= Narajowski
        <michal.narajowski@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] tools/mgmt-tester: Fix add local name tests
Date: Tue, 25 Oct 2016 21:54:28 +0200
Message-ID: <6369747.kFHU6Fl373@ix>
In-Reply-To: <1477385608-6574-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1477385608-6574-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Micha=C5=82,

On Tuesday, 25 October 2016 10:53:28 CEST Micha=C5=82 Narajowski wrote:
> Test shortened and short names separately. Added few missing
> expect_hci_command params. Fixed a few typos.
> ---
>  tools/mgmt-tester.c | 85
> +++++++++++++++++++++++++++++++++++++++++++++++++---- 1 file changed, 79
> insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 271df2b..d87d800 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -1904,6 +1904,11 @@ static const struct mgmt_cp_set_local_name
> set_local_name_longer_cp =3D { .name =3D {'T', 'e', 's', 't', ' ', 'n', '=
a',
> 'm', 'e', '1', '2', '3'}, };
>=20
> +static const struct mgmt_cp_set_local_name set_local_name_long_short_cp =
=3D {
> +	.name =3D {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e', '1', '2', '3'},
> +	.short_name =3D {'T', 'e', 's', 't'},
> +};
> +
>  static const struct generic_data set_local_name_test_1 =3D {
>  	.send_opcode =3D MGMT_OP_SET_LOCAL_NAME,
>  	.send_param =3D set_local_name_param,
> @@ -6528,10 +6533,10 @@ static const struct generic_data
> add_advertising_name_fits_in_scrsp =3D { .expect_hci_len =3D
> sizeof(set_scan_rsp_data_name_fits_in_scrsp),
>  };
>=20
> -static const uint8_t set_scan_rsp_data_short_name_fits[] =3D {
> +static const uint8_t set_scan_rsp_data_shortened_name_fits[] =3D {
>  	0x0d, /* Scan rsp data len */
>  	0x0c, /* Local name data len */
> -	0x08, /* Complete name */
> +	0x08, /* Short name */
>  	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x31,
>  	/* "Test name1" */
>  	/* padding */
> @@ -6539,7 +6544,7 @@ static const uint8_t
> set_scan_rsp_data_short_name_fits[] =3D { 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00,
> 0x00, 0x00, 0x00,
>  };
>=20
> -static const struct generic_data add_advertising_short_name_in_scrsp =3D=
 {
> +static const struct generic_data add_advertising_shortened_name_in_scrsp=
 =3D
> { .setup_settings =3D settings_powered_le,
>  	.setup_send_opcode =3D MGMT_OP_SET_LOCAL_NAME,
>  	.setup_send_param =3D &set_local_name_longer_cp,
> @@ -6551,6 +6556,34 @@ static const struct generic_data
> add_advertising_short_name_in_scrsp =3D { .expect_param =3D
> advertising_instance1_param,
>  	.expect_len =3D sizeof(advertising_instance1_param),
>  	.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
> +	.expect_hci_param =3D set_scan_rsp_data_shortened_name_fits,
> +	.expect_hci_len =3D sizeof(set_scan_rsp_data_shortened_name_fits),
> +};
> +
> +static const uint8_t set_scan_rsp_data_short_name_fits[] =3D {
> +	0x07, /* Scan rsp data len */
> +	0x06, /* Local name data len */
> +	0x08, /* Short name */
> +	0x54, 0x65, 0x73, 0x74,
> +	/* "Test*/
> +	/* padding */
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00,
> +};
> +
> +static const struct generic_data add_advertising_short_name_in_scrsp =3D=
 {
> +	.setup_settings =3D settings_powered_le,
> +	.setup_send_opcode =3D MGMT_OP_SET_LOCAL_NAME,
> +	.setup_send_param =3D &set_local_name_long_short_cp,
> +	.setup_send_len =3D sizeof(set_local_name_long_short_cp),
> +	.send_opcode =3D MGMT_OP_ADD_ADVERTISING,
> +	.send_param =3D add_advertising_param_name,
> +	.send_len =3D sizeof(add_advertising_param_name),
> +	.expect_status =3D MGMT_STATUS_SUCCESS,
> +	.expect_param =3D advertising_instance1_param,
> +	.expect_len =3D sizeof(advertising_instance1_param),
> +	.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
>  	.expect_hci_param =3D set_scan_rsp_data_short_name_fits,
>  	.expect_hci_len =3D sizeof(set_scan_rsp_data_short_name_fits),
>  };
> @@ -6568,6 +6601,19 @@ static const uint8_t
> add_advertising_param_name_data_ok[] =3D { 0x00, 0x00, 0x00, 0x00, 0x00,
> 0x00, 0x00, 0x00,
>  };
>=20
> +static const uint8_t set_scan_rsp_data_param_name_data_ok[] =3D {
> +	0x1e, /* Scan rsp data len */
> +	/* scan rsp data */
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x0b, /* Local name data len */
> +	0x09, /* Complete name */
> +	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
> +	/* "Test name" */
> +	/* padding */
> +	0x00,
> +};
> +
>  static const struct generic_data add_advertising_name_data_ok =3D {
>  	.setup_settings =3D settings_powered_le,
>  	.setup_send_opcode =3D MGMT_OP_SET_LOCAL_NAME,
> @@ -6579,6 +6625,9 @@ static const struct generic_data
> add_advertising_name_data_ok =3D { .expect_status =3D MGMT_STATUS_SUCCESS,
>  	.expect_param =3D advertising_instance1_param,
>  	.expect_len =3D sizeof(advertising_instance1_param),
> +	.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
> +	.expect_hci_param =3D set_scan_rsp_data_param_name_data_ok,
> +	.expect_hci_len =3D sizeof(set_scan_rsp_data_param_name_data_ok),
>  };
>=20
>  static const uint8_t add_advertising_param_name_data_inv[] =3D {
> @@ -6638,6 +6687,22 @@ static const struct setup_mgmt_cmd
> add_advertising_mgmt_cmd_arr[] =3D { }
>  };
>=20
> +static const uint8_t set_scan_rsp_data_name_data_appear[] =3D {
> +	0x1e, /* Scan rsp data len */
> +	0x03, /* appearance len */
> +	0x19, /* EIR_APPEARANCE */
> +	0x54, 0x65, /* appearance value */
> +	/* scan rsp data */
> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	0x00, 0x00, 0x00, 0x00,
> +	0x0b, /* Local name data len */
> +	0x09, /* Complete name */
> +	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
> +	/* "Test name" */
> +	/* padding */
> +	0x00,
> +};
> +
>  static const struct generic_data add_advertising_name_data_appear =3D {
>  	.setup_settings =3D settings_powered_le,
>  	.setup_mgmt_cmd_arr =3D add_advertising_mgmt_cmd_arr,
> @@ -6647,6 +6712,9 @@ static const struct generic_data
> add_advertising_name_data_appear =3D { .expect_status =3D MGMT_STATUS_SUC=
CESS,
>  	.expect_param =3D advertising_instance1_param,
>  	.expect_len =3D sizeof(advertising_instance1_param),
> +	.expect_hci_command =3D BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
> +	.expect_hci_param =3D set_scan_rsp_data_name_data_appear,
> +	.expect_hci_len =3D sizeof(set_scan_rsp_data_name_data_appear),
>  };
>=20
>  static const struct generic_data set_appearance_not_supported =3D {
> @@ -7909,10 +7977,15 @@ int main(int argc, char *argv[])
>  					setup_command_generic,
>  					test_command_generic);
>=20
> +	test_bredrle("Add Advertising - Success (Shortened name)",
> +				&add_advertising_shortened_name_in_scrsp,
> +					setup_command_generic,
> +					test_command_generic);
> +
>  	test_bredrle("Add Advertising - Success (Short name)",
> -					 &add_advertising_short_name_in_scrsp,
> -					 setup_command_generic,
> -					 test_command_generic);
> +					&add_advertising_short_name_in_scrsp,
> +					setup_command_generic,
> +					test_command_generic);
>=20
>  	test_bredrle("Add Advertising - Success (Name + data)",
>  					 &add_advertising_name_data_ok,

Applied, thanks.

=2D-=20
pozdrawiam
Szymon Janc
