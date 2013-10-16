Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 14:43:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/3] Bluetooth: Fix L2CAP "Command Reject: Invalid CID"
 response
Message-ID: <20131016114310.GA710@x220.p-661hnu-f1>
References: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
 <1381910801-3130-2-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_Pmjnag0HrK7N8T6Q5L138pYN4HDHcrwAQ-m_hEYsUyMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_Pmjnag0HrK7N8T6Q5L138pYN4HDHcrwAQ-m_hEYsUyMA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Oct 16, 2013, Anderson Lizardo wrote:
> On Wed, Oct 16, 2013 at 4:06 AM,  <johan.hedberg@gmail.com> wrote:
> > @@ -4217,8 +4225,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
> >
> >         chan = __l2cap_get_chan_by_scid(conn, dcid);
> >         if (!chan) {
> > -               mutex_unlock(&conn->chan_lock);
> > -               return -EBADSLT;
> > +               cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid);
> > +               return 0;
> >         }
> >
> >         l2cap_chan_lock(chan);
> 
> Are you sure this mutex_unlock() call should be removed?

It was indeed a bug which got fixed before this went upstream. Good that
you spotted it too though.

Johan
