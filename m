Return-Path: <cyrus@holtmann.org>
Date: Sat, 23 Feb 2013 10:09:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] profile: Fix crash when registering an invalid
 profile
Message-ID: <20130223080915.GA29928@x220.P-661HNU-F1>
References: <1361573456-11528-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361573456-11528-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Feb 22, 2013, Vinicius Costa Gomes wrote:
> When a uuid string is sent and it doesn't indentify a profile
> (bt_name2string() returns NULL), bluetoothd crash later when trying
> to access the external profile uuid field.
> 
> Valgrind log:
> 
> bluetoothd[3986]: src/profile.c:register_profile() sender :1.492
> ==3986== Invalid read of size 1
> ==3986==    at 0x4C2ACA4: strcasecmp (mc_replace_strmem.c:583)
> ==3986==    by 0x4656F0: register_profile (profile.c:1920)
> ==3986==    by 0x40CFF0: process_message.isra.4 (object.c:258)
> ==3986==    by 0x517C9E5: _dbus_object_tree_dispatch_and_unlock (in /usr/lib64/libdbus-1.so.3.7.2)
> ==3986==    by 0x5167349: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.2)
> ==3986==    by 0x40AB77: message_dispatch (mainloop.c:76)
> ==3986==    by 0x4E77BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==3986==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==3986==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==3986==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==3986==    by 0x40A3AE: main (main.c:583)
> ==3986==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
> ==3986==
> ==3986==
> ==3986== Process terminating with default action of signal 11 (SIGSEGV)
> ==3986==  Access not within mapped region at address 0x0
> ==3986==    at 0x4C2ACA4: strcasecmp (mc_replace_strmem.c:583)
> ==3986==    by 0x4656F0: register_profile (profile.c:1920)
> ==3986==    by 0x40CFF0: process_message.isra.4 (object.c:258)
> ==3986==    by 0x517C9E5: _dbus_object_tree_dispatch_and_unlock (in /usr/lib64/libdbus-1.so.3.7.2)
> ==3986==    by 0x5167349: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.2)
> ==3986==    by 0x40AB77: message_dispatch (mainloop.c:76)
> ==3986==    by 0x4E77BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==3986==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==3986==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==3986==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==3986==    by 0x40A3AE: main (main.c:583)
> ==3986==  If you believe this happened as a result of a stack
> ==3986==  overflow in your program's main thread (unlikely but
> ==3986==  possible), you can try to increase the size of the
> ==3986==  main thread stack using the --main-stacksize= flag.
> ==3986==  The main thread stack size used in this run was 8388608.
> ==3986==
> ---
>  src/profile.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
