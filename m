Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Oct 2012 15:33:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Move adapter config file to ini-file format
Message-ID: <20121010133306.GA13821@x220.c.hospitality.swisscom.com>
References: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
 <1349863391.27233.115.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349863391.27233.115.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 10, 2012, Marcel Holtmann wrote:
> > Adapter saved configuration will be saved to /var/lib/bluetooth/<adapter address>/settings
> > in ini-file format for BlueZ 5.
> > If this file does not exist, we try to convert legacy config file to it.
> > 
> > Access to variables during run-time is performed in adapter structure which is populated by loading saved configuration during initialization.
> > 
> > First 6 patches remove access to config file from run-time.
> > Last patch move to ini-file format style (load, save and convert).
> 
> I am fine with the first 6 patches (7 in the end). Lets have Johan a
> second look at it.

Looks all pretty good to me.

Johan
