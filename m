Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jan 2012 00:48:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org, Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] net: bluetooth: Fix 'enable_hs' type
Message-ID: <20120110224804.GA10526@x220.ger.corp.intel.com>
References: <1326227630-2556-1-git-send-email-festevam@gmail.com>
 <20120110210042.GA7954@x220.ger.corp.intel.com>
 <CAOMZO5BLGwvJEJCrv9hooj5PTMuOQire2nz=Bc6S3i+VjUEEjw@mail.gmail.com>
 <20120110213134.GA8679@x220.ger.corp.intel.com>
 <CAOMZO5ANrmCNZep0-5OJ9gKzvDBrCdqfU91o81f_2FjSjXnAHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5ANrmCNZep0-5OJ9gKzvDBrCdqfU91o81f_2FjSjXnAHw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabio,

On Tue, Jan 10, 2012, Fabio Estevam wrote:
> Hi Johan,
> 
> On Tue, Jan 10, 2012 at 7:31 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Fabio,
> >
> > On Tue, Jan 10, 2012, Fabio Estevam wrote:
> >> > The patch has been applied to my bluetooth-next tree. Don't you get the
> >> > same warning for enable_mgmt and enable_le as well? Those seem to be
> >> > declared in a similar manner.
> >>
> >> No, because enable_mgmt and enable_le are already declared as 'bool'.
> >
> > I don't know what tree you're looking at but at least in mine they're
> > both "static int".
> 
> I am using linux-next. Please check:
> 
> http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Fnext%2Flinux-next-history.git&a=search&h=refs%2Fheads%2Fmaster&st=grep&s=enable_mgmt

Yep, seems commit eb939922 from Rusty Russel took care of this, but the
commit has not yet made it to the bluetooth-next tree.

Johan
