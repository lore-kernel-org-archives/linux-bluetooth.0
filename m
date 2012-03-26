Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Mar 2012 14:30:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: don't increment twice in eir_has_data_type()
Message-ID: <20120326113054.GA15616@x220>
References: <20120320150611.GA24873@elgon.mountain>
 <20120321220632.GA14964@x220.amr.corp.intel.com>
 <20120322062801.GA3232@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120322062801.GA3232@mwanda>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

On Thu, Mar 22, 2012, Dan Carpenter wrote:
> On Wed, Mar 21, 2012 at 07:06:32PM -0300, Johan Hedberg wrote:
> > Looks like the original code is indeed buggy, no idea how I didn't
> > notice something that obvious. Your patch does however seem to change
> > the behavior a bit, a valid tag would be detected even though its length
> > would be invalid (pointing outside of the supplied data). Not sure if
> > that's so critical though since the important thing is to keep the code
> > from doing anything nasty when supplied invalid data.
> > 
> 
> We should check the length.  It will just cause headaches if we
> don't.
> 
> It would be simple enough for me to put back the check I removed
> from the middle of the loop.  But the thing is I wasn't sure how all
> the + 1 and - 1 things fit together so I didn't feel good about
> signing off on this.  Could you send a patch?  That way I get a
> reported-by tag but if there are any problems you get blamed while I
> deny knowing anything about it.  ;)

Done. I also sent a second patch for another issue with the function.

In case you're interested the EIR data format is quite simple,
consisting of a sequence of data structures with a format of:

	| data_len (1 byte) | data (data_len bytes) |

The first byte of "data" is the type of data structure in question. EIR
data buffers do not need to be completely filled up, i.e. they can
contain a non-significant part at the end, the beginning of which can be
detected by a data_len field with the value of 0.

Johan
