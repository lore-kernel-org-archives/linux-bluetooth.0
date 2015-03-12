Return-Path: <cyrus@holtmann.org>
Message-ID: <55015449.3040202@ubnt.com>
Date: Thu, 12 Mar 2015 10:54:33 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	Stefan Seyfried <stefan.seyfried@googlemail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] core/gatt-database: Fix memory corruption
References: <550043CD.7080202@ubnt.com>	<CABBYNZLW19LcNQerGUa+U0DTn26HR9LpMqi2=RcPHwiFCHbC9g@mail.gmail.com>	<550052CA.20407@ubnt.com>	<5500B15B.9090508@message-id.googlemail.com>	<55014D38.4040506@ubnt.com> <CABBYNZKR1O7G0yt-7mM6Q7aQZG3B6=ArXAhZHY5n6wqMrqkFdA@mail.gmail.com>
In-Reply-To: <CABBYNZKR1O7G0yt-7mM6Q7aQZG3B6=ArXAhZHY5n6wqMrqkFdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 2015.03.12. 10:39, Luiz Augusto von Dentz wrote:
> Hi Andrejs,
> 
> On Thu, Mar 12, 2015 at 10:24 AM, Andrejs Hanins
> <andrejs.hanins@ubnt.com> wrote:
>> Hi Lukasz,
>>
>> On 2015.03.11. 23:19, Stefan Seyfried wrote:
>>> Am 11.03.2015 um 15:35 schrieb Andrejs Hanins:
>>>> Pointer to on-stack variable was returned from pending_write_new.
>>>
>>> I still get a crash in the tests when running with memory debugging
>>> enabled (which is default in openSUSE Build Service):
>>>
>>> $> MALLOC_CHECK_=3 MALLOC_PERTURB_=69 unit/test-gatt
>>>
>>> /TP/GAC/CL/BV-01-C - init
>>> /TP/GAC/CL/BV-01-C - setup
>>> [...]
>>> /TP/GAR/CL/BV-01-C - setup complete
>>> /TP/GAR/CL/BV-01-C - run
>>> /TP/GAR/CL/BV-01-C - test passed
>>> Segmentation fault
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0x000055555558cb70 in bt_att_send (att=0x4000000f300432d, opcode=opcode@entry=24 '\030',
>>>     pdu=pdu@entry=0x7fffffff4a0f, length=length@entry=1,
>>>     callback=callback@entry=0x55555558fc30 <cancel_long_write_cb>, user_data=0x5555557b1ca0,
>>>     destroy=destroy@entry=0x0) at src/shared/att.c:1135
>>> 1135            if (!att || !att->io)
>>> (gdb) bt
>>> #0  0x000055555558cb70 in bt_att_send (att=0x4000000f300432d, opcode=opcode@entry=24 '\030',
>>>     pdu=pdu@entry=0x7fffffff4a0f, length=length@entry=1,
>>>     callback=callback@entry=0x55555558fc30 <cancel_long_write_cb>, user_data=0x5555557b1ca0,
>>>     destroy=destroy@entry=0x0) at src/shared/att.c:1135
>>> #1  0x0000555555591039 in cancel_long_write_req (client=<optimized out>, req=<optimized out>)
>>>     at src/shared/gatt-client.c:1791
>> Lukasz, I think there is some "missed-ref" problem related to the code you have recently added to the gatt-client/cancel_request() to cancel long_write and prep_write. Namely, bt_att_cancel can actually free the request which is later on accessed as req->long_write and req->prep_write thus reading free'd memory. Valgrind shows it happens this way:
>>
>>   Address 0x5a06fa8 is 8 bytes inside a block of size 40 free'd
>>     at 0x4C2B200: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>     by 0x415BC0: request_unref (gatt-client.c:160)   <<------ this one frees the request which is accessed later in cancel_request()
>>     by 0x410BB3: cancel_att_send_op (att.c:222)
>>     by 0x412700: bt_att_cancel (att.c:1194)
>>     by 0x418EC0: cancel_request (gatt-client.c:1852)
>>     by 0x421C91: queue_remove_all (queue.c:387)
>>     by 0x418F53: bt_gatt_client_cancel_all (gatt-client.c:1866)
>>     by 0x418601: bt_gatt_client_free (gatt-client.c:1569)
>>     by 0x418A65: bt_gatt_client_unref (gatt-client.c:1692)
>>     by 0x4021FB: destroy_context (test-gatt.c:284)
>>     by 0x40230C: context_quit (test-gatt.c:312)
>>     by 0x4031AC: test_read_cb (test-gatt.c:677)
>>
>> I can't instantly figure out the proper fix (add_ref to the request in the beginning of cancel_request() to avoid preliminary free?), hopefully it will be easier for you, as you are the author of the original code. Probably there are also other similar issues elsewhere.
> 
> Yep, this seems a regression we introduced with prepare write set, but
> I did not managed to reproduce it with our unit tests how are getting
> this trace?

