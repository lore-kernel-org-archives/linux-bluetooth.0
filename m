Return-Path: <cyrus@holtmann.org>
Message-ID: <5476D9C3.3040807@tieto.com>
Date: Thu, 27 Nov 2014 08:58:59 +0100
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] android/gatt: Set proper MTU for BR/EDR link
References: <1416991660-21828-1-git-send-email-jakub.tyszkowski@tieto.com> <1416991660-21828-4-git-send-email-jakub.tyszkowski@tieto.com> <20141126124412.GA9449@t440s.lan>
In-Reply-To: <20141126124412.GA9449@t440s.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/26/2014 01:44 PM, Johan Hedberg wrote:
> Hi Jakub,
>
> On Wed, Nov 26, 2014, Jakub Tyszkowski wrote:
>> Minimum mtu depends on transport layer and is larger for BREDR link.
>> ---
>>   android/gatt.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index b9b3c7b..95ddba0 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -1439,7 +1439,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>>   	uint32_t status;
>>   	GAttrib *attrib;
>>   	uint16_t mtu;
>> -	uint16_t cid;
>> +	uint8_t dst_type;
>>
>>   	if (dev->state != DEVICE_CONNECT_READY) {
>>   		error("gatt: Device not in a connecting state!?");
>> @@ -1459,9 +1459,11 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>>   		goto reply;
>>   	}
>>
>> -	if (!bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &mtu, BT_IO_OPT_CID, &cid,
>> -				BT_IO_OPT_INVALID) || cid == ATT_CID)
>> -		mtu = ATT_DEFAULT_LE_MTU;
>> +	mtu = ATT_DEFAULT_LE_MTU;
>> +
>> +	if (bt_io_get(io, &gerr, BT_IO_OPT_DEST_TYPE, &dst_type,
>> +			BT_IO_OPT_INVALID) && (dst_type == BDADDR_BREDR))
>> +		mtu = ATT_DEFAULT_L2CAP_MTU;
>>
>>   	attrib = g_attrib_new(io, mtu);
>>   	if (!attrib) {
>
> Isn't this a kernel or BtIO bug if we get the wrong MTU from bt_io_get?

I guess You are right that something is wrong with this patch. I'll take 
a look at this again. The issue I had might have already been fixed 
somewhere else by other patches. Please ignore this one.

Regards,
Jakub

