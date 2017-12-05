Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v2] mesh: Make meshctl use bt_shell helpers
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20171205112626.11210-1-luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <41fb43fe-8be1-0398-ea06-96a33e5a2134@jp.fujitsu.com>
Date: Tue, 5 Dec 2017 21:33:47 +0900
MIME-Version: 1.0
In-Reply-To: <20171205112626.11210-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> @@ -2177,7 +1949,6 @@ int main(int argc, char *argv[])
>  	GOptionContext *context;
>  	GError *error = NULL;
>  	GDBusClient *client;
> -	guint signal;
>  	int len;
>  	int extra;
>  
> @@ -2196,22 +1967,22 @@ int main(int argc, char *argv[])
>  	g_option_context_free(context);
>  
>  	if (option_version == TRUE) {
> -		rl_printf("%s\n", VERSION);
> +		bt_shell_printf("%s\n", VERSION);
>  		exit(0);
>  	}
>  
>  	if (!mesh_config_dir) {
> -		rl_printf("Local config directory not provided.\n");
> +		bt_shell_printf("Local config directory not provided.\n");
>  		mesh_config_dir = "";
>  	} else {
> -		rl_printf("Reading prov_db.json and local_node.json from %s\n",
> +		bt_shell_printf("Reading prov_db.json and local_node.json from %s\n",
>  							mesh_config_dir);
>  	}
>  
>  	len = strlen(mesh_config_dir);
>  	if (len && mesh_config_dir[len - 1] != '/') {
>  		extra = 1;
> -		rl_printf("mesh_config_dir[%d] %s\n", len,
> +		bt_shell_printf("mesh_config_dir[%d] %s\n", len,
>  						&mesh_config_dir[len - 1]);
>  	} else {
>  		extra = 0;
> @@ -2257,18 +2028,11 @@ int main(int argc, char *argv[])
>  		exit(1);
>  	}
>  
> -	main_loop = g_main_loop_new(NULL, FALSE);
> -	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
> -
> -	setlinebuf(stdout);
> -
> -	rl_erase_empty_line = 1;
> -	rl_callback_handler_install(NULL, rl_handler);
> +	bt_shell_init(&argc, &argv);

meshctl will not output version with --version/-v.
Refer to the mail (shared/shell: Fix no version output with option) that I sent.


Regards,
Eramoto

