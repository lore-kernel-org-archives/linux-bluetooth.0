Return-Path: <cyrus@holtmann.org>
Message-ID: <4C494C00.9070108@libresoft.es>
Date: Fri, 23 Jul 2010 10:00:00 +0200
From: Santiago Carot-Nemesio <scarot@libresoft.es>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 10/60] Process md_abort_mdl_req in PENDING state
References: <1279788733-2324-2-git-send-email-sancane@gmail.com> <1279788733-2324-3-git-send-email-sancane@gmail.com> <1279788733-2324-4-git-send-email-sancane@gmail.com> <1279788733-2324-5-git-send-email-sancane@gmail.com> <1279788733-2324-6-git-send-email-sancane@gmail.com> <1279788733-2324-7-git-send-email-sancane@gmail.com> <1279788733-2324-8-git-send-email-sancane@gmail.com> <1279788733-2324-9-git-send-email-sancane@gmail.com> <1279788733-2324-10-git-send-email-sancane@gmail.com> <1279788733-2324-11-git-send-email-sancane@gmail.com> <20100722235021.GF2620@vigoh>
In-Reply-To: <20100722235021.GF2620@vigoh>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 07/23/10 01:50, Gustavo F. Padovan wrote:
> Hi Santiago,
>
> * Santiago Carot-Nemesio<sancane@gmail.com>  [2010-07-22 10:52:05 +0200]:
>
>    
>> ---
>>   mcap/mcap.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 files changed, 49 insertions(+), 1 deletions(-)
>>
>> diff --git a/mcap/mcap.c b/mcap/mcap.c
>> index d6a9760..9f41c6b 100644
>> --- a/mcap/mcap.c
>> +++ b/mcap/mcap.c
>> @@ -551,6 +551,51 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
>>   	send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_SUCCESS, mdl_id);
>>   }
>>
>> +static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
>> +								uint32_t len)
>> +{
>> +	mcap_md_req *req;
>> +	GSList *l;
>> +	struct mcap_mdl *mdl, *del;
>> +	uint16_t mdl_id;
>> +
>> +	if (len != sizeof(mcap_md_req)) {
>> +		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
>> +				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
>>      
> I remenber about a Johan's comment on send4B_cmd(). It was basically,
> wouldn't be better have function to send data of a arbritrary size. I
> think I saw a send5B_cmd() in these patches as well.
>    

Yes, patch 56 Fix that.
That is a big change in MCAP core to be amended in previous patches and 
to expect that intermediate patches still compile.
In fact, it may be a stupid waste of time try to do that to hide MCAP 
developing history. I'm not sure if that it is a good idea and as far I 
remember we accorded to keep MCAP history in last meeting.

>    
>> +		return;
>> +	}
>> +
>> +	req = (mcap_md_req *)cmd;
>> +	mdl_id = ntohs(req->mdl);
>> +	mcl->state = MCL_CONNECTED;
>> +	for (l = mcl->mdls; l; l = l->next) {
>> +		mdl = l->data;
>> +		if ((mdl_id == mdl->mdlid)&&  (mdl->state == MDL_WAITING)) {
>> +			del = mdl;
>> +			if (mcl->state != MCL_CONNECTED)
>> +				break;
>> +			continue;
>> +		}
>> +		if ((mdl->state == MDL_CONNECTED)&&  (mcl->state != MCL_ACTIVE))
>> +			mcl->state = MCL_ACTIVE;
>> +
>> +		if ((del)&&  (mcl->state == MCL_ACTIVE))
>> +			break;
>> +	}
>> +
>> +	if (!del) {
>> +		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_INVALID_MDL,
>> +									mdl_id);
>> +		return;
>> +	}
>> +
>> +	mcl->cb->mdl_aborted(del, mcl->cb->user_data);
>> +
>> +	mcl->mdls = g_slist_remove(mcl->mdls, del);
>> +	g_free(del);
>> +	send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_SUCCESS, mdl_id);
>> +}
>> +
>>   static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
>>   								uint32_t len)
>>   {
>> @@ -626,7 +671,10 @@ static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
>>
>>   static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
>>   {
>> -	/* TODO */
>> +	if (cmd[0] == MCAP_MD_ABORT_MDL_REQ)
>> +		process_md_abort_mdl_req(mcl, cmd, len);
>> +	else
>> +		error_cmd_rsp(mcl, cmd, len);
>>   }
>>
>>   static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
>>      
>    

