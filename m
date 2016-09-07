Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: =?utf-8?B?TWljaGHFgg==?= Narajowski
        <michal.narajowski@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] tools/mgmt-tester: Test read extended controller info
Date: Wed, 07 Sep 2016 22:37:57 +0200
Message-ID: <5769739.QZNNW2uP2O@ix>
In-Reply-To: <1472808350-17169-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1472808350-17169-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Micha=C5=82,

On Friday, 2 September 2016 11:25:50 CEST Micha=C5=82 Narajowski wrote:
> This patch tests read extended controller info command added in kernel.
> It also adds support for sending multiple mgmt commands on setup and
> expecting hci command on setup.
> ---
>  emulator/hciemu.c   |  10 ++
>  emulator/hciemu.h   |   2 +
>  tools/mgmt-tester.c | 308
> ++++++++++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 320
> insertions(+)
>=20
> diff --git a/emulator/hciemu.c b/emulator/hciemu.c
> index ea1e3cf..7debb8f 100644
> --- a/emulator/hciemu.c
> +++ b/emulator/hciemu.c
> @@ -467,6 +467,16 @@ bool hciemu_add_master_post_command_hook(struct hcie=
mu
> *hciemu, return true;
>  }
>=20
> +bool hciemu_clear_master_post_command_hooks(struct hciemu *hciemu)
> +{
> +	if (!hciemu)
> +		return false;
> +
> +	queue_remove_all(hciemu->post_command_hooks,
> +					NULL, NULL, destroy_command_hook);
> +	return true;
> +}
> +
>  int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
>  				uint16_t opcode, hciemu_hook_func_t function,
>  				void *user_data)
> diff --git a/emulator/hciemu.h b/emulator/hciemu.h
> index c5578d1..783f99c 100644
> --- a/emulator/hciemu.h
> +++ b/emulator/hciemu.h
> @@ -66,6 +66,8 @@ typedef bool (*hciemu_hook_func_t)(const void *data,
> uint16_t len, bool hciemu_add_master_post_command_hook(struct hciemu
> *hciemu,
>  			hciemu_command_func_t function, void *user_data);
>=20
> +bool hciemu_clear_master_post_command_hooks(struct hciemu *hciemu);
> +
>  int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
>  				uint16_t opcode, hciemu_hook_func_t function,
>  				void *user_data);
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index b6f4873..1533cc1 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -384,6 +384,12 @@ static void controller_setup(const void *test_data)
>  	tester_test_passed();
>  }
>=20
> +struct setup_mgmt_cmd {
> +	uint8_t send_opcode;
> +	const void *send_param;
> +	uint16_t send_len;
> +};
> +
>  struct generic_data {
>  	const uint16_t *setup_settings;
>  	bool setup_nobredr;
> @@ -394,6 +400,7 @@ struct generic_data {
>  	uint16_t setup_send_opcode;
>  	const void *setup_send_param;
>  	uint16_t setup_send_len;
> +	const struct setup_mgmt_cmd *setup_mgmt_cmd_arr;
>  	bool send_index_none;
>  	uint16_t send_opcode;
>  	const void *send_param;
> @@ -4862,6 +4869,199 @@ static const struct generic_data
> read_local_oob_success_sc_test =3D { .expect_hci_command =3D
> BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA,
>  };
>=20
> +static const char ext_ctrl_info1[] =3D {
> +	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
> +	0x08, /* version */
> +	0x3f, 0x00, /* manufacturer */
> +	0xff, 0xbf, 0x00, 0x00, /* supported settings */
> +	0x80, 0x00, 0x00, 0x00, /* current settings */
> +	0x09, 0x00, /* eir length */
> +	0x04, /* dev class length */
> +	0x0d, /* dev class info */
> +	0x00, /* minor */
> +	0x00, /* major */
> +	0x00, /* service classes */
> +	0x01, /* complete name data length */
> +	0x09, /* complete name flag */
> +	0x01, /* short name data length */
> +	0x08, /* short name flag */
> +};
> +
> +static const struct generic_data read_ext_ctrl_info1 =3D {
> +	.send_opcode =3D MGMT_OP_READ_EXT_INFO,
> +	.expect_status =3D MGMT_STATUS_SUCCESS,
> +	.expect_param =3D ext_ctrl_info1,
> +	.expect_len =3D sizeof(ext_ctrl_info1),
> +};
> +
> +static const char set_dev_class1[] =3D { 0x03, 0xe0 };
> +
> +static const struct setup_mgmt_cmd set_dev_class_cmd_arr1[] =3D {
> +	{
> +		.send_opcode =3D MGMT_OP_SET_DEV_CLASS,
> +		.send_param =3D set_dev_class1,
> +		.send_len =3D sizeof(set_dev_class1),
> +	},
> +	{
> +		.send_opcode =3D MGMT_OP_ADD_UUID,
> +		.send_param =3D add_spp_uuid_param,
> +		.send_len =3D sizeof(add_spp_uuid_param),
> +	},
> +	{ /* last element should always have opcode 0x00 */
> +		.send_opcode =3D 0x00,
> +		.send_param =3D NULL,
> +		.send_len =3D 0,
> +	}
> +};
> +
> +static const char ext_ctrl_info2[] =3D {
> +	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
> +	0x08, /* version */
> +	0x3f, 0x00, /* manufacturer */
> +	0xff, 0xbf, 0x00, 0x00, /* supported settings */
> +	0x81, 0x02, 0x00, 0x00, /* current settings */
> +	0x09, 0x00, /* eir length */
> +	0x04, /* dev class length */
> +	0x0d, /* dev class info */
> +	0xe0, /* minor */
> +	0x03, /* major */
> +	0x00, /* service classes */
> +	0x01, /* complete name data length */
> +	0x09, /* complete name flag */
> +	0x01, /* short name data length */
> +	0x08, /* short name flag */
> +};
> +
> +static const struct generic_data read_ext_ctrl_info2 =3D {
> +	.setup_settings =3D settings_powered_le,
> +	.setup_mgmt_cmd_arr =3D set_dev_class_cmd_arr1,
> +	.send_opcode =3D MGMT_OP_READ_EXT_INFO,
> +	.expect_status =3D MGMT_STATUS_SUCCESS,
> +	.expect_param =3D ext_ctrl_info2,
> +	.expect_len =3D sizeof(ext_ctrl_info2),
> +};
> +
> +static const char ext_ctrl_info3[] =3D {
> +	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
> +	0x08, /* version */
> +	0x3f, 0x00, /* manufacturer */
> +	0xff, 0xbf, 0x00, 0x00, /* supported settings */
> +	0x80, 0x02, 0x00, 0x00, /* current settings */
> +	0x12, 0x00, /* eir length */
> +	0x04, /* dev class length */
> +	0x0d, /* dev class info */
> +	0x00, /* minor */
> +	0x00, /* major */
> +	0x00, /* service classes */
> +	0x0A, /* Local name length */
> +	0x09, /* Complete name */
> +	0x54, 0x65, 0x73, 0x74,
> +	0x20, 0x6E, 0x61, 0x6D, 0x65, /* "Test name" */
> +	0x01, /* short name data length */
> +	0x08, /* short name flag */
> +};
> +
> +static const struct generic_data read_ext_ctrl_info3 =3D {
> +	.setup_settings =3D settings_le,
> +	.setup_send_opcode =3D MGMT_OP_SET_LOCAL_NAME,
> +	.setup_send_param =3D set_local_name_param,
> +	.setup_send_len =3D sizeof(set_local_name_param),
> +	.send_opcode =3D MGMT_OP_READ_EXT_INFO,
> +	.expect_status =3D MGMT_STATUS_SUCCESS,
> +	.expect_param =3D ext_ctrl_info3,
> +	.expect_len =3D sizeof(ext_ctrl_info3),
> +};
> +
> +static const struct mgmt_cp_set_local_name set_local_name_cp =3D {
> +	.name =3D {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e'},
> +	.short_name =3D {'T', 'e', 's', 't'},
> +};
> +
> +static const char ext_ctrl_info4[] =3D {
> +	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
> +	0x08, /* version */
> +	0x3f, 0x00, /* manufacturer */
> +	0xff, 0xbf, 0x00, 0x00, /* supported settings */
> +	0x80, 0x02, 0x00, 0x00, /* current settings */
> +	0x16, 0x00, /* eir length */
> +	0x04, /* dev class length */
> +	0x0d, /* dev class info */
> +	0x00, /* minor */
> +	0x00, /* major */
> +	0x00, /* service classes */
> +	0x0A, /* Complete Local name len */
> +	0x09, /* Complete name */
> +	0x54, 0x65, 0x73, 0x74,
> +	0x20, 0x6E, 0x61, 0x6D, 0x65, /* "Test name" */
> +	0x05, /* Short Local name len */
> +	0x08, /* Short name */
> +	0x54, 0x65, 0x73, 0x74, /* "Test" */
> +};
> +
> +static const struct generic_data read_ext_ctrl_info4 =3D {
> +	.setup_settings =3D settings_le,
> +	.setup_send_opcode =3D MGMT_OP_SET_LOCAL_NAME,
> +	.setup_send_param =3D &set_local_name_cp,
> +	.setup_send_len =3D sizeof(set_local_name_cp),
> +	.send_opcode =3D MGMT_OP_READ_EXT_INFO,
> +	.expect_status =3D MGMT_STATUS_SUCCESS,
> +	.expect_param =3D ext_ctrl_info4,
> +	.expect_len =3D sizeof(ext_ctrl_info4),
> +};
> +
> +static const struct setup_mgmt_cmd set_dev_class_cmd_arr2[] =3D {
> +	{
> +		.send_opcode =3D MGMT_OP_SET_DEV_CLASS,
> +		.send_param =3D set_dev_class1,
> +		.send_len =3D sizeof(set_dev_class1),
> +	},
> +	{
> +		.send_opcode =3D MGMT_OP_ADD_UUID,
> +		.send_param =3D add_spp_uuid_param,
> +		.send_len =3D sizeof(add_spp_uuid_param),
> +	},
> +	{
> +		.send_opcode =3D MGMT_OP_SET_LOCAL_NAME,
> +		.send_param =3D &set_local_name_cp,
> +		.send_len =3D sizeof(set_local_name_cp),
> +	},
> +	{ /* last element should always have opcode 0x00 */
> +		.send_opcode =3D 0x00,
> +		.send_param =3D NULL,
> +		.send_len =3D 0,
> +	}
> +};
> +
> +static const char ext_ctrl_info5[] =3D {
> +	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
> +	0x08, /* version */
> +	0x3f, 0x00, /* manufacturer */
> +	0xff, 0xbf, 0x00, 0x00, /* supported settings */
> +	0x81, 0x02, 0x00, 0x00, /* current settings */
> +	0x16, 0x00, /* eir len */
> +	0x04, /* dev class len */
> +	0x0d, /* dev class info */
> +	0xe0, /* minor */
> +	0x03, /* major */
> +	0x00, /* service classes */
> +	0x0A, /* Complete Local name len */
> +	0x09, /* Complete name */
> +	0x54, 0x65, 0x73, 0x74,
> +	0x20, 0x6E, 0x61, 0x6D, 0x65, /* "Test name" */
> +	0x05, /* Short Local name len */
> +	0x08, /* Short name */
> +	0x54, 0x65, 0x73, 0x74, /* "Test" */
> +};
> +
> +static const struct generic_data read_ext_ctrl_info5 =3D {
> +	.setup_settings =3D settings_powered_le,
> +	.setup_mgmt_cmd_arr =3D set_dev_class_cmd_arr2,
> +	.send_opcode =3D MGMT_OP_READ_EXT_INFO,
> +	.expect_status =3D MGMT_STATUS_SUCCESS,
> +	.expect_param =3D ext_ctrl_info5,
> +	.expect_len =3D sizeof(ext_ctrl_info5),
> +};
> +
>  static void client_cmd_complete(uint16_t opcode, uint8_t status,
>  					const void *param, uint8_t len,
>  					void *user_data)
> @@ -5844,6 +6044,35 @@ static void command_generic_callback(uint8_t statu=
s,
> uint16_t length, test_condition_complete(data);
>  }
>=20
> +static void command_setup_hci_callback(uint16_t opcode, const void *para=
m,
> +					uint8_t length, void *user_data)
> +{
> +	struct test_data *data =3D user_data;
> +	const struct generic_data *test =3D data->test_data;
> +	const void *setup_expect_hci_param =3D test->setup_expect_hci_param;
> +	uint8_t setup_expect_hci_len =3D test->setup_expect_hci_len;
> +
> +	tester_print("HCI Command 0x%04x length %u", opcode, length);
> +
> +	if (opcode !=3D test->setup_expect_hci_command)
> +		return;
> +
> +	if (length !=3D setup_expect_hci_len) {
> +		tester_warn("Invalid parameter size for HCI command");
> +		tester_test_failed();
> +		return;
> +	}
> +
> +	if (memcmp(param, setup_expect_hci_param, length) !=3D 0) {
> +		tester_warn("Unexpected HCI command parameter value");
> +		tester_test_failed();
> +		return;
> +	}
> +
> +	hciemu_clear_master_post_command_hooks(data->hciemu);
> +	test_condition_complete(data);
> +}
> +
>  static void command_hci_callback(uint16_t opcode, const void *param,
>  					uint8_t length, void *user_data)
>  {
> @@ -5875,6 +6104,65 @@ static void command_hci_callback(uint16_t opcode,
> const void *param, test_condition_complete(data);
>  }
>=20
> +static void setup_mgmt_cmd_callback(uint8_t status, uint16_t length,
> +					const void *param, void *user_data)
> +{
> +	if (status !=3D MGMT_STATUS_SUCCESS) {
> +		tester_setup_failed();
> +		return;
> +	}
> +
> +	tester_setup_complete();
> +}
> +
> +static void setup_set_local_name(const void *test_data)
> +{
> +	struct test_data *data =3D tester_get_data();
> +	const struct generic_data *test =3D data->test_data;
> +	const void *send_param =3D test->setup_send_param;
> +	uint16_t send_len =3D test->setup_send_len;
> +	size_t i =3D 0;
> +
> +	if (test->setup_expect_hci_command) {
> +		tester_print("Registering setup expected HCI command callback");
> +		tester_print("Setup expected HCI command 0x%04x",
> +					 test->setup_expect_hci_command);
> +		hciemu_add_master_post_command_hook(data->hciemu,
> +					command_setup_hci_callback, data);
> +		test_add_condition(data);
> +	}
> +
> +	if (test->setup_send_opcode) {
> +		tester_print("Setup sending %s (0x%04x)",
> +				mgmt_opstr(test->setup_send_opcode),
> +				test->setup_send_opcode);
> +		mgmt_send(data->mgmt, test->setup_send_opcode, data->mgmt_index,
> +					send_len, send_param,
> +					setup_mgmt_cmd_callback,
> +					NULL, NULL);
> +		return;
> +	}
> +
> +	tester_print("Sending setup opcode array");
> +	for (; test->setup_mgmt_cmd_arr + i; ++i) {
> +		const struct setup_mgmt_cmd *cmd =3D test->setup_mgmt_cmd_arr + i;
> +
> +		if (cmd->send_opcode =3D=3D 0x00)
> +			break;
> +
> +		tester_print("Setup sending %s (0x%04x)",
> +				mgmt_opstr(cmd->send_opcode),
> +				cmd->send_opcode);
> +
> +		mgmt_send(data->mgmt, cmd->send_opcode, data->mgmt_index,
> +				cmd->send_len, cmd->send_param,
> +				setup_mgmt_cmd_callback,
> +				NULL, NULL);
> +	}
> +
> +	tester_setup_complete();
> +}
> +
>  static bool power_off(uint16_t index)
>  {
>  	int sk, err;
> @@ -7100,6 +7388,26 @@ int main(int argc, char *argv[])
>  					setup_add_advertising_duration,
>  					test_command_generic, 3);
>=20
> +	test_bredrle("Read Ext Controller Info 1",
> +				&read_ext_ctrl_info1,
> +				setup_set_local_name, test_command_generic);
> +
> +	test_bredrle("Read Ext Controller Info 2",
> +				&read_ext_ctrl_info2,
> +				setup_set_local_name, test_command_generic);
> +
> +	test_bredrle("Read Ext Controller Info 3",
> +				&read_ext_ctrl_info3,
> +				setup_set_local_name, test_command_generic);
> +
> +	test_bredrle("Read Ext Controller Info 4",
> +				&read_ext_ctrl_info4,
> +				setup_set_local_name, test_command_generic);
> +
> +	test_bredrle("Read Ext Controller Info 5",
> +				&read_ext_ctrl_info5,
> +				setup_set_local_name, test_command_generic);
> +
>  	test_bredrle("Read Local OOB Data - Not powered",
>  				&read_local_oob_not_powered_test,
>  				NULL, test_command_generic);

Patch applied, thanks.

=2D-=20
pozdrawiam
Szymon Janc
