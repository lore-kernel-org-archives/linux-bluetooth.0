Return-Path: <cyrus@holtmann.org>
Message-ID: <52834A76.4050600@linux.intel.com>
Date: Wed, 13 Nov 2013 11:46:30 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH_v3 3/3] android/pan: Handle connection and control state
 notifications
References: <1384334727-25940-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1384334727-25940-3-git-send-email-ravikumar.veeramally@linux.intel.com> <20131113093301.GB1749@x220.p-661hnu-f1>
In-Reply-To: <20131113093301.GB1749@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/13/2013 11:33 AM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Wed, Nov 13, 2013, Ravi kumar Veeramally wrote:
>> ---
>>   android/hal-pan.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
> I've applied the first two patches, but for this one I've got a few
> questions:
>
>> diff --git a/android/hal-pan.c b/android/hal-pan.c
>> index 851c5d2..2bc560e 100644
>> --- a/android/hal-pan.c
>> +++ b/android/hal-pan.c
>> @@ -31,10 +31,41 @@ static bool interface_ready(void)
>>   	return cbs != NULL;
>>   }
>>   
>> +static void handle_conn_state(void *buf)
>> +{
>> +	struct hal_ev_pan_conn_state *ev = buf;
>> +
>> +	if (cbs->connection_state_cb)
>> +		cbs->connection_state_cb(ev->state, ev->status,
>> +					(bt_bdaddr_t *) ev->bdaddr,
>> +					ev->local_role, ev->remote_role);
>> +}
>> +
>> +static void handle_ctrl_state(void *buf)
>> +{
>> +	struct hal_ev_pan_ctrl_state *ev = buf;
>> +
>> +	if (cbs->control_state_cb)
>> +		cbs->control_state_cb(ev->state, ev->status,
>> +					ev->local_role, (char *)ev->name);
>> +}
>> +
>>   void bt_notify_pan(uint8_t opcode, void *buf, uint16_t len)
>>   {
>>   	if (!interface_ready())
>>   		return;
>> +
>> +	switch (opcode) {
>> +	case HAL_EV_PAN_CONN_STATE:
>> +		handle_conn_state(buf);
>> +		break;
>> +	case HAL_EV_PAN_CTRL_STATE:
>> +		handle_ctrl_state(buf);
>> +		break;
>> +	default:
>> +		DBG("Unhandled callback opcode=0x%x", opcode);
>> +		break;
>> +	}
>>   }
> What I don't like about this is that you're not pushing the data length
> to the handler functions. If you did that the handler functions could:
>
> 	if (len < sizeof(*ev))
> 		return;
>
> Instead of return we could also just abort - what's the general policy
> on the HAL side regarding invalid data from the daemon? How does this
> relate to the work Szymon is doing to add proper checks for the IPC
> data? Is that only for the daemon side?
>
> Are we missing similar checks in other HALs too?

   Yes, we are not doing similar checks in other HALs 
(hal-bluetooth/a2dp/hid/) too.
   Very few places in hal-bluetooth length is passing but validation is 
not done.
   I will fix them all and send you the patch.

  Thanks,
  Ravi.
