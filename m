Return-Path: <cyrus@holtmann.org>
Message-ID: <52CD5E9E.9090503@linux.intel.com>
Date: Wed, 08 Jan 2014 16:20:14 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2] android-tester: Add HIDHost initial interface setup
 test
References: <1389178957-8730-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1581614.crLN0P0epW@uw000953>
In-Reply-To: <1581614.crLN0P0epW@uw000953>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 01/08/2014 04:02 PM, Szymon Janc wrote:
> Hi Ravi,
>
> On Wednesday 08 of January 2014 13:02:37 Ravi kumar Veeramally wrote:
>> ---
>>   android/android-tester.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/android/android-tester.c b/android/android-tester.c
>> index 9a161ad..cbb827d 100644
>> --- a/android/android-tester.c
>> +++ b/android/android-tester.c
>> @@ -39,6 +39,7 @@
>>   #include <hardware/hardware.h>
>>   #include <hardware/bluetooth.h>
>>   #include <hardware/bt_sock.h>
>> +#include <hardware/bt_hh.h>
>>   
>>   #include "utils.h"
>>   
>> @@ -79,6 +80,7 @@ struct test_data {
>>   	struct hw_device_t *device;
>>   	const bt_interface_t *if_bluetooth;
>>   	const btsock_interface_t *if_sock;
>> +	const bthh_interface_t *if_hid;
>>   
>>   	bool mgmt_settings_set;
>>   	bool cb_count_checked;
>> @@ -958,6 +960,16 @@ static bt_callbacks_t bt_callbacks = {
>>   	.le_test_mode_cb = NULL
>>   };
>>   
>> +static bthh_callbacks_t bthh_callbacks = {
>> +	.size = sizeof(bthh_callbacks),
>> +	.connection_state_cb = NULL,
>> +	.hid_info_cb = NULL,
>> +	.protocol_mode_cb = NULL,
>> +	.idle_time_cb = NULL,
>> +	.get_report_cb = NULL,
>> +	.virtual_unplug_cb = NULL
>> +};
>> +
>>   static void setup(struct test_data *data)
>>   {
>>   	const hw_module_t *module;
>> @@ -1069,6 +1081,11 @@ static void teardown(const void *test_data)
>>   		data->if_bluetooth = NULL;
>>   	}
>>   
>> +	if (data->if_hid) {
>> +		data->if_hid->cleanup();
>> +		data->if_hid = NULL;
>> +	}
>> +
> This results in test being aborted due to IPC error. After bluetooth
> service is closed daemon exits. I think hid cleanup should be called
> before bluetooth cleanup.
>
> In future also please pay attention to tester output while testing your patches
> i.e. tests summary should be printed.
   Sorry, updated and sent _v3.

  Thanks,
  Ravi.
>
>>   	data->device->close(data->device);
>>   
>>   	if (data->bluetoothd_pid)
>> @@ -1860,6 +1877,39 @@ clean:
>>   		close(sock_fd);
>>   }
>>   
>> +static void setup_hidhost_interface(const void *test_data)
>> +{
>> +	struct test_data *data = tester_get_data();
>> +	bt_status_t status;
>> +	const void *hid;
>> +
>> +	setup(data);
>> +
>> +	status = data->if_bluetooth->init(&bt_callbacks);
>> +	if (status != BT_STATUS_SUCCESS) {
>> +		data->if_bluetooth = NULL;
>> +		tester_setup_failed();
>> +		return;
>> +	}
>> +
>> +	hid = data->if_bluetooth->get_profile_interface(BT_PROFILE_HIDHOST_ID);
>> +	if (!hid) {
>> +		tester_setup_failed();
>> +		return;
>> +	}
>> +
>> +	data->if_hid = hid;
>> +
>> +	status = data->if_hid->init(&bthh_callbacks);
>> +	if (status != BT_STATUS_SUCCESS) {
>> +		data->if_hid = NULL;
>> +		tester_setup_failed();
>> +		return;
>> +	}
>> +
>> +	tester_setup_complete();
>> +}
>> +
>>   #define test_bredrle(name, data, test_setup, test, test_teardown) \
>>   	do { \
>>   		struct test_data *user; \
>> @@ -2071,5 +2121,8 @@ int main(int argc, char *argv[])
>>   			setup_socket_interface_enabled,
>>   			test_socket_real_connect, teardown);
>>   
>> +	test_bredrle("HIDHost Init", NULL, setup_hidhost_interface,
>> +						test_dummy, teardown);
>> +
>>   	return tester_run();
>>   }
>>

