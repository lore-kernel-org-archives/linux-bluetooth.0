Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/avdtp: Fix crash on disconnect
Date: Fri, 26 Sep 2014 15:40:33 +0200
Message-ID: <3119980.6yBsDKdWM4@uw000953>
In-Reply-To: <1411737719-28189-1-git-send-email-szymon.janc@tieto.com>
References: <1411737719-28189-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 26 of September 2014 15:21:59 Szymon Janc wrote:
> Last reference to session may be dropped while calling connection_lost
> so move watch ID clean before that.
> 
> external/bluetooth/bluez/android/avdtp.c:session_cb()
> external/bluetooth/bluez/android/avdtp.c:avdtp_parse_resp() CLOSE
>     request succeeded
> external/bluetooth/bluez/android/avdtp.c:avdtp_sep_set_state() stream
>     state changed: OPEN -> CLOSING
> external/bluetooth/bluez/android/a2dp.c:sep_close_cfm()
> external/bluetooth/bluez/android/avdtp.c:avdtp_sep_set_state() stream
>     state changed: CLOSING -> IDLE
> external/bluetooth/bluez/android/avdtp.c:session_cb()
> external/bluetooth/bluez/android/avdtp.c:connection_lost()
>     Disconnected: I/O error (5)
> external/bluetooth/bluez/android/avdtp.c:avdtp_ref() 0x4a27fc8: ref=2
> external/bluetooth/bluez/android/a2dp.c:bt_a2dp_notify_state() device
>     00:1E:DE:21:85:6A state 0
> external/bluetooth/bluez/android/avrcp.c:bt_avrcp_disconnect()
> external/bluetooth/bluez/android/avctp.c:avctp_shutdown() AVCTP:
>     closing  uinput
> external/bluetooth/bluez/android/avrcp.c:disconnect_cb()
> external/bluetooth/bluez/android/avdtp.c:avdtp_unref() 0x4a27fc8: ref=1
> external/bluetooth/bluez/android/avdtp.c:avdtp_unref() 0x4a27fc8: ref=0
> external/bluetooth/bluez/android/avdtp.c:avdtp_free() 0x4a27fc8
> 
> ==1225== Invalid write of size 4
> ==1225==    at 0x11ABDE: session_cb (avdtp.c:2084)
> ==1225==    by 0x48BD9C7: g_io_unix_dispatch (giounix.c:166)
> ==1225==    by 0x48C2CCB: g_main_context_dispatch (gmain.c:2539)
> ==1225==    by 0x48C2ED9: g_main_context_iterate.isra.19 (gmain.c:3146)
> ==1225==    by 0x48C3167: g_main_loop_run (gmain.c:3340)
> ==1225==    by 0x10D379: main (main.c:628)
> ==1225==  Address 0x4a27fdc is 20 bytes inside a block of size 1,104 free'd
> ==1225==    at 0x4897E6C: free (in /system/lib/valgrind/
>    vgpreload_memcheck-arm-linux.so)
> ==1225==    by 0x48C5E2B: g_free (gmem.c:252)
> ==1225==    by 0x11ABDB: session_cb (avdtp.c:2082)
> ==1225==    by 0x48BD9C7: g_io_unix_dispatch (giounix.c:166)
> ==1225==    by 0x48C2CCB: g_main_context_dispatch (gmain.c:2539)
> ==1225==    by 0x48C2ED9: g_main_context_iterate.isra.19 (gmain.c:3146)
> ==1225==    by 0x48C3167: g_main_loop_run (gmain.c:3340)
> ==1225==    by 0x10D379: main (main.c:628)
> ==1225==
> ---
> 
> Other option would be to pass avdtp reference to session_cb and drop it
> when function returns FALSE. If that is prefered I'd send revised
> patch.
> 
>  android/avdtp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/android/avdtp.c b/android/avdtp.c
> index 970476a..9f2527f 100644
> --- a/android/avdtp.c
> +++ b/android/avdtp.c
> @@ -2079,9 +2079,8 @@ next:
>  	return TRUE;
>  
>  failed:
> -	connection_lost(session, EIO);
> -
>  	session->io_id = 0;
> +	connection_lost(session, EIO);
>  
>  	return FALSE;
>  }
> 

Pushed.

-- 
Best regards, 
Szymon Janc
