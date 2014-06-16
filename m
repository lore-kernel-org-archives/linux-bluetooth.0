Return-Path: <cyrus@holtmann.org>
Message-ID: <539EB4FC.6010005@linux.intel.com>
Date: Mon, 16 Jun 2014 12:12:28 +0300
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] android/health: Notify application registration status
References: <1402578618-31484-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1402578618-31484-6-git-send-email-ravikumar.veeramally@linux.intel.com> <7545894.rj9sN0mCY5@uw000953>
In-Reply-To: <7545894.rj9sN0mCY5@uw000953>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 06/16/2014 11:59 AM, Szymon Janc wrote:
> Hi Ravi,
>
> On Thursday 12 of June 2014 16:10:17 Ravi kumar Veeramally wrote:
>> ---
>>   android/health.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/android/health.c b/android/health.c
>> index 45255df..687dfee 100644
>> --- a/android/health.c
>> +++ b/android/health.c
>> @@ -105,6 +105,19 @@ static void free_health_app(void *data)
>>   	free(app);
>>   }
>>   
>> +static void send_app_reg_notify(struct health_app *app, uint8_t state)
>> +{
>> +	struct hal_ev_health_app_reg_state ev;
>> +
>> +	DBG("");
>> +
>> +	ev.id = app->id;
>> +	ev.state = state;
>> +
>> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HEALTH,
>> +				HAL_EV_HEALTH_APP_REG_STATE, sizeof(ev), &ev);
>> +}
>> +
>>   static bool mdep_by_mdep_role(const void *data, const void *user_data)
>>   {
>>   	const struct mdep_cfg *mdep = data;
>> @@ -660,6 +673,7 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
>>   	}
>>   
>>   	status = HAL_STATUS_SUCCESS;
>> +	send_app_reg_notify(app, HAL_HEALTH_APP_REG_SUCCESS);
>>   
>>   fail:
>>   	if (status != HAL_STATUS_SUCCESS) {
>> @@ -686,12 +700,15 @@ static void bt_health_unregister_app(const void *buf, uint16_t len)
>>   		return;
>>   	}
>>   
>> +	send_app_reg_notify(app, HAL_HEALTH_APP_DEREG_SUCCESS);
>> +
>>   	if (record_id > 0) {
>>   		bt_adapter_remove_record(record_id);
>>   		record_id = 0;
>>   	}
>>   
>>   	free_health_app(app);
>> +
> Move this to proper patch (ie. one that added free_health_app call).
> This makes bisecting easier.
   Ok.
>>   	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
>>   				HAL_OP_HEALTH_UNREG_APP, HAL_STATUS_SUCCESS);
>>   }
>>

  Thanks,
  Ravi.
