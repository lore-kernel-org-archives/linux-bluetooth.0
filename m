Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <550A7C86.8050403@ubnt.com>
References: <1426712691-5048-1-git-send-email-luiz.dentz@gmail.com>
	<1426712691-5048-6-git-send-email-luiz.dentz@gmail.com>
	<550A7C86.8050403@ubnt.com>
Date: Thu, 19 Mar 2015 12:17:14 +0200
Message-ID: <CABBYNZL-_mTC+jNfN=8qHWi=zJ4t4u8+dU5wfBcebdQ3fj_uSA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] shared/gatt-client: Fix service discovery
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

On Thu, Mar 19, 2015 at 9:36 AM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
> Hi Luiz
>
> On 2015.03.18. 23:04, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> The code should proceed to discover all descriptors before moving to
>> next service otherwise it may attempt to insert characteristics in the
>> wrong service which would probably fail.
>> ---
>>  src/shared/gatt-client.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index 3e28c6e..729bd87 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -690,13 +690,13 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
>>                       goto failed;
>>       }
>>
>> +next:
>>       if (!discover_descs(op, &discovering))
>>               goto failed;
>>
>>       if (discovering)
>>               return;
>>
>> -next:
>>       /* Done with the current service */
>>       gatt_db_service_set_active(op->cur_svc, true);
>>
>>
>
> I tested this new patch-set and and results are the following:
> 1. Three characteristics (GAP, GATT and custom) do appear on D-BUs. This was not the case before.
> 2. CCC descriptor still does not appear on D-Bus. If I change handles on the peripheral back to sequential, then CCC appears on D-Bus also.
> 3. Reading of any characteristic times out with 'g-io-error-quark: Timeout was reached (24)'. Logs attached. Based on HCI dumps the ATT reading is OK, but for some reason result is not propagated to the D-Bus level, so D-Dbus method times out. With sequential handles reading works fine.

Strange for me it is working normally:

[NEW] Service /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011
Battery Service (Primary)
[NEW] Characteristic
/org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012 Battery
Level
[NEW] Descriptor
/org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012/desc0014
Client Characteristic Configuration
[Arc Touch Mouse SE]# select-attribute
/org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012
[Arc Touch Mouse SE:/service0011/char0012]# read
Attempting to read /org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012
[CHG] Attribute
/org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012 Value: 0x5d
  5d                                               ]
[Arc Touch Mouse SE:/service0011/char0012]# select-attribute
/org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012/desc0014
[Arc Touch Mouse SE:/service0011/char0012/desc0014]# read
Attempting to read
/org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012/desc0014
[CHG] Attribute
/org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012/desc0014
Value: 0x00
[CHG] Attribute
/org/bluez/hci0/dev_F3_43_74_B7_86_24/service0011/char0012/desc0014
Value: 0x00
  00 00

But perhaps this is because the handles are in sequence as you said,
can you try with the following changes:

http://fpaste.org/199962/67601931/

-- 
Luiz Augusto von Dentz
