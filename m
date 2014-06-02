Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFCv2 2/2] android/gatt: Add test command for database dump
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401715171-29175-3-git-send-email-jakub.tyszkowski@tieto.com>
Date: Mon, 2 Jun 2014 17:05:13 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C088D1E3-5FAD-49FA-8255-B63ADB999622@holtmann.org>
References: <1401715171-29175-1-git-send-email-jakub.tyszkowski@tieto.com> <1401715171-29175-3-git-send-email-jakub.tyszkowski@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> With this we can check all attributes handles, uuids, permissions etc.
> on demand without adding to much logs. This will help to execute and
> verify some PTS test cases and debug.
> ---
> android/gatt.c    | 4 ++++
> android/hal-msg.h | 1 +
> 2 files changed, 5 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 429181f..83a051b 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3543,6 +3543,10 @@ static void handle_client_test_command(const void *buf, uint16_t len)
> 		status = test_read_write(&bdaddr, &uuid, cmd->u1, cmd->u2,
> 						cmd->u3, cmd->u4, cmd->u5);
> 		break;
> +	case GATT_CLIENT_TEST_CMD_DB_DUMP:
> +		gatt_db_dump(gatt_db);
> +		status = HAL_STATUS_SUCCESS;
> +		break;
> 	case GATT_CLIENT_TEST_CMD_PAIRING_CONFIG:
> 	default:
> 		status = HAL_STATUS_FAILED;
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 5da62f3..ce86304 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -753,6 +753,7 @@ struct hal_cmd_gatt_client_set_adv_data {
> #define GATT_CLIENT_TEST_CMD_DISCOVER		0x04
> #define GATT_CLIENT_TEST_CMD_READ		0xe0
> #define GATT_CLIENT_TEST_CMD_WRITE		0xe1
> +#define GATT_CLIENT_TEST_CMD_DB_DUMP		0xe2
> #define GATT_CLIENT_TEST_CMD_PAIRING_CONFIG	0xf0

are these all defined by Bluedroid and Android Bluetooth Service or are some of these BlueZ specific? If so we need to comment that.

Regards

Marcel

