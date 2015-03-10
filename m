Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25QYC1xSrkpZik_Lar_Vg7EatTYQDnBmvzeM03SKC+gw7g@mail.gmail.com>
References: <1425994298-2883-1-git-send-email-luiz.dentz@gmail.com>
	<1425994298-2883-4-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25QYC1xSrkpZik_Lar_Vg7EatTYQDnBmvzeM03SKC+gw7g@mail.gmail.com>
Date: Tue, 10 Mar 2015 21:14:18 +0200
Message-ID: <CABBYNZKo_FAzYpOwsyDjy1Udp8VtU5c1dyFB2HYDHdi4tSwyBg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] unit/test-gatt: Check if crypto is enabled
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Mar 10, 2015 at 8:07 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
>> On Tue, Mar 10, 2015 at 6:31 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This checks if crypto is enabled and in case it is not do not run test
>> /TP/GAW/CL/BV-02-C.
>> ---
>>  unit/test-gatt.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
>> index 2edcacb..7668e93 100644
>> --- a/unit/test-gatt.c
>> +++ b/unit/test-gatt.c
>> @@ -304,9 +304,12 @@ static gboolean context_quit(gpointer user_data)
>>         if (step && step->post_func)
>>                 step->post_func(context);
>>
>> -       destroy_context(context);
>> +       if (context->data->pdu_list[context->pdu_offset].valid)
>> +               tester_test_abort();
>> +       else
>> +               tester_test_passed();
>>
>> -       tester_test_passed();
>> +       destroy_context(context);
>>
>>         return FALSE;
>>  }
>> @@ -910,6 +913,11 @@ static void test_signed_write(struct context *context)
>>         uint8_t key[16] = {0xD8, 0x51, 0x59, 0x48, 0x45, 0x1F, 0xEA, 0x32, 0x0D,
>>                                 0xC0, 0x5A, 0x2E, 0x88, 0x30, 0x81, 0x88 };
>>
>> +       if (!bt_att_has_crypto(context->att)) {
>
> Should we assert in this case that
> bt_gatt_client_write_without_response, given true for "signed_write"
> returns 0 without crashing? We would at least be validating the
> current behavior, or perhaps we should add a separate test case for
> it.

What do you mean, note that this won't affect the test for seclevel
which test the same code except the signature since the transport is
considered secure already, all it does it check if crypto has been
enabled and the make the test no run in such case since it would
obviously fail. We might have to remove the use of assert in future
and leave tester_run return the proper result at the end.

>
>> +               context_quit(context);
>> +               return;
>> +       }
>> +
>>         g_assert(bt_att_set_local_key(context->att, key, local_counter,
>>                                                                 context));
>>
>> --
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks,
> Arman



-- 
Luiz Augusto von Dentz
