Return-Path: <cyrus@holtmann.org>
Message-ID: <53049B8C.1040000@tieto.com>
Date: Wed, 19 Feb 2014 12:54:52 +0100
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 07/11] android/tester: Execute hh connection state cbacks
 in main loop
References: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>	<1392805549-28152-8-git-send-email-jakub.tyszkowski@tieto.com> <CAJdJm_Mh-vZ2ieKJq_CWao43ticSu++JTdvDwraHODFB_U76dA@mail.gmail.com>
In-Reply-To: <CAJdJm_Mh-vZ2ieKJq_CWao43ticSu++JTdvDwraHODFB_U76dA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On 02/19/2014 12:25 PM, Anderson Lizardo wrote:
> Hi Jakub,
>
> On Wed, Feb 19, 2014 at 6:25 AM, Jakub Tyszkowski
> <jakub.tyszkowski@tieto.com> wrote:
>> Execute generic HIDHost connection_state_cb in tester's main loop.
>> ---
>>   android/android-tester.c | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/android/android-tester.c b/android/android-tester.c
>> index 0115943..664f381 100644
>> --- a/android/android-tester.c
>> +++ b/android/android-tester.c
>> @@ -3212,19 +3212,34 @@ clean:
>>                  close(sock_fd);
>>   }
>>
>> -static void hidhost_connection_state_cb(bt_bdaddr_t *bd_addr,
>> -                                               bthh_connection_state_t state)
>> +static gboolean hidhost_connection_state(gpointer user_data)
>>   {
>>          struct test_data *data = tester_get_data();
>>          const struct hidhost_generic_data *test = data->test_data;
>> +       struct generic_cb_data *cb_data = user_data;
>>
>>          data->cb_count++;
>>
>> -       if (state == BTHH_CONN_STATE_CONNECTED)
>> +       if ((int) cb_data->state == BTHH_CONN_STATE_CONNECTED)
>
> You are reusing a variable of different type (bt_state_t vs.
> bthh_connection_state_t), so I believe it's why you are casting above.
>
> My suggestion (if that works) is to declare the state field in
> generic_cb_data as int, so it should work without any casting.
>
> Best Regards,
>
Yeap, we could probably use int or add more fields to this struct. But 
it would probably be better to replace single generic_cb_data with per 
HAL struct like bt_cb_data and hh_cb_data. It would be more elegant.

Best regards,
Jakub Tyszkowski
