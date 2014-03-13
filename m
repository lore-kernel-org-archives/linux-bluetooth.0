Return-Path: <cyrus@holtmann.org>
Message-ID: <532178D4.9050603@linux.intel.com>
Date: Thu, 13 Mar 2014 11:22:28 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 12/15] android/hal-health: Add HDP .connect_channel method
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1394637058-586-13-git-send-email-ravikumar.veeramally@linux.intel.com> <1451588.llZxefWAr7@athlon>
In-Reply-To: <1451588.llZxefWAr7@athlon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 03/12/2014 10:05 PM, Szymon Janc wrote:
> Hi Ravi,
>
> On Wednesday 12 March 2014 17:10:55 Ravi kumar Veeramally wrote:
>> ---
>>   android/hal-health.c | 31 ++++++++++++++++++++++++++++++-
>>   1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/android/hal-health.c b/android/hal-health.c
>> index 007a37a..0d10d98 100644
>> --- a/android/hal-health.c
>> +++ b/android/hal-health.c
>> @@ -106,6 +106,35 @@ static bt_status_t unregister_application(int app_id)
>>   					sizeof(cmd), &cmd, 0, NULL, NULL);
>>   }
>>
>> +static bt_status_t connect_channel(int app_id, bt_bdaddr_t *bd_addr,
>> +					int mdep_cfg_index, int *channel_id)
>> +{
>> +	struct hal_cmd_health_connect_channel cmd;
>> +	struct hal_rsp_health_connect_channel rsp;
>> +	size_t len = sizeof(rsp);
>> +	bt_status_t status;
>> +
>> +	DBG("");
>> +
>> +	if (!interface_ready())
>> +		return BT_STATUS_NOT_READY;
>> +
>> +	if (!bd_addr)
>> +		return BT_STATUS_PARM_INVALID;
> Verify channel_id pointer as well here.
>
>> +
>> +	cmd.app_id = app_id;
>> +	cmd.mdep_index = mdep_cfg_index;
>> +	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
>> +
>> +	status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH,
>> +					HAL_OP_HEALTH_CONNECT_CHANNEL,
>> +					sizeof(cmd), &cmd, &len, &rsp, NULL);
>> +
>> +	*channel_id = rsp.channel_id;
> if (status == HAL_STATUS_SUCCESS)
>      *channel_id = rsp.channel_id;
>
> Otherwise you might assign garbage.

   Ok, I will fix all your comments.
>> +
>> +	return status;
>> +}
>> +
>>   static bt_status_t init(bthl_callbacks_t *callbacks)
>>   {
>>   	struct hal_cmd_register_module cmd;
>> @@ -159,7 +188,7 @@ static bthl_interface_t health_if = {
>>   	.init = init,
>>   	.register_application = register_application,
>>   	.unregister_application = unregister_application,
>> -	.connect_channel = NULL,
>> +	.connect_channel = connect_channel,
>>   	.destroy_channel = NULL,
>>   	.cleanup = cleanup
>>   };

Thanks,
Ravi.
