Return-Path: <cyrus@holtmann.org>
Date: Sat, 10 Nov 2012 14:25:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bart Westgeest <bart@elbrys.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Feedback on potential fix for issue while advertising Feature
 List
Message-ID: <20121110122535.GA26532@x220.P-661HNU-F1>
References: <509BD103.2040808@elbrys.com>
 <509D879C.1080205@elbrys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <509D879C.1080205@elbrys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bart,

On Fri, Nov 09, 2012, Bart Westgeest wrote:
> > I appreciate any input from anybody more familiar with the SDP
> > code on what the accepted/preferred approach is to get this
> > issue fixed.
> 
> Anybody? Again, I've already root caused the problem and have a fix.
> 
> I am Just looking for input to see if what I have is acceptable, or
> if something else is preferred.

Have a bit more patience, sometimes it can take a few days to get
feedback. I think the option of looking at the length and using the old
type for < 256 and a 16-bit type for greater lengths would be the
safest. This way old code will still produce the same result for < 256
lengths.

Johan
