Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJMAJbDwutWndn55nWQOdj310N2t85Qt4erMXu0sB5DKw@mail.gmail.com>
References: <1387564210-6102-1-git-send-email-szymon.janc@tieto.com>
	<CABBYNZJMAJbDwutWndn55nWQOdj310N2t85Qt4erMXu0sB5DKw@mail.gmail.com>
Date: Mon, 23 Dec 2013 11:46:39 +0200
Message-ID: <CABBYNZK-XO1dyET9kEELLdbmgQgZP3Y31LHkevuOtN3x7pVNNg@mail.gmail.com>
Subject: Re: [PATCH 1/4] android/bluetooth: Add support for timestamp device property
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 23, 2013 at 9:53 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Szymon,
>
> On Fri, Dec 20, 2013 at 8:30 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> This allows to handle timestamp property request. Also this will be
>> usefull for devices info cache (clearing old devices).
>> ---
>>  android/bluetooth.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/android/bluetooth.c b/android/bluetooth.c
>> index e534fc1..2e75864 100644
>> --- a/android/bluetooth.c
>> +++ b/android/bluetooth.c
>> @@ -80,6 +80,8 @@ struct device {
>>         uint32_t class;
>>         int32_t rssi;
>>
>> +       uint32_t timestamp;
>> +
>>         GSList *uuids;
>>  };
>>
>> @@ -227,6 +229,8 @@ static void store_device_info(struct device *dev)
>>         else
>>                 g_key_file_remove_key(key_file, addr, "Class", NULL);
>>
>> +       g_key_file_set_integer(key_file, addr, "Timestamp", dev->timestamp);
>> +
>>         if (dev->uuids) {
>>                 GSList *l;
>>                 int i;
>> @@ -291,6 +295,7 @@ static struct device *create_device(const bdaddr_t *bdaddr, uint8_t type)
>>         bacpy(&dev->bdaddr, bdaddr);
>>         dev->bdaddr_type = type;
>>         dev->bond_state = HAL_BOND_STATE_NONE;
>> +       dev->timestamp = time(NULL);
>>
>>         /* use address for name, will be change if one is present
>>          * eg. in EIR or set by set_property. */
>> @@ -1004,6 +1009,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>>
>>                 ev->status = HAL_STATUS_SUCCESS;
>>                 bdaddr2android(bdaddr, ev->bdaddr);
>> +
>> +               dev->timestamp = time(NULL);
>>         }
>>
>>         if (eir.class) {
>> @@ -1607,6 +1614,9 @@ static void create_device_from_info(GKeyFile *key_file, const char *peer)
>>
>>         dev->class = g_key_file_get_integer(key_file, peer, "Class", NULL);
>>
>> +       dev->timestamp = g_key_file_get_integer(key_file, peer, "Timestamp",
>> +                                                                       NULL);
>> +
>>         uuids = g_key_file_get_string_list(key_file, peer, "Services", NULL,
>>                                                                         NULL);
>>         if (uuids) {
>> @@ -2647,11 +2657,10 @@ static uint8_t get_device_version_info(struct device *dev)
>>
>>  static uint8_t get_device_timestamp(struct device *dev)
>>  {
>> -       DBG("Not implemented");
>> -
>> -       /* TODO */
>> +       send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_TIMESTAMP,
>> +                               sizeof(dev->timestamp), &dev->timestamp);
>>
>> -       return HAL_STATUS_FAILED;
>> +       return HAL_STATUS_SUCCESS;
>>  }
>>
>
> I guess it probably make sense to update the timestamp also whenever a
> connection completes or does bluedroid ignores it?

As discussed in irc this seems to be way HAL is defined, so Im
applying this one and patch 4, patches 2 and 3 needs some changes so
Im expecting a v2 soon.


-- 
Luiz Augusto von Dentz
