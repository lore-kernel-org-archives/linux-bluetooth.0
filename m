Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Feb 2011 09:34:00 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
Subject: Re: [PATCH 04/10] Bluetooth: Use EIO code to report HCI error to
 userpace
Message-ID: <20110218073400.GA874@null>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
 <1297948601-12723-5-git-send-email-szymon.janc@tieto.com>
 <20110217134946.GY874@null>
 <201102171523.10461.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201102171523.10461.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 17, 2011 at 03:23:10PM +0100, ext Szymon Janc wrote:
> Hi,
> 
> > On Thu, Feb 17, 2011 at 02:16:35PM +0100, ext Szymon Janc wrote:
> > > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > > ---
> > >  net/bluetooth/mgmt.c |    7 +++----
> > >  1 files changed, 3 insertions(+), 4 deletions(-)
> > 
> > Some kind of explanation why EIO is better than status would be nice.
> 
> As I've mentioned in cover letter:

Cover letters does not end up to git log. Proper description helps debugging
later a much if we can easily determine why this was needed and what was the
motivation for this patch.

> It is not possible to distinguish in cmd status if error was from kernel
> or from HCI. Since in mgmt only kernel sends HCI commands their errors
> shouldn't be needed for userspace so report EIO to userspace on HCI error
> (if HCI error is needed for debugging, logs can be added on kernel side)
> 
> HCI status codes and kernel error codes overlaps  i.e. one can't distinguish
> if error was ENOMEM or HCI Command Disallowed as both have value 12.
> 
> For userspace is should be enough to just know that HCI failed, not why.
> (in fact, currently userspace is not able to determine error too...)

This sounds reasonable to me.

-- 
Ville
