Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jan 2013 09:07:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 1/6] device: Fix invalid memory access during Find
 Included
Message-ID: <20130125070708.GA17746@x220>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
 <1359083227-13122-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359083227-13122-2-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jan 25, 2013, Vinicius Costa Gomes wrote:
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
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/device.c b/src/device.c
> index bb79b38..893e4bb 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2963,7 +2963,7 @@ static void find_included_cb(GSList *includes, uint8_t status,
>  	struct gatt_primary *prim;
>  	GSList *l;
>  
> -	if (includes == NULL)
> +	if (includes == NULL || status != 0)
>  		goto done;
>  
>  	for (l = includes; l; l = l->next) {

I think the bigger question is why is includes not NULL if status is not
zero? Does it contain invalid entries? Isn't that something that should
be fixed instead? Also, why isn't the code logging something in the case
of status != 0?

Johan
