Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sun, 18 Mar 2018 10:44:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Atul Rai <a.rai@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com,
        anupam.r@samsung.com
Subject: Re: [PATCH] Mesh: Close net session on device disconnection
Message-ID: <20180318084438.GA14438@x1c.home>
References: <CGME20180316074208epcas2p22e43ea7190d2ce88a5cf952269c8939a@epcas2p2.samsung.com>
 <1521186117-12216-1-git-send-email-a.rai@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521186117-12216-1-git-send-email-a.rai@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Atul,

On Fri, Mar 16, 2018, Atul Rai wrote:
> On device disconnection, net session is not closed. On next
> attempt to provision/connect a device, net session proxy is
> not updated by net_session_open() as proxy_in is not NULL.
> This causes meshctl to use invalid proxy resulting in below
> crash.
> 
> 0  strlen () at ../sysdeps/x86_64/strlen.S:106
> 1  0x00007f3a3c8b1ac4 in _dbus_string_init_const () from libdbus-1.so.3
> 2  0x00007f3a3c89ed15 in ?? () from libdbus-1.so.3
> 3  0x00007f3a3c89fba0 in dbus_message_new_method_call () from libdbus-1.so.3
> 4  0x0000000000419880 in g_dbus_proxy_method_call at gdbus/client.c:997
> 5  0x000000000040ab9d in mesh_gatt_write at mesh/gatt.c:347
> 6  0x000000000040d761 in send_mesh_pkt at mesh/net.c:1227
> 7  send_seg at mesh/net.c:1325
> 8  0x000000000040fa60 in net_access_layer_send at mesh/net.c:2163
> 9  0x0000000000413c74 in config_send at mesh/config-client.c:418
> 10 0x0000000000414886 in cmd_composition_get at mesh/config-client.c:470
> 11 0x000000000041ffd9 in cmd_exec at src/shared/shell.c:356
> 12 menu_exec at src/shared/shell.c:383
> 13 0x00000000004203a5 in shell_exec at src/shared/shell.c:426
> 14 0x0000000000420d24 in rl_handler (input=0x2259aa0 "composition-get ")
> at src/shared/shell.c:571
> 15 0x00007f3a3c45d6f5 in rl_callback_read_char () from libreadline.so.6
> 16 0x0000000000420229 in input_read at src/shared/shell.c:1034
> 17 0x0000000000421655 in watch_callback at src/shared/io-glib.c:170
> 18 0x00007f3a3cb1a04a in g_main_context_dispatch () from libglib-2.0.so.0
> 19 0x00007f3a3cb1a3f0 in ?? () from libglib-2.0.so.0
> 20 0x00007f3a3cb1a712 in g_main_loop_run () from libglib-2.0.so.0
> 21 0x0000000000421bf5 in mainloop_run () at src/shared/mainloop-glib.c:73
> 22 0x000000000042115a in bt_shell_run () at src/shared/shell.c:962
> 23 0x0000000000405c5d in main at mesh/main.c:1992
> ---
>  mesh/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
