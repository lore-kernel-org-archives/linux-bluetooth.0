Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1368232149-9974-2-git-send-email-vinicius.gomes@openbossa.org>
References: <1368232149-9974-1-git-send-email-vinicius.gomes@openbossa.org>
	<1368232149-9974-2-git-send-email-vinicius.gomes@openbossa.org>
Date: Sat, 11 May 2013 11:18:02 +0300
Message-ID: <CABBYNZJDL478uFzA2qAdj1ubav4FXEVvHix5Z37mv7oLyL0=ZQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] avrcp: Fix crash using the wrong AVRCP role
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Sat, May 11, 2013 at 3:29 AM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> When both A2DP Sink and Source are unavailable (dev->sink and
> dev->source are NULL), the wrong AVRCP role gets selected.
>
> Valgrind log:
>
> bluetoothd[24510]: src/adapter.c:connected_callback() hci0 device 00:02:72:DC:29:78 connected eir_len 10
> bluetoothd[24510]: profiles/audio/avctp.c:avctp_confirm_cb() AVCTP: incoming connect from 00:02:72:DC:29:78
> bluetoothd[24510]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
> bluetoothd[24510]: profiles/audio/avctp.c:avctp_connect_cb() AVCTP: connected to 00:02:72:DC:29:78
> bluetoothd[24510]: Can't open input device: No such file or directory (2)
> bluetoothd[24510]: AVRCP: failed to init uinput for 00:02:72:DC:29:78
> bluetoothd[24510]: profiles/audio/avrcp.c:session_ct_init_control() 0x62df7e0 version 0x0000
> ==24510== Invalid read of size 4
> ==24510==    at 0x468370: btd_service_connecting_complete (service.c:315)
> ==24510==    by 0x41B70F: session_ct_init_control (avrcp.c:2790)
> ==24510==    by 0x41B1E0: state_changed (avrcp.c:2933)
> ==24510==    by 0x418054: avctp_set_state (avctp.c:548)
> ==24510==    by 0x41A2E4: avctp_connect_cb (avctp.c:1201)
> ==24510==    by 0x44F989: accept_cb (btio.c:201)
> ==24510==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==24510==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==24510==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==24510==    by 0x40A8EE: main (main.c:583)
> ==24510==  Address 0x20 is not stack'd, malloc'd or (recently) free'd
> ==24510==
> ==24510==
> ==24510== Process terminating with default action of signal 11 (SIGSEGV)
> ==24510==  Access not within mapped region at address 0x20
> ==24510==    at 0x468370: btd_service_connecting_complete (service.c:315)
> ==24510==    by 0x41B70F: session_ct_init_control (avrcp.c:2790)
> ==24510==    by 0x41B1E0: state_changed (avrcp.c:2933)
> ==24510==    by 0x418054: avctp_set_state (avctp.c:548)
> ==24510==    by 0x41A2E4: avctp_connect_cb (avctp.c:1201)
> ==24510==    by 0x44F989: accept_cb (btio.c:201)
> ==24510==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==24510==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==24510==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==24510==    by 0x40A8EE: main (main.c:583)
> ==24510==  If you believe this happened as a result of a stack
> ==24510==  overflow in your program's main thread (unlikely but
> ==24510==  possible), you can try to increase the size of the
> ==24510==  main thread stack using the --main-stacksize= flag.
> ==24510==  The main thread stack size used in this run was 8388608.
> ---

Are you still seeing this problem after we have applied Mikel's patch?
Perhaps we should do a late detection if we cannot find any A2DP role,
we can figure out by looking at the get_capabilities response, but
this would only work for 1.3 and latter. But perhaps we should use the
initiator as under these conditions it should be the controller.
