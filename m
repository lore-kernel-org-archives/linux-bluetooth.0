Return-Path: <cyrus@holtmann.org>
Message-ID: <4D5BFAB8.7030608@codeaurora.org>
Date: Wed, 16 Feb 2011 08:26:32 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com,
	padovan@profusion.mobi
Subject: Re: [PATCH 2/3] Add SDP registration of Primary GATT services
References: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>	<1297891081-27976-3-git-send-email-bgix@codeaurora.org> <AANLkTikCnorqDid1cRYmCm=-Jq04K67wJOHpOdWE8Pn+@mail.gmail.com>
In-Reply-To: <AANLkTikCnorqDid1cRYmCm=-Jq04K67wJOHpOdWE8Pn+@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On 2/14/2011 1:53 PM, Anderson Lizardo wrote:
> On Wed, Feb 16, 2011 at 6:18 PM, Brian Gix<bgix@codeaurora.org>  wrote:
>> SDP registration can be supressed by passing Zero as the end
>> handle argument to attrib_db_add().
>> ---
>>   attrib/example.c    |  119 +++++++++++++++++++++++++++++++------------
>>   src/attrib-server.c |  139 +++++++++++++++++++++++++++++++++++----------------
>>   src/attrib-server.h |    6 ++-
>>   3 files changed, 184 insertions(+), 80 deletions(-)
>>
>> diff --git a/attrib/example.c b/attrib/example.c
>> index 1911912..eab3c0f 100644
>> --- a/attrib/example.c
>> +++ b/attrib/example.c
>> @@ -31,6 +31,7 @@
>>
>>   #include<bluetooth/sdp.h>
>>   #include<bluetooth/sdp_lib.h>
>> +#include<src/sdpd.h>
>>
>>   #include<glib.h>
>>
>> @@ -59,6 +60,9 @@
>>   #define FMT_KILOGRAM_UUID              0xA010
>>   #define FMT_HANGING_UUID               0xA011
>>
>> +#define SDP_RECORD_COUNT 10
>> +sdp_record_t *sdp_records[SDP_RECORD_COUNT];
>> +
>>   static int register_attributes(void)
>>   {
>>         const char *desc_out_temp = "Outside Temperature";
>> @@ -77,59 +81,73 @@ static int register_attributes(void)
>>         uint8_t atval[256];
>>         uuid_t uuid;
>>         int len;
>> +       int i = 0;
>>
>>         /* Battery state service: primary service definition */
>>         sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
>>         att_put_u16(BATTERY_STATE_SVC_UUID,&atval[0]);
>> -       attrib_db_add(0x0100,&uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
>> +       sdp_records[i++] = attrib_db_add(0x0100, 0x0111,&uuid,
>> +                                               "Battery State Service",
>> +                                               ATT_NONE, ATT_NOT_PERMITTED,
>> +                                               atval, 2);
>
> What if instead of changing attrib_db_add() signature to return a SDP
> record, you create a "sdp_record_from_attrib()" for this purpose? This
> function could get the struct attribute * pointers for start/end.
>
> There are plans for attrib_db_add() to return the created struct
> attribute *a (as shown in a patch I sent sometime ago which I still
> need to resend), I can send an updated version of that patch if you
> agree to this approach.

I was considering an approach like this during UPF but abandoned it for 
lack of time. There are few hours available to make hot fixes during 
these events, and I just learned of the requirement for SDP records in 
"real time".

However, here are the issues as I see them:

1. We currently register everything into the attribute database a single 
attribute at a time.  The current attrib_db_add therefore has no 
inherent knowledge of entire "Service" objects, and lacks the start-end 
range that is required not only by the SDP record, but also the ATT 
driven GATT Service Discovery. Ideally I would like to see a "Register 
Service" API which internally would register all INCLUDES, 
CHARACTERISTICS, and SDP Records, but this would be a significant 
departure from the current code.

2. A less significant change would be to create an 
sdp_record_from_attrib() API, but it would need to be called after all 
attributes for the service have been registered, because it needs to 
calculate the "end" handle of the service, much like the current GATT 
procedures to Discover and Find Services. This would probably constitute 
the "least change necessary" to the current paradigm.

3. I'm not sure that the "struct attrib *a" would add anything here, 
except as a way to prevent having to explicitly specify the attribute 
handle value in the first place.  We should eventually get away from 
specifying explicit attribute handle values, because that makes it hard 
to have mix-and-match services.  A service app writer should not be 
expected to know the remaining 0-65535 "number space" that is available 
on every device that they want to target there service app to.  In that 
respect, having attrib_db_add assign an available handle, and return a 
"struct attrib *" pointer could then be used instead of a handle when 
registering the SDP of a completely registered primary service.


I propose that I change this patch set to follow plan "2" above.  If you 
want to subsequently change the return of attrib_db_add() as you have 
described, it should then be trivial to change the arguments to the new 
sdp_record_from_attrib() API to accept the attrib struct pointer rather 
than the explicit start handle.


>
>> @@ -609,7 +603,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
>>   static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
>>                 uint8_t *pdu, int len)
>>   {
>> -       channel->mtu = MIN(mtu, ATT_MAX_MTU);
>> +       channel->mtu = MIN(mtu, channel->mtu);
>>
>>         return enc_mtu_resp(channel->mtu, pdu, len);
>>   }
>
> This change looks unrelated to the patch.
>
> Regards,


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
