Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] De-register pbap drivers on init failure scenarios
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "Counihan, Tom" <tom.counihan@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20100727123129.GA6483@jh-x301>
References: <B09AD526409DF14F8DA79CC5429052C299EE0FC7@irsmsx505.ger.corp.intel.com>
	 <20100727123129.GA6483@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 08:41:27 -0700
Message-ID: <1280245287.2621.78.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > Unwind the driver registration/phonebook initialization stack on pbap plugin init failure scenarios.
> > 
> > 
> > ---
> >  plugins/pbap.c |   25 ++++++++++++++++++++-----
> >  1 files changed, 20 insertions(+), 5 deletions(-)
> 
> Thanks for the patch! It's now upstream. In the future please pay
> attention to your commit message line length. It shouldn't exceed 74
> characters (or so) in order to be nicely viewable on a 80-character wide
> terminal using git log. I fixed it this time for you manually.

please pay attention to Outlook/Exchange users where the the firstname,
lastname thing is reversed :(

Tom, Ensure that patches have a proper From: line first with the correct
name in the correct order.

Regards

Marcel


