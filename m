Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1512747566.26064.79.camel@ewol.com>
References: <1512747566.26064.79.camel@ewol.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 8 Dec 2017 14:38:43 -0200
Message-ID: <CABBYNZJZFXTM2fgVyhnmUZmDN9W2QrizoyQ9zQm1ksNG7OXUBA@mail.gmail.com>
Subject: Re: BlueZ meshctl segv in config-client.c:read_input_parameters()
To: Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Fri, Dec 8, 2017 at 1:39 PM, Steve Brown <sbrown@cortland.com> wrote:
> Caught one running the current head.
>
> Steve
>
> [Zephyr-Node-0104]#
> Program received signal SIGSEGV, Segmentation fault.
> 0x00021970 in read_input_parameters (argc=-1, argc@entry=0, argv=0x4, argv@entry=0x0) at mesh/config-client.c:291
> 291             if (!argc || argv[1][0] == '\0')
> (gdb) bt
> #0  0x00021970 in read_input_parameters (argc=-1, argc@entry=0, argv=0x4, argv@entry=0x0) at mesh/config-client.c:291
> #1  0x00022b1c in cmd_get_composition (argc=0, argv=0x0) at mesh/config-client.c:362
> #2  0x00022fd4 in config_client_get_composition (dst=<optimized out>) at mesh/config-client.c:851
> #3  0x0001d598 in beacon_update (iv_index=5, iv_update=<optimized out>, first=<optimized out>) at mesh/net.c:1007
> #4  process_beacon (size=<optimized out>, data=0x47551 <gatt_pkt+1> "\001") at mesh/net.c:1085
> #5  net_data_ready (msg=0x47551 <gatt_pkt+1> "\001", len=<optimized out>) at mesh/net.c:1874
> #6  0x00018c60 in pipe_read (io=<optimized out>, prov=<optimized out>, user_data=0x601c8) at mesh/gatt.c:399
> #7  0x0002d250 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:170
> #8  0x76ee3fe8 in g_main_context_dispatch () from /lib/arm-linux-gnueabihf/libglib-2.0.so.0
> #9  0x76ee43b8 in ?? () from /lib/arm-linux-gnueabihf/libglib-2.0.so.0
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> (gdb)

Just sent a fix for that.

-- 
Luiz Augusto von Dentz
