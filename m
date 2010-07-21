Return-Path: <cyrus@holtmann.org>
Message-ID: <4C470E2D.7000607@aircable.net>
Date: Wed, 21 Jul 2010 12:11:41 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
References: <4C46324D.5070800@aircable.net> <20100721101934.GA12188@jh-x301>
In-Reply-To: <20100721101934.GA12188@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,
> Thanks for the patch proposal. It seems like you're trying to to fix the
> issue by doing all sorts of minor tweaks here and there, i.e. it seems
> like there isn't a full understanding of the real root cause.
>
I agree, I know this doesn't fix the root cause, it only works it out. 
Like we say in Argentina we attach it with aluminium threads.
>> -	if (ctxt->cb)
>> +	if (ctxt->cb&&  ctxt->user_data)
>>   		ctxt->cb(recs, err, ctxt->user_data);
>>
> This part isn't right. It should be perfectly fine for a discovery
> requester to pass NULL as user_data and still expect its callback to get
> called.
>
Then the problem is the callback function!

The trace shows that browse_cb gets right into search_cb which never 
checks if user_data is NULL. It doesn't do it because MOST of the time 
it isn't only when something weird happens.

>> -		if (ctxt->cb)
>> +		if (ctxt->cb&&  ctxt->user_data)
>>   			ctxt->cb(NULL, err, ctxt->user_data);
>>
> Same here.
>
>
>> @@ -254,6 +256,8 @@ static gboolean connect_watch(GIOChannel *chan, GIOCondition cond, gpointer user
>>   	int sk, err = 0;
>>
>>   	sk = g_io_channel_unix_get_fd(chan);
>> +	if (ctxt->io_id)
>> +	    g_source_remove(ctxt->io_id);
>>
> connect_watch returns FALSE in all cases which will remove the GSource.
> So the change you're doing seems redundant.
>
Ok you got me I missed that.


>> @@ -391,11 +395,13 @@ int bt_cancel_discovery(const bdaddr_t *src, const bdaddr_t *dst)
>>   		return -ENODATA;
>>
>>   	ctxt = match->data;
>> -	if (!ctxt->session)
>> -		return -ENOTCONN;
>>
>>   	if (ctxt->io_id)
>>   		g_source_remove(ctxt->io_id);
>> +	ctxt->io_id = 0;
>> +
>> +	if (!ctxt->session)
>> +		return -ENOTCONN;
>>
>>   	if (ctxt->session)
>>   		sdp_close(ctxt->session);
>>
> I don't really understand the need for these changes, but admitedly the
> function does have issues since it first checks for !ctxt->session and
> then later for ctxt->session even though at that point it's already
> guaranteed that ctxt->session is not NULL.
>
I think this is the one that really fix the problem. I see connect_watch 
getting called and then getting into the crash. I have a nice log with 
the tracing feature I sent the other day, here's the end of it (the hole 
thing is almost 40 megs if someone wants just ask for it).


         +  0 0x808a019 (from 0x17fdab)  io_security_event()
         +  1 0x8087c29 (from 0x808a121)   hci_test_bit()
         +  1 0x80893be (from 0x808a166)   cmd_status()
         +  1 0x808812b (from 0x808a38a)   check_pending_hci_req()
         +  0 0x808a019 (from 0x17fdab)  io_security_event()
         +  1 0x8087c29 (from 0x808a121)   hci_test_bit()
         +  1 0x8089425 (from 0x808a187)   cmd_complete()
         +  1 0x808812b (from 0x808a38a)   check_pending_hci_req()
         +  0 0x808a019 (from 0x17fdab)  io_security_event()
         +  1 0x8087c29 (from 0x808a121)   hci_test_bit()
         +  1 0x8089b72 (from 0x808a2f4)   conn_complete()
         +  2 0x80add52 (from 0x8089bda)    hcid_dbus_conn_complete()
         +  3 0x80ac3e0 (from 0x80adda1)     get_adapter_and_device()
         +  4 0x809d9c3 (from 0x80ac405)      manager_find_adapter()
         +  5 0x809d8e3 (from 0x16847e)       adapter_cmp()
         +  6 0x80a44f7 (from 0x809d91b)        adapter_get_address()
         +  7 0x809dff1 (from 0x80a4525)         bacpy()
         +  6 0x809cf7c (from 0x809d92d)        bacmp()
         +  4 0x80a0aba (from 0x80ac45b)      adapter_get_device()
         +  5 0x8087840 (from 0x80a0b03)       btd_debug()
         +  5 0x80a041a (from 0x80a0b22)       adapter_find_device()
         +  6 0x80a883e (from 0x16847e)        device_address_cmp()
