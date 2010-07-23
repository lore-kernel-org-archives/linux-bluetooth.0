Return-Path: <cyrus@holtmann.org>
Message-ID: <4C495FA2.5070901@libresoft.es>
Date: Fri, 23 Jul 2010 11:23:46 +0200
From: Santiago Carot-Nemesio <scarot@libresoft.es>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 12/60] Managing connection of Data Channels
References: <1279788733-2324-4-git-send-email-sancane@gmail.com> <1279788733-2324-5-git-send-email-sancane@gmail.com> <1279788733-2324-6-git-send-email-sancane@gmail.com> <1279788733-2324-7-git-send-email-sancane@gmail.com> <1279788733-2324-8-git-send-email-sancane@gmail.com> <1279788733-2324-9-git-send-email-sancane@gmail.com> <1279788733-2324-10-git-send-email-sancane@gmail.com> <1279788733-2324-11-git-send-email-sancane@gmail.com> <1279788733-2324-12-git-send-email-sancane@gmail.com> <1279788733-2324-13-git-send-email-sancane@gmail.com> <20100722235452.GG2620@vigoh>
In-Reply-To: <20100722235452.GG2620@vigoh>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 07/23/10 01:54, Gustavo F. Padovan wrote:
> Hi Santiago,
>
> * Santiago Carot-Nemesio<sancane@gmail.com>  [2010-07-22 10:52:07 +0200]:
>
>    
>> ---
>>   mcap/mcap.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 files changed, 70 insertions(+), 1 deletions(-)
>>
>> diff --git a/mcap/mcap.c b/mcap/mcap.c
>> index cf44472..1d86c51 100644
>> --- a/mcap/mcap.c
>> +++ b/mcap/mcap.c
>> @@ -754,6 +754,27 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
>>   		proc_req[mcl->state](mcl, cmd, len);
>>   }
>>
>> +static gboolean mdl_event_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
>> +{
>> +
>> +	struct mcap_mdl *mdl = data;
>> +	gboolean notify;
>> +
>> +	DBG("Close MDL %d", mdl->mdlid);
>> +
>> +	notify = (mdl->state == MDL_CONNECTED);
>>      
> You actually don't need 'notify', just put the comparison in the if
> below.
>
>    

That is not true, you need to do it there because you need to know if 
the MDL has been closed due a delete operation initiated by upper layer 
(HDP) or it has been closed by remote side. In any case, MCAP need 
shutdown the channel to set the MDL in a proper state before make any 
callback. See coment below:
>> +	shutdown_mdl(mdl);
>>      

Above function sets the MDL state to closed, due that you can not check 
the MDL state after shutdown it. I suggest to look that part of the code 
to understand how data channel are managed by each MCL.
Note that mdl_event_cb is called from the watcher funtion set to the 
bluetooth channel. When control flow reaches this part of the code the 
MDL state can be connected or deleted. How can you know the MDL state 
after doing a shutdown over the data channel?, remember that MCAP does 
not know what will happen into the upper layer callback, due that, it 
need set the MDL in a proper state by shutting down it before make the 
callback.

>> +
>> +	update_mcl_state(mdl->mcl);
>> +
>> +	if (notify) {
>> +		/*Callback to upper layer */
>> +		mdl->mcl->cb->mdl_closed(mdl, mdl->mcl->cb->user_data);
>> +	}
>> +
>> +	return FALSE;
>> +}
>> +
>>   static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
>>   								gpointer data)
>>   {
>> @@ -779,9 +800,57 @@ fail:
>>   	return FALSE;
>>   }
>>
>> +static void connect_dc_event_cb(GIOChannel *chan, GError *err,
>> +							gpointer user_data)
>> +{
>> +	struct mcap_mdl *mdl = user_data;
>> +	struct mcap_mcl *mcl = mdl->mcl;
>> +
>> +	mdl->state = MDL_CONNECTED;
>> +	mdl->dc = g_io_channel_ref(chan);
>> +	mdl->wid = g_io_add_watch(mdl->dc, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
>> +						(GIOFunc) mdl_event_cb, mdl);
>> +
>> +	mcl->state = MCL_ACTIVE;
>> +	mcl->cb->mdl_connected(mdl, mcl->cb->user_data);
>> +}
>> +
>>   static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
>>   {
>> -	/* TODO */
>> +	struct mcap_instance *ms = user_data;
>> +	struct mcap_mcl *mcl;
>> +	struct mcap_mdl *mdl;
>> +	GError *err = NULL;
>> +	bdaddr_t dst;
>> +	GSList *l;
>> +
>> +	bt_io_get(chan, BT_IO_L2CAP,&err,
>> +			BT_IO_OPT_DEST_BDADDR,&dst,
>> +			BT_IO_OPT_INVALID);
>> +	if (err) {
>> +		error("%s", err->message);
>> +		g_error_free(err);
>> +		goto drop;
>> +	}
>> +
>> +	mcl = find_mcl(ms->mcls,&dst);
>> +	if (!mcl || (mcl->state != MCL_PENDING))
>>      
> No need for () in the '!=' comparison.
>
>    
>> +		goto drop;
>> +
>> +	for (l = mcl->mdls; l; l = l->next) {
>> +		mdl = l->data;
>> +		if (mdl->state == MDL_WAITING) {
>> +			if (!bt_io_accept(chan, connect_dc_event_cb, mdl, NULL,
>> +									&err)) {
>> +				error("MDL accept error %s", err->message);
>> +				g_error_free(err);
>> +				goto drop;
>> +			}
>> +			return;
>> +		}
>> +	}
>> +drop:
>> +	g_io_channel_shutdown(chan, TRUE, NULL);
>>   }
>>
>>   static void connect_mcl_event_cb(GIOChannel *chan, GError *err,
>>      
>    

