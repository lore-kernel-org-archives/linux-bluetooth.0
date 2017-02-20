Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <df2d0d02-2d38-2712-4d9e-e40d7d47370b@felipetonello.com>
References: <20170216180315.30531-1-eu@felipetonello.com> <20170216180315.30531-4-eu@felipetonello.com>
 <df2d0d02-2d38-2712-4d9e-e40d7d47370b@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Feb 2017 18:55:46 +0200
Message-ID: <CABBYNZLL4gjTnFhBTEniErMcOynPBXEBW5s2aK_xs_8hUB-jsQ@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ 3/7] src/device: Added function to set connection parameters
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Fri, Feb 17, 2017 at 2:17 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi,
>
> On 16/02/17 18:03, Felipe F. Tonello wrote:
>> This function allows plugins to set the connection parameters of the
>> respective btd_device object.
>>
>> It is useful for GAP Peripheral Preferred Connection Parameters
>> characteristic for example.
>> ---
>>  src/device.c | 16 ++++++++++++++++
>>  src/device.h |  4 ++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 8693eb826b54..d4aa7f90561e 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -6122,3 +6122,19 @@ void btd_device_cleanup(void)
>>  {
>>       btd_service_remove_state_cb(service_state_cb_id);
>>  }
>> +
>> +void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
>> +                                     uint16_t max_interval, uint16_t latency,
>> +                                     uint16_t timeout)
>> +{
>> +     btd_assert(device != NULL);
>
> This assert shouldn't be here. I'll fix next revision.

Is this new revision coming anytime soon?

>> +
>> +     adapter_store_conn_param(device->adapter, &device->bdaddr,
>> +                                     device->bdaddr_type, min_interval,
>> +                                     max_interval, latency,
>> +                                     timeout);
>> +     adapter_load_conn_param(device->adapter, &device->bdaddr,
>> +                                     device->bdaddr_type, min_interval,
>> +                                     max_interval, latency,
>> +                                     timeout);
>> +}
>> diff --git a/src/device.h b/src/device.h
>> index 3cab366eeaea..88076d2d196d 100644
>> --- a/src/device.h
>> +++ b/src/device.h
>> @@ -163,3 +163,7 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services);
>>
>>  void btd_device_init(void);
>>  void btd_device_cleanup(void);
>> +
>> +void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
>> +                                     uint16_t max_interval, uint16_t latency,
>> +                                     uint16_t timeout);
>>
>
> --
> Felipe



-- 
Luiz Augusto von Dentz
