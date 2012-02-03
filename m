Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Feb 2012 12:11:00 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Arik Nemtsov <arik@wizery.com>, linux-bluetooth@vger.kernel.org,
	claudio.takahasi@openbossa.org
Subject: Re: [PATCH v2] proximity: make reporter work per-adapter
Message-ID: <20120203201100.GA29771@x220.globalsuite.net>
References: <1328284418-4989-1-git-send-email-arik@wizery.com>
 <CAJdJm_M6kc_ZLsTMsxvZAs1H5DB8Zmyby51cN4cipe9BfYeSmQ@mail.gmail.com>
 <CAJdJm_PTg77D5KGXR7FcozA96DU9QqyiwK3zzWLfzygCX9_HOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_PTg77D5KGXR7FcozA96DU9QqyiwK3zzWLfzygCX9_HOg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 03, 2012, Anderson Lizardo wrote:
> On Fri, Feb 3, 2012 at 1:25 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > Hi Arik,
> >
> > On Fri, Feb 3, 2012 at 11:53 AM, Arik Nemtsov <arik@wizery.com> wrote:
> >> Register an adapter driver for reporter and add the adapter argument in
> >> appropriate places.
> >
> > Looks ok.
> >
> >>
> >> Signed-off-by: Arik Nemtsov <arik@wizery.com>
> 
> Except for the signed off by line which is not okay (i.e. not used)
> for BlueZ patches.

And this doesn't apply to the latest upstream tree. Does it depend on
some other patch I haven't applied (or maybe broken because of some
patch I *did* apply)?

Johan
