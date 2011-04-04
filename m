Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Apr 2011 18:05:51 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 12/15] Bluetooth: Move ERTM timers to struct l2cap_chan
Message-ID: <20110404210551.GC2230@joana>
References: <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-9-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-10-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-11-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-12-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-13-git-send-email-padovan@profusion.mobi>
 <BANLkTikP-bL5LUmmim7Y3dxrsU7Qwuhm0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTikP-bL5LUmmim7Y3dxrsU7Qwuhm0Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2011-04-04 17:00:17 -0400]:

> Hi Gustavo,
> 
> On Fri, Apr 1, 2011 at 6:33 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > @@ -958,7 +961,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
> >
> >        bh_lock_sock(sk);
> >        if (chan->retry_count >= chan->remote_max_tx) {
> > -               l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk, ECONNABORTED);
> > +               l2cap_send_disconn_req(l2cap_pi(chan)->conn, chan, ECONNABORTED);
> >                bh_unlock_sock(sk);
> >                return;
> >        }
> 
> Why "l2cap_pi(chan)" ? This looks strange.

Indeed, I'll fix it.

-- 
Gustavo F. Padovan
http://profusion.mobi
