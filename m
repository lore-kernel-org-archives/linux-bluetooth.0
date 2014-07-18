Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/9] emulator: Add flags param to advertise enabling function
Date: Fri, 18 Jul 2014 13:37:51 +0200
Message-ID: <5171266.A5jKLzk8eC@uw000953>
In-Reply-To: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405677021-18877-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 18 of July 2014 11:50:13 Jakub Tyszkowski wrote:
> This allows to pass additional parameter describing wheter to set
> flags parameter in advertising data.
> 
> This is needed to make device discoverable.
> ---
>  android/android-tester.c |  2 +-
>  emulator/bthost.c        | 21 ++++++++++++++++++++-
>  emulator/bthost.h        |  3 ++-
>  tools/l2cap-tester.c     |  2 +-
>  tools/mgmt-tester.c      |  2 +-
>  tools/smp-tester.c       |  2 +-
>  6 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index eb5c513..ff14fc8 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -701,7 +701,7 @@ static void setup_powered_emulated_remote(void)
>  	bthost_set_cmd_complete_cb(bthost, emu_connectable_complete, data);
>  
>  	if (data->hciemu_type == HCIEMU_TYPE_LE)
> -		bthost_set_adv_enable(bthost, 0x01);
> +		bthost_set_adv_enable(bthost, 0x01, 0x00);
>  	else
>  		bthost_write_scan_enable(bthost, 0x03);
>  }
> diff --git a/emulator/bthost.c b/emulator/bthost.c
> index 298edcf..b30999b 100644
> --- a/emulator/bthost.c
> +++ b/emulator/bthost.c
> @@ -747,6 +747,8 @@ static void evt_cmd_complete(struct bthost *bthost, const void *data,
>  		break;
>  	case BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY:
>  		break;
> +	case BT_HCI_CMD_LE_SET_ADV_DATA:
> +		break;
>  	default:
>  		printf("Unhandled cmd_complete opcode 0x%04x\n", opcode);
>  		break;
> @@ -2072,7 +2074,7 @@ void bthost_write_scan_enable(struct bthost *bthost, uint8_t scan)
>  	send_command(bthost, BT_HCI_CMD_WRITE_SCAN_ENABLE, &scan, 1);
>  }
>  
> -void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
> +void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable, uint8_t flags)
>  {
>  	struct bt_hci_cmd_le_set_adv_parameters cp;
>  
> @@ -2080,6 +2082,23 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
>  	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
>  							&cp, sizeof(cp));
>  
> +	if (flags) {
> +		struct bt_hci_cmd_le_set_adv_data adv_cp;
> +
> +		memset(adv_cp.data, 0, 31);
> +
> +		adv_cp.data[0] = 0x02;	/* Field length */
> +		adv_cp.data[1] = 0x01;	/* Flags */
> +		adv_cp.data[2] = flags;
> +
> +		adv_cp.data[3] = 0x00;	/* Field terminator */
> +
> +		adv_cp.len = 1 + adv_cp.data[0];
> +
> +		send_command(bthost, BT_HCI_CMD_LE_SET_ADV_DATA, &adv_cp,
> +								sizeof(adv_cp));
> +	}
> +
>  	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_ENABLE, &enable, 1);
>  }
>  
> diff --git a/emulator/bthost.h b/emulator/bthost.h
> index b00bcd6..4a7e2bd 100644
> --- a/emulator/bthost.h
> +++ b/emulator/bthost.h
> @@ -70,7 +70,8 @@ bool bthost_l2cap_req(struct bthost *bthost, uint16_t handle, uint8_t req,
>  
>  void bthost_write_scan_enable(struct bthost *bthost, uint8_t scan);
>  
> -void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable);
> +void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable,
> +								uint8_t flags);
>  
>  void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode);
>  
> diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
> index 79362b2..6841341 100644
> --- a/tools/l2cap-tester.c
> +++ b/tools/l2cap-tester.c
> @@ -535,7 +535,7 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
>  	bthost = hciemu_client_get_host(data->hciemu);
>  	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, user_data);
>  	if (data->hciemu_type == HCIEMU_TYPE_LE)
> -		bthost_set_adv_enable(bthost, 0x01);
> +		bthost_set_adv_enable(bthost, 0x01, 0x00);
>  	else
>  		bthost_write_scan_enable(bthost, 0x03);
>  }
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 16c3656..c813314 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -2946,7 +2946,7 @@ static void setup_bthost(void)
>  	bthost = hciemu_client_get_host(data->hciemu);
>  	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, data);
>  	if (data->hciemu_type == HCIEMU_TYPE_LE)
> -		bthost_set_adv_enable(bthost, 0x01);
> +		bthost_set_adv_enable(bthost, 0x01, 0x00);
>  	else
>  		bthost_write_scan_enable(bthost, 0x03);
>  }
> diff --git a/tools/smp-tester.c b/tools/smp-tester.c
> index 12e0bed..c9639e6 100644
> --- a/tools/smp-tester.c
> +++ b/tools/smp-tester.c
> @@ -411,7 +411,7 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
>  
>  	bthost = hciemu_client_get_host(data->hciemu);
>  	bthost_set_cmd_complete_cb(bthost, client_connectable_complete, data);
> -	bthost_set_adv_enable(bthost, 0x01);
> +	bthost_set_adv_enable(bthost, 0x01, 0x00);
>  }
>  
>  static void setup_powered_client(const void *test_data)
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
