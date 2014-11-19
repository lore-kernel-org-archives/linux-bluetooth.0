Return-Path: <cyrus@holtmann.org>
Message-ID: <1416405776.9374.5.camel@sipsolutions.net>
Subject: Re: [PATCH] Bluetooth: btmrvl add firmware dump support
From: Johannes Berg <johannes@sipsolutions.net>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "marcel@holtmann.org" <marcel@holtmann.org>, Xinming Hu <huxm@marvell.com>,
 Cathy Luo <cluo@marvell.com>,  Avinash Patil <patila@marvell.com>
Date: Wed, 19 Nov 2014 15:02:56 +0100
In-Reply-To: <5FF020A1CFFEEC49BD1E09530C4FF5951821E912D2@SC-VEXCH1.marvell.com>
References: <1416403887-9271-1-git-send-email-akarwar@marvell.com>
	 <1416404595.9374.4.camel@sipsolutions.net>
	 <5FF020A1CFFEEC49BD1E09530C4FF5951821E912D2@SC-VEXCH1.marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2014-11-19 at 05:58 -0800, Amitkumar Karwar wrote:

> >The more intended use case for this was to trigger it when the driver
> >detected a crash, but I guess a debugfs file works as well, just not
> >sure when you'd want it.
> 
> When user encounters a case when firmware doesn't respond or got hang,
> firmware dump can be triggered via debugfs command.

Sure, but do you want to hand-hold users through it? and do they even
have debugfs?

At least for us we intentionally made this a general framework so if it
crashes/hangs and we detect it we can automatically trigger it and
collect it for bug reports.

johannes
