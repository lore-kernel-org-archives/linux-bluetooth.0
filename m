Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 14:10:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Garbat Rafal <rafal.garbat@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Finalize discovery after discover message was
 rejected.
Message-ID: <20120404111002.GA3463@x220>
References: <1331314055-18669-1-git-send-email-rafal.garbat@tieto.com>
 <20120404102047.GA29893@x220>
 <4F7C2AF7.10500@tieto.com>
 <20120404110834.GA3300@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120404110834.GA3300@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 04, 2012, Johan Hedberg wrote:
> Hi Rafal,
> 
> On Wed, Apr 04, 2012, Garbat Rafal wrote:
> > >The patch looks ok'ish but it doesn't compile:
> > >
> > >audio/avdtp.c: In function ‘avdtp_parse_rej’:
> > >audio/avdtp.c:3071:11: error: ‘struct avdtp’ has no member named ‘used_data’
> > >
> > >Secondly, please use a "avdtp:" prefix for the commit message
> > >("Bluetooth" is only reserved for kernel patches) and remove the '.'
> > >from the end of the summary line.
> > >
> > >Johan
> > 
> > Sorry, just a nasty typo. Will fix it and send patch once again.
> 
> The thing I'm more worried about is that this seems to imply that you've
> neither run the code nor even tried to compile it. Is that the case?

I.e. how do you know that the patch is correct if you haven't tested it?

Johan
