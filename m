Return-Path: <arnaud.rebillout@collabora.com>
Subject: Re: [PATCH] Bluetooth: hidp: sixaxis dualshock report via ctrl quirk
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, vivek@collabora.com
References: <20180328034526.13446-1-arnaud.rebillout@collabora.com>
 <DABE3E89-2AAE-457C-AAEA-BFE34844BE96@holtmann.org>
From: Arnaud Rebillout <arnaud.rebillout@collabora.com>
Message-ID: <f0425f48-8bf8-c394-2b16-5208f949cc88@collabora.com>
Date: Fri, 30 Mar 2018 14:46:15 +0700
MIME-Version: 1.0
In-Reply-To: <DABE3E89-2AAE-457C-AAEA-BFE34844BE96@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 03/28/2018 04:30 PM, Marcel Holtmann wrote:
> Hi Arnaud,
>
>> The Sixaxis and Dualshock 4 wants report sent via the ctrl channel.
>>
>> This patch has been used in the SteamOS kernel for a while now.
>> <https://github.com/ValveSoftware/steamos_kernel/commit/6e215b67a13c85d0cf5a9e0970acd9df7d2b77bd>
>>
>> Signed-off-by: Vivek Das Mohapatra <vivek@collabora.com>
>> Signed-off-by: Arnaud Rebillout <arnaud.rebillout@collabora.com>
>> ---
>> net/bluetooth/hidp/core.c | 13 ++++++++++---
>> 1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
>> index 1036e4fa1ea2..fa75da91a559 100644
>> --- a/net/bluetooth/hidp/core.c
>> +++ b/net/bluetooth/hidp/core.c
>> @@ -379,9 +379,16 @@ static int hidp_output_report(struct hid_device *hid, __u8 *data, size_t count)
>> {
>> 	struct hidp_session *session = hid->driver_data;
>>
>> -	return hidp_send_intr_message(session,
>> -				      HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT,
>> -				      data, count);
>> +	/* The Sixaxis and Dualshock 4 wants report sent via the ctrl channel */
>> +	if (hid->vendor == 0x54c && (hid->product == 0x5c4 || hid->product == 0x268)) {
>> +		return hidp_send_ctrl_message(session,
>> +					      HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT,
>> +					      data, count);
>> +	} else {
>> +		return hidp_send_intr_message(session,
>> +					      HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT,
>> +					      data, count);
>> +	}
>> }
> see the comment from Bastien, the HIDP layer is just a transport layer and should really not need to know about device specific quirks. Seems these quirks could be easily handled one layer about where the right channel is selected.

I noticed indeed that the fix for the Sixaxis is already present in
`drivers/hid/hid-sony.c`. I'm not sure about the Dualshock 4, but I will
investigate further. If there's anything to fix I will patch `hid-sony.c`.

Thanks for the feedback, and sorry for the noise :)

  Arnaud
