Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Feb 2012 10:55:34 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: ilia.kolominsky@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Subject: Re: [PATCH] BlueZ: Added retries for BNEP connection setup.
Message-ID: <20120202185534.GA28700@x220.globalsuite.net>
References: <1327216233-17629-1-git-send-email-iliak@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327216233-17629-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

On Sun, Jan 22, 2012, ilia.kolominsky@gmail.com wrote:
> According to BNEP spec. section 2.6.3 and
> in order to pass TP/BNEP/CTRL/BV-02-C certification test.

Please add a much more detailed commit message explaining the background
to this, what the test case does and why your fix is the right one, why
using SO_RCVTIMEO wasn't good enough, etc. Also fix the summary line not
to have a "BlueZ" prefix (that should be within the initial []) and the
form of the first word should be "Add" and not "Added" (actually since
this entire patch seems to be a fix it should be "Fix ...").

> Signed-off-by: Ilia Kolomisnky <iliak@ti.com>

We don't use this for user space patches.

> +#define CON_SETUP_TO_MS        9000

Please use the _seconds variant of the GLib timeout functions.

>  typedef enum {
>  	CONNECTED,
> @@ -73,6 +75,8 @@ struct network_conn {
>  	guint		watch;		/* Disconnect watch */
>  	guint		dc_id;
>  	struct network_peer *peer;
> +	char		con_attempt;

Don't use char for integer variables. int, guint etc. would be more
appropriate here.

> +	guint 		con_to_src;

I'd call this timeout_source (it's already within a struct called
network_conn so you don't need a conn prefix).

> +	g_source_remove(nc->con_to_src);

I suppose this should also set the source back to 0?

> +static inline int bnep_send_conn_req(struct network_conn *nc) {

Does this really need to be inline? Have you done some profiling to
determine that it's really needed and has a huge impact? If not just
leave the "inline" bit out.

> -	int fd;

Please keep this variable.

> @@ -306,14 +310,43 @@ static int bnep_connect(struct network_conn *nc)
>  	s->dst = htons(nc->id);
>  	s->src = htons(BNEP_SVC_PANU);
>  
> -	memset(&timeo, 0, sizeof(timeo));
> -	timeo.tv_sec = 30;
> +	if (send(g_io_channel_unix_get_fd(nc->io), pkt, sizeof(*req) + sizeof(*s), 0) < 0) {

..and don't do the get_fd() call within the parameters of another
function call. Also, why not use write() since you're anyway passing 0
as the flags (I know the original code was using send so this is a minor
issue). Also the above line looks like it's breaking the 80 character
rule.

> +static gboolean bnep_conn_req_to(gpointer user_data)
> +{
> +	struct network_conn *nc;
> +	int err;
> +
> +	nc = (struct network_conn *) user_data;

No explicit type casts for void pointer please.

> +	if (nc->con_attempt == CON_SETUP_RETRIES) {
> +		error("Too many bnep connection attempts, aborting connection setup");
> +	}
> +	else {
> +		error("bnep connection setup TO, retrying...");
> +
> +		if (!bnep_send_conn_req(nc))
> +			return TRUE;
> +	}

Looks like you're breaking the 80 character rule for the first error
call. Also, the coding style should be "} else {" on one line.

> +static int bnep_connect(struct network_conn *nc)
> +{
> +	int err;
> +
> +	if (err = bnep_send_conn_req(nc))
> +		return err;

Split this up:

	err = foo();
	if (err < 0)
		return err;

> +	nc->con_to_src = g_timeout_add(CON_SETUP_TO_MS, bnep_conn_req_to, nc);

And this one (like I mentioned previously) should use the _seconds
variant.

Johan
