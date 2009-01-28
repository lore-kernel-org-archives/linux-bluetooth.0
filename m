Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez: bluetoothd: segmentation fault
From: Marcel Holtmann <marcel@holtmann.org>
To: Eric Rannaud <eric.rannaud@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090123224609.GC6670@nc050>
References: <20090123224609.GC6670@nc050>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 06:49:35 +0100
Message-Id: <1233121775.18259.12.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eric,

> With bluez-4.22-2.fc10.x86_64.rpm (built from the SRPM with debug
> information enabled), when starting/stopping 'mplayer
> -ao:device=bluetooth' several times, bluetoothd regularly segfaults. I
> got the following information from gdb and valgrind.
> 
> It seems somewhat similar to the segfault in:
> http://markmail.org/message/patvlq26erojxbj6
> 
> (I also tried with git HEAD, but I have another problem, see end of the
> email.)
> 
> 
> bluetoothd[29533]: Accepted new client connection on unix socket (fd=29)
> bluetoothd[29533]: Unix client disconnected (fd=27)
> bluetoothd[29533]: Audio API: received BT_GETCAPABILITIES_REQ
> bluetoothd[29533]: Audio API: sending BT_GETCAPABILITIES_RSP
> bluetoothd[29533]: Audio API: received BT_SETCONFIGURATION_REQ
> bluetoothd[29533]: config sco - device = 00:1A:0E:16:18:B2 access_mode = 2
> bluetoothd[29533]: Audio API: sending BT_STREAMSTART_RSP
> bluetoothd[29533]: Error Bad file descriptor(9)
> bluetoothd[29533]: Audio API: sending BT_STREAMFD_IND
> bluetoothd[29533]: Error Bad file descriptor(9)
> bluetoothd[29533]: unix_sendmsg_fd: Bad file descriptor(9)
> bluetoothd[29533]: headset_resume_complete: resume failed
> bluetoothd[29533]: Audio API: sending BT_SETCONFIGURATION_RSP
> bluetoothd[29533]: Audio API: received BT_STREAMSTART_REQ
> bluetoothd[29533]: Unix client disconnected (fd=29)
> bluetoothd[29533]: Accepted new client connection on unix socket (fd=27)
> bluetoothd[29533]: Audio API: received BT_GETCAPABILITIES_REQ
> bluetoothd[29533]: Audio API: sending BT_GETCAPABILITIES_RSP
> bluetoothd[29533]: Audio API: received BT_SETCONFIGURATION_REQ
> bluetoothd[29533]: config sco - device = 00:1A:0E:16:18:B2 access_mode = 2
> bluetoothd[29533]: Audio API: sending BT_STREAMSTART_RSP
> bluetoothd[29533]: Error Socket operation on non-socket(88)
> bluetoothd[29533]: Audio API: sending BT_STREAMFD_IND
> bluetoothd[29533]: Error Socket operation on non-socket(88)
> bluetoothd[29533]: unix_sendmsg_fd: Socket operation on non-socket(88)
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00000000f29c9453 in dbus_message_append_args ()
>    from /usr/lib64/bluetooth/plugins/audio.so
> (gdb) bt
> #0  0x00000000f29c9453 in dbus_message_append_args ()
>    from /usr/lib64/bluetooth/plugins/audio.so
> #1  0x00000000f29bff17 in dbus_message_append_args ()
>    from /usr/lib64/bluetooth/plugins/audio.so
> #2  0x00000000f29c4eb7 in dbus_message_append_args ()
>    from /usr/lib64/bluetooth/plugins/audio.so
> #3  0x00000000003873fd in g_slist_foreach () from /lib64/libglib-2.0.so.0
> #4  0x00000000f29c4ef8 in dbus_message_append_args ()
>    from /usr/lib64/bluetooth/plugins/audio.so
> #5  0x00000000f29c8968 in dbus_message_append_args ()
>    from /usr/lib64/bluetooth/plugins/audio.so
> #6  0x000000000036879b in g_main_context_dispatch ()
>    from /lib64/libglib-2.0.so.0
> #7  0x000000000036bf6d in ?? () from /lib64/libglib-2.0.so.0
> #8  0x000000000036c49d in g_main_loop_run () from /lib64/libglib-2.0.so.0
> #9  0x00007ffff7fd2b2f in main () from /usr/sbin/bluetoothd
> (gdb) i r
> rax            0x5a1	1441
> rbx            0x58	88
> rcx            0x100f	4111
> rdx            0xf	15
> rsi            0xf82053f0	4162868208
> rdi            0x7ffff82139b0	140737356315056
> rbp            0x7fffffffe190	0x7fffffffe190
> rsp            0x7fffffffe170	0x7fffffffe170
> r8             0x7ffff8214fe0	140737356320736
> r9             0x0	0
> r10            0x4000	16384
> r11            0x246	582
> r12            0xf29c4e5a	4070329946
> r13            0x1	1
> r14            0x0	0
> r15            0x7ffff820f650	140737356297808
> rip            0xf29c9453	0xf29c9453 <dbus_message_append_args+42611>
> eflags         0x10202	[ IF RF ]
> cs             0x33	51
> ss             0x2b	43
> ds             0x0	0
> es             0x0	0
> fs             0x0	0
> gs             0x0	0
> fctrl          0x37f	895
> fstat          0x0	0
> ftag           0xffff	65535
> fiseg          0x0	0
> fioff          0x0	0
> foseg          0x0	0
> fooff          0x0	0
> fop            0x0	0
> mxcsr          0x1f80	[ IM DM ZM OM UM PM ]
> 
> 
> 
> 
> 
> bluetoothd[31752]: Received AT+VGM=13
> bluetoothd[31752]: Unix client disconnected (fd=16)
> bluetoothd[31752]: Accepted new client connection on unix socket (fd=16)
> bluetoothd[31752]: Audio API: received BT_GETCAPABILITIES_REQ
> bluetoothd[31752]: Audio API: sending BT_GETCAPABILITIES_RSP
> bluetoothd[31752]: Audio API: received BT_SETCONFIGURATION_REQ
> bluetoothd[31752]: config sco - device = 00:1A:0E:16:18:B2 access_mode = 2
> ==31752== Invalid write of size 4
> ==31752==    at 0x5237D80: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523CEB6: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E563FC: g_slist_foreach (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x523CEF7: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5240967: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752==  Address 0x4d831fc is 68 bytes inside a block of size 88 free'd
> ==31752==    at 0x4A0609F: free (vg_replace_malloc.c:323)
> ==31752==    by 0x5237728: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5239B28: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752== 
> ==31752== Invalid read of size 4
> ==31752==    at 0x5237DAD: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523CEB6: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E563FC: g_slist_foreach (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x523CEF7: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5240967: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752==  Address 0x4d831d8 is 32 bytes inside a block of size 88 free'd
> ==31752==    at 0x4A0609F: free (vg_replace_malloc.c:323)
> ==31752==    by 0x5237728: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5239B28: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> bluetoothd[31752]: Audio API: sending BT_STREAMSTART_RSP
> ==31752== 
> ==31752== Invalid read of size 4
> ==31752==    at 0x523785B: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5237E29: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523CEB6: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E563FC: g_slist_foreach (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x523CEF7: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5240967: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752==  Address 0x4d831f0 is 56 bytes inside a block of size 88 free'd
> ==31752==    at 0x4A0609F: free (vg_replace_malloc.c:323)
> ==31752==    by 0x5237728: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5239B28: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> bluetoothd[31752]: Audio API: sending BT_STREAMFD_IND
> ==31752== 
> ==31752== Invalid read of size 4
> ==31752==    at 0x523785B: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5237E6D: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523CEB6: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E563FC: g_slist_foreach (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x523CEF7: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5240967: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752==  Address 0x4d831f0 is 56 bytes inside a block of size 88 free'd
> ==31752==    at 0x4A0609F: free (vg_replace_malloc.c:323)
> ==31752==    by 0x5237728: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5239B28: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752== 
> ==31752== Invalid write of size 4
> ==31752==    at 0x5237E94: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523CEB6: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E563FC: g_slist_foreach (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x523CEF7: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5240967: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752==  Address 0x4d831f8 is 64 bytes inside a block of size 88 free'd
> ==31752==    at 0x4A0609F: free (vg_replace_malloc.c:323)
> ==31752==    by 0x5237728: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5239B28: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752== 
> ==31752== Invalid read of size 4
> ==31752==    at 0x5237EAF: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523CEB6: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E563FC: g_slist_foreach (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x523CEF7: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5240967: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752==  Address 0x4d831f8 is 64 bytes inside a block of size 88 free'd
> ==31752==    at 0x4A0609F: free (vg_replace_malloc.c:323)
> ==31752==    by 0x5237728: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5239B28: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752== 
> ==31752== Invalid read of size 4
> ==31752==    at 0x5237EB9: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523CEB6: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E563FC: g_slist_foreach (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x523CEF7: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5240967: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752==  Address 0x4d831f0 is 56 bytes inside a block of size 88 free'd
> ==31752==    at 0x4A0609F: free (vg_replace_malloc.c:323)
> ==31752==    by 0x5237728: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5239B28: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> bluetoothd[31752]: unix_sendmsg_fd: Bad file descriptor(9)
> ==31752== 
> ==31752== Invalid read of size 4
> ==31752==    at 0x5237F06: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523CEB6: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E563FC: g_slist_foreach (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x523CEF7: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5240967: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752==  Address 0x4d831d8 is 32 bytes inside a block of size 88 free'd
> ==31752==    at 0x4A0609F: free (vg_replace_malloc.c:323)
> ==31752==    by 0x5237728: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5239B28: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752== 
> ==31752== Invalid read of size 8
> ==31752==    at 0x5237F0F: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523CEB6: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E563FC: g_slist_foreach (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x523CEF7: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5240967: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752==  Address 0x4d831b8 is 0 bytes inside a block of size 88 free'd
> ==31752==    at 0x4A0609F: free (vg_replace_malloc.c:323)
> ==31752==    by 0x5237728: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x5239B28: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> bluetoothd[31752]: telephony-dummy: device 0x4d624b8 disconnected
> bluetoothd[31752]: State changed /org/bluez/31752/hci0/dev_00_1A_0E_16_18_B2: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
> bluetoothd[31752]: headset_resume_complete: resume failed
> bluetoothd[31752]: Audio API: sending BT_SETCONFIGURATION_RSP
> bluetoothd[31752]: Error Broken pipe(32)
> bluetoothd[31752]: Unix client disconnected (fd=16)
> bluetoothd[31752]: connect(): Connection timed out (110)
> ==31752== 
> ==31752== Invalid read of size 4
> ==31752==    at 0x3563C12D35: (within /lib64/libdbus-1.so.3.4.0)
> ==31752==    by 0x3563C178F9: dbus_message_get_sender (in /lib64/libdbus-1.so.3.4.0)
> ==31752==    by 0x3563C1AE95: dbus_message_new_error (in /lib64/libdbus-1.so.3.4.0)
> ==31752==    by 0x17D73: error_common_reply (in /usr/sbin/bluetoothd)
> ==31752==    by 0x523C64A: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523D3BE: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x29085: (within /usr/sbin/bluetoothd)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752==  Address 0x10102464c45bb is not stack'd, malloc'd or (recently) free'd
> ==31752== 
> ==31752== Process terminating with default action of signal 11 (SIGSEGV)
> ==31752==  General Protection Fault
> ==31752==    at 0x3563C12D35: (within /lib64/libdbus-1.so.3.4.0)
> ==31752==    by 0x3563C178F9: dbus_message_get_sender (in /lib64/libdbus-1.so.3.4.0)
> ==31752==    by 0x3563C1AE95: dbus_message_new_error (in /lib64/libdbus-1.so.3.4.0)
> ==31752==    by 0x17D73: error_common_reply (in /usr/sbin/bluetoothd)
> ==31752==    by 0x523C64A: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x523D3BE: (within /usr/lib64/bluetooth/plugins/audio.so)
> ==31752==    by 0x29085: (within /usr/sbin/bluetoothd)
> ==31752==    by 0x3E78E3779A: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3AF6C: (within /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0x3E78E3B49C: g_main_loop_run (in /lib64/libglib-2.0.so.0.1800.3)
> ==31752==    by 0xCB2E: main (in /usr/sbin/bluetoothd)
> ==31752== 
> ==31752== ERROR SUMMARY: 10 errors from 10 contexts (suppressed: 22 from 1)
> ==31752== malloc/free: in use at exit: 63,482 bytes in 833 blocks.
> ==31752== malloc/free: 3,087 allocs, 2,254 frees, 3,214,137 bytes allocated.
> ==31752== For counts of detected errors, rerun with: -v
> ==31752== searching for pointers to 833 not-freed blocks.
> ==31752== checked 183,216 bytes.
> ==31752== 
> ==31752== LEAK SUMMARY:
> ==31752==    definitely lost: 88 bytes in 1 blocks.
> ==31752==      possibly lost: 992 bytes in 2 blocks.
> ==31752==    still reachable: 62,402 bytes in 830 blocks.
> ==31752==         suppressed: 0 bytes in 0 blocks.
> ==31752== Rerun with --leak-check=full to see details of leaked memory.
> Segmentation fault
> 
> 
> 
> 
> I tried to reproduce this segmentation fault with git HEAD, but when
> running 'src/bluetooth -dn', running 'mplayer -ao:device=headset' fails
> with:
> 
> [AO_ALSA] alsa-lib: pcm_bluetooth.c:1531:(audioservice_recv) Error receiving data from audio service: Success(0)
> [AO_ALSA] alsa-lib: pcm_bluetooth.c:1547:(audioservice_expect) Bogus message BT_GETCAPABILITIES_REQ received while BT_GETCAPABILITIES_RSP was expected
> [AO_ALSA] Playback open error: Invalid argument
> 
> 
> while:
> ...
> bluetoothd[31939]: Computer is classified as laptop
> bluetoothd[31939]: Current device class is 0x4a010c
> bluetoothd[31939]: Setting 0x00010c for major/minor device class
> bluetoothd[31939]: Agent registered for hci0 at :1.34:/org/bluez/agent/hci0
> bluetoothd[20499]: Accepted new client connection on unix socket (fd=16)
> bluetoothd[20499]: Audio API: BT_REQUEST <- (null)
> bluetoothd[20499]: Invalid message: length mismatch
> 
> 
> (note: this is not doing 'make install', but running on top of the F10
> bluez package. I realize that's far from ideal, but 'make install'
> doesn't give me a running configuration:

that will be the reason since you have to have the correct daemon
running and the correct pcm_bluetooth.so for ALSA to use.

Regards

Marcel


