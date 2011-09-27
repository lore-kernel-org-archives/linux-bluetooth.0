Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:31:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix possible crash while removing a device
Message-ID: <20110927093102.GB3952@dell>
References: <1316781399-10977-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1316781399-10977-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Sep 23, 2011, Luiz Augusto von Dentz wrote:
> If adapter has more than one sdp session active find_by_bdaddr always
> return the first one regardless if the device address match or not
> which leads to the following crash:
> 
> Invalid read of size 4
>    at 0x16CB31: search_cb (in /usr/sbin/bluetoothd)
>    by 0x15C0CA: connect_watch (in /usr/sbin/bluetoothd)
>    by 0x48CFD37: g_io_unix_dispatch (in /usr/lib/libglib-2.0.so.0.2800.6)
>    by 0x488B4A0: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.2800.6)
>    by 0x488BCD0: g_main_context_iterate.clone.5 (in /usr/lib/libglib-2.0.so.0.2800.6)
>    by 0x488C3B8: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.2800.6)
>    by 0x152D09: main (in /usr/sbin/bluetoothd)
>   Address 0x4c8c600 is 16 bytes inside a block of size 48 free'd
>    at 0x48234A9: free (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
>    by 0x48920F0: g_free (in /usr/lib/libglib-2.0.so.0.2800.6)
>    by 0x16BDD3: browse_request_free (in /usr/sbin/bluetoothd)
>    by 0x16C7A2: browse_request_cancel (in /usr/sbin/bluetoothd)
> 
> Reported by Alberto José Rodríguez Rodríguez <ajrodriguez@blulabs.es>
> ---
>  src/glib-helper.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
