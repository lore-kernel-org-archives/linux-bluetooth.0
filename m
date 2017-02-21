Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v2 BlueZ 3/7] src/device: Added function to set connection
 parameters
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20170216180315.30531-1-eu@felipetonello.com>
 <20170216180315.30531-4-eu@felipetonello.com>
 <df2d0d02-2d38-2712-4d9e-e40d7d47370b@felipetonello.com>
 <CABBYNZLL4gjTnFhBTEniErMcOynPBXEBW5s2aK_xs_8hUB-jsQ@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Felipe Ferreri Tonello <eu@felipetonello.com>
Message-ID: <c081e2c4-a79c-791a-67b6-2fb8ceb05b22@felipetonello.com>
Date: Tue, 21 Feb 2017 09:37:56 +0000
MIME-Version: 1.0
In-Reply-To: <CABBYNZLL4gjTnFhBTEniErMcOynPBXEBW5s2aK_xs_8hUB-jsQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------D29406F8F21FBD38FA26F84B"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------D29406F8F21FBD38FA26F84B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Luiz,

On 20/02/17 16:55, Luiz Augusto von Dentz wrote:
> Hi Felipe,
> 
> On Fri, Feb 17, 2017 at 2:17 PM, Felipe Ferreri Tonello
> <eu@felipetonello.com> wrote:
>> Hi,
>>
>> On 16/02/17 18:03, Felipe F. Tonello wrote:
>>> This function allows plugins to set the connection parameters of the
>>> respective btd_device object.
>>>
>>> It is useful for GAP Peripheral Preferred Connection Parameters
>>> characteristic for example.
>>> ---
>>>  src/device.c | 16 ++++++++++++++++
>>>  src/device.h |  4 ++++
>>>  2 files changed, 20 insertions(+)
>>>
>>> diff --git a/src/device.c b/src/device.c
>>> index 8693eb826b54..d4aa7f90561e 100644
>>> --- a/src/device.c
>>> +++ b/src/device.c
>>> @@ -6122,3 +6122,19 @@ void btd_device_cleanup(void)
>>>  {
>>>       btd_service_remove_state_cb(service_state_cb_id);
>>>  }
>>> +
>>> +void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
>>> +                                     uint16_t max_interval, uint16_t latency,
>>> +                                     uint16_t timeout)
>>> +{
>>> +     btd_assert(device != NULL);
>>
>> This assert shouldn't be here. I'll fix next revision.
> 
> Is this new revision coming anytime soon?

I was waiting on any comments before.

> 
>>> +
>>> +     adapter_store_conn_param(device->adapter, &device->bdaddr,
>>> +                                     device->bdaddr_type, min_interval,
>>> +                                     max_interval, latency,
>>> +                                     timeout);
>>> +     adapter_load_conn_param(device->adapter, &device->bdaddr,
>>> +                                     device->bdaddr_type, min_interval,
>>> +                                     max_interval, latency,
>>> +                                     timeout);
>>> +}
>>> diff --git a/src/device.h b/src/device.h
>>> index 3cab366eeaea..88076d2d196d 100644
>>> --- a/src/device.h
>>> +++ b/src/device.h
>>> @@ -163,3 +163,7 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services);
>>>
>>>  void btd_device_init(void);
>>>  void btd_device_cleanup(void);
>>> +
>>> +void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
>>> +                                     uint16_t max_interval, uint16_t latency,
>>> +                                     uint16_t timeout);
>>>
>>
>> --
>> Felipe
> 
> 
> 

-- 
Felipe

--------------D29406F8F21FBD38FA26F84B
Content-Type: application/pgp-keys;
 name="0x92698E6A.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0x92698E6A.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SkAyCfQaSw==
=JwBB
-----END PGP PUBLIC KEY BLOCK-----

--------------D29406F8F21FBD38FA26F84B--
