Return-Path: <cyrus@holtmann.org>
Message-ID: <528B6DBB.6060008@linux.intel.com>
Date: Tue, 19 Nov 2013 15:55:07 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 5/5] android/hidhost: Free all connected devices in profile
 cleanup call
References: <1384863676-12358-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1384863676-12358-5-git-send-email-ravikumar.veeramally@linux.intel.com> <20131119133506.GE30863@x220.p-661hnu-f1>
In-Reply-To: <20131119133506.GE30863@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/19/2013 03:35 PM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Tue, Nov 19, 2013, Ravi kumar Veeramally wrote:
>> ---
>>   android/hidhost.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/android/hidhost.c b/android/hidhost.c
>> index 05a3fe4..20dedc4 100644
>> --- a/android/hidhost.c
>> +++ b/android/hidhost.c
>> @@ -1226,6 +1226,14 @@ bool bt_hid_register(int sk, const bdaddr_t *addr)
>>   	return true;
>>   }
>>   
>> +static void free_hid_devices(gpointer data, gpointer user_data)
>> +{
>> +	struct hid_device *dev = data;
>> +
>> +	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
>> +	hid_device_free(dev);
>> +}
>> +
>>   void bt_hid_unregister(void)
>>   {
>>   	DBG("");
>> @@ -1233,6 +1241,8 @@ void bt_hid_unregister(void)
>>   	if (notification_sk < 0)
>>   		return;
>>   
>> +	g_slist_foreach(devices, free_hid_devices, NULL);
> I suppose you also need to set devices = NULL; after this call?
  Sure.

  Thanks,
  Ravi.
