Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Oct 2010 10:17:33 +0100
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ville Tervo <ville.tervo@nokia.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 3/6] Bluetooth: Implement the first SMP commands
Message-ID: <20101028091733.GB15997@vigoh>
References: <linux-bluetooth@vger.kernel.org>
 <1287791820-22693-4-git-send-email-anderson.briglia@openbossa.org>
 <20101025130356.GA8862@vigoh>
 <20101026092623.GC15050@null>
 <AANLkTikVG-gjd1d7T6ETbfXCU0jp2GsR0miWJFO55hps@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikVG-gjd1d7T6ETbfXCU0jp2GsR0miWJFO55hps@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2010-10-26 08:22:16 -0700]:

> Hi,
> 
> On Tue, Oct 26, 2010 at 2:26 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> > On Mon, Oct 25, 2010 at 03:03:56PM +0200, ext Gustavo F. Padovan wrote:
> >> Hi Vinicius,
> >>
> >> * Anderson Briglia <anderson.briglia@openbossa.org> [2010-10-22 19:56:57 -0400]:
> >>
> >> > From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> >> >
> >> > These simple commands will allow the SMP procedure to be started
> >> > and terminated with a not supported error. This is the first step
> >> > toward something useful.
> >> >
> >> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> >> > ---
> >> >  net/bluetooth/l2cap.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++++
> >> >  1 files changed, 117 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> >> > index 1ac44f4..ba87c84 100644
> >> > --- a/net/bluetooth/l2cap.c
> >> > +++ b/net/bluetooth/l2cap.c
> >> > @@ -54,6 +54,7 @@
> >> >  #include <net/bluetooth/bluetooth.h>
> >> >  #include <net/bluetooth/hci_core.h>
> >> >  #include <net/bluetooth/l2cap.h>
> >> > +#include <net/bluetooth/smp.h>
> >> >
> >> >  #define VERSION "2.15"
> >> >
> >> > @@ -307,6 +308,85 @@ static void l2cap_chan_del(struct sock *sk, int err)
> >> >     }
> >> >  }
> >> >
> >> > +static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
> >> > +                                                   u16 dlen, void *data)
> >>
> >> Call this l2cap_smp_build_cmd()
> >
> > Should the whole smp stuff be in separate file (smp.c)? It's not a l2cap feature but a
> > protocol using l2cap. In that case smp_build_cmd would be good name.
> 
> +1
> 
> It is also much better for maintenance and development since there is
> less patches touching the l2cap.c so less chances of conflicts,
> rebases and regressions on l2cap.

Yep, we may need a new smp.c file.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
