Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 May 2011 11:56:24 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix starting security procedures when not needed
Message-ID: <20110510145624.GA6502@piper>
References: <1304984994-14114-1-git-send-email-vinicius.gomes@openbossa.org>
 <BANLkTinX+8SXu+6jg5v4vHjde1fOWP2_cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTinX+8SXu+6jg5v4vHjde1fOWP2_cw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 13:21 Tue 10 May, Luiz Augusto von Dentz wrote:
> Hi Vinicius,
> 
> On Tue, May 10, 2011 at 2:49 AM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > The default value of sec_level when setting *any* option
> > using bt_io_set() was BT_SECURITY_MEDIUM. This was causing
> > the security procedure being started in some situations that
> > it should not.
> > ---
> >  btio/btio.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >
> > diff --git a/btio/btio.c b/btio/btio.c
> > index a3cf38a..df028a6 100644
> > --- a/btio/btio.c
> > +++ b/btio/btio.c
> > @@ -659,7 +659,6 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
> >        /* Set defaults */
> >        opts->defer = DEFAULT_DEFER_TIMEOUT;
> >        opts->master = -1;
> > -       opts->sec_level = BT_IO_SEC_MEDIUM;
> >        opts->mode = L2CAP_MODE_BASIC;
> >        opts->flushable = -1;
> 
> I believe this was on purpose so that if you want another security
> level you need to force it when using BtIO, this could be set in the
> kernel by default but since it already uses LOW that could break some
> applications.

If this was by design, I would gladly have my first patch applied.

It is just that it is weird that I have to pass the security level on
every call to bt_io_set() if I don't want the security level to change.

In any case, while writing this email, I realized that only checking
all bt_io_set() calls wasn't enough, so this patch may be incomplete.
All bt_io_listen() users should be safe, but there are some callers
of bt_io_connect() that may depend on BtIO setting the default
security level to MEDIUM.

> 
> 
> -- 
> Luiz Augusto von Dentz
> Computer Engineer


Cheers,
-- 
Vinicius
