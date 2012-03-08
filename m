Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Mar 2012 17:58:59 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/2] gateway: Fix crash if SCO connection fails
Message-ID: <20120308235859.GB19895@x220.amr.corp.intel.com>
References: <1329842810-13449-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1329842810-13449-1-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Feb 21, 2012, Frédéric Dalleau wrote:
> The first patch is a resend of a previous patch with same name.
> The second one happens after the sco connection has failed : the disconnect
> watch is not removed when the media owner is freed upon error in acquire.
> 
> Let me know what you think.
> 
> Regards,
> Frédéric
> 
> Frédéric Dalleau (2):
>   gateway: Fix crash if SCO connection fails
>   media: register disconnect watch at transport add
> 
>  audio/gateway.c   |    5 +----
>  audio/transport.c |    6 +++---
>  2 files changed, 4 insertions(+), 7 deletions(-)

Both patches have been applied. Thanks.

Johan
