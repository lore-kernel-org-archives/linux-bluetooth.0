Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Jan 2013 16:36:18 +0100
From: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau <frederic.dalleau@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau <frederic.dalleau@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Add option for SCO socket mode
Message-ID: <20130117153618.GA30817@fredo-Latitude-E6430>
References: <1358426389-25903-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1358426389-25903-2-git-send-email-frederic.dalleau@linux.intel.com>
 <1358431772.3059.13.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1358431772.3059.13.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jan 17, 2013 at 06:09:32AM -0800, Marcel Holtmann wrote:
Hi Marcel,
> I do not like this enhanced magic. How is this suppose to work? And it
> is also not explained in the commit message. Or used in this patch.

sco_options_enhanced is not definitive, this patch is meant to describe
different parameters for the socket option that could be selected based on the
mode field. To ensure compatibility accross versions, the size of the socket
options structure can be checked.

The idea is to read supported codecs list using mgmt API. Then,it is possible
to select some codecs and the enhanced accept/setup sync conn are sent.

It does not make sense to get this option since the codec is negociated
externally.

If this mode is removed, we fallback on version 1 of RFC (except at this time,
sco_options.mode was sco_options.codec).  And it is it is easy to add new modes
to select latency, or packet types without breaking existing API.

Thanks,
Frédéric
