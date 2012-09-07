Return-Path: <cyrus@holtmann.org>
Message-ID: <5049A718.6020701@tieto.com>
Date: Fri, 7 Sep 2012 09:49:44 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] gatt: Remove reading Service Changed characteristic after
 connected
References: <1346928807-17149-1-git-send-email-andrzej.kaczmarek@tieto.com> <CAKT1EBdHL8q-sm=ibqZFoTFYtzeNTVHjB2wvoFBS=zHrb7xyxQ@mail.gmail.com>
In-Reply-To: <CAKT1EBdHL8q-sm=ibqZFoTFYtzeNTVHjB2wvoFBS=zHrb7xyxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On 09/06/2012 03:56 PM, Claudio Takahasi wrote:
> Hi Andrzej:
>
> On Thu, Sep 6, 2012 at 7:53 AM, Andrzej Kaczmarek
> <andrzej.kaczmarek@tieto.com> wrote:

<snip>

>>   static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
>>                                                          gpointer user_data)
>>   {
>> @@ -311,8 +280,6 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>>          /* TODO: Read other GAP characteristics - See Core spec page 1739 */
>>
>>          /*
>> -        * Always read the characteristic value in the first connection
>> -        * since attribute handles caching is not supported at the moment.
>>           * When re-connecting <<Service Changed>> handle and characteristic
>>           * value doesn't need to read again: known information from the
>>           * previous interaction.
>> @@ -322,10 +289,6 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>>
>>                  bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
>>
>> -               gatt_read_char_by_uuid(gas->attrib, gas->gatt.start,
>> -                                               gas->gatt.end, &uuid,
>> -                                               gatt_service_changed_cb, gas);
>> -
>>                  gatt_discover_char(gas->attrib, gas->gatt.start, gas->gatt.end,
>>                                          &uuid, gatt_characteristic_cb, gas);
>>          }
>> --
>> 1.7.11.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> As discussed in the IRC, please add in the commit message the BT SPEC
> errata information/section.
>
> Since we can't read the characteristic value, it will be necessary to
> store the handle, otherwise BlueZ will loose the Service Changed
> Indication when re-connecting.

Handle is already stored during characteristics discovery 
(gatt_characteristic_cb) so this should not be a problem.

BR,
Andrzej
