Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jul 2014 10:42:03 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 02/11] android/core: Remove unneeded assignment
Message-ID: <20140729074200.GA29412@aemeltch-MOBL1>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406551609-17546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406551609-17546-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140728135750.GA17010@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140728135750.GA17010@t440s.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Jul 28, 2014 at 04:57:50PM +0300, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Mon, Jul 28, 2014, Andrei Emeltchenko wrote:
> > ---
> >  android/bluetooth.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/android/bluetooth.c b/android/bluetooth.c
> > index a2ab445..5b72a36 100644
> > --- a/android/bluetooth.c
> > +++ b/android/bluetooth.c
> > @@ -291,7 +291,6 @@ static void load_adapter_config(void)
> >  	if (gerr) {
> >  		adapter.discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
> >  		g_error_free(gerr);
> > -		gerr = NULL;
> >  	}
> >  
> >  	g_key_file_free(key_file);
> 
> I don't think patches like this are a good idea since they make the code
> more prone to bugs in the future. In this case if the function was ever
> extended and gerr reused one would need to remember to "fix" the old
> code so that it's re-initialized to NULL.

This is common practice, to initialize if needed value before use
(especially if value is reused). Makes code more clean.

This also fixes static analyzer warnings.

Best regards 
Andrei Emeltchenko 
