Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2013 16:05:30 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/4] device: Fix invalid memory access during
 Find Included
Message-ID: <20130129220530.GC11112@x220>
References: <1359486007-3273-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359486007-3273-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Jan 29, 2013, Vinicius Costa Gomes wrote:
> When doing the Find Included Services GATT procedure, the status of the ATT
> procedure was being ignored, and in the case of a timeout it is possible to
> crash bluetooth with an invalid memory access.
> 
> Valgrind log:
> 
> ==1755== Invalid read of size 8
> ==1755==    at 0x46971A: find_included_cb (device.c:2964)
> ==1755==    by 0x4465AE: isd_unref (gatt.c:92)
> ==1755==    by 0x446885: find_included_cb (gatt.c:425)
> ==1755==    by 0x448266: disconnect_timeout (gattrib.c:269)
> ==1755==    by 0x4E76BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x40A2EE: main (main.c:583)
> ==1755==  Address 0x69530a8 is 8 bytes inside a block of size 64 free'd
> ==1755==    at 0x4C2874F: free (vg_replace_malloc.c:446)
> ==1755==    by 0x40BFA6: service_filter (watch.c:486)
> ==1755==    by 0x40BC6A: message_filter (watch.c:554)
> ==1755==    by 0x5160A1D: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.2)
> ==1755==    by 0x40AAB7: message_dispatch (mainloop.c:76)
> ==1755==    by 0x4E76BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x40A2EE: main (main.c:583)
> ==1755==
> ==1755== Invalid read of size 8
> ==1755==    at 0x4486D5: g_attrib_get_buffer (gattrib.c:657)
> ==1755==    by 0x4467C5: find_included (gatt.c:363)
> ==1755==    by 0x4465AE: isd_unref (gatt.c:92)
> ==1755==    by 0x446885: find_included_cb (gatt.c:425)
> ==1755==    by 0x448266: disconnect_timeout (gattrib.c:269)
> ==1755==    by 0x4E76BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x40A2EE: main (main.c:583)
> ==1755==  Address 0x18 is not stack'd, malloc'd or (recently) free'd
> ==1755==
> ==1755==
> ==1755== Process terminating with default action of signal 11 (SIGSEGV)
> ==1755==  Access not within mapped region at address 0x18
> ==1755==    at 0x4486D5: g_attrib_get_buffer (gattrib.c:657)
> ==1755==    by 0x4467C5: find_included (gatt.c:363)
> ==1755==    by 0x4465AE: isd_unref (gatt.c:92)
> ==1755==    by 0x446885: find_included_cb (gatt.c:425)
> ==1755==    by 0x448266: disconnect_timeout (gattrib.c:269)
> ==1755==    by 0x4E76BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x4E76771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
> ==1755==    by 0x40A2EE: main (main.c:583)
> ---
>  attrib/gatt.c | 5 ++++-
>  src/device.c  | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)

Patches 1-3 have been applied. We still need to discuss 4/4 though since

1) We should always try to secure the link as well as possible (meaning
encrypt it if we have an LTK)
and
2) Even if we do try to encrypt the link the ATT socket still needs to
remain functional all the time since there could be PDUs coming and
going that do not need high security.

Johan
