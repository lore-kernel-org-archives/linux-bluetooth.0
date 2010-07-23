Return-Path: <cyrus@holtmann.org>
Message-ID: <4C495FE9.7010802@libresoft.es>
Date: Fri, 23 Jul 2010 11:24:57 +0200
From: Santiago Carot-Nemesio <scarot@libresoft.es>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 18/60] Implement function to send md_abort_mdl_req
References: <1279788733-2324-10-git-send-email-sancane@gmail.com> <1279788733-2324-11-git-send-email-sancane@gmail.com> <1279788733-2324-12-git-send-email-sancane@gmail.com> <1279788733-2324-13-git-send-email-sancane@gmail.com> <1279788733-2324-14-git-send-email-sancane@gmail.com> <1279788733-2324-15-git-send-email-sancane@gmail.com> <1279788733-2324-16-git-send-email-sancane@gmail.com> <1279788733-2324-17-git-send-email-sancane@gmail.com> <1279788733-2324-18-git-send-email-sancane@gmail.com> <1279788733-2324-19-git-send-email-sancane@gmail.com> <20100723000709.GI2620@vigoh>
In-Reply-To: <20100723000709.GI2620@vigoh>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
On 07/23/10 02:07, Gustavo F. Padovan wrote:
> Hi Santiago,
>
> * Santiago Carot-Nemesio<sancane@gmail.com>  [2010-07-22 10:52:13 +0200]:
>
>    
>> ---
>>   mcap/mcap.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 48 insertions(+), 0 deletions(-)
>>
>> diff --git a/mcap/mcap.c b/mcap/mcap.c
>> index 5419d54..6f6e08a 100644
>> --- a/mcap/mcap.c
>> +++ b/mcap/mcap.c
>> @@ -519,6 +519,38 @@ void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
>>   		g_free(con);
>>   }
>>
>> +void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
>> +			mcap_mdl_del_cb abort_cb, gpointer user_data)
>> +{
>> +	struct mcap_mdl_op_cb *con;
>> +	struct mcap_mcl *mcl = mdl->mcl;
>> +	uint8_t *cmd;
>> +
>> +	if (mdl->state != MDL_WAITING) {
>> +		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
>> +							"Mdl in invalid state");
>> +		return;
>> +	}
>> +
>> +	con = g_new0(struct mcap_mdl_op_cb, 1);
>> +	cmd = create_req(MCAP_MD_ABORT_MDL_REQ, mdl->mdlid);
>> +	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
>> +	if (*err) {
>> +		g_free(con);
>> +		g_free(cmd);
>> +		return;
>> +	}
>> +
>> +	con->mdl = mdl;
>> +	con->cb.del = abort_cb;
>> +	con->user_data = user_data;
>> +
>> +	mcl->priv_data = con;
>> +
>> +	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
>> +									mcl);
>> +}
>> +
>>   static void update_mcl_state(struct mcap_mcl *mcl)
>>   {
>>   	GSList *l;
>> @@ -554,6 +586,22 @@ static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
>>   	return NULL;
>>   }
>>
>> +int mcap_mdl_get_fd(struct mcap_mdl *mdl)
>> +{
>> +	if ((!mdl) || (mdl->state != MDL_CONNECTED))
>> +		return -1;
>>      
> A proper Unix error is better than -1 here.
>    
Patch 58 fix that.
>    
>> +
>> +	return g_io_channel_unix_get_fd(mdl->dc);
>> +}
>> +
>> +uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl)
>> +{
>> +	if (!mdl)
>> +		return MCAP_MDLID_RESERVED;
>> +
>> +	return mdl->mdlid;
>> +}
>> +
>>   static void shutdown_mdl(struct mcap_mdl *mdl)
>>   {
>>   	mdl->state = MDL_CLOSED;
>>      
>    

