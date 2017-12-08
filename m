Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1512752773.26064.84.camel@ewol.com>
Subject: Re: [PATCH BlueZ] mesh: Fix crash while reading input parameters
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Fri, 08 Dec 2017 10:06:13 -0700
In-Reply-To: <20171208163805.6130-1-luiz.dentz@gmail.com>
References: <20171208163805.6130-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, 2017-12-08 at 14:38 -0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> read_input_parameters skips the command argument thus arg[0] shall be
> considerer the fist argument.
> ---
>  mesh/config-client.c | 2 +-
>  mesh/onoff-model.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mesh/config-client.c b/mesh/config-client.c
> index 7aabe6ce7..da2c79b05 100644
> --- a/mesh/config-client.c
> +++ b/mesh/config-client.c
> @@ -232,7 +232,7 @@ static uint32_t read_input_parameters(int argc,
> char *argv[])
>  	--argc;
>  	++argv;
>  
> -	if (!argc || argv[1][0] == '\0')
> +	if (!argc || argv[0][0] == '\0')
>  		return 0;
>  
>  	memset(parms, 0xff, sizeof(parms));
> diff --git a/mesh/onoff-model.c b/mesh/onoff-model.c
> index 9c8869414..2a9860f61 100644
> --- a/mesh/onoff-model.c
> +++ b/mesh/onoff-model.c
> @@ -155,7 +155,7 @@ static uint32_t read_input_parameters(int argc,
> char *argv[])
>  	--argc;
>  	++argv;
>  
> -	if (!argc || argv[1][0] == '\0')
> +	if (!argc || argv[0][0] == '\0')
>  		return 0;
>  
>  	memset(parms, 0xff, sizeof(parms));

Didn't fix it. 

I think the problem is that 
config_client_get_composition() doesn't send real args.

Steve

[Zephyr-Node-0100]# 
Program received signal SIGSEGV, Segmentation fault.
0x00021970 in read_input_parameters (argc=-1, argc@entry=0, argv=0x4, argv@entry=0x0) at mesh/config-client.c:291
291		if (!argc || argv[0][0] == '\0')
(gdb) bt
#0  0x00021970 in read_input_parameters (argc=-1, argc@entry=0, argv=0x4, argv@entry=0x0) at mesh/config-client.c:291
#1  0x00022b1c in cmd_get_composition (argc=0, argv=0x0) at mesh/config-client.c:362
#2  0x00022fd4 in config_client_get_composition (dst=<optimized out>) at mesh/config-client.c:853
#3  0x0001d598 in beacon_update (iv_index=5, iv_update=<optimized out>, first=<optimized out>) at mesh/net.c:1007
#4  process_beacon (size=<optimized out>, data=0x47551 <gatt_pkt+1> "\001") at mesh/net.c:1085
#5  net_data_ready (msg=0x47551 <gatt_pkt+1> "\001", len=<optimized out>) at mesh/net.c:1874
#6  0x00018c60 in pipe_read (io=<optimized out>, prov=<optimized out>, user_data=0x601d0) at mesh/gatt.c:399
#7  0x0002d250 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:170
#8  0x76ee3fe8 in g_main_context_dispatch () from /lib/arm-linux-gnueabihf/libglib-2.0.so.0
#9  0x76ee43b8 in ?? () from /lib/arm-linux-gnueabihf/libglib-2.0.so.0
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb) 

