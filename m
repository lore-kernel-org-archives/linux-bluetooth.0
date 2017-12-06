Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1512572530.14268.55.camel@ewol.com>
Subject: Re: [RFC]Mesh: meshctl configuration output fails in
 gatt.c:pipe_write
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 06 Dec 2017 08:02:10 -0700
In-Reply-To: <CABBYNZKLGjucdGxWJ-771MPc6xZnE9GWnaPUpdqbUX=vCaz1aA@mail.gmail.com>
References: <1511534342.16445.52.camel@ewol.com>
         <CABBYNZKLGjucdGxWJ-771MPc6xZnE9GWnaPUpdqbUX=vCaz1aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, 2017-11-24 at 17:10 +0200, Luiz Augusto von Dentz wrote:
> Hi Steve,
> 
> On Fri, Nov 24, 2017 at 4:39 PM, Steve Brown <sbrown@cortland.com>
> wrote:
> > If the first command output in a new connection exceeds 20 bytes,
> > mesh_gatt_write sets the SAR to FIRST as the write_mtu is initially
> > 0
> > and the default is GATT_MTU-3 (20).
> > 
> > When pipe_write gets called, a new larger write_mtu has been set,
> > but
> > the SAR is still set to FIRST. It's assumed that data->gatt_len >
> > max_len. However, it's not which causes lots of bogus output.
> > 
> > I've added code to reset the SAR and length in acquire_write_reply
> > in
> > case write_mtu might have changed.
> > 
> > This seems to work, but I'm sure there is a better way.
> > 
> > Steve
> > 

> Ive never really liked the idea of putting the SAR byte into data but
> it was required due to use of WriteValue, now perhaps we can even
> remove that since AcquireWrite is stable the sar byte can be set in
> an
> independent variable in pipe_write so we can move this logic there.
> 
> 
> 

Have you had a chance to review my changes to gatt.c?

http://www.spinics.net/lists/linux-bluetooth/msg72981.html

I removed the WriteValue code and moved the sar logic to pipe_write as
you requested. The latter fixed the bug I reported. If you have no
additional comments, let me know and I'll submit it as a patch.

I'm working on some additional commands for meshctl and they won't work
without the bug fixed.

Thanks,

Steve
