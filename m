Return-Path: <cyrus@holtmann.org>
Message-ID: <4C49658D.4090906@libresoft.es>
Date: Fri, 23 Jul 2010 11:49:01 +0200
From: Santiago Carot-Nemesio <scarot@libresoft.es>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 16/60] Implement function to send md_reconnect_mdl_req
References: <1279788733-2324-8-git-send-email-sancane@gmail.com> <1279788733-2324-9-git-send-email-sancane@gmail.com> <1279788733-2324-10-git-send-email-sancane@gmail.com> <1279788733-2324-11-git-send-email-sancane@gmail.com> <1279788733-2324-12-git-send-email-sancane@gmail.com> <1279788733-2324-13-git-send-email-sancane@gmail.com> <1279788733-2324-14-git-send-email-sancane@gmail.com> <1279788733-2324-15-git-send-email-sancane@gmail.com> <1279788733-2324-16-git-send-email-sancane@gmail.com> <1279788733-2324-17-git-send-email-sancane@gmail.com> <20100722234724.GE2620@vigoh>
In-Reply-To: <20100722234724.GE2620@vigoh>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/23/10 01:47, Gustavo F. Padovan wrote:
> * Santiago Carot-Nemesio<sancane@gmail.com>  [2010-07-22 10:52:11 +0200]:
>
>    
>> ---
>>   mcap/mcap.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 51 insertions(+), 0 deletions(-)
>>
>> diff --git a/mcap/mcap.c b/mcap/mcap.c
>> index dc55cda..a0f00af 100644
>> --- a/mcap/mcap.c
>> +++ b/mcap/mcap.c
>> @@ -261,6 +261,20 @@ static uint16_t generate_mdlid(struct mcap_mcl *mcl)
>>   	return mdlid;
>>   }
>>
>> +static uint8_t *create_req(uint8_t op, uint16_t mdl_id)
>> +{
>> +	uint8_t *req;
>> +	mcap_md_req *req_cmd;
>> +
>> +	req = g_malloc0(sizeof(mcap_md_req));
>> +
>> +	req_cmd = (mcap_md_req *)req;
>> +	req_cmd->op = op;
>> +	req_cmd->mdl = htons(mdl_id);
>> +
>> +	return req;
>> +}
>>      
> Why are you casting here? I would expect  mcap_md_req * as return type
> here. If the problem is with mcap_send_std_opcode() you can used "void *" as
> parameter type there.
>
>    
I don't see why is better doing it as you say.
In fact I did it to make the code similar to other bluez modules like 
sdp. You can see the sdp_send_req_w4_rsp and the sdp_send_req functions 
in sdp.c to find similarities with my code.

>> +
>>   static uint8_t *create_mdl_req(uint16_t mdl_id, uint8_t mdep, uint8_t conf)
>>   {
>>   	uint8_t *req;
>> @@ -356,6 +370,43 @@ void mcap_req_mdl_creation(struct mcap_mcl *mcl,
>>   									mcl);
>>   }
>>
>> +void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
>> +				GError **err,
>> +				mcap_mdl_operation_cb reconnect_cb,
>> +				gpointer user_data)
>> +{
>> +	struct mcap_mdl_op_cb *con;
>> +	struct mcap_mcl *mcl = mdl->mcl;
>> +	uint8_t *cmd;
>> +
>> +	if (mdl->state != MDL_CLOSED) {
>> +		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
>> +					"MDL is not closed");
>> +		return;
>> +	}
>> +	con = g_new0(struct mcap_mdl_op_cb, 1);
>> +
>> +	cmd = create_req(MCAP_MD_RECONNECT_MDL_REQ, mdl->mdlid);
>> +	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
>> +	if (*err) {
>> +		g_free(con);
>> +		g_free(cmd);
>> +		return;
>> +	}
>> +
>> +	mdl->state = MDL_WAITING;
>> +
>> +	con->mdl = mdl;
>> +	con->cb.op = reconnect_cb;
>> +	con->user_data = user_data;
>> +
>> +	mcl->state = MCL_ACTIVE;
>> +	mcl->priv_data = con;
>> +
>> +	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
>> +									mcl);
>> +}
>> +
>>   static void update_mcl_state(struct mcap_mcl *mcl)
>>   {
>>   	GSList *l;
>>      
>    

