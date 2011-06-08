Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Jun 2011 11:38:47 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: Re: [bluetooth-next v3 07/16] Bluetooth: Add SMP confirmation checks
 methods
Message-ID: <20110608143847.GA20343@piper>
References: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
 <1307483205-1518-8-git-send-email-vinicius.gomes@openbossa.org>
 <20110608022610.GA2772@dell.ccr.corp.intel.com>
 <BANLkTikHJE-165=JOD+4UhxY7XQ6Lrx3KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTikHJE-165=JOD+4UhxY7XQ6Lrx3KA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 13:16 Wed 08 Jun, Luiz Augusto von Dentz wrote:
> Hi Vinicius,
> 
> On Wed, Jun 8, 2011 at 11:26 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Vinicius/Anderson,
> >
> > On Tue, Jun 07, 2011, Vinicius Costa Gomes wrote:
> >> +     ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp, 0,
> >> +                     conn->src, 0, conn->dst, res);
> >
> > The third last parameter is the remote address type and you're
> > hard-coding it to 0 (public) here. This means that we cannot pair with a
> > device with a random address. I suppose you should be passing
> > conn->hcon->dst_type instead.
> 
> I notice that you guys have this fixed here:
> 
> http://git.infradead.org/users/vcgomes/linux-2.6.git/commitdiff/f345aa37d6d49104ef4b2b7e4466fb3186807199
> 
> So I wonder why this was not fix in place?

No reason at all. It happened because this patch was written when the dst_type field
wasn't introduced yet. Will fix.

> 
> >> +             ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp,
> >> +                                     0, conn->dst, 0, conn->src, res);
> >
> > Same here.
> >
> >> +     if (conn->hcon->out)
> >> +             ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
> >> +                             conn->src, 0, conn->dst, res);
> >> +     else
> >> +             ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
> >> +                             conn->dst, 0, conn->src, res);
> >
> > And here.
> >
> > You're also hard-coding the local address type to public, but that's a
> > less severe issue (for now).
> >
> > Johan
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
> Computer Engineer


Cheers,
-- 
Vinicius
