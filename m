Return-Path: <foo00@h08.hostsharing.net>
Date: Thu, 15 Mar 2018 09:14:08 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org, "Robert R. Howell" <rhowell@uwyo.edu>
Subject: Re: [PATCH 4.16 REGRESSION fix 1/2] Revert "Bluetooth: hci_bcm:
 Streamline runtime PM code"
Message-ID: <20180315081408.GC4615@wunner.de>
References: <20180314220603.7559-1-hdegoede@redhat.com>
 <20180314220603.7559-2-hdegoede@redhat.com>
 <20180314221603.GB28738@wunner.de>
 <807b74cb-2222-2d47-12c2-0415a9027102@redhat.com>
 <20180314223813.GD28738@wunner.de>
 <066d03cc-6dd0-7eca-f8cc-78e81277459c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <066d03cc-6dd0-7eca-f8cc-78e81277459c@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 15, 2018 at 08:49:04AM +0100, Hans de Goede wrote:
> On 14-03-18 23:38, Lukas Wunner wrote:
> > On Wed, Mar 14, 2018 at 11:23:12PM +0100, Hans de Goede wrote:
> > >We're quite far into the cycle already and this is a serious regression,
> > >also nothing of great value is lost by the revert, the original commit
> > >was a minor cleanup which turns out to have bad side-effects, a simple
> > >revert really is the best solution here, esp. in this point of the cycle.
> >
> > Just an hour ago he sent me the patch to look over it.  And we're at
> > least two and a half weeks away from v4.16.
> 
> No we are *only* two and a half weeks away from v4.16 (worst case scenario)
> and Linus does not like getting last minute fixes.

That doesn't preclude allowing a few hours to discuss things.
There is never such a rush.  In the present case, a new contributor
was willing to debug the issue and submit a patch.  Onboarding new
contributors is important and IMO it's worth waiting a few days for
them to sort things out, even if it means a regression stays present
a little longer.  I'm sorry that it meant you wasted time debugging
it in parallel.

That said, when submitting the patch I clearly failed to notice that
for devices using autosuspend, pm_request_resume() doesn't update
the last usage timestamp.  While that could be fixed by calling
pm_runtime_mark_last_busy() before pm_request_resume(), it doesn't
seem to be customary as a look at all the call sites of
pm_request_resume() shows.  The original three-line sequence,
although quite verbose, appears to be what is commonly used in such
a case.  For this reason reverting back to the original version
seems justified.

Thanks,

Lukas
