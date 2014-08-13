Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <53EB6393.8070107@linux.intel.com>
References: <1407777812-15652-1-git-send-email-lukasz.rymanowski@tieto.com>
	<53EB6393.8070107@linux.intel.com>
Date: Wed, 13 Aug 2014 17:30:55 +0300
Message-ID: <CABBYNZ+hYxYcU-heUFHpvyHkCPv7Qk+xtgvedcqAWuXF8-TWmw@mail.gmail.com>
Subject: Re: [PATCH] android/health: Fix reconnect scenario
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 13, 2014 at 4:09 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> ping.
>
>
> On 08/11/2014 08:23 PM, Lukasz Rymanowski wrote:
>>
>> When trying to reconnect to HDP device, BfA tries to connect MDL even
>> MCL is not connected.
>>
>> D/BlueZ   ( 2218):
>> external/bluetooth/bluez/android/hal-health.c:connect_channel()
>> I/bluetoothd( 2220): bluetoothd[2221]:
>> external/bluetooth/bluez/android/health.c:bt_health_connect_channel()
>> I/bluetoothd( 2220): bluetoothd[2221]:
>> external/bluetooth/bluez/android/health.c:create_channel() mdep 1
>> D/BlueZ   ( 2218):
>> external/bluetooth/bluez/android/hal-bluetooth.c:handle_acl_state_changed()
>> state 0
>> I/bluetoothd( 2220): bluetoothd[2221]:
>> external/bluetooth/bluez/android/mcap-lib.c:mcap_create_mdl()
>> I/bluetoothd( 2220): bluetoothd[2221]: health: error creating mdl MCL is
>> not connected
>>
>> This patch makes sure that MCL is connected before trying to connect
>> MDL.
>> ---
>>   android/health.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/android/health.c b/android/health.c
>> index 2d80365..f4edc3e 100644
>> --- a/android/health.c
>> +++ b/android/health.c
>> @@ -1949,7 +1949,7 @@ static void bt_health_connect_channel(const void
>> *buf, uint16_t len)
>>                 }
>>         }
>>   -     if (!dev->mcl) {
>> +       if (!dev->mcl || (dev->mcl && !dev->mcl_conn)) {
>>                 if (connect_mcl(channel) < 0) {
>>                         error("health: error retrieving HDP SDP record");
>>                         goto fail;
>
>
> Ravi.

Pushed, thanks.


-- 
Luiz Augusto von Dentz
