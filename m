Return-Path: <cyrus@holtmann.org>
Date: Sun, 26 Feb 2012 19:10:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 3/3] l2test: Add BT Channel Policy option
Message-ID: <20120226171030.GB29000@x220.P-661HNU-F1>
References: <1330073065-8188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1330073065-8188-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120224124144.GB4013@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120224124144.GB4013@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 24, 2012, Andrei Emeltchenko wrote:
> On Fri, Feb 24, 2012 at 10:44:25AM +0200, Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Make l2test able to set channel policy socket option.
> > ---
> >  test/l2test.c |   32 ++++++++++++++++++++++++++++++--
> >  1 files changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/test/l2test.c b/test/l2test.c
> > index 3705fdc..9f615a2 100644
> > --- a/test/l2test.c
> > +++ b/test/l2test.c
> > @@ -116,6 +116,7 @@ static int timestamp = 0;
> >  static int defer_setup = 0;
> >  static int priority = -1;
> >  static int rcvbuf = 0;
> > +static int chan_policy;
> 
> Sorry shall be:
> 
> -static int chan_policy;
> +static int chan_policy = -1;

You could have just sent a v3 for that. Anyway, I went ahead and fixed
it now myself and all three patches have been pushed upstream. Thanks.

Johan:w

