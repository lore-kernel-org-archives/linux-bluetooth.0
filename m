Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 14:32:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 BlueZ 1/4] gatt: Add support for find included services
Message-ID: <20120928113212.GA18666@x220>
References: <1348526019-28402-1-git-send-email-vinicius.gomes@openbossa.org>
 <1348526019-28402-2-git-send-email-vinicius.gomes@openbossa.org>
 <20120928110833.GB14450@x220>
 <CAJdJm_PPjxkXoL+Q=f-3AozUnUErCrD-cQ2KzO1WQSvxJWyRrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_PPjxkXoL+Q=f-3AozUnUErCrD-cQ2KzO1WQSvxJWyRrg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Sep 28, 2012, Anderson Lizardo wrote:
> On Fri, Sep 28, 2012 at 7:08 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Btw, if you guys are wondering why the stricter coding style checks,
> > I've added the following to .git/hooks/pre-{commit,applypatch}:
> >
> > git diff --cached | ~/src/linux/scripts/checkpatch.pl --no-signoff --ignore INITIALISED_STATIC,NEW_TYPEDEFS,VOLATILE --show-types --mailback -
> >
> > You might want to do the same (with the correct path to checkpatch.pl)).
> > And thanks to Luiz for the idea (he's using the same when applying
> > patches).
> 
> Thanks for the very useful tip! But which checkpatch.pl version are
> you using? Mine (from bluetooth-next tree) lacks --ignore and
> --show-types options.

I'm using Linus' tree.

Johan
