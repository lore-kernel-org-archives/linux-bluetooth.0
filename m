Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1385649955-29276-2-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385649955-29276-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1385649955-29276-2-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Thu, 28 Nov 2013 11:52:31 -0400
Message-ID: <CAJdJm_Marb2+Q4e=zLeHq9Qf4a=o4z3-Q55mpL0bDWq3h1-s_Q@mail.gmail.com>
Subject: Re: [PATCH_v2 1/7] profiles/network: Remove redundant code for bnep
 interface name
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Thu, Nov 28, 2013 at 10:45 AM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> Remove redundant code for copying bnepX interface name from connection
> and server files. It is better to place on actual function call.
> ---
>  profiles/network/common.c     | 3 +--
>  profiles/network/connection.c | 2 --
>  profiles/network/server.c     | 3 ---
>  3 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/profiles/network/common.c b/profiles/network/common.c
> index 0b291bd..b94b3a5 100644
> --- a/profiles/network/common.c
> +++ b/profiles/network/common.c
> @@ -150,8 +150,7 @@ int bnep_connadd(int sk, uint16_t role, char *dev)
>         struct bnep_connadd_req req;
>
>         memset(&req, 0, sizeof(req));
> -       strncpy(req.device, dev, 16);
> -       req.device[15] = '\0';
> +       strcpy(req.device, "bnep%d");
>         req.sock = sk;
>         req.role = role;
>         if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
> diff --git a/profiles/network/connection.c b/profiles/network/connection.c
> index 5966268..301f66d 100644
> --- a/profiles/network/connection.c
> +++ b/profiles/network/connection.c
> @@ -692,8 +692,6 @@ int connection_register(struct btd_service *service)
>
>         nc = g_new0(struct network_conn, 1);
>         nc->id = id;
> -       memset(nc->dev, 0, sizeof(nc->dev));
> -       strcpy(nc->dev, "bnep%d");
>         nc->service = btd_service_ref(service);
>         nc->state = DISCONNECTED;
>         nc->peer = peer;
> diff --git a/profiles/network/server.c b/profiles/network/server.c
> index 0050b30..3a7e52a 100644
> --- a/profiles/network/server.c
> +++ b/profiles/network/server.c
> @@ -269,9 +269,6 @@ static int server_connadd(struct network_server *ns,
>         char devname[16];
>         int err, nsk;
>
> -       memset(devname, 0, sizeof(devname));
> -       strcpy(devname, "bnep%d");
> -
>         nsk = g_io_channel_unix_get_fd(session->io);
>         err = bnep_connadd(nsk, dst_role, devname);

You are still passing a (now uninitialized) devname pointer to
bnep_connadd(). Is this still necessary?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
