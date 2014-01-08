Return-Path: <cyrus@holtmann.org>
Message-ID: <52CD1A97.8090400@linux.intel.com>
Date: Wed, 08 Jan 2014 11:29:59 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 3/4] android/pan: Implement PAN enable HAL api at daemon
 side
References: <1389097880-14783-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1389097880-14783-4-git-send-email-ravikumar.veeramally@linux.intel.com> <7986762.b1HJLuCvE7@uw000953>
In-Reply-To: <7986762.b1HJLuCvE7@uw000953>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 01/08/2014 11:24 AM, Szymon Janc wrote:
> Hi Ravi,
>
>> ---
>>   android/pan.c | 32 ++++++++++++++++++++++++++------
>>   1 file changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/android/pan.c b/android/pan.c
>> index 0eef284..0e12245 100644
>> --- a/android/pan.c
>> +++ b/android/pan.c
>> @@ -585,18 +585,38 @@ static void bt_pan_enable(const void *buf, uint16_t len)
>>   {
>>   	const struct hal_cmd_pan_enable *cmd = buf;
>>   	uint8_t status;
>> +	int err;
>> +
>> +	DBG("");
>> +
>> +	if (local_role == cmd->local_role) {
>> +		status = HAL_STATUS_SUCCESS;
>> +		goto reply;
>> +	}
>> +
>> +	/* destroy existing server */
>> +	destroy_nap_device();
>>   
>>   	switch (cmd->local_role) {
>>   	case HAL_PAN_ROLE_PANU:
>> -	case HAL_PAN_ROLE_NAP:
>> -		DBG("Not Implemented");
>> -		status  = HAL_STATUS_FAILED;
>> -		break;
>> -	default:
>>   		status = HAL_STATUS_UNSUPPORTED;
>> -		break;
>> +		goto reply;
>> +	case HAL_PAN_ROLE_NONE:
>> +		status = HAL_STATUS_SUCCESS;
>> +		goto reply;
>> +	}
> Why do you remove default here? Daemon should verify parameter correctness.

   Yes, default should be there, I think I was still in the impression of
  HAL side parameter validation. I will correct it in next version.

  Thanks,
  Ravi.
>
>> +
>> +	local_role = cmd->local_role;
>> +	err = register_nap_server();
>> +	if (err < 0) {
>> +		status = HAL_STATUS_FAILED;
>> +		destroy_nap_device();
>> +		goto reply;
>>   	}
>>   
>> +	status = HAL_STATUS_SUCCESS;
>> +
>> +reply:
>>   	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE, status);
>>   }
>>   
>>

