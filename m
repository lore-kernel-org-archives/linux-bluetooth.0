Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Dec 2012 20:30:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 3/5] core: Simplify set_powered to not use set_mode
Message-ID: <20121217183057.GA22883@x220.P-661HNU-F1>
References: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
 <1355759155-27921-3-git-send-email-luiz.dentz@gmail.com>
 <CAJdJm_N+5_wcvGw7wkgx+Ryr3EkB-Mcd0hfGmK4u=42LL9=fHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_N+5_wcvGw7wkgx+Ryr3EkB-Mcd0hfGmK4u=42LL9=fHg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Dec 17, 2012, Anderson Lizardo wrote:
> On Mon, Dec 17, 2012 at 11:45 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > -       err = set_mode(adapter, mode);
> > +       err = mgmt_set_powered(adapter->dev_id, powered);
> >         if (err < 0)
> >                 return g_dbus_pending_property_error(id,
> >                                                 ERROR_INTERFACE ".Failed",
> > -                                               strerror(-err));
> > +                                               strerror(err));
> 
> Looks like you changed the line above by mistake, err is negative and
> thus need to be made positive to pass to strerror().

Since I missed this one and already pushed the patch set I went ahead
and applied a separate fix for it.

Johan
