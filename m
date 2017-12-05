Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 5 Dec 2017 13:14:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] mesh: Make meshctl use bt_shell helpers
Message-ID: <20171205111406.GA8010@x1c.lan>
References: <20171205105718.5832-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171205105718.5832-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 05, 2017, Luiz Augusto von Dentz wrote:
> -static void cmd_connect(const char *arg)
> +static void cmd_connect(int argc, char *argv[])
>  {
> +	char *filters[] = { MESH_PROXY_SVC_UUID };
> +
>  	if (check_default_ctrl() == FALSE)
>  		return;
>  
>  	memset(&connection, 0, sizeof(connection));
>  
> -	if (!arg || !strlen(arg)) {
> +	if (!argc || !strlen(argv[0])) {
>  		connection.net_idx = NET_IDX_PRIMARY;
>  	} else {
>  		char *end;
> -		connection.net_idx = strtol(arg, &end, 16);
> -		if (end == arg) {
> +		connection.net_idx = strtol(argv[0], &end, 16);
> +		if (end == argv[0]) {
>  			connection.net_idx = NET_IDX_INVALID;
> -			rl_printf("Invalid network index %s\n", arg);
> +			bt_shell_printf("Invalid network index %s\n", argv[0]);
>  			return;
>  		}

This looks like it's breaking the Node ID connecting that was just
added. That code from Steve was taking advantage of the "end" pointer to
get the next parameter, however now that you get the full parsed argv
the connection.unicast should be set based on argv[1].

Johan