valgrind --log-file=valgrind.txt  ./unit/test-gatt

But if you do "MALLOC_CHECK_=3 MALLOC_PERTURB_=69 unit/test-gatt" as suggested by Stefan, then core dump also happens to me.

> 
>>
>>> #2  0x00005555555910ab in cancel_request (data=0x5555557b1e80) at src/shared/gatt-client.c:1855
>>> #3  0x0000555555597903 in queue_remove_all (queue=<optimized out>, function=function@entry=0x0,
>>>     user_data=user_data@entry=0x0, destroy=destroy@entry=0x555555591060 <cancel_request>)
>>>     at src/shared/queue.c:387
>>> #4  0x00005555555917cd in bt_gatt_client_cancel_all (client=client@entry=0x5555557b36f0)
>>>     at src/shared/gatt-client.c:1866
>>> #5  0x0000555555591839 in bt_gatt_client_free (client=0x5555557b36f0) at src/shared/gatt-client.c:1569
>>> #6  0x0000555555589439 in destroy_context (context=0x5555557b1bb0) at unit/test-gatt.c:284
>>> #7  context_quit (user_data=0x5555557b1bb0) at unit/test-gatt.c:312
>>> #8  0x000055555558d59b in handle_rsp (pdu_len=<optimized out>, pdu=0x5555557c6571 "\001\002\003\001)",
>>>     opcode=11 '\v', att=0x5555557b2e90) at src/shared/att.c:640
>>> #9  can_read_data (io=<optimized out>, user_data=0x5555557b2e90) at src/shared/att.c:813
>>> #10 0x0000555555596ec5 in watch_callback (channel=<optimized out>, cond=<optimized out>,
>>>     user_data=<optimized out>) at src/shared/io-glib.c:170
>>> #11 0x00007ffff7b198e5 in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
>>> #12 0x00007ffff7b19c48 in ?? () from /usr/lib64/libglib-2.0.so.0
>>> #13 0x00007ffff7b19f0a in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
>>> #14 0x000055555558c031 in tester_run () at src/shared/tester.c:830
>>> #15 0x0000555555587e19 in main (argc=1, argv=0x7fffffffdc58) at unit/test-gatt.c:3182
>>>
>>> Valgrind also complains loudly:
>>> $> valgrind unit/test-gatt > /dev/null
>>> ==20817== Memcheck, a memory error detector
>>> ==20817== Copyright (C) 2002-2013, and GNU GPL'd, by Julian Seward et al.
>>> ==20817== Using Valgrind-3.10.0 and LibVEX; rerun with -h for copyright info
>>> ==20817== Command: unit/test-gatt
>>> ==20817==
>>> ==20817== Syscall param socketcall.bind(my_addr.sa_data) points to uninitialised byte(s)
>>> ==20817==    at 0x522A737: bind (in /lib64/libc-2.21.so)
>>> ==20817==    by 0x14BBC2: ecb_aes_setup (crypto.c:110)
>>> ==20817==    by 0x14BBC2: bt_crypto_new (crypto.c:148)
>>> ==20817==    by 0x140788: bt_att_new (att.c:937)
>>> ==20817==    by 0x13EA4B: create_context.constprop.24 (test-gatt.c:592)
>>> ==20817==    by 0x13F2E2: run_callback (tester.c:412)
>>> ==20817==    by 0x4E808E4: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80C47: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80F09: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x140030: tester_run (tester.c:830)
>>> ==20817==    by 0x13BE18: main (test-gatt.c:3182)
>>> ==20817==  Address 0xffeff6aa8 is on thread 1's stack
>>> ==20817==  in frame #1, created by bt_crypto_new (crypto.c:141)
>>> ==20817==
>> This one looks like a Valgrind bug. It probably does not take into account, that sockaddr passed to the bind is not a 'struct sockaddr' but actually a 'struct sockaddr_alg' of different size. The code, as such, does proper initialization.
> 
> Valgrind probably is expecting some other size for the sockaddr, we do
> memset to 0 so it is probably just a false positive.
> 
>>> ==20817== Syscall param socketcall.bind(my_addr.sa_data) points to uninitialised byte(s)
>>> ==20817==    at 0x522A737: bind (in /lib64/libc-2.21.so)
>>> ==20817==    by 0x14BC4B: cmac_aes_setup (crypto.c:132)
>>> ==20817==    by 0x14BC4B: bt_crypto_new (crypto.c:161)
>>> ==20817==    by 0x140788: bt_att_new (att.c:937)
>>> ==20817==    by 0x13EA4B: create_context.constprop.24 (test-gatt.c:592)
>>> ==20817==    by 0x13F2E2: run_callback (tester.c:412)
>>> ==20817==    by 0x4E808E4: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80C47: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80F09: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x140030: tester_run (tester.c:830)
>>> ==20817==    by 0x13BE18: main (test-gatt.c:3182)
>>> ==20817==  Address 0xffeff6aa8 is on thread 1's stack
>>> ==20817==  in frame #1, created by bt_crypto_new (crypto.c:141)
>>> ==20817==
>>> ==20817== Invalid read of size 1
>>> ==20817==    at 0x145076: cancel_request (gatt-client.c:1854)
>>> ==20817==    by 0x14B902: queue_remove_all (queue.c:387)
>>> ==20817==    by 0x1457CC: bt_gatt_client_cancel_all (gatt-client.c:1866)
>>> ==20817==    by 0x145838: bt_gatt_client_free (gatt-client.c:1569)
>>> ==20817==    by 0x13D438: destroy_context (test-gatt.c:284)
>>> ==20817==    by 0x13D438: context_quit (test-gatt.c:312)
>>> ==20817==    by 0x14159A: handle_rsp (att.c:640)
>>> ==20817==    by 0x14159A: can_read_data (att.c:813)
>>> ==20817==    by 0x14AEC4: watch_callback (io-glib.c:170)
>>> ==20817==    by 0x4E808E4: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80C47: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80F09: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x140030: tester_run (tester.c:830)
>>> ==20817==    by 0x13BE18: main (test-gatt.c:3182)
>>> ==20817==  Address 0x5a13908 is 8 bytes inside a block of size 40 free'd
>>> ==20817==    at 0x4C2A37C: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>>> ==20817==    by 0x140F1E: cancel_att_send_op (att.c:222)
>>> ==20817==    by 0x140F1E: bt_att_cancel (att.c:1200)
>>> ==20817==    by 0x145075: cancel_request (gatt-client.c:1852)
>>> ==20817==    by 0x14B902: queue_remove_all (queue.c:387)
>>> ==20817==    by 0x1457CC: bt_gatt_client_cancel_all (gatt-client.c:1866)
>>> ==20817==    by 0x145838: bt_gatt_client_free (gatt-client.c:1569)
>>> ==20817==    by 0x13D438: destroy_context (test-gatt.c:284)
>>> ==20817==    by 0x13D438: context_quit (test-gatt.c:312)
>>> ==20817==    by 0x14159A: handle_rsp (att.c:640)
>>> ==20817==    by 0x14159A: can_read_data (att.c:813)
>>> ==20817==    by 0x14AEC4: watch_callback (io-glib.c:170)
>>> ==20817==    by 0x4E808E4: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80C47: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80F09: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==
>>> ==20817== Invalid read of size 1
>>> ==20817==    at 0x14507C: cancel_request (gatt-client.c:1857)
>>> ==20817==    by 0x14B902: queue_remove_all (queue.c:387)
>>> ==20817==    by 0x1457CC: bt_gatt_client_cancel_all (gatt-client.c:1866)
>>> ==20817==    by 0x145838: bt_gatt_client_free (gatt-client.c:1569)
>>> ==20817==    by 0x13D438: destroy_context (test-gatt.c:284)
>>> ==20817==    by 0x13D438: context_quit (test-gatt.c:312)
>>> ==20817==    by 0x14159A: handle_rsp (att.c:640)
>>> ==20817==    by 0x14159A: can_read_data (att.c:813)
>>> ==20817==    by 0x14AEC4: watch_callback (io-glib.c:170)
>>> ==20817==    by 0x4E808E4: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80C47: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80F09: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x140030: tester_run (tester.c:830)
>>> ==20817==    by 0x13BE18: main (test-gatt.c:3182)
>>> ==20817==  Address 0x5a13909 is 9 bytes inside a block of size 40 free'd
>>> ==20817==    at 0x4C2A37C: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>>> ==20817==    by 0x140F1E: cancel_att_send_op (att.c:222)
>>> ==20817==    by 0x140F1E: bt_att_cancel (att.c:1200)
>>> ==20817==    by 0x145075: cancel_request (gatt-client.c:1852)
>>> ==20817==    by 0x14B902: queue_remove_all (queue.c:387)
>>> ==20817==    by 0x1457CC: bt_gatt_client_cancel_all (gatt-client.c:1866)
>>> ==20817==    by 0x145838: bt_gatt_client_free (gatt-client.c:1569)
>>> ==20817==    by 0x13D438: destroy_context (test-gatt.c:284)
>>> ==20817==    by 0x13D438: context_quit (test-gatt.c:312)
>>> ==20817==    by 0x14159A: handle_rsp (att.c:640)
>>> ==20817==    by 0x14159A: can_read_data (att.c:813)
>>> ==20817==    by 0x14AEC4: watch_callback (io-glib.c:170)
>>> ==20817==    by 0x4E808E4: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80C47: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==    by 0x4E80F09: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.1)
>>> ==20817==
>>> ==20817==
>>> ==20817== HEAP SUMMARY:
>>> ==20817==     in use at exit: 29,640 bytes in 618 blocks
>>> ==20817==   total heap usage: 36,545 allocs, 35,927 frees, 1,585,464 bytes allocated
>>> ==20817==
>>> ==20817== LEAK SUMMARY:
>>> ==20817==    definitely lost: 0 bytes in 0 blocks
>>> ==20817==    indirectly lost: 0 bytes in 0 blocks
>>> ==20817==      possibly lost: 0 bytes in 0 blocks
>>> ==20817==    still reachable: 29,640 bytes in 618 blocks
>>> ==20817==         suppressed: 0 bytes in 0 blocks
>>> ==20817== Rerun with --leak-check=full to see details of leaked memory
>>> ==20817==
>>> ==20817== For counts of detected and suppressed errors, rerun with: -v
>>> ==20817== Use --track-origins=yes to see where uninitialised values come from
>>> ==20817== ERROR SUMMARY: 358 errors from 4 contexts (suppressed: 0 from 0)
>>>
>>> Unfortunately, my understanding of the code did not allow me
>>> to fis this :-(
>>>
>>> Best regards,
>>>
>>>       Stefan
>>>
> 
> 
> 
