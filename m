Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 23:40:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: CSP implementation for MCAP
Message-ID: <20100902204022.GA18957@jh-x301>
References: <4A11989E-5448-43B7-887F-217C54977E22@epx.com.br>
 <20100902202806.GA8391@jh-x301>
 <FC6865EA-F6F4-459A-9962-7215F8B0509C@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <FC6865EA-F6F4-459A-9962-7215F8B0509C@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Thu, Sep 02, 2010, Elvis Pfützenreuter wrote:
> > - I'm not so happy about all the ifdefs in the code and the way that
> >  they are used. So this may need some rethinking. Probably we could
> >  have the code always compiled in and have a runtime variable to
> >  disable its use.
> 
> Such variable already exists, and starts turned off. So could I remove
> the --enable-mcap-csp flag altogether?

Yes, I think a single --enable-mcap that covers also csp should be
enough.

Johan
