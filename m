Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jul 2014 10:50:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 02/11] android/core: Remove unneeded assignment
Message-ID: <20140729075014.GB5465@t440s.lan>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406551609-17546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406551609-17546-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140728135750.GA17010@t440s.P-661HNU-F1>
 <20140729074200.GA29412@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140729074200.GA29412@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Jul 29, 2014, Andrei Emeltchenko wrote:
> On Mon, Jul 28, 2014 at 04:57:50PM +0300, Johan Hedberg wrote:
> > Hi Andrei,
> > 
> > On Mon, Jul 28, 2014, Andrei Emeltchenko wrote:
> > > ---
> > >  android/bluetooth.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/android/bluetooth.c b/android/bluetooth.c
> > > index a2ab445..5b72a36 100644
> > > --- a/android/bluetooth.c
> > > +++ b/android/bluetooth.c
> > > @@ -291,7 +291,6 @@ static void load_adapter_config(void)
> > >  	if (gerr) {
> > >  		adapter.discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
> > >  		g_error_free(gerr);
> > > -		gerr = NULL;
> > >  	}
> > >  
> > >  	g_key_file_free(key_file);
> > 
> > I don't think patches like this are a good idea since they make the code
> > more prone to bugs in the future. In this case if the function was ever
> > extended and gerr reused one would need to remember to "fix" the old
> > code so that it's re-initialized to NULL.
> 
> This is common practice, to initialize if needed value before use
> (especially if value is reused). Makes code more clean.

Then use at least g_clear_error instead of g_error_free.

> This also fixes static analyzer warnings.

To me it looks more like this is not just a nice side effect (which you
imply by your "also ...") but the main reason you created this patch.

Johan
