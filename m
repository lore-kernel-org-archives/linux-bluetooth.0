Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Jun 2012 11:46:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Smith <door@shapeseeker.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Small Patch for scotest.c
Message-ID: <20120610084658.GB28539@x220.P-661HNU-F1>
References: <4FD111EB.8070307@shapeseeker.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FD111EB.8070307@shapeseeker.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Thu, Jun 07, 2012, Brian Smith wrote:
> Hi there.
> Here is a tiny 3-line patch to scotest.c to get it working. (I've
> been trying to get bluez working on a Raspberry Pi, hitting USB
> problems, having a workng scotest is helpful). The problem is that
> bdaddr never gets initialized and tends to have random data in it,
> preventing the client/server end from matching up.
> 
> 344a345,346
> >       hci_devba(0, &bdaddr);
> >

Please only send patches in unified diff format. If you want them
applied upstream they should be created using "git format-patch" and
preferably sent with "git send-email".

However, in this case I don't think your patch is quite right even if it
was in the right format. Looking at bdaddr in scotest.c it's a static
variable and to my understanding those should (according to the C
standard) always get implicitly initialized to 0 if the code itself
doesn't do so. At least gcc should follow this, so which compiler are
you really using?

Furthermore, assuming that this (zero-initialized bdaddr) is how scotest
behaves for most people (as it's existed many years and you're the first
one to face the issue), it's the same as using BDADDR_ANY. Therefore,
I'd just go ahead and remove the bdaddr variable and replace the places
where it was used with BDADDR_ANY (and please format the patch like I
described above). Thanks.

Johan
