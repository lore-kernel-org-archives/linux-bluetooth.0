Return-Path: <cyrus@holtmann.org>
Message-ID: <52CD19E7.9000602@linux.intel.com>
Date: Wed, 08 Jan 2014 11:27:03 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 1/4] android/pan: Register Network Access Point
References: <1389097880-14783-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1389097880-14783-2-git-send-email-ravikumar.veeramally@linux.intel.com> <1697122.rgbbQeg154@uw000953>
In-Reply-To: <1697122.rgbbQeg154@uw000953>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 01/08/2014 11:18 AM, Szymon Janc wrote:
> Hi Ravi,
>
>> +
>> +	nap_dev.record_id = rec->handle;
>>   	ipc_register(HAL_SERVICE_ID_PAN, cmd_handlers,
>>   						G_N_ELEMENTS(cmd_handlers));
>>   
>> @@ -455,6 +559,6 @@ void bt_pan_unregister(void)
>>   	bnep_cleanup();
>>   
>>   	ipc_unregister(HAL_SERVICE_ID_PAN);
>> -	bt_adapter_remove_record(record_id);
>> -	record_id = 0;
>> +	bt_adapter_remove_record(nap_dev.record_id);
>> +	destroy_nap_device();
> I would either zero nap_dev.record_id right after removing record or move
> removing record to destroy_nap_device().

  OK, I will zero it right after removing record.

  Thanks,
  Ravi.
