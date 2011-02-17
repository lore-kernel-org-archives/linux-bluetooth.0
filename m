Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [PATCH 04/10] Bluetooth: Use EIO code to report HCI error to userpace
Date: Thu, 17 Feb 2011 15:23:10 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com> <1297948601-12723-5-git-send-email-szymon.janc@tieto.com> <20110217134946.GY874@null>
In-Reply-To: <20110217134946.GY874@null>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201102171523.10461.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On Thu, Feb 17, 2011 at 02:16:35PM +0100, ext Szymon Janc wrote:
> > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > ---
> >  net/bluetooth/mgmt.c |    7 +++----
> >  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> Some kind of explanation why EIO is better than status would be nice.

As I've mentioned in cover letter:
It is not possible to distinguish in cmd status if error was from kernel
or from HCI. Since in mgmt only kernel sends HCI commands their errors
shouldn't be needed for userspace so report EIO to userspace on HCI error
(if HCI error is needed for debugging, logs can be added on kernel side)

HCI status codes and kernel error codes overlaps  i.e. one can't distinguish
if error was ENOMEM or HCI Command Disallowed as both have value 12.

For userspace is should be enough to just know that HCI failed, not why.
(in fact, currently userspace is not able to determine error too...)

-- 
br
Szymon Janc
