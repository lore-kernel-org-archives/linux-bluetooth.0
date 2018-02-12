Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: =?utf-8?B?xYF1a2Fzeg==?= Rymanowski
        <lukasz.rymanowski@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 3/3] mgmt-tester: Add testcases for advertising while connected
Date: Mon, 12 Feb 2018 10:06:13 +0100
Message-ID: <4884302.7PIqPRA8oQ@ix>
In-Reply-To: <20180209172627.20500-4-lukasz.rymanowski@codecoup.pl>
References: <20180209172627.20500-1-lukasz.rymanowski@codecoup.pl> <20180209172627.20500-4-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi =C5=81ukasz,

On Friday, 9 February 2018 18:26:27 CET =C5=81ukasz Rymanowski wrote:
> This patch adds testcases which verifies if Linux Kernel properly
> enables advertising while is connected (LE) based on supported LE states
> in the controller
> ---
>  tools/mgmt-tester.c | 365
> ++++++++++++++++++++++++++++++++++++++++++++-------- 1 file changed, 310
> insertions(+), 55 deletions(-)
>=20
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 191c1cd4d..1be245c84 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -28,6 +28,8 @@
>  #include <stdlib.h>
>  #include <stdbool.h>
>  #include <sys/ioctl.h>
> +#include <errno.h>
> +#include <unistd.h>
>=20
>  #include <glib.h>
>=20
> @@ -35,6 +37,7 @@
>  #include "lib/hci.h"
>  #include "lib/hci_lib.h"
>  #include "lib/mgmt.h"
> +#include "lib/l2cap.h"
>=20
>  #include "monitor/bt.h"
>  #include "emulator/bthost.h"
> @@ -64,6 +67,7 @@ struct test_data {
>  	enum hciemu_type hciemu_type;
>  	int unmet_conditions;
>  	int unmet_setup_conditions;
> +	int sk;
>  };
>=20
>  static void mgmt_debug(const char *str, void *user_data)
> @@ -211,10 +215,68 @@ static void index_removed_callback(uint16_t index,
> uint16_t length, tester_post_teardown_complete();
>  }
>=20
> +struct generic_data {
> +	bool setup_le_states;
> +	const uint8_t *le_states;
> +	const uint16_t *setup_settings;
> +	bool setup_nobredr;
> +	bool setup_limited_discov;
> +	uint16_t setup_expect_hci_command;
> +	const void *setup_expect_hci_param;
> +	uint8_t setup_expect_hci_len;
> +	uint16_t setup_send_opcode;
> +	const void *setup_send_param;
> +	uint16_t setup_send_len;
> +	const struct setup_mgmt_cmd *setup_mgmt_cmd_arr;
> +	bool send_index_none;
> +	uint16_t send_opcode;
> +	const void *send_param;
> +	uint16_t send_len;
> +	const void * (*send_func)(uint16_t *len);
> +	uint8_t expect_status;
> +	bool expect_ignore_param;
> +	const void *expect_param;
> +	uint16_t expect_len;
> +	const void * (*expect_func)(uint16_t *len);
> +	uint32_t expect_settings_set;
> +	uint32_t expect_settings_unset;
> +	uint16_t expect_alt_ev;
> +	const void *expect_alt_ev_param;
> +	bool (*verify_alt_ev_func)(const void *param, uint16_t length);
> +	uint16_t expect_alt_ev_len;
> +	uint16_t expect_hci_command;
> +	const void *expect_hci_param;
> +	uint8_t expect_hci_len;
> +	const void * (*expect_hci_func)(uint8_t *len);
> +	bool expect_pin;
> +	uint8_t pin_len;
> +	const void *pin;
> +	uint8_t client_pin_len;
> +	const void *client_pin;
> +	bool client_enable_ssp;
> +	uint8_t io_cap;
> +	uint8_t client_io_cap;
> +	uint8_t client_auth_req;
> +	bool reject_confirm;
> +	bool client_reject_confirm;
> +	bool just_works;
> +	bool client_enable_le;
> +	bool client_enable_sc;
> +	bool client_enable_adv;
> +	bool expect_sc_key;
> +	bool force_power_off;
> +	bool addr_type_avail;
> +	uint8_t addr_type;
> +	bool set_adv;
> +	const uint8_t *adv_data;
> +	uint8_t adv_data_len;
> +};
> +
>  static void read_index_list_callback(uint8_t status, uint16_t length,
>  					const void *param, void *user_data)
>  {
>  	struct test_data *data =3D tester_get_data();
> +	const struct generic_data *test =3D data->test_data;
>=20
>  	tester_print("Read Index List callback");
>  	tester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
> @@ -235,6 +297,9 @@ static void read_index_list_callback(uint8_t status,
> uint16_t length, tester_warn("Failed to setup HCI emulation");
>  		tester_pre_setup_failed();
>  	}
> +
> +	if (test && test->setup_le_states)
> +		hciemu_set_master_le_states(data->hciemu, test->le_states);
>  }
>=20
>  static void test_pre_setup(const void *test_data)
> @@ -271,12 +336,17 @@ static void test_pre_setup(const void *test_data)
>=20
>  	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
>  					read_index_list_callback, NULL, NULL);
> +
> +	data->sk =3D -1;
>  }
>=20
>  static void test_post_teardown(const void *test_data)
>  {
>  	struct test_data *data =3D tester_get_data();
>=20
> +	if (data->sk >=3D 0)
> +		close(data->sk);
> +
>  	hciemu_unref(data->hciemu);
>  	data->hciemu =3D NULL;
>  }
> @@ -403,61 +473,6 @@ struct setup_mgmt_cmd {
>  	uint16_t send_len;
>  };
>=20
> -struct generic_data {
> -	const uint16_t *setup_settings;
> -	bool setup_nobredr;
> -	bool setup_limited_discov;
> -	uint16_t setup_expect_hci_command;
> -	const void *setup_expect_hci_param;
> -	uint8_t setup_expect_hci_len;
> -	uint16_t setup_send_opcode;
> -	const void *setup_send_param;
> -	uint16_t setup_send_len;
> -	const struct setup_mgmt_cmd *setup_mgmt_cmd_arr;
> -	bool send_index_none;
> -	uint16_t send_opcode;
> -	const void *send_param;
> -	uint16_t send_len;
> -	const void * (*send_func)(uint16_t *len);
> -	uint8_t expect_status;
> -	bool expect_ignore_param;
> -	const void *expect_param;
> -	uint16_t expect_len;
> -	const void * (*expect_func)(uint16_t *len);
> -	uint32_t expect_settings_set;
> -	uint32_t expect_settings_unset;
> -	uint16_t expect_alt_ev;
> -	const void *expect_alt_ev_param;
> -	bool (*verify_alt_ev_func)(const void *param, uint16_t length);
> -	uint16_t expect_alt_ev_len;
> -	uint16_t expect_hci_command;
> -	const void *expect_hci_param;
> -	uint8_t expect_hci_len;
> -	const void * (*expect_hci_func)(uint8_t *len);
> -	bool expect_pin;
> -	uint8_t pin_len;
> -	const void *pin;
> -	uint8_t client_pin_len;
> -	const void *client_pin;
> -	bool client_enable_ssp;
> -	uint8_t io_cap;
> -	uint8_t client_io_cap;
> -	uint8_t client_auth_req;
> -	bool reject_confirm;
> -	bool client_reject_confirm;
> -	bool just_works;
> -	bool client_enable_le;
> -	bool client_enable_sc;
> -	bool client_enable_adv;
> -	bool expect_sc_key;
> -	bool force_power_off;
> -	bool addr_type_avail;
> -	uint8_t addr_type;
> -	bool set_adv;
> -	const uint8_t *adv_data;
> -	uint8_t adv_data_len;
> -};
> -
>  static const char dummy_data[] =3D { 0x00 };
>=20
>  static const struct generic_data invalid_command_test =3D {
> @@ -5002,6 +5017,45 @@ static const struct generic_data
> read_local_oob_success_sc_test =3D { .expect_hci_command =3D
> BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA,
>  };
>=20
> +static uint8_t le_states_conn_slave_adv_connectable[] =3D {
> +			0x00, 0x00, 0x20, 0x00, 0x40, 0x00, 0x00, 0x00};
> +static uint8_t le_states_conn_slave_adv_non_connectable[] =3D {
> +			0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00};
> +static uint8_t le_states_conn_master_adv_connectable[] =3D {
> +			0x00, 0x00, 0x08, 0x00, 0x08, 0x00, 0x00, 0x00};
> +static uint8_t le_states_conn_master_adv_non_connectable[] =3D {
> +			0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00};
> +

Could be static const.


> +static const struct generic_data conn_slave_adv_conneactable_test =3D {
> +	.setup_le_states =3D true,
> +	.le_states =3D le_states_conn_slave_adv_connectable,
> +	.setup_settings =3D settings_powered_le,
> +	.client_enable_le =3D true
> +};
> +
> +static const struct generic_data conn_slave_adv_non_conneactable_test =
=3D {
> +	.setup_le_states =3D true,
> +	.le_states =3D le_states_conn_slave_adv_non_connectable,
> +	.setup_settings =3D settings_powered_le,
> +	.client_enable_le =3D true
> +};
> +
> +static const struct generic_data conn_master_adv_conneactable_test =3D {
> +	.setup_le_states =3D true,
> +	.le_states =3D le_states_conn_master_adv_connectable,
> +	.setup_settings =3D settings_powered_le,
> +	.client_enable_le =3D true,
> +	.client_enable_adv =3D 1
> +};
> +
> +static const struct generic_data conn_master_adv_non_conneactable_test =
=3D {
> +	.setup_le_states =3D true,
> +	.le_states =3D le_states_conn_master_adv_non_connectable,
> +	.setup_settings =3D settings_powered_le,
> +	.client_enable_le =3D true,
> +	.client_enable_adv =3D 1
> +};
> +
>  static const char ext_ctrl_info1[] =3D {
>  	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
>  	0x09, /* version */
> @@ -5671,6 +5725,77 @@ static void setup_add_advertising_connectable(const
> void *test_data) NULL, NULL);
>  }
>=20
> +static int create_le_att_sock(struct test_data *data)
> +{
> +	struct sockaddr_l2 addr;
> +	int sk, err;
> +
> +	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | SOCK_NONBLOCK,
> +							BTPROTO_L2CAP);
> +	if (sk < 0) {
> +		err =3D -errno;
> +		tester_warn("Can't create socket: %s (%d)", strerror(errno),
> +									errno);
> +		return err;
> +	}
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.l2_family =3D AF_BLUETOOTH;
> +	addr.l2_psm =3D 0;
> +	addr.l2_cid =3D htobs(0x0004);
> +	addr.l2_bdaddr_type =3D BDADDR_LE_PUBLIC;
> +
> +	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> +		err =3D -errno;
> +		tester_warn("Can't bind socket: %s (%d)", strerror(errno),
> +									errno);
> +		close(sk);
> +		return err;
> +	}
> +
> +	if (listen(sk, 1) < 0) {
> +		err =3D -errno;
> +		tester_warn("Can't bind socket: %s (%d)", strerror(errno),
> +									errno);
> +		close(sk);
> +		return err;
> +	}
> +
> +	data->sk =3D sk;
> +
> +	return sk;
> +}
> +
> +static void setup_advertise_while_connected(const void *test_data)
> +{
> +	struct test_data *data =3D tester_get_data();
> +	struct mgmt_cp_add_advertising *cp;
> +	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];

