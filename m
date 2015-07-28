Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jul 2015 11:03:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Atul Rai <a.rai@samsung.com>, linux-bluetooth@vger.kernel.org,
	sachin.dev@samsung.com
Subject: Re: [PATCH v2] tools/sdptool: Fix NULL pointer dereference
Message-ID: <20150728080346.GA5327@t440s.lan>
References: <1438068019-4094-1-git-send-email-a.rai@samsung.com>
 <20150728074056.GA2417@t440s.lan>
 <4524026.9PhAiZIq7z@leonov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4524026.9PhAiZIq7z@leonov>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jul 28, 2015, Szymon Janc wrote:
> > > -	void **dtdArray;
> > > -	void **valueArray;
> > > -	void **allocArray;
> > > +	void **dtdArray = NULL;
> > > +	void **valueArray = NULL;
> > > +	void **allocArray = NULL;
> > 
> > This doesn't seem to be related to fixing missing malloc failure checks.
> > It's also unnecessary since all of these either way get unconditionally
> > assigned to before reading the values.
> 
> Those are due to 'goto cleanup' where all pointers are freed.

Right. I was looking at the existing code and forgot that the patch adds
this label.

> But we could make this code a bit simpler with:
> 
> foo = malloc();
> bar = malloc();
> if (!foo || !bar)
>   goto cleanup;
> 
> Then initialization is not needed.

Agreed.

Johan
