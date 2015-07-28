Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Atul Rai <a.rai@samsung.com>, linux-bluetooth@vger.kernel.org,
	sachin.dev@samsung.com
Subject: Re: [PATCH v2] tools/sdptool: Fix NULL pointer dereference
Date: Tue, 28 Jul 2015 09:57:42 +0200
Message-ID: <4524026.9PhAiZIq7z@leonov>
In-Reply-To: <20150728074056.GA2417@t440s.lan>
References: <1438068019-4094-1-git-send-email-a.rai@samsung.com> <20150728074056.GA2417@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tuesday 28 of July 2015 10:40:56 Johan Hedberg wrote:
> Hi Atul,
> 
> On Tue, Jul 28, 2015, Atul Rai wrote:
> > This patch fixes NULL pointer dereferences in case malloc fails
> > and returns NULL.
> > ---
> > 
> >  tools/sdptool.c | 37 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 33 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/sdptool.c b/tools/sdptool.c
> > index 257964d..02e7f23 100644
> > --- a/tools/sdptool.c
> > +++ b/tools/sdptool.c
> > @@ -902,9 +902,9 @@ static int set_attribseq(sdp_session_t *session,
> > uint32_t handle, uint16_t attri> 
> >  	uint32_t range = 0x0000ffff;
> >  	sdp_record_t *rec;
> >  	sdp_data_t *pSequenceHolder = NULL;
> > 
> > -	void **dtdArray;
> > -	void **valueArray;
> > -	void **allocArray;
> > +	void **dtdArray = NULL;
> > +	void **valueArray = NULL;
> > +	void **allocArray = NULL;
> 
> This doesn't seem to be related to fixing missing malloc failure checks.
> It's also unnecessary since all of these either way get unconditionally
> assigned to before reading the values.

Those are due to 'goto cleanup' where all pointers are freed.
But we could make this code a bit simpler with:

foo = malloc();
bar = malloc();
if (!foo || !bar)
  goto cleanup;

Then initialization is not needed.

> 
> >  	/* Create arrays */
> >  	dtdArray = (void **)malloc(argc * sizeof(void *));
> 
> While you're at it could you (in a separate patch) fix all of these
> unnecessary typecasts of malloc return values?
> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
BR
Szymon Janc
