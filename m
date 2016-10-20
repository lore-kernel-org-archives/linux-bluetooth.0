Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: =?utf-8?B?TWljaGHFgg==?= Narajowski
        <michal.narajowski@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 1/3] tools/mgmt-tester: Fix setup commands and conditions handling
Date: Thu, 20 Oct 2016 22:32:27 +0200
Message-ID: <70335012.KhHQpdqxA2@ix>
In-Reply-To: <1476802469-23292-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1476802469-23292-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Micha=C5=82,

On Tuesday, 18 October 2016 16:54:27 CEST Micha=C5=82 Narajowski wrote:
> It used to be a quick hack so it would be possible to send
> multiple mgmt cmds on setup. Now sending setup command in
> setup_command_generic adds a setup condition (separate from
> ordinary conditions) so a setup is only successful when all
> the setup conditions are met.
> ---
>  tools/mgmt-tester.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>=20
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index b052570..8929e09 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -63,6 +63,7 @@ struct test_data {
>  	struct hciemu *hciemu;
>  	enum hciemu_type hciemu_type;
>  	int unmet_conditions;
> +	int unmet_setup_conditions;
>  };
>=20
>  static void mgmt_debug(const char *str, void *user_data)
> @@ -287,6 +288,27 @@ static void test_add_condition(struct test_data *dat=
a)
>  	tester_print("Test condition added, total %d", data->unmet_conditions);
>  }
>=20
> +static void test_add_setup_condition(struct test_data *data)
> +{
> +	data->unmet_setup_conditions++;
> +
> +	tester_print("Test setup condition added, total %d",
> +		     data->unmet_setup_conditions);
> +}
> +
> +static void test_setup_condition_complete(struct test_data *data)
> +{
> +	data->unmet_setup_conditions--;
> +
> +	tester_print("Test setup condition complete, %d left",
> +		     data->unmet_setup_conditions);
> +
> +	if (data->unmet_setup_conditions > 0)
> +		return;
> +
> +	tester_setup_complete();
> +}
> +
>  static void test_condition_complete(struct test_data *data)
>  {
>  	data->unmet_conditions--;
> @@ -6086,7 +6108,7 @@ static void command_setup_hci_callback(uint16_t
> opcode, const void *param, }
>=20
>  	hciemu_clear_master_post_command_hooks(data->hciemu);
> -	test_condition_complete(data);
> +	test_setup_condition_complete(data);
>  }
>=20
>  static void command_hci_callback(uint16_t opcode, const void *param,
> @@ -6127,8 +6149,7 @@ static void setup_mgmt_cmd_callback(uint8_t status,
> uint16_t length, tester_setup_failed();
>  		return;
>  	}
> -
> -	tester_setup_complete();
> +	test_setup_condition_complete(user_data);
>  }
>=20
>  static void setup_command_generic(const void *test_data)
> @@ -6145,7 +6166,7 @@ static void setup_command_generic(const void
> *test_data) test->setup_expect_hci_command);
>  		hciemu_add_master_post_command_hook(data->hciemu,
>  					command_setup_hci_callback, data);
> -		test_add_condition(data);
> +		test_add_setup_condition(data);
>  	}
>=20
>  	if (test->setup_send_opcode) {
> @@ -6155,7 +6176,8 @@ static void setup_command_generic(const void
> *test_data) mgmt_send(data->mgmt, test->setup_send_opcode,
> data->mgmt_index, send_len, send_param,
>  					setup_mgmt_cmd_callback,
> -					NULL, NULL);
> +					data, NULL);
> +		test_add_setup_condition(data);
>  		return;
>  	}
>=20
> @@ -6173,10 +6195,9 @@ static void setup_command_generic(const void
> *test_data) mgmt_send(data->mgmt, cmd->send_opcode, data->mgmt_index,
>  				cmd->send_len, cmd->send_param,
>  				setup_mgmt_cmd_callback,
> -				NULL, NULL);
> +				data, NULL);
> +		test_add_setup_condition(data);
>  	}
> -
> -	tester_setup_complete();
>  }
>=20
>  static const uint8_t add_advertising_param_name[] =3D {
> @@ -7895,7 +7916,7 @@ int main(int argc, char *argv[])
>=20
>  	test_bredrle("Read Ext Controller Info 1",
>  				&read_ext_ctrl_info1,
> -				setup_command_generic, test_command_generic);
> +				NULL, test_command_generic);
>=20
>  	test_bredrle("Read Ext Controller Info 2",
>  				&read_ext_ctrl_info2,

All patches applied, thanks.
Note that I modified last patch to match with recent changes to name=20
shortening.

=2D-=20
pozdrawiam
Szymon Janc
