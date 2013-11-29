Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Nov 2013 10:26:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 05/10] android/socket: Cleanup sockets on unregister
Message-ID: <20131129082648.GB6800@x220.p-661hnu-f1>
References: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1385649486-19978-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385649486-19978-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Nov 28, 2013, Andrei Emeltchenko wrote:
> This cleans up rfsock structures closing all sockets and making general cleanup
> for servers and for connections. This will be called form socket unregister.
> ---
>  android/socket.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/android/socket.c b/android/socket.c
> index 1fb154d..d55db54 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -943,7 +943,27 @@ bool bt_socket_register(int sk, const bdaddr_t *addr)
>  	return true;
>  }
>  
> +static void free_connection(gpointer data, gpointer user_data)
> +{
> +	struct rfcomm_sock *rfsock = data;
> +
> +	connections = g_list_remove(connections, rfsock);
> +	cleanup_rfsock(rfsock);
> +}
> +
> +static void free_server(gpointer data, gpointer user_data)
> +{
> +	struct rfcomm_sock *rfsock = data;
> +
> +	servers = g_list_remove(servers, rfsock);
> +	cleanup_rfsock(rfsock);
> +}
> +
>  void bt_socket_unregister(void)
>  {
>  	DBG("");
> +
> +	g_list_foreach(connections, free_connection, NULL);
> +
> +	g_list_foreach(servers, free_server, NULL);
>  }

I think what you're looking for here is g_slist_free_full instead of
g_slist_foreach. That way you won't need to have any helper functions at
all but you can directly pass cleanup_rfsock to it.

Johan
