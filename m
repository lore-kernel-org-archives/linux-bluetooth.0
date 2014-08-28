Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK1OHKc4iuU-MovGHJoQGmrP2ckY2erTsPdD1PnwzVhiA@mail.gmail.com>
References: <1409172464-30369-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1409172464-30369-2-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZK1OHKc4iuU-MovGHJoQGmrP2ckY2erTsPdD1PnwzVhiA@mail.gmail.com>
Date: Thu, 28 Aug 2014 10:47:37 +0200
Message-ID: <CAN_7+YZKP4uV2Q_bdPO_DHwU+pgiRJp-FMwJtQ6hGWax1h7CgA@mail.gmail.com>
Subject: Re: [PATCH 1/3] android/bluetooth: Add unpaired device callback
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Aug 28, 2014 at 10:06 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Wed, Aug 27, 2014 at 11:47 PM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> GATT, HID, HOG, might be interested in the fact that some device has
>> been unpaired in order to clear cache or similar. This patch adds means
>> to register callback for unpaired event.
>> ---
>>  android/bluetooth.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  android/bluetooth.h |  3 +++
>>  2 files changed, 41 insertions(+)
>>
>> diff --git a/android/bluetooth.c b/android/bluetooth.c
>> index 984ecba..588ecd4 100644
>> --- a/android/bluetooth.c
>> +++ b/android/bluetooth.c
>> @@ -41,6 +41,7 @@
>>  #include "lib/uuid.h"
>>  #include "src/shared/util.h"
>>  #include "src/shared/mgmt.h"
>> +#include "src/shared/queue.h"
>>  #include "src/eir.h"
>>  #include "lib/sdp.h"
>>  #include "lib/sdp_lib.h"
>> @@ -223,6 +224,8 @@ static struct ipc *hal_ipc = NULL;
>>
>>  static bool kernel_conn_control = false;
>>
>> +static struct queue *unpaired_cb_list;
>> +
>>  static void get_device_android_addr(struct device *dev, uint8_t *addr)
>>  {
>>         /*
>> @@ -1688,6 +1691,22 @@ void bt_auto_connect_remove(const bdaddr_t *addr)
>>         error("Failed to remove device");
>>  }
>>
>> +static bool match_by_value(const void *data, const void *user_data)
>> +{
>> +       return data == user_data;
>> +}
>> +
>> +void bt_unpaired_register(bt_unpaired_device_cb cb)
>> +{
>> +       if (!unpaired_cb_list)
>> +               return;
>> +
>> +       if (queue_find(unpaired_cb_list, match_by_value, cb))
>> +               return;
>> +
>> +       queue_push_head(unpaired_cb_list, cb);
>> +}
>
> Shouldn't it take the actual device address as well? Otherwise each
> callback has to do a lookup on its own which is not that great.
>

I thought about it but eventually drop this idea. It is because each
module interested in this callback needs to find provided device on
their lists anyway. It is in order to remove it.
If we would like to provide address in register function we would have
to do some additional checks before actually callback call - so double
check which is not nice.
Queue would be also bigger since it would have to be  for each device
etc. So I would keep that approach if you agree

>>  static bool rssi_above_threshold(int old, int new)
>>  {
>>         /* only 8 dBm or more */
>> @@ -4313,6 +4332,14 @@ failed:
>>                                                                         status);
>>  }
>>
>> +static void send_unpaired_notification(void *data, void *user_data)
>> +{
>> +       bt_unpaired_device_cb cb = data;
>> +       bdaddr_t *addr = user_data;
>> +
>> +       cb(addr);
>> +}
>> +
>>  static void unpair_device_complete(uint8_t status, uint16_t length,
>>                                         const void *param, void *user_data)
>>  {
>> @@ -4330,6 +4357,9 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
>>
>>         update_device_state(dev, rp->addr.type, HAL_STATUS_SUCCESS, false,
>>                                                                 false, false);
>> +
>> +       queue_foreach(unpaired_cb_list, send_unpaired_notification,
>> +                                                               &dev->bdaddr);
>>  }
>>
>>  static void handle_remove_bond_cmd(const void *buf, uint16_t len)
>> @@ -5114,6 +5144,12 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
>>
>>         DBG("mode 0x%x", mode);
>>
>> +       unpaired_cb_list = queue_new();
>> +       if (!unpaired_cb_list) {
>> +               error("Can not allocate queue for unpaired callbacks");
>> +               return false;
>> +       }
>> +
>>         missing_settings = adapter.current_settings ^
>>                                         adapter.supported_settings;
>>
>> @@ -5185,4 +5221,6 @@ void bt_bluetooth_unregister(void)
>>
>>         ipc_unregister(hal_ipc, HAL_SERVICE_ID_CORE);
>>         hal_ipc = NULL;
>> +
>> +       queue_destroy(unpaired_cb_list, NULL);
>>  }
>> diff --git a/android/bluetooth.h b/android/bluetooth.h
>> index ac7f3ad..6db2b88 100644
>> --- a/android/bluetooth.h
>> +++ b/android/bluetooth.h
>> @@ -85,3 +85,6 @@ bool bt_kernel_conn_control(void);
>>  bool bt_auto_connect_add(const bdaddr_t *addr);
>>
>>  void bt_auto_connect_remove(const bdaddr_t *addr);
>> +
>> +typedef void (*bt_unpaired_device_cb)(const bdaddr_t *addr);
>> +void bt_unpaired_register(bt_unpaired_device_cb cb );
>> --
>> 1.8.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Lukasz
