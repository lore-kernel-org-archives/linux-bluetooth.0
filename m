Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25Sw9qdqbsSiY5cWsgikkUmAv8V7dj-aUFuH7HH34Zp9eg@mail.gmail.com>
References: <1427087337-17479-1-git-send-email-jaganath.k@samsung.com>
	<CAHrH25SJXjAj6oayUUL1_Mi7o4gi8i=JcEGVUZ4J8DOhBoTNRQ@mail.gmail.com>
	<CAHrH25Sw9qdqbsSiY5cWsgikkUmAv8V7dj-aUFuH7HH34Zp9eg@mail.gmail.com>
Date: Tue, 24 Mar 2015 11:06:16 +0200
Message-ID: <CABBYNZKHVz7Xu+Gno_ECp2AMqC+7TWWPbRA-HGHNmFkpx0a1Tw@mail.gmail.com>
Subject: Re: [PATCH] Fix crash during register_notify after service_changed_event
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Mar 24, 2015 at 7:25 AM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Jaganath,
>
>> On Mon, Mar 23, 2015 at 4:45 PM, Arman Uguray <armansito@chromium.org> wrote:
>> Hi Jaganath,
>>
>>> On Sun, Mar 22, 2015 at 10:08 PM, Jaganath Kanakkassery <jaganath.k@samsung.com> wrote:
>>> During service changed event the characteristics of the modified
>>> services will be destroyed and corresponding notify clients also
>>> will be freed. But those notify clients are not removed from
>>> all_notify_clients queue of btd_client which causes the below
>>> crash
>>>
>>> 0  queue_remove (queue=0x1, data=0xb8e97a68) at src/shared/queue.c:292
>>>         entry = <value optimized out>
>>>         prev = <value optimized out>
>>> 1  0xb6f84c34 in register_notify (data=0xb8e9a900, user_data=0xb8e97a68)
>>>     at src/gatt-client.c:1833
>>> No locals.
>>> 2  register_notify (data=0xb8e9a900, user_data=0xb8e97a68)
>>>     at src/gatt-client.c:1807
>>>         notify_client = 0xb8e9a900
>>>         client = 0xb8e97a68
>>>         op = 0xb8e91f30
>>> 3  0xb6f9a41a in queue_foreach (queue=0xb8e97a98,
>>>     function=0xb6f84bd9 <register_notify>, user_data=0xb8e97a68)
>>>     at src/shared/queue.c:251
>>>         next = <value optimized out>
>>>         entry = 0xb8e9baf0
>>> 4  0xb6f89b62 in gatt_client_ready_cb (success=<value optimized out>,
>>>     att_ecode=<value optimized out>, user_data=0xb8e97770) at src/device.c:5173
>>> No locals.
>>> 5  gatt_client_ready_cb (success=<value optimized out>,
>>>     att_ecode=<value optimized out>, user_data=0xb8e97770) at src/device.c:5132
>>>         device = 0xb8e97770
>>> 6  0xb6f9e232 in notify_client_ready (client=0xb8e90710,
>>> ---Type <return> to continue, or q <return> to quit---
>>>     success=<value optimized out>, att_ecode=<value optimized out>)
>>>     at src/shared/gatt-client.c:1019
>>> No locals.
>>> 7  0xb6f9cb6a in complete_notify_request (data=<value optimized out>)
>>>     at src/shared/gatt-client.c:1405
>>>         notify_data = <value optimized out>
>>> 8  0xb6f9e168 in enable_ccc_callback (opcode=<value optimized out>,
>>>     pdu=<value optimized out>, length=<value optimized out>,
>>>     user_data=0xb8e911a8) at src/shared/gatt-client.c:1488
>>>         notify_data = 0xb8e911a8
>>>         att_ecode = <value optimized out>
>>>         __PRETTY_FUNCTION__ = "enable_ccc_callback"
>>> 9  0xb6f9c6d8 in handle_rsp (io=<value optimized out>, user_data=0xb8e9a330)
>>>     at src/shared/att.c:640
>>>         rsp_opcode = 19 '\023'
>>>         rsp_pdu = <value optimized out>
>>>         rsp_pdu_len = <value optimized out>
>>>         op = 0xb8e8ece8
>>>         req_opcode = <value optimized out>
>>>
>>> This patch removes the notify clients (which will be freed) from
>>> all_notify_clients as well
>>
>> Your patch looks good to me. I also tested it and everything seems to
>> work fine, although if you can also add a test case to unit/test-gatt
>> for this particular crash it would be great.
>>
>
> I realized that this can't really be unit tested using unit/test-gatt
> since that only exercises shared/gatt. It would still be nice to have
> tests for this particular case though, I'm not sure if we have any
> test cases for Service Changed.

There is the test TP/GAS/CL/BV-01-C but it would only affect shared/
code, for D-Bus we need end-to-end tests like we did for android.

>>> ---
>>>  src/gatt-client.c |   12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/gatt-client.c b/src/gatt-client.c
>>> index 863492a..2e26ed7 100644
>>> --- a/src/gatt-client.c
>>> +++ b/src/gatt-client.c
>>> @@ -1370,6 +1370,16 @@ static struct characteristic *characteristic_create(
>>>         return chrc;
>>>  }
>>>
>>> +static void remove_client(void *data)
>>> +{
>>> +       struct notify_client *ntfy_client = data;
>>> +       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
>>> +
>>> +       queue_remove(client->all_notify_clients, ntfy_client);
>>> +
>>> +       notify_client_unref(ntfy_client);
>>> +}
>>> +
>>>  static void unregister_characteristic(void *data)
>>>  {
>>>         struct characteristic *chrc = data;
>>> @@ -1383,7 +1393,7 @@ static void unregister_characteristic(void *data)
>>>         if (chrc->write_id)
>>>                 bt_gatt_client_cancel(gatt, chrc->write_id);
>>>
>>> -       queue_remove_all(chrc->notify_clients, NULL, NULL, notify_client_unref);
>>> +       queue_remove_all(chrc->notify_clients, NULL, NULL, remove_client);
>>>         queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
>>>
>>>         g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
>>> --
>>> 1.7.9.5
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Pushed.
>
> Thanks,
> Arman
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
