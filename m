Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>
Subject: RE: [PATCH] BlueZ: Added retries for BNEP connection setup.
Date: Thu, 26 Jan 2012 09:18:20 +0000
Message-ID: <A7CD2DBA66569F478A0C1ECFC39E1C5218DF4435@DNCE03.ent.ti.com>
References: <1327216233-17629-1-git-send-email-iliak@ti.com>
In-Reply-To: <1327216233-17629-1-git-send-email-iliak@ti.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.
Regards

Ilia Kolominsky
iliak@ti.com
Direct:=A0 +972(9)7906231
Mobile: +972(54)909009




> -----Original Message-----
> From: ilia.kolominsky@gmail.com [mailto:ilia.kolominsky@gmail.com]
> Sent: Sunday, January 22, 2012 9:11 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Ilia, Kolominsky
> Subject: [PATCH] BlueZ: Added retries for BNEP connection setup.
>=20
> From: Ilia Kolomisnky <iliak@ti.com>
>=20
> According to BNEP spec. section 2.6.3 and
> in order to pass TP/BNEP/CTRL/BV-02-C certification test.
>=20
> Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
> ---
>  network/connection.c |   53 ++++++++++++++++++++++++++++++++++++++++--
> -------
>  1 files changed, 43 insertions(+), 10 deletions(-)
>=20
> diff --git a/network/connection.c b/network/connection.c
> index ca1f4b2..5c3819a 100644
> --- a/network/connection.c
> +++ b/network/connection.c
> @@ -49,6 +49,8 @@
>  #include "connection.h"
>=20
>  #define NETWORK_PEER_INTERFACE "org.bluez.Network"
> +#define CON_SETUP_RETRIES      3
> +#define CON_SETUP_TO_MS        9000
>=20
>  typedef enum {
>  	CONNECTED,
> @@ -73,6 +75,8 @@ struct network_conn {
>  	guint		watch;		/* Disconnect watch */
>  	guint		dc_id;
>  	struct network_peer *peer;
> +	char		con_attempt;
> +	guint 		con_to_src;
>  };
>=20
>  struct __service_16 {
> @@ -218,6 +222,8 @@ static gboolean bnep_setup_cb(GIOChannel *chan,
> GIOCondition cond,
>  		goto failed;
>  	}
>=20
> +	g_source_remove(nc->con_to_src);
> +
>  	errno =3D EPROTO;
>=20
>  	if ((size_t) r < sizeof(*rsp)) {
> @@ -289,13 +295,11 @@ failed:
>  	return FALSE;
>  }
>=20
> -static int bnep_connect(struct network_conn *nc)
> -{
> +static inline int bnep_send_conn_req(struct network_conn *nc) {
> +
>  	struct bnep_setup_conn_req *req;
>  	struct __service_16 *s;
> -	struct timeval timeo;
>  	unsigned char pkt[BNEP_MTU];
> -	int fd;
>=20
>  	/* Send request */
>  	req =3D (void *) pkt;
> @@ -306,14 +310,43 @@ static int bnep_connect(struct network_conn *nc)
>  	s->dst =3D htons(nc->id);
>  	s->src =3D htons(BNEP_SVC_PANU);
>=20
> -	memset(&timeo, 0, sizeof(timeo));
> -	timeo.tv_sec =3D 30;
> +	if (send(g_io_channel_unix_get_fd(nc->io), pkt, sizeof(*req) +
> sizeof(*s), 0) < 0) {
> +		error("bnep connection setup send failed");
> +		return -errno;
> +	}
>=20
> -	fd =3D g_io_channel_unix_get_fd(nc->io);
> -	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
> +	nc->con_attempt++;
>=20
> -	if (send(fd, pkt, sizeof(*req) + sizeof(*s), 0) < 0)
> -		return -errno;
> +	return 0;
> +}
> +
> +static gboolean bnep_conn_req_to(gpointer user_data)
> +{
> +	struct network_conn *nc;
> +	int err;
> +
> +	nc =3D (struct network_conn *) user_data;
> +	if (nc->con_attempt =3D=3D CON_SETUP_RETRIES) {
> +		error("Too many bnep connection attempts, aborting
> connection setup");
> +	}
> +	else {
> +		error("bnep connection setup TO, retrying...");
> +
> +		if (!bnep_send_conn_req(nc))
> +			return TRUE;
> +	}
> +
> +	cancel_connection(nc, "bnep setup failed");
> +	return FALSE;
> +}
> +
> +static int bnep_connect(struct network_conn *nc)
> +{
> +	int err;
> +
> +	if (err =3D bnep_send_conn_req(nc))
> +		return err;
> +	nc->con_to_src =3D g_timeout_add(CON_SETUP_TO_MS, bnep_conn_req_to,
> nc);
>=20
>  	g_io_add_watch(nc->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
>  			(GIOFunc) bnep_setup_cb, nc);
> --
> 1.7.4.1