....
         +  6 0x80a883e (from 0x16847e)        device_address_cmp()
         +  3 0x80a80a3 (from 0x80addc4)     device_get_secmode3_conn()
         +  3 0x80a80e1 (from 0x80addda)     device_set_secmode3_conn()
         +  3 0x80aaddf (from 0x80added)     device_is_bonding()
         +  3 0x80a9cf7 (from 0x80ade0f)     device_is_temporary()
         +  1 0x808812b (from 0x808a38a)   check_pending_hci_req()
         +  0 0x808a019 (from 0x17fdab)  io_security_event()
         +  1 0x8087c29 (from 0x808a121)   hci_test_bit()
         +  1 0x80891f0 (from 0x808a239)   inquiry_complete()
         +  2 0x809d9c3 (from 0x808923f)    manager_find_adapter()
         +  3 0x809d8e3 (from 0x16847e)     adapter_cmp()
         +  4 0x80a44f7 (from 0x809d91b)      adapter_get_address()
         +  5 0x809dff1 (from 0x80a4525)       bacpy()
         +  4 0x809cf7c (from 0x809d92d)      bacmp()
         +  2 0x809e7a5 (from 0x808929a)    adapter_resolve_names()
         +  3 0x809dff1 (from 0x809e804)     bacpy()
         +  3 0x80a46bb (from 0x809e81d)     adapter_search_found_devices()
         +  2 0x80a4642 (from 0x80892b0)    adapter_get_state()
         +  2 0x80a453a (from 0x80892fe)    adapter_set_state()
         +  3 0x80a4d46 (from 0x80a45e5)     adapter_update_oor_devices()
         +  3 0x80ac200 (from 0x80a4618)     emit_property_changed()
         +  4 0x80abf1d (from 0x80ac29c)      append_variant()
         +  4 0x804f543 (from 0x80ac2ae)      g_dbus_send_message()
         +  1 0x808812b (from 0x808a38a)   check_pending_hci_req()
         +  0 0x808a019 (from 0x17fdab)  io_security_event()
         +  1 0x8087c29 (from 0x808a121)   hci_test_bit()
         +  1 0x80893be (from 0x808a166)   cmd_status()
         +  1 0x808812b (from 0x808a38a)   check_pending_hci_req()
         +  0 0x804da4a (from 0x17fdab)  watch_func()
         +  1 0x804df9b (from 0x9cc0dd)   dispatch_status()
         +  2 0x804d9fb (from 0x804dfdd)    queue_dispatch()
         +  0 0x804d996 (from 0x14953c)  message_dispatch()
         +  1 0x8050409 (from 0x9cec8d)   message_filter()
         +  1 0x804ea38 (from 0x9dbf13)   generic_message()
         +  2 0x804e9b5 (from 0x804ea7b)    find_interface()
         +  2 0x80a0d23 (from 0x804eafd)    adapter_stop_discovery()
         +  3 0x809f488 (from 0x80a0d7f)     find_session()
         +  3 0x809f895 (from 0x80a0db2)     session_unref()
         +  4 0x8087840 (from 0x809f8f7)      btd_debug()
         +  4 0x809f7a8 (from 0x809f913)      session_free()
         +  5 0x8050a57 (from 0x809f7e3)       g_dbus_remove_watch()
         +  6 0x804fd59 (from 0x8050aa2)        filter_data_find_callback()
         +  6 0x804fd59 (from 0x8050aa2)        filter_data_find_callback()
         +  6 0x804fd59 (from 0x8050aa2)        filter_data_find_callback()
         +  6 0x804fd59 (from 0x8050aa2)        filter_data_find_callback()
         +  6 0x8050032 (from 0x8050abd) 
filter_data_remove_callback()
         +  7 0x804fb14 (from 0x80500db)         remove_match()
         +  8 0x804f8ea (from 0x804fb4e)          format_rule()
         +  8 0x804de1d (from 0x9e1783)          add_timeout()
         +  8 0x804df9b (from 0x9cc0dd)          dispatch_status()
         +  9 0x804d9fb (from 0x804dfdd)           queue_dispatch()
         +  8 0x804decc (from 0x9e16ff)          remove_timeout()
         +  8 0x804ddbf (from 0x9e1469)          timeout_handler_free()
         +  7 0x804fdf7 (from 0x805011d)         filter_data_free()
         +  7 0x804f790 (from 0x8050150)         filter_data_find()
         +  5 0x809f58c (from 0x809f7ee)       session_remove()
         +  6 0x8087840 (from 0x809f616)        btd_debug()
         +  6 0x8087840 (from 0x809f721)        btd_debug()
         +  6 0x809e6a8 (from 0x809f72c)        pending_remote_name_cancel()
         +  7 0x809dff1 (from 0x809e70e)         bacpy()
         +  7 0x80a46bb (from 0x809e727) 
