Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Nov 2013 15:44:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Remove unnecessary 'send' parameter from
 smp_failure()
Message-ID: <20131106134407.GA5925@x220.p-661hnu-f1>
References: <1383729897-28492-1-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_MGVDvH4h71PgD6YWavOBm=xpgnh1nMtFNtEpL7gEQQcw@mail.gmail.com>
 <CAJdJm_Mj4AUHka3y5T1T=GEAATbuzwgsB20dLSMEzpdzi56jbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_Mj4AUHka3y5T1T=GEAATbuzwgsB20dLSMEzpdzi56jbA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Nov 06, 2013, Anderson Lizardo wrote:
> On Wed, Nov 6, 2013 at 9:31 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > Hi Johan,
> >
> > On Wed, Nov 6, 2013 at 5:24 AM,  <johan.hedberg@gmail.com> wrote:
> >
> >> @@ -895,7 +895,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
> >>                 break;
> >>
> >>         case SMP_CMD_PAIRING_FAIL:
> >> -               smp_failure(conn, skb->data[0], 0);
> >> +               smp_failure(conn, 0);
> >
> > I think you meant "smp_failure(conn, skb->data[0]);" here.
> 
> My bad, I see now that the purpose is to not send an error in this case.

Exactly. Which is why the original code was misleading in that you might
have thought it actually did something with skb->data[0].

Johan
