Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 20:10:57 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Alan Ott <alan@signal11.us>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ospite@studenti.unina.it,
	linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	bgood@velocity.net
Subject: Re: [PATCH v4 1/2] HID: Documentation for hidraw
In-Reply-To: <4D5C202B.5030403@signal11.us>
Message-ID: <alpine.LNX.2.00.1102162010180.2160@pobox.suse.cz>
References: <1297829209-10511-1-git-send-email-alan@signal11.us> <1297829209-10511-2-git-send-email-alan@signal11.us> <20110216071200.02ccdaa5@bike.lwn.net> <4D5C202B.5030403@signal11.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 16 Feb 2011, Alan Ott wrote:

> > >   Documentation/hid/Makefile      |    8 ++
> > >   Documentation/hid/hid-example.c |  167
> > > +++++++++++++++++++++++++++++++++++++++
> > >      
> > I believe we're trying to get code - especially runnable code - out of the
> > Documentation tree.  Should this go under samples/ or, if it's useful
> > enough, under tools/?
> >    
> 
> Not a problem. I'd say samples/ over tools/ for this stuff. I'll re-spin 
> and re-submit.

Perfect, thanks, I'd prefer samples/ as well.

Otherwise I like the hidraw documentation, thanks a lot for putting it 
together.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
