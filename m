Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1381910801-3130-2-git-send-email-johan.hedberg@gmail.com>
References: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
	<1381910801-3130-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Oct 2013 07:34:33 -0400
Message-ID: <CAJdJm_Pmjnag0HrK7N8T6Q5L138pYN4HDHcrwAQ-m_hEYsUyMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: Fix L2CAP "Command Reject: Invalid CID" response
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Oct 16, 2013 at 4:06 AM,  <johan.hedberg@gmail.com> wrote:
> @@ -4217,8 +4225,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
>
>         chan = __l2cap_get_chan_by_scid(conn, dcid);
>         if (!chan) {
> -               mutex_unlock(&conn->chan_lock);
> -               return -EBADSLT;
> +               cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid);
> +               return 0;
>         }
>
>         l2cap_chan_lock(chan);

Are you sure this mutex_unlock() call should be removed?


Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
