Return-Path: <cyrus@holtmann.org>
Message-ID: <528B6D20.1000009@linux.intel.com>
Date: Tue, 19 Nov 2013 15:52:32 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 3/5] android: Handle multiple init(register) and cleanup(unregister)
 calls properly
References: <1384863676-12358-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1384863676-12358-3-git-send-email-ravikumar.veeramally@linux.intel.com> <20131119133000.GC30863@x220.p-661hnu-f1>
In-Reply-To: <20131119133000.GC30863@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 11/19/2013 03:30 PM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Tue, Nov 19, 2013, Ravi kumar Veeramally wrote:
>> @@ -2275,6 +2275,9 @@ bool bt_bluetooth_register(int sk)
>>   {
>>   	DBG("");
>>   
>> +	if (notification_sk > 0)
> 0 is a valid file descriptor value so the check should be >= 0
>
>> @@ -1190,6 +1190,9 @@ bool bt_hid_register(int sk, const bdaddr_t *addr)
>>   
>>   	DBG("");
>>   
>> +	if (notification_sk > 0)
>> +		return false;
> Same here.
>
>> @@ -95,6 +95,9 @@ bool bt_pan_register(int sk, const bdaddr_t *addr)
>>   {
>>   	DBG("");
>>   
>> +	if (notification_sk > 0)
>> +		return false;
> And here.
>
> Johan
>
  Ok.

  Thanks,
  Ravi.
