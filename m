Return-Path: <cyrus@holtmann.org>
Message-ID: <540EEA33.2090904@tieto.com>
Date: Tue, 09 Sep 2014 13:53:23 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv3 6/7] android/tester: Fix HIDHost cases sending fixed
 tid sdp responses
References: <1410248823-8975-1-git-send-email-jakub.tyszkowski@tieto.com>	<1410248823-8975-7-git-send-email-jakub.tyszkowski@tieto.com> <CABBYNZ+OVW+detLyTHRs5EO2zQ2k=LudEDVQyqXyJ=nOrGw8OA@mail.gmail.com>
In-Reply-To: <CABBYNZ+OVW+detLyTHRs5EO2zQ2k=LudEDVQyqXyJ=nOrGw8OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On 09/09/2014 11:10 AM, Luiz Augusto von Dentz wrote:
> Hi Jakub,
>
> On Tue, Sep 9, 2014 at 10:47 AM, Jakub Tyszkowski
> <jakub.tyszkowski@tieto.com> wrote:
>> Multiple cases were affected because of hardcoded transaction id for
>> emulated remote's SDP responses.
>>
>> This resulted in the following error in the daemon:
>>          bluetoothd[13486]: sdp_process: Protocol error.
>> ---
>>   android/tester-hidhost.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
>> index abff837..d5741f9 100644
>> --- a/android/tester-hidhost.c
>> +++ b/android/tester-hidhost.c
>> @@ -21,6 +21,7 @@
>>   #include "tester-main.h"
>>
>>   #include "android/utils.h"
>> +#include "src/shared/util.h"
>>
>>   #define HID_GET_REPORT_PROTOCOL                0x60
>>   #define HID_GET_BOOT_PROTOCOL          0x61
>> @@ -214,15 +215,24 @@ static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>>          struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
>>          struct emu_cid_data *cid_data = user_data;
>>          struct raw_dataset *sdp_data = cid_data->user_data;
>> +       const uint8_t *req_buf = data;
>> +       uint8_t *sdp_buf;
>>
>> -       if (!memcmp(did_req_pdu, data, len)) {
>> +       if (!memcmp(did_req_pdu, req_buf, len)) {
>>                  bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
>>                                          did_rsp_pdu, sizeof(did_rsp_pdu));
>>                  return;
>>          }
>>
>> +       /* Get transaction ID from the request */
>> +       sdp_buf = g_memdup(sdp_data->pdu, sdp_data->len);
>> +       sdp_buf[1] = req_buf[1];
>> +       sdp_buf[2] = req_buf[2];
>> +
>>          bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
>> -                                       sdp_data->pdu, sdp_data->len);
>> +                                                       sdp_buf, sdp_data->len);
>> +
>> +       g_free(sdp_buf);
>>   }
>
> Do we really need this copy? Wouldn't it be enough not to mark it as
> const and just change in place? Anyway this is also broke in AVRCP,  I

Yes, It looks like we could use non-const pdu array to avoid copying.
First idea was not leave any trace of previous test case but we broke it 
and use non-const global variables as storage elsewhere anyway. Not sure 
which way we should go to be consistent.

> have been planning to handle this but perhaps we should unify this,
> btw in case of did we should also check tid.

Agree, memcmp checks for did request with tid == 0 and responses with 
tid == 0. Luckily for now its always 0 in request, but we should fix 
this anyway. ;)

It looks like we need a pair of helpers, one for matching pdu and one 
for sending responses to unify this 'tid' issue.

Is this something we can fix later in all testers ,by providing helpers 
in tester-main or should It be part of this patch set?

Regards,
Jakub

