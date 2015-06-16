Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <043001d0a36c$5e8b3040$1ba190c0$@samsung.com>
References: <041c01d0a35e$eedcb780$cc962680$@samsung.com>
	<043001d0a36c$5e8b3040$1ba190c0$@samsung.com>
Date: Tue, 16 Jun 2015 15:15:44 +0300
Message-ID: <CABBYNZJXOsj8SrVQvtJc03_QqXcPNAgczvxpeG5rJ75T33kKZw@mail.gmail.com>
Subject: Re: Query on AVRCP PTS testing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Wed, Jun 10, 2015 at 1:58 PM, Bharat Bhusan Panda
<bharat.panda@samsung.com> wrote:
> Hi Luiz,
>
> Please find below logs with valgrind,
>
> ==19866== Invalid read of size 8
> ==19866==    at 0x426817: avrcp_handle_event (avrcp.c:3102)
> ==19866==    by 0x4208B3: session_cb (avctp.c:831)
> ==19866==    by 0x4E7FCE4: g_main_context_dispatch (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==19866==    by 0x4E80047: g_main_context_iterate.isra.24 (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==19866==    by 0x4E80309: g_main_loop_run (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==19866==    by 0x40B2AE: main (main.c:661)
> ==19866==  Address 0x50 is not stack'd, malloc'd or (recently) free'd

It seems session->controller is not initialized but we did have a fix
for this no long ago:

commit f58d61e7fdfc2c60aa3054d4a9467aa5e2627650
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Mar 18 11:25:09 2015 +0200

    audio/avrcp: Fix crash when acting as TG

    When acting as TG the code may end up using GetCapabilities to figure
    out if volume changed event is supported, this cause crashes with
    remote devices that don't support TG themselves because
    session->controller is not initialized.

    Note that to pass AVRCP qualification when volume changed is supported
    the device has to support TG as well as CT record, this is because PTS
    will attempt to fetch the TG record for any test that it is sending
    commands so devices where this crash happen most likely don't have
    volume control feature enabled.

-- 
Luiz Augusto von Dentz
