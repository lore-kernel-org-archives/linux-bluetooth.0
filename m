Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 May 2010 18:03:30 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Fabian Greffrath <fabian@greffrath.com>
Cc: Stefan Seyfried <stefan.seyfried@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Detect invalid (i.e. non-UTF-8) device names and fix them
 during initialization phase
Message-ID: <20100506150228.GA20880@jh-x301>
References: <4BE14458.1020908@greffrath.com>
 <4BE14819.4080903@greffrath.com>
 <20100505170202.3d6b1dcb@susi.home.s3e.de>
 <1273156964.25110.1.camel@vfrodo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1273156964.25110.1.camel@vfrodo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 06, 2010, Fabian Greffrath wrote:
> Am Mittwoch, den 05.05.2010, 17:02 +0200 schrieb Stefan Seyfried:
> > Then it would probably good if you could send the patch against current
> > git (even if it still applies cleanly) and in a format that "git am" can
> > process directly. That makes it very easy for the maintainers to apply the
> > code and in the same run makes sure you get proper attribution for your
> > contribution ;)
> 
> I have reapplied my patch against current git, I have replaced the
> obscure 249 in "char name[249];" by MAX_NAME_LENGTH as defined in
> src/adapter.h and I am now posting it inline. Happy reviewing! ;)

BlueZ will (or at least should) set the name for the adapter as follows:

1. If there's a name in /var/lib/bluetooth/... use that
2. Else if there's a name in main.conf use that
3. If all else fails set the name to "BlueZ"

So I fail to see why this patch is needed at all. It sounds like there's
something else wrong in the initialization process which makes the
initialzation fail if the adapter contains some invalid default name (we
shouldn't as far as I see be trying to read the name at all from the
adapter before we've written it ourselves from the host side). I.e. I
suspect the patch might be just working around the real issue instead of
fixing it.

Johan
