Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 5 Dec 2017 14:35:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] mesh: Make meshctl use bt_shell helpers
Message-ID: <20171205123523.GA15993@x1c.lan>
References: <20171205112626.11210-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171205112626.11210-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 05, 2017, Luiz Augusto von Dentz wrote:
> This makes meshctl use bt_shell to manage the menus and command
> handling.
> ---
>  mesh/config-client.c | 187 ++++++++---------
>  mesh/config-model.h  |   1 -
>  mesh/main.c          | 571 +++++++++++++++------------------------------------
>  mesh/onoff-model.c   |  88 +++-----
>  mesh/util.c          | 155 +-------------
>  mesh/util.h          |  16 +-
>  6 files changed, 278 insertions(+), 740 deletions(-)

There's still something broken. Did you test this at all?

If I issue "connect 1 2" right after starting meshctl I get this:

[meshctl]# connect 1 2
==16599== Invalid read of size 1
==16599==    at 0x4C32B82: strlen (vg_replace_strmem.c:458)
==16599==    by 0x4EA5962: g_strdup (in /usr/lib64/libglib-2.0.so.0.5400.2)
==16599==    by 0x4EA7404: g_strdupv (in /usr/lib64/libglib-2.0.so.0.5400.2)
==16599==    by 0x40861F: set_scan_filter_uuids.constprop.14 (main.c:1613)
==16599==    by 0x4086E2: cmd_connect (main.c:1729)
==16599==    by 0x41C8F7: cmd_exec (shell.c:290)
==16599==    by 0x41C8F7: menu_exec (shell.c:314)
==16599==    by 0x41D1B2: shell_exec (shell.c:326)
==16599==    by 0x41D1B2: rl_handler (shell.c:473)
==16599==    by 0x55DB8BD: rl_callback_read_char (in /usr/lib64/libreadline.so.7.0)
==16599==    by 0x41C4E8: input_read (shell.c:765)
==16599==    by 0x41D672: watch_callback (io-glib.c:170)
==16599==    by 0x4E86BB6: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5400.2)
==16599==    by 0x4E86F5F: ??? (in /usr/lib64/libglib-2.0.so.0.5400.2)
==16599==  Address 0x2 is not stack'd, malloc'd or (recently) free'd

It looks like the cause might be the new UUID string arrays which are
expected to be NULL terminated.

Johan
