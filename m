Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Oct 2012 10:53:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] service: Fix passing stack variable as reference
 value
Message-ID: <20121009085318.GA32191@x220.ger.corp.intel.com>
References: <1349726904-5381-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349726904-5381-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 08, 2012, Luiz Augusto von Dentz wrote:
> BDADDR_ANY cannot be return as it uses stack allocation:
> 
> Conditional jump or move depends on uninitialised value(s)
>    at 0x170E47: sdp_record_remove (sdpd-database.c:269)
>    by 0x17071A: remove_record_from_server (sdpd-service.c:290)
>    by 0x14D416: exit_callback (service.c:131)
>    by 0x124396: service_filter (watch.c:486)
>    by 0x12405A: message_filter (watch.c:554)
>    by 0x4F63A35: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x122EE7: message_dispatch (mainloop.c:76)
>    by 0x4C7B3BA: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7A824: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7AB57: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7AF51: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x1225B1: main (main.c:551)
>  Uninitialised value was created by a stack allocation
>    at 0x1705B0: add_record_to_server (sdpd-service.c:235)
> 
> Conditional jump or move depends on uninitialised value(s)
>    at 0x4A0AD21: bcmp (mc_replace_strmem.c:889)
>    by 0x4C959E0: g_slist_find_custom (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x17C059: manager_find_adapter (manager.c:291)
>    by 0x170E8F: sdp_record_remove (sdpd-database.c:270)
>    by 0x17071A: remove_record_from_server (sdpd-service.c:290)
>    by 0x14D416: exit_callback (service.c:131)
>    by 0x124396: service_filter (watch.c:486)
>    by 0x12405A: message_filter (watch.c:554)
>    by 0x4F63A35: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x122EE7: message_dispatch (mainloop.c:76)
>    by 0x4C7B3BA: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7A824: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
>  Uninitialised value was created by a stack allocation
>    at 0x1705B0: add_record_to_server (sdpd-service.c:235)
> ---
>  plugins/service.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
