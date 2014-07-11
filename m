Return-Path: <cyrus@holtmann.org>
Message-ID: <1405074304.9749.64.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH net-next 0/2] Introduce generic 6LoWPAN branch
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: netdev@vger.kernel.org, marcel@holtmann.org,
	linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org
Date: Fri, 11 Jul 2014 13:25:04 +0300
In-Reply-To: <1405067059-18782-1-git-send-email-alex.aring@gmail.com>
References: <1405067059-18782-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On pe, 2014-07-11 at 10:24 +0200, Alexander Aring wrote:
> Hi,
> 
> this patch series add a new branch "net/6lowpan" for generic 6LoWPAN code.
> 
> Since commit 8df8c56a5abc70af5862aa7cac2875aeeb17a42b ("6lowpan: Moving
> generic compression code into 6lowpan_iphc.c") the IPHC compression is shared
> between bluetooth 6LoWPAN and IEEE 802.15.4 6LoWPAN. The new 6LoWPAN directory
> will contain generic code for 6LoWPAN and futhermore 6LoWPAN upper layer
> protocols.
> 
> The shared code between bluetooth and 802.15.4 should be review from both
> communities. The current behaviour is that get_maintainers.pl returns the
> IEEE 802.15.4 community only.
> 
> 
> I request a new mailinglist for the IEEE 802.15.4 subsystem at vger but I didn't
> get a response now so I add the current sourceforge IEEE 802.15.4 mailinglist to
> the MAINTAINERS file. I will update them soon.

This is great idea.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
