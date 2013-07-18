Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Jul 2013 16:13:10 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH 6/8] Fix the reference counting of tty_port
Message-ID: <20130718141310.GA16537@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
 <1373661649-1385-6-git-send-email-gianluca@sottospazio.it>
 <51E6A3F7.20202@hurleysoftware.com>
 <20130717170500.GA10640@sottospazio.it>
 <51E6DE1D.4020808@hurleysoftware.com>
 <51E7E377.2000108@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51E7E377.2000108@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 18, 2013 at 08:45:43AM -0400, Peter Hurley wrote:
> On 07/17/2013 02:10 PM, Peter Hurley wrote:
> >That said, preventing rfcomm_dev destruction by holding the dlc lock
> >is poor design (not that I'm suggesting you should be required to fix it though)
> >and something that at least needs documenting.
> >
> >Regarding acquiring a snapshot of dev->id is fine, provided that the id
> >cannot be reallocated in between dropping the dlc lock and subsequently
> >scanning the rfcomm_dev_list for that id.
> 
> Or at least a FIXME comment that the id could potentially be reallocated
> between dropping the dlc lock and the subsequent rfcomm_dev_get().
> 
> Regards,
> Peter Hurley

I must admit I don't know how to solve the issue you outlined. I cannot also
understand why that code exists in first place: why should we release the
device when RFCOMM_RELEASE_ONHUP is set but we didn't get a HUP?

Gianluca
