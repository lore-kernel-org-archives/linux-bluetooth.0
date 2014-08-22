Return-Path: <cyrus@holtmann.org>
Message-ID: <53F6FE8D.3000300@tieto.com>
Date: Fri, 22 Aug 2014 10:25:49 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/2] android/hid: Force encryption for keyboards
References: <1408615488-31534-1-git-send-email-jakub.tyszkowski@tieto.com>	<1408615488-31534-2-git-send-email-jakub.tyszkowski@tieto.com> <CABBYNZKw-ropQpjGuq0Ko7rTmXJBuTzHOi9Fu0R20EH3GJ58Ng@mail.gmail.com>
In-Reply-To: <CABBYNZKw-ropQpjGuq0Ko7rTmXJBuTzHOi9Fu0R20EH3GJ58Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 08/21/2014 01:58 PM, Luiz Augusto von Dentz wrote:
> Hi Jakub,
>
> On Thu, Aug 21, 2014 at 1:04 PM, Jakub Tyszkowski
> <jakub.tyszkowski@tieto.com> wrote:
>> Encryption is mandatory for keyboards.
>> ---
>>   android/hidhost.c | 27 ++++++++++++++++++++++++---
>>   1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/android/hidhost.c b/android/hidhost.c
>> index 07985d8..d57b24b 100644
>> --- a/android/hidhost.c
>> +++ b/android/hidhost.c
>> @@ -579,6 +579,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
>>   {
>>          struct hid_device *dev = user_data;
>>          GError *err = NULL;
>> +       int sec_level;
>>
>>          DBG("");
>>
>> @@ -589,12 +590,15 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
>>                  goto failed;
>>          }
>>
>> +       /* Encryption is mandatory for keyboards */
>> +       sec_level = (dev->subclass & 0x40) ? BT_IO_SEC_MEDIUM : BT_IO_SEC_LOW;
>> +
>>          /* Connect to the HID interrupt channel */
>>          dev->intr_io = bt_io_connect(interrupt_connect_cb, dev, NULL, &err,
>>                                          BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
>>                                          BT_IO_OPT_DEST_BDADDR, &dev->dst,
>>                                          BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
>> -                                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
>> +                                       BT_IO_OPT_SEC_LEVEL, sec_level,
>>                                          BT_IO_OPT_INVALID);
>>          if (!dev->intr_io) {
>>                  error("hidhost: Failed to connect interrupt channel (%s)",
>> @@ -618,6 +622,7 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
>>          struct hid_device *dev = data;
>>          sdp_list_t *list;
>>          GError *gerr = NULL;
>> +       int sec_level = BT_IO_SEC_LOW;
>>
>>          DBG("");
>>
>> @@ -640,9 +645,14 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
>>                          dev->country = data->val.uint8;
>>
>>                  data = sdp_data_get(rec, SDP_ATTR_HID_DEVICE_SUBCLASS);
>> -               if (data)
>> +               if (data) {
>>                          dev->subclass = data->val.uint8;
>>
>> +                       /* Encryption is mandatory for keyboards */
>> +                       if (dev->subclass & 0x40)
>> +                               sec_level =  BT_IO_SEC_MEDIUM;
>> +               }
>
> I prefer to store this info in the device struct e..g dev->sec_level

Seams reasonable. I'll be sending v2.

>
>>                  data = sdp_data_get(rec, SDP_ATTR_HID_BOOT_DEVICE);
>>                  if (data)
>>                          dev->boot_dev = data->val.uint8;
>> @@ -673,6 +683,17 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
>>          }
>>
>>          if (dev->ctrl_io) {
>> +               /* Encryption is mandatory for keyboards */
>> +               if ((dev->subclass & 0x40) && !bt_io_set(dev->ctrl_io, &gerr,
>> +                                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>> +                                       BT_IO_OPT_INVALID)) {
>> +                       error("hidhost: Cannot rise security level: %s",
>> +                                                               gerr->message);
>> +                       g_error_free(gerr);
>> +
>> +                       goto fail;
>> +               }
>> +
>>                  if (uhid_create(dev) < 0)
>>                          goto fail;
>>                  return;
>> @@ -682,7 +703,7 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
>>                                          BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
>>                                          BT_IO_OPT_DEST_BDADDR, &dev->dst,
>>                                          BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
>> -                                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
>> +                                       BT_IO_OPT_SEC_LEVEL, sec_level,
>>                                          BT_IO_OPT_INVALID);
>>          if (gerr) {
>>                  error("hidhost: Failed to connect control channel (%s)",
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

Regards,
Jakub

