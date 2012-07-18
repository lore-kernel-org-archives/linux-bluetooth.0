Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 15:39:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: ramm@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Do not resolve name if entry was not
 found.
Message-ID: <20120718123956.GA2562@x220.ger.corp.intel.com>
References: <1342613166-23651-1-git-send-email-ramm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342613166-23651-1-git-send-email-ramm@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ram,

On Wed, Jul 18, 2012, ramm@ti.com wrote:
> From: Ram Malovany <ramm@ti.com>
> 
> If entry wasn't found in the hci_inquiry_cache_lookup_resolve do not
> resolve the name.
> 
> Signed-off-by: Ram Malovany <ramm@ti.com>
> ---
>  net/bluetooth/hci_event.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

I'm fine with all of these three patches but you might consider
improving the commit messages a bit. Especially with kernel patches it
doesn't hurt to have a bit more verbosity.

Also, formulating the summary line as "Fix ..." would be good since they
*are* all fixes (this can help fast-tracking them upstream). It's
particularly important for this first one to be clearly identifiable as
a fix since it's fixing a NULL pointer dereference (something that
should also have been mentioned in the commit message imo).

Another smaller cosmetic issue with the messages: usually the summary
lines do not end with a period.

Johan
