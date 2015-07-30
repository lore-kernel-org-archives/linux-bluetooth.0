Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: cmtp: Do not use list_for_each_safe when not needed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <7a32b5e113be6344c436791e5ce7c17e8f2b4e68.1437077656.git.christophe.jaillet@wanadoo.fr>
Date: Thu, 30 Jul 2015 13:51:20 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Message-Id: <F6E17164-28FF-436C-900A-EFC1DF3D5749@holtmann.org>
References: <7a32b5e113be6344c436791e5ce7c17e8f2b4e68.1437077656.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christophe,

> There is no need to use the safe version of list_for_each here.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> net/bluetooth/cmtp/capi.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
> index b0c6c6a..4c5e3e0 100644
> --- a/net/bluetooth/cmtp/capi.c
> +++ b/net/bluetooth/cmtp/capi.c
> @@ -100,9 +100,9 @@ static void cmtp_application_del(struct cmtp_session *session, struct cmtp_appli
> static struct cmtp_application *cmtp_application_get(struct cmtp_session *session, int pattern, __u16 value)
> {
> 	struct cmtp_application *app;
> -	struct list_head *p, *n;
> +	struct list_head *p;
> 
> -	list_for_each_safe(p, n, &session->applications) {
> +	list_for_each(p, &session->applications) {
> 		app = list_entry(p, struct cmtp_application, list);
> 		switch (pattern) {
> 		case CMTP_MSGNUM:
> @@ -511,13 +511,13 @@ static int cmtp_proc_show(struct seq_file *m, void *v)
> 	struct capi_ctr *ctrl = m->private;
> 	struct cmtp_session *session = ctrl->driverdata;
> 	struct cmtp_application *app;
> -	struct list_head *p, *n;
> +	struct list_head *p;
> 
> 	seq_printf(m, "%s\n\n", cmtp_procinfo(ctrl));
> 	seq_printf(m, "addr %s\n", session->name);
> 	seq_printf(m, "ctrl %d\n", session->num);
> 
> -	list_for_each_safe(p, n, &session->applications) {
> +	list_for_each(p,  &session->applications) {

you have two spaces here. I fixed that and applied the patch.

Regards

Marcel

