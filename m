Return-Path: <cyrus@holtmann.org>
Date: Sat, 21 Aug 2010 14:47:48 +0200
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Makefile.am fixes
Message-ID: <20100821124748.GA21115@joshua.mesa.nl>
References: <201008201635.o7KGZLs1009991@joshua.mesa.nl> <1282379964.23399.223.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset*=utf-8''%E2%80%9Cus-ascii
In-Reply-To: <1282379964.23399.223.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Aug 21, 2010 at 10:39:24AM +0200, Marcel Holtmann wrote:
> Hi Marcel,
> 
> > phonebook.h should not be under _nodist.
> 
> yes it should. It is auto-generated.

Hm, I don't think phonebook.h is generated, phonebook.c more
or less is.... But anyway, this part of the change message is bogus.
Phonebook.h was not part of builtin_nodist. 
Sorry about that. I'll resend the patch without this sentence.

> > vcard.[ch] is not related to pbap, but to phonebook backend
> > ---
> >  Makefile.am |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> Did you verify that "fakeroot make distcheck" still works properly after
> your changes?

This fails with an error message about builtin.h. But the same error
happens without the Makefile.am patch.
(probably because distcheck builds in a separate builddir apart from
the actual source tree and builtin.h is generated in the builddir tree)

Thanks,

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
