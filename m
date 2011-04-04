Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Apr 2011 17:58:46 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/15] Bluetooth: Move conn_state to struct l2cap_chan
Message-ID: <20110404205846.GB2230@joana>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
 <BANLkTinLMLapNTfDD+URnAcb8GZZP4UyXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTinLMLapNTfDD+URnAcb8GZZP4UyXQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2011-04-04 16:50:13 -0400]:

> Hi Gustavo,
> 
> (patch too big for me to review properly...)
> 
> On Fri, Apr 1, 2011 at 6:33 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> >  static void l2cap_retrans_timeout(unsigned long arg)
> >  {
> > -       struct sock *sk = (void *) arg;
> > +       struct l2cap_chan *chan = (void *) arg;
> > +       struct sock *sk = chan->sk;
> >
> >        BT_DBG("sk %p", sk);
> >
> > @@ -978,9 +983,9 @@ static void l2cap_retrans_timeout(unsigned long arg)
> >        l2cap_pi(sk)->retry_count = 1;
> >        __mod_monitor_timer();
> >
> > -       l2cap_pi(sk)->conn_state |= L2CAP_CONN_WAIT_F;
> > +       chan->conn_state |= L2CAP_CONN_WAIT_F;
> 
> I suppose the above requires a lock ?

It has one, the socket lock. It's completely safe use it here.

> 
> In general it seems that by creating the additional "l2cap_chan"
> layer, all lock usages need to be reviewed (IMHO).

Yes, that will be done in an next step. I'm going to remove any sock reference
from l2cap_core.c, so a new locking system will be needed.

-- 
Gustavo F. Padovan
http://profusion.mobi
