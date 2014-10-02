Return-Path: <cyrus@holtmann.org>
Message-ID: <542CFA52.6040602@tieto.com>
Date: Thu, 02 Oct 2014 09:10:10 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv3 07/17] android/tester: Make HDP tests use generic pdu
 struct
References: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>	<1412154099-28014-8-git-send-email-jakub.tyszkowski@tieto.com> <CABBYNZJoqmsa45OQ0XO5rZSL7v877A4qMOyXm+VoZqs5wpm68g@mail.gmail.com>
In-Reply-To: <CABBYNZJoqmsa45OQ0XO5rZSL7v877A4qMOyXm+VoZqs5wpm68g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 10/01/2014 02:21 PM, Luiz Augusto von Dentz wrote:
> Hi Jakub,
>
> On Wed, Oct 1, 2014 at 12:01 PM, Jakub Tyszkowski
> <jakub.tyszkowski@tieto.com> wrote:
>> ---
>>   android/tester-hdp.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/android/tester-hdp.c b/android/tester-hdp.c
>> index 9ecef21..e81df71 100644
>> --- a/android/tester-hdp.c
>> +++ b/android/tester-hdp.c
>> @@ -184,7 +184,8 @@ static void hdp_unregister_app_action(void)
>>          schedule_action_verification(step);
>>   }
>>
>> -static uint8_t hdp_rsp_pdu[] = { 0x07, /* PDU id */
>> +static const struct pdu hdp_rsp_pdu = raw_pdu(
>> +                       0x07, /* PDU id */
>>                          0x00, 0x00, /* Transaction id */
>>                          0x01, 0xc8, /* Response length */
>>                          0x01, 0xc5, /* Attributes length */
>> @@ -239,7 +240,7 @@ static uint8_t hdp_rsp_pdu[] = { 0x07, /* PDU id */
>>                          0x63, 0x6f, 0x73, 0x65, 0x20, 0x4d, 0x65, 0x74, 0x65,
>>                          0x72, 0x0d, 0x09, 0x03, 0x01, 0x08, 0x01, 0x09, 0x03,
>>                          0x02, 0x08, 0x00,
>> -                       0x00 };
>> +                       0x00);
>>
>>   static void hdp_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>>   {
>> @@ -247,11 +248,11 @@ static void hdp_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>>          struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
>>          struct emu_cid_data *cid_data = user_data;
>>
>> -       hdp_rsp_pdu[1] = ((uint8_t *) data)[1];
>> -       hdp_rsp_pdu[2] = ((uint8_t *) data)[2];
>> +       hdp_rsp_pdu.data[1] = ((uint8_t *) data)[1];
>> +       hdp_rsp_pdu.data[2] = ((uint8_t *) data)[2];
>
> I suppose we could use memcpy here, or in case of iovec you can
> actually send them separably them like this:
>
> struct iovec iov[2]
>
> iov[0].iov_base = data;
> iov[0].iov_len = 2;
>
> iov[1].iov_base = hdp_rsp_pdu.data + 2;
> iov[1].iov_len = hdp_rsp_pdu.size - 2;
>
> This way the variables can be const.

memcpy was the first solution I proposed when this pdu refactor was part 
of some other patch set. At that time You suggested to make pdus non 
const and overwrite transaction ID to avoid copying. :)
But I agree that with iovecs it will work with const pdus and without 
copying. I'll fix that.

>
>>          bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
>> -                                       hdp_rsp_pdu, sizeof(hdp_rsp_pdu));
>> +                                       hdp_rsp_pdu.data, hdp_rsp_pdu.size);
>>   }
>>
>>   static void hdp_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
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

Regards
