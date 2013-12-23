Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v2 2/2] android/bluetooth: Print error on unimplemented functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1387796839-8164-2-git-send-email-szymon.janc@tieto.com>
Date: Mon, 23 Dec 2013 05:53:01 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <78923B74-D53E-4D00-AF55-4485A1CB924D@holtmann.org>
References: <1387796839-8164-1-git-send-email-szymon.janc@tieto.com> <1387796839-8164-2-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Functions, callbacks or properties that are not implemented due to
> being bogus or not feasible now prints error messages.
> ---
> android/bluetooth.c | 22 ++++++++++++++++++++--
> 1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 59f0810..0700972 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -2146,6 +2146,10 @@ static void handle_get_adapter_prop_cmd(const void *buf, uint16_t len)
> 		break;
> 	}
> 
> +	if (status != HAL_STATUS_SUCCESS && status != HAL_STATUS_DONE)
> +		error("Failed to get adapter property (type %u status %u)",
> +							cmd->type, status);
> +
> 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROP, status);
> }
> 
> @@ -2293,6 +2297,10 @@ static void handle_set_adapter_prop_cmd(const void *buf, uint16_t len)
> 		break;
> 	}
> 
> +	if (status != HAL_STATUS_SUCCESS && status != HAL_STATUS_DONE)
> +		error("Failed to set adapter property (type %u status %u)",
> +							cmd->type, status);
> +
> 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_ADAPTER_PROP, status);
> }
> 
> @@ -2745,6 +2753,10 @@ static void handle_get_remote_device_prop_cmd(const void *buf, uint16_t len)
> 		break;
> 	}
> 
> +	if (status != HAL_STATUS_SUCCESS && status != HAL_STATUS_DONE)
> +		error("Failed to get device property (type %u status %u)",
> +							cmd->type, status);
> +
> failed:
> 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_DEVICE_PROP,
> 								status);
> @@ -2809,6 +2821,10 @@ static void handle_set_remote_device_prop_cmd(const void *buf, uint16_t len)
> 		break;
> 	}
> 
> +	if (status != HAL_STATUS_SUCCESS && status != HAL_STATUS_DONE)
> +		error("Failed to set device property (type %u status %u)",
> +							cmd->type, status);
> +
> failed:
> 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_REMOTE_DEVICE_PROP,
> 									status);
> @@ -2818,6 +2834,8 @@ static void handle_get_remote_service_rec_cmd(const void *buf, uint16_t len)
> {
> 	/* TODO */
> 
> +	error("get_remote_service_record not supported");
> +
> 	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_SERVICE_REC,
> 							HAL_STATUS_FAILED);
> }
> @@ -2914,7 +2932,7 @@ static void handle_dut_mode_send_cmd(const void *buf, uint16_t len)
> 		return;
> 	}
> 
> -	DBG("opcode %u", cmd->opcode);
> +	error("dut_mode_send not supported”);
> 
> 	/* TODO */
> 
> @@ -2932,7 +2950,7 @@ static void handle_le_test_mode_cmd(const void *buf, uint16_t len)
> 		return;
> 	}
> 
> -	DBG("opcode %u", cmd->opcode);
> +	error("le_test_mode not supported”);

please keep the cmd->opcode in the error message here in both cases. This is valuable information on what kind of HCI command the Java layer tries to send.

Regards

Marcel

