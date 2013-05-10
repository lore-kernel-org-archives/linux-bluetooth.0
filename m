Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 May 2013 10:33:13 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH BlueZ v0] avctp: Fix missing UUID registration
Message-ID: <20130510133313.GA9736@samus.indt.org>
References: <1368186064-10960-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368186064-10960-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On 13:41 Fri 10 May, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> When there is an incoming connection to AVCTP PSM, there is no way to
> know if the remote UUID corresponds to AVRCP_REMOTE_UUID or
> AVRCP_TARGET_UUID. Therefore both UUIDs should be reported to the core.
> 
> Without this patch, a crash has been observed with the iPhone 5
> immediately after pairing.
> ---
> I don't have the log traces right now but submitting the patch anyway due to the upcoming release.

I imagine it is this issue:

bluetoothd[17941]: src/adapter.c:connected_callback() hci0 device 00:02:72:DC:29:78 connected eir_len 10
bluetoothd[17941]: profiles/audio/avctp.c:avctp_confirm_cb() AVCTP: incoming connect from 00:02:72:DC:29:78
bluetoothd[17941]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
bluetoothd[17941]: profiles/audio/avctp.c:avctp_connect_cb() AVCTP: connected to 00:02:72:DC:29:78
bluetoothd[17941]: Can't open input device: No such file or directory (2)
bluetoothd[17941]: AVRCP: failed to init uinput for 00:02:72:DC:29:78
bluetoothd[17941]: profiles/audio/avrcp.c:session_ct_init_control() 0x7342480 version 0x0000
==17941== Invalid read of size 4
==17941==    at 0x468370: btd_service_connecting_complete (service.c:315)
==17941==    by 0x41B70F: session_ct_init_control (avrcp.c:2790)
==17941==    by 0x41B1E0: state_changed (avrcp.c:2933)
==17941==    by 0x418054: avctp_set_state (avctp.c:548)
==17941==    by 0x41A2E4: avctp_connect_cb (avctp.c:1201)
==17941==    by 0x44F989: accept_cb (btio.c:201)
==17941==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==17941==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==17941==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==17941==    by 0x40A8EE: main (main.c:583)
==17941==  Address 0x20 is not stack'd, malloc'd or (recently) free'd
==17941== 
==17941== 
==17941== Process terminating with default action of signal 11 (SIGSEGV)
==17941==  Access not within mapped region at address 0x20
==17941==    at 0x468370: btd_service_connecting_complete (service.c:315)
==17941==    by 0x41B70F: session_ct_init_control (avrcp.c:2790)
==17941==    by 0x41B1E0: state_changed (avrcp.c:2933)
==17941==    by 0x418054: avctp_set_state (avctp.c:548)
==17941==    by 0x41A2E4: avctp_connect_cb (avctp.c:1201)
==17941==    by 0x44F989: accept_cb (btio.c:201)
==17941==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==17941==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==17941==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==17941==    by 0x40A8EE: main (main.c:583)
==17941==  If you believe this happened as a result of a stack
==17941==  overflow in your program's main thread (unlikely but
==17941==  possible), you can try to increase the size of the
==17941==  main thread stack using the --main-stacksize= flag.
==17941==  The main thread stack size used in this run was 8388608.
==17941== 


Cheers,
-- 
Vinicius
