Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Feb 2015 08:44:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] policy: Fix not removing timers
Message-ID: <20150202064456.GA9301@t440s.lan>
References: <1422623075-6319-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422623075-6319-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jan 30, 2015, Luiz Augusto von Dentz wrote:
> If service becomes unavailable, due to e.g. the device being removed,
> all the related timers should be removed as well otherwise it may cause
> crashes such as the following:
> 
> Invalid read of size 8
>    at 0x4A6597: btd_device_get_service (device.c:5335)
>    by 0x40F49F: policy_connect_ct (policy.c:112)
>    by 0x4E7F552: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
>    by 0x4E7EAEA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
>    by 0x4E7EE87: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
>    by 0x4E7F1B1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.1)
>    by 0x40BACF: main (main.c:631)
>  Address 0x73b9ba8 is 360 bytes inside a block of size 592 free'd
>    at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>    by 0x4E847FE: g_free (in /usr/lib64/libglib-2.0.so.0.4200.1)
>    by 0x49C83F: device_free (device.c:624)
>    by 0x4BDB29: remove_interface (object.c:658)
>    by 0x4BE701: g_dbus_unregister_interface (object.c:1382)
>    by 0x4A49DC: btd_device_unref (device.c:5173)
>    by 0x41DC46: avdtp_free (avdtp.c:1138)
>    by 0x41EE09: connection_lost (avdtp.c:1164)
>    by 0x422EA5: session_cb (avdtp.c:2263)
>    by 0x4E7EAEA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
>    by 0x4E7EE87: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
>    by 0x4E7F1B1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.1)
> ---
>  plugins/policy.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Both of these two patches have been applied. Thanks.

Johan
