Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/ipc-tester: Add cases for the handsfree client interface
Date: Fri, 26 Sep 2014 12:29:51 +0200
Message-ID: <3356830.ekRRoiuXIV@uw000953>
In-Reply-To: <1411455136-28194-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411455136-28194-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 23 of September 2014 08:52:16 Jakub Tyszkowski wrote:
> ---
>  android/ipc-tester.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 210 insertions(+)
> 
> diff --git a/android/ipc-tester.c b/android/ipc-tester.c
> index 5ca236a..66632f8 100644
> --- a/android/ipc-tester.c
> +++ b/android/ipc-tester.c
> @@ -834,6 +834,36 @@ static struct hidhost_send_data_data hidhost_send_data_unders = {
>  	.buf = send_data_data,
>  };
>  
> +#define hfp_number "#1234567890"
> +
> +struct hfp_dial_data {
> +	struct ipc_hdr hdr;
> +	struct hal_cmd_hf_client_dial data;
> +
> +	uint8_t buf[IPC_MTU - sizeof(struct ipc_hdr) -
> +				sizeof(struct hal_cmd_hf_client_dial)];
> +} __attribute__((packed));
> +
> +static struct hfp_dial_data hfp_dial_overs = {
> +	.hdr.service_id = HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +	.hdr.opcode = HAL_OP_HF_CLIENT_DIAL,
> +	.hdr.len = sizeof(struct hal_cmd_hf_client_dial) +
> +							sizeof(hfp_number),
> +
> +	.data.number_len = sizeof(hfp_number) + 1,
> +	.buf = hfp_number,
> +};
> +
> +static struct hfp_dial_data hfp_dial_unders = {
> +	.hdr.service_id = HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +	.hdr.opcode = HAL_OP_HF_CLIENT_DIAL,
> +	.hdr.len = sizeof(struct hal_cmd_hf_client_dial) +
> +							sizeof(hfp_number),
> +
> +	.data.number_len = sizeof(hfp_number) - 1,
> +	.buf = hfp_number,
> +};
> +
>  int main(int argc, char *argv[])
>  {
>  	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
> @@ -892,6 +922,10 @@ int main(int argc, char *argv[])
>  	test_opcode_valid("A2DP", HAL_SERVICE_ID_A2DP, 0x03, 0,
>  			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_A2DP);
>  
> +	test_opcode_valid("HF_CLIENT", HAL_SERVICE_ID_HANDSFREE_CLIENT, 0x10, 0,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +
>  	/* check for valid data size */
>  	test_datasize_valid("CORE Register+", HAL_SERVICE_ID_CORE,
>  			HAL_OP_REGISTER_MODULE,
> @@ -1258,5 +1292,181 @@ int main(int argc, char *argv[])
>  			sizeof(struct hal_cmd_a2dp_disconnect), -1,
>  			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_A2DP);
>  
> +	/* Check for valid data size for Handsfree Client */
> +	test_datasize_valid("HF_CLIENT Connect+",
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_OP_HF_CLIENT_CONNECT,
> +			sizeof(struct hal_cmd_hf_client_connect), 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Connect-",
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_OP_HF_CLIENT_CONNECT,
> +			sizeof(struct hal_cmd_hf_client_connect), -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Disconnect+",
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_OP_HF_CLIENT_DISCONNECT,
> +			sizeof(struct hal_cmd_hf_client_disconnect), 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Disconnect-",
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_OP_HF_CLIENT_DISCONNECT,
> +			sizeof(struct hal_cmd_hf_client_disconnect), -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Connect Audio+",
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_OP_HF_CLIENT_CONNECT_AUDIO,
> +			sizeof(struct hal_cmd_hf_client_connect_audio), 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Connect Audio-",
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_OP_HF_CLIENT_CONNECT_AUDIO,
> +			sizeof(struct hal_cmd_hf_client_connect_audio), -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Disconnect Audio+",
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_OP_HF_CLIENT_DISCONNECT_AUDIO,
> +			sizeof(struct hal_cmd_hf_client_disconnect_audio), 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Disconnect Audio-",
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +			HAL_OP_HF_CLIENT_DISCONNECT_AUDIO,
> +			sizeof(struct hal_cmd_hf_client_disconnect_audio), -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Start VR+", HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_START_VR,
> +			0, 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Start VR-", HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_START_VR,
> +			0, -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Stop VR+", HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_STOP_VR,
> +			0, 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Stop VR-", HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_STOP_VR,
> +			0, -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Vol Contr.+", HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_VOLUME_CONTROL,
> +			sizeof(struct hal_cmd_hf_client_volume_control), 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Vol Contr.-", HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_VOLUME_CONTROL,
> +			sizeof(struct hal_cmd_hf_client_volume_control), -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_generic("Data size HF_CLIENT Dial Vardata+",
> +			ipc_send_tc, setup, teardown,
> +			&hfp_dial_overs,
> +			(sizeof(struct ipc_hdr) +
> +				sizeof(struct hal_cmd_hf_client_dial) +
> +				sizeof(hfp_number)),
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_generic("Data size HF_CLIENT Dial Vardata-",
> +			ipc_send_tc, setup, teardown,
> +			&hfp_dial_unders,
> +			(sizeof(struct ipc_hdr) +
> +				sizeof(struct hal_cmd_hf_client_dial) +
> +				sizeof(hfp_number)),
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Dial Memory+", HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_DIAL_MEMORY,
> +			sizeof(struct hal_cmd_hf_client_dial_memory), 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Dial Memory-", HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_DIAL_MEMORY,
> +			sizeof(struct hal_cmd_hf_client_dial_memory), -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Call Action+", HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_CALL_ACTION,
> +			sizeof(struct hal_cmd_hf_client_call_action), 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Call Action-", HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_CALL_ACTION,
> +			sizeof(struct hal_cmd_hf_client_call_action), -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Query Current Calls+",
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_QUERY_CURRENT_CALLS,
> +			0, 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Query Current Calls-",
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_QUERY_CURRENT_CALLS,
> +			0, -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Query Operator Name+",
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME,
> +			0, 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Query Operator Name-",
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME,
> +			0, -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Retrieve Subscrb. Info+",
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO,
> +			0, 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Retrieve Subscrb. Info-",
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO,
> +			0, -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Send DTMF+",
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_SEND_DTMF,
> +			sizeof(struct hal_cmd_hf_client_send_dtmf), 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Send DTMF-",
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_SEND_DTMF,
> +			sizeof(struct hal_cmd_hf_client_send_dtmf), -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Get Last Voice Tag+",
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM,
> +			0, 1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +	test_datasize_valid("HF_CLIENT Get Last Voice Tag-",
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM,
> +			0, -1,
> +			HAL_SERVICE_ID_BLUETOOTH,
> +			HAL_SERVICE_ID_HANDSFREE_CLIENT);
> +
>  	return tester_run();
>  }
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