uint8_t

> +
> +	tester_print("Adding advertising instances");
> +
> +	cp =3D (struct mgmt_cp_add_advertising *) adv_param;
> +	setup_add_adv_param(cp, 1);
> +
> +	cp->flags |=3D MGMT_ADV_FLAG_CONNECTABLE;
> +	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
> +						sizeof(adv_param), adv_param,
> +						NULL, NULL, NULL);
> +
> +	cp->flags &=3D ~MGMT_ADV_FLAG_CONNECTABLE;
> +	cp->instance =3D 2;
> +
> +	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
> +						sizeof(adv_param), adv_param,
> +						setup_add_advertising_callback,
> +						NULL, NULL);
> +
> +	/* Listen on the socket so Kernel does not drop connection just after
> +	 * connect. Socket is closed in test_post_teardown
> +	 */
> +	create_le_att_sock(data);
> +}
> +
>  static void setup_add_advertising_timeout(const void *test_data)
>  {
>  	struct test_data *data =3D tester_get_data();
> @@ -6982,6 +7107,116 @@ static void test_command_generic_connect(const vo=
id
> *test_data) bthost_hci_connect(bthost, master_bdaddr, addr_type);
>  }
>=20
> +static bool test_adv_enable_hook(const void *data, uint16_t len,
> +								void *user_data)
> +{
> +	struct test_data *test_data =3D user_data;
> +	const uint8_t *status =3D data;
> +
> +	if (*status =3D=3D 0) {
> +		tester_print("Advertising enabled");
> +		test_condition_complete(test_data);
> +	} else {
> +		tester_print("Advertising enabled error 0x%02x", *status);
> +	}
> +
> +	return true;
> +}
> +
> +static void disconnected_event(uint16_t index, uint16_t length,
> +					const void *param, void *user_data)
> +{
> +	tester_test_failed();
> +}
> +
> +static void le_connected_event(uint16_t index, uint16_t length,
> +					const void *param, void *user_data)
> +{
> +	struct test_data *data =3D tester_get_data();
> +
> +	tester_print("Device connected");
> +
> +	test_add_condition(data);
> +	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
> +						BT_HCI_CMD_LE_SET_ADV_ENABLE,
> +						test_adv_enable_hook, data);
> +
> +	/* Make sure we get not disconnected during the testaces */
> +	mgmt_register(data->mgmt_alt, MGMT_EV_DEVICE_DISCONNECTED,
> +				data->mgmt_index, disconnected_event,
> +
> +				NULL, NULL);
> +
> +	test_condition_complete(data);
> +}
> +
> +static void add_device_callback(uint8_t status, uint16_t len, const void
> *param, +							void *user_data)
> +{
> +	struct test_data *data =3D user_data;
> +	const struct generic_data *test =3D data->test_data;
> +	struct bthost *bthost;
> +	const uint8_t *master_bdaddr;
> +
> +	if (status !=3D 0)
> +		tester_test_failed();

missign return here?

> +
> +	tester_print("Device added");
> +
> +	/* If advertising is enabled on client that means we can stop here and
> +	 * just wait for connection
> +	 */
> +	if (test->client_enable_adv)
> +		return;
> +
> +	master_bdaddr =3D hciemu_get_master_bdaddr(data->hciemu);
> +	if (!master_bdaddr) {
> +		tester_warn("No master bdaddr");
> +		tester_test_failed();
> +		return;
> +	}
> +
> +	bthost =3D hciemu_client_get_host(data->hciemu);
> +	bthost_hci_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
> +}
> +
> +static void test_connected_and_advertising(const void *test_data)
> +{
> +	struct test_data *data =3D tester_get_data();
> +	const struct generic_data *test =3D data->test_data;
> +	const uint8_t *client_bdaddr;
> +	struct mgmt_cp_add_device cp;
> +
> +	tester_print("Registering %s notification",
> +					mgmt_evstr(MGMT_EV_DEVICE_CONNECTED));
> +
> +	test_add_condition(data);
> +	mgmt_register(data->mgmt_alt, MGMT_EV_DEVICE_CONNECTED,
> +				data->mgmt_index, le_connected_event,
> +				NULL, NULL);
> +
> +	client_bdaddr =3D hciemu_get_client_bdaddr(data->hciemu);
> +	if (!client_bdaddr) {
> +		tester_warn("No client bdaddr");
> +		tester_test_failed();
> +		return;
> +	}
> +
> +	memset(&cp, 0, sizeof(cp));
> +	memcpy(&cp.addr.bdaddr, client_bdaddr, 6);
> +	cp.addr.type =3D BDADDR_LE_PUBLIC;
> +
> +	if (test->client_enable_adv)
> +		cp.action =3D 0x02; // Auto connect
> +	else
> +		cp.action =3D 0x01; // Allow incoming connection

No C++ style comments.

> +
> +	mgmt_send(data->mgmt_alt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
> +						sizeof(cp), &cp,
> +						add_device_callback,
> +						data, NULL);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	tester_init(&argc, &argv);
> @@ -8004,6 +8239,26 @@ int main(int argc, char *argv[])
>  					 setup_command_generic,
>  					 test_command_generic);
>=20
> +	test_le_full("Adv. connectable & connected (slave) - Success",
> +					&conn_slave_adv_conneactable_test,
> +					setup_advertise_while_connected,
> +					test_connected_and_advertising, 10);
> +
> +	test_le_full("Adv. non-connectable & connected (slave) - Success",
> +					&conn_slave_adv_non_conneactable_test,
> +					setup_advertise_while_connected,
> +					test_connected_and_advertising, 10);
> +
> +	test_le_full("Adv. connectable & connected (master) - Success",
> +					&conn_master_adv_conneactable_test,
> +					setup_advertise_while_connected,
> +					test_connected_and_advertising, 10);
> +
> +	test_le_full("Adv. non-connectable & connected (master) - Success",
> +					&conn_master_adv_non_conneactable_test,
> +					setup_advertise_while_connected,
> +					test_connected_and_advertising, 10);
> +
>  	test_bredrle("Remove Advertising - Invalid Params 1",
>  					&remove_advertising_fail_1,
>  					NULL, test_command_generic);


=2D-=20
pozdrawiam
Szymon Janc


