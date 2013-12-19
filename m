Return-Path: <cyrus@holtmann.org>
Message-ID: <52B305B5.9020003@tieto.com>
Date: Thu, 19 Dec 2013 15:41:57 +0100
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android/tester: Fix for not checking for BT_STATUS_SUCCESS
References: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com> <20131219134224.GA23417@x220.p-661hnu-f1>
In-Reply-To: <20131219134224.GA23417@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 12/19/2013 02:42 PM, Johan Hedberg wrote:
> Hi Jakub,
>
> On Thu, Dec 19, 2013, Jakub Tyszkowski wrote:
>> For BT_STATUS_SUCCESS no checks were done as it is 0 in bt_status_t
>> enum. Valid status for no status expected should be STATUS_NOT_EXPECTED.
>>
>> ---
>>   android/android-tester.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/android/android-tester.c b/android/android-tester.c
>> index c24f5a6..5549dcb 100644
>> --- a/android/android-tester.c
>> +++ b/android/android-tester.c
>> @@ -72,7 +72,7 @@ enum hal_bluetooth_callbacks_id {
>>   };
>>
>>   struct generic_data {
>> -	uint8_t expected_adapter_status;
>> +	int expected_adapter_status;
>>   	uint32_t expect_settings_set;
>>   	bt_property_t expected_property;
>>   	uint8_t expected_hal_callbacks[];
>> @@ -92,6 +92,8 @@ struct socket_data {
>>   #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
>>   #define EMULATOR_SIGNAL "emulator_started"
>>
>> +#define BT_STATUS_NOT_EXPECTED	-1
>> +
>>   struct test_data {
>>   	struct mgmt *mgmt;
>>   	uint16_t mgmt_index;
>> @@ -199,7 +201,7 @@ static void expected_status_init(struct test_data *data)
>>   {
>>   	const struct generic_data *test_data = data->test_data;
>>
>> -	if (!(test_data->expected_adapter_status))
>> +	if (test_data->expected_adapter_status == BT_STATUS_NOT_EXPECTED)
>>   		data->status_checked = true;
>>   }
>
> I suppose it does make sense to have such a special value, but I can't
> see you use it anywhere in your patch set. So I'd postpone this patch
> until you've got some actual code that needs it.
>
> Johan
>
But this will actually leave the tester not checking for 
BT_STATUS_SUCCESS (0 in enum) at all during real tests, as it is already 
being set as checked during the expected_status_init() call.
