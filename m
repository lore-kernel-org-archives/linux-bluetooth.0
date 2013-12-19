Return-Path: <cyrus@holtmann.org>
Message-ID: <52B2B2C3.2030802@linux.intel.com>
Date: Thu, 19 Dec 2013 10:48:03 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: [PATCH_v4 3/7] android/pan: shutdown io channel on disconnect
 call
References: <1387378396-6259-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1387378396-6259-3-git-send-email-ravikumar.veeramally@linux.intel.com> <20131219081452.GB31549@x220.p-661hnu-f1>
In-Reply-To: <20131219081452.GB31549@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 19.12.2013 10:14, Johan Hedberg wrote:
> Hi Ravi,
>
> On Wed, Dec 18, 2013, Ravi kumar Veeramally wrote:
>> Shutdown io channel and send DISCONNECTING notification and send
>> DISCONNECTED notification and free the device on callback.
>> ---
>>   android/pan.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
> I've applied the first two patches, but one thing with this one:
>
>> diff --git a/android/pan.c b/android/pan.c
>> index b83f534..f64b09a 100644
>> --- a/android/pan.c
>> +++ b/android/pan.c
>> @@ -269,7 +269,7 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
>>   {
>>   	const struct hal_cmd_pan_disconnect *cmd = buf;
>>   	struct pan_device *dev;
>> -	uint8_t status;
>> +	uint8_t status = HAL_STATUS_FAILED;
>>   	GSList *l;
>>   	bdaddr_t dst;
>>   
>> @@ -278,20 +278,20 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
>>   	android2bdaddr(&cmd->bdaddr, &dst);
>>   
>>   	l = g_slist_find_custom(devices, &dst, device_cmp);
>> -	if (!l) {
>> -		status = HAL_STATUS_FAILED;
>> +	if (!l)
>>   		goto failed;
> Since we in general try to avoid initializations upon declaration I'd
> keep the status = HAL_STATUS_FAILED here. Even if it would be ok to move
> it it shouldn't be in this patch since it's unrelated.
  Ok, make sense. I'll send you updated patch set from 3-7 in a moment.

Thanks,
Ravi.
