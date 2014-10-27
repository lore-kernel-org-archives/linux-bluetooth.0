Return-Path: <cyrus@holtmann.org>
Message-ID: <1414420099.2705.218.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v2 2/3] Bluetooth: 6lowpan: Fix lockdep splats
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 27 Oct 2014 16:28:19 +0200
In-Reply-To: <20141027141000.GB24691@omega>
References: <1414418683-1057-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1414418683-1057-3-git-send-email-jukka.rissanen@linux.intel.com>
	 <20141027141000.GB24691@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On ma, 2014-10-27 at 15:10 +0100, Alexander Aring wrote:
> Hi Jukka,
> 
> On Mon, Oct 27, 2014 at 04:04:42PM +0200, Jukka Rissanen wrote:
> > When a device ndo_start_xmit() calls again dev_queue_xmit(),
> > lockdep can complain because dev_queue_xmit() is re-entered and the
> > spinlocks protecting tx queues share a common lockdep class.
> > 
> > Same issue was fixed for ieee802162 in commit "20e7c4e80dcd"
> > 
> 
> s/ieee802162/ieee802154/

Good catch.

> 
> 
> I know it's hard. I also do some mistake on these IEEE number word
> salads.

Yep, it was also very difficult to see (or actually impossible because I
missed this one) when I was proof reading the patches before sending :)


Thanks,
Jukka


