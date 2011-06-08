Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Jun 2011 13:30:35 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth-next 02/13] Bluetooth: Fix sending wrong IO
 Capabilities value
Message-ID: <20110608163035.GB20343@piper>
References: <1307487014-19398-1-git-send-email-vinicius.gomes@openbossa.org>
 <1307487014-19398-3-git-send-email-vinicius.gomes@openbossa.org>
 <BANLkTinnXEqNr8ZCj79iAFZj2yzqncyZ8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTinnXEqNr8ZCj79iAFZj2yzqncyZ8Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 17:20 Wed 08 Jun, Luiz Augusto von Dentz wrote:
> Hi Vinicius,
> 
> On Wed, Jun 8, 2011 at 7:50 AM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > We should send the IO Capabilities set by userspace, using the
> > management interface, instead of a fixed value.
> >
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  net/bluetooth/smp.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > index c9ae5d4..171a65c 100644
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -198,7 +198,7 @@ static __u8 seclevel_to_authreq(__u8 level)
> >  static void build_pairing_cmd(struct l2cap_conn *conn,
> >                                struct smp_cmd_pairing *cmd, __u8 authreq)
> >  {
> > -       cmd->io_capability = SMP_IO_NO_INPUT_OUTPUT;
> > +       cmd->io_capability = conn->hcon->io_capability;
> >        cmd->oob_flag = SMP_OOB_NOT_PRESENT;
> >        cmd->max_key_size = SMP_MAX_ENC_KEY_SIZE;
> >        cmd->init_key_dist = SMP_DIST_ENC_KEY | SMP_DIST_ID_KEY | SMP_DIST_SIGN;
> > --
> 
> Does this fix something that is not upstream yet? If not then we
> should be fixing it in place whenever possible.

Done. Thanks.

> 
> -- 
> Luiz Augusto von Dentz
> Computer Engineer


Cheers,
-- 
Vinicius