adapter_search_found_devices()
         +  6 0x809e391 (from 0x809f737)        clear_found_devices_list()
         +  6 0x8085e04 (from 0x809f787)        hciops_stop_discovery()
         +  7 0x8084898 (from 0x8085e7b)         hci_test_bit()
         +  3 0x80877a4 (from 0x80a0dbe)     info()
         +  0 0x808a019 (from 0x17fdab)  io_security_event()
         +  1 0x8087c29 (from 0x808a121)   hci_test_bit()
         +  1 0x8089425 (from 0x808a187)   cmd_complete()
         +  2 0x80891f0 (from 0x808951e)    inquiry_complete()
         +  3 0x809d9c3 (from 0x808923f)     manager_find_adapter()
         +  4 0x809d8e3 (from 0x16847e)      adapter_cmp()
         +  5 0x80a44f7 (from 0x809d91b)       adapter_get_address()
         +  6 0x809dff1 (from 0x80a4525)        bacpy()
         +  5 0x809cf7c (from 0x809d92d)       bacmp()
         +  3 0x80a4642 (from 0x808926f)     adapter_get_state()
         +  3 0x80a453a (from 0x8089288)     adapter_set_state()
         +  1 0x808812b (from 0x808a38a)   check_pending_hci_req()
         +  0 0x804da4a (from 0x17fdab)  watch_func()
         +  1 0x804df9b (from 0x9cc0dd)   dispatch_status()
         +  2 0x804d9fb (from 0x804dfdd)    queue_dispatch()
         +  0 0x804d996 (from 0x14953c)  message_dispatch()
         +  1 0x8050409 (from 0x9cec8d)   message_filter()
         +  1 0x804ea38 (from 0x9dbf13)   generic_message()
         +  2 0x804e9b5 (from 0x804ea7b)    find_interface()
         +  2 0x80a0bde (from 0x804eafd)    adapter_start_discovery()
         +  3 0x809f488 (from 0x80a0c3d)     find_session()
         +  3 0x80a0b66 (from 0x80a0c92)     adapter_start_inquiry()
         +  4 0x809e6a8 (from 0x80a0ba4)      pending_remote_name_cancel()
         +  5 0x809dff1 (from 0x809e70e)       bacpy()
         +  5 0x80a46bb (from 0x809e727) 
adapter_search_found_devices()
         +  4 0x8085c9a (from 0x80a0bc1)      hciops_start_discovery()
         +  3 0x809ed21 (from 0x80a0cdd)     create_session()
         +  4 0x805092f (from 0x809ede5)      g_dbus_add_disconnect_watch()
         +  5 0x8050834 (from 0x8050978)       g_dbus_add_service_watch()
         +  6 0x804fbbb (from 0x8050898)        filter_data_get()
         +  7 0x804f790 (from 0x804fc08)         filter_data_find()
         +  7 0x804f790 (from 0x804fc6b)         filter_data_find()
         +  7 0x804fa5a (from 0x804fd0c)         add_match()
         +  8 0x804f8ea (from 0x804fa94)          format_rule()
         +  8 0x804de1d (from 0x9e1783)          add_timeout()
         +  8 0x804df9b (from 0x9cc0dd)          dispatch_status()
         +  9 0x804d9fb (from 0x804dfdd)           queue_dispatch()
         +  8 0x804decc (from 0x9e16ff)          remove_timeout()
         +  8 0x804ddbf (from 0x9e1469)          timeout_handler_free()
         +  6 0x804ff5d (from 0x80508d8)        filter_data_add_callback()
         +  4 0x80877a4 (from 0x809ee20)      info()
         +  4 0x809eca1 (from 0x809ee2b)      session_ref()
         +  5 0x8087840 (from 0x809ed03)       btd_debug()
         +  0 0x808a019 (from 0x17fdab)  io_security_event()
         +  1 0x8087c29 (from 0x808a121)   hci_test_bit()
         +  1 0x8089425 (from 0x808a187)   cmd_complete()
         +  2 0x80890df (from 0x80894fe)    start_inquiry()
         +  3 0x809d9c3 (from 0x808912e)     manager_find_adapter()
         +  4 0x809d8e3 (from 0x16847e)      adapter_cmp()
         +  5 0x80a44f7 (from 0x809d91b)       adapter_get_address()
         +  6 0x809dff1 (from 0x80a4525)        bacpy()
         +  5 0x809cf7c (from 0x809d92d)       bacmp()
         +  3 0x80a4642 (from 0x8089158)     adapter_get_state()
         +  3 0x80a543e (from 0x8089166)     adapter_has_discov_sessions()
         +  3 0x80a453a (from 0x808918a)     adapter_set_state()
         +  4 0x80ac200 (from 0x80a4618)      emit_property_changed()
         +  5 0x80abf1d (from 0x80ac29c)       append_variant()
         +  5 0x804f543 (from 0x80ac2ae)       g_dbus_send_message()
         +  1 0x808812b (from 0x808a38a)   check_pending_hci_req()
         +  0 0x80962cd (from 0x17fdab)  connect_watch()
         +  1 0x80a97cf (from 0x80964ae)   browse_cb()

Last call is search_cb I'm sure about it, thing is that the tracer only 
traces function when they exit, not when they get in.

I think the best way to solve this is that the device structure has a 
reference to the context so it can release it when it gets removed 
without any issue. We don't need the sdp callback if we no longer have a 
device anyway.

Manuel

