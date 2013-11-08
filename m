Return-Path: <cyrus@holtmann.org>
Message-ID: <527CD8C2.3030507@linux.intel.com>
Date: Fri, 08 Nov 2013 14:27:46 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH_v4 1/5] android/hid: Fix set seport ipc cmd preparation
References: <1383912531-1306-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1383912531-1306-2-git-send-email-ravikumar.veeramally@linux.intel.com> <20131108121531.GA1371@x220.p-661hnu-f1>
In-Reply-To: <20131108121531.GA1371@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/08/2013 02:15 PM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Fri, Nov 08, 2013, Ravi kumar Veeramally wrote:
>> -	memcpy(cmd.data, report, cmd.len);
>> +	memset(cmd, 0, sizeof(buf));
> How about memset(buf, 0, sizeof(buf)) to make this perfectly clear.
   Ok.
>   Btw,
> why is the memset needed? I don't think the original code had it. Seems
> like this is an independent bug fix?
   Not in original, but in between versions (v1~v4) :(.
>
>> +	cmd->len = strlen(report);
>> +	memcpy(cmd->data, report, cmd->len);
>>   
>>   	switch (report_type) {
>>   	case BTHH_INPUT_REPORT:
>> -		cmd.type = HAL_HIDHOST_INPUT_REPORT;
>> +		cmd->type = HAL_HIDHOST_INPUT_REPORT;
>>   		break;
>>   	case BTHH_OUTPUT_REPORT:
>> -		cmd.type = HAL_HIDHOST_OUTPUT_REPORT;
>> +		cmd->type = HAL_HIDHOST_OUTPUT_REPORT;
>>   		break;
>>   	case BTHH_FEATURE_REPORT:
>> -		cmd.type = HAL_HIDHOST_FEATURE_REPORT;
>> +		cmd->type = HAL_HIDHOST_FEATURE_REPORT;
>>   		break;
>>   	default:
>>   		return BT_STATUS_PARM_INVALID;
>>   	}
>>   
>>   	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT,
>> -				sizeof(cmd), &cmd, 0, NULL, NULL);
>> +					sizeof(buf), buf, 0, NULL, NULL);
> This last call looks broken to me. Shouldn't you instead of sizeof(buf)
> be sending sizeof(*cmd) + cmd->len?
   yes, should be "sizeof(*cmd) + cmd->len".
>
> Johan
>
Thanks,
Ravi.
