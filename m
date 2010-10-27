Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1288009280-5149-6-git-send-email-ville.tervo@nokia.com>
References: <1288009280-5149-1-git-send-email-ville.tervo@nokia.com>
	<1288009280-5149-6-git-send-email-ville.tervo@nokia.com>
Date: Wed, 27 Oct 2010 15:09:32 -0400
Message-ID: <AANLkTi=r0yodYL8N0SnswWH7JQbquttcsjmUruQT0rAs@mail.gmail.com>
Subject: Re: [PATCH 5/6] Bluetooth: Add server socket support for LE connection
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 25, 2010 at 8:21 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> +static void l2cap_le_conn_ready(struct l2cap_conn *conn)
> +{
> +       struct l2cap_chan_list *list = &conn->chan_list;
> +       struct sock *parent, *uninitialized_var(sk);
> +
> +       BT_DBG("");
> +
> +       /* Check if we have socket listening on cid */
> +       parent = l2cap_get_sock_by_cid(BT_LISTEN, 0x04, conn->src);

You can use L2CAP_CID_LE_DATA instead of 0x04.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
