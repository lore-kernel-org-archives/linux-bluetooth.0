Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Nov 2010 19:21:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Implements primary service search when creating a
 device
Message-ID: <20101129172139.GA23846@jh-x301>
References: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290565847-17382-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Nov 24, 2010, Claudio Takahasi wrote:
> Discover primary services implemented inside the device entity to allow
> proper integration of attribute plugin. Implements a single entry point
> to the attribute plugin no matter the transport(BR/EDR or LE), the device
> probe callback is called for both types.
> 
> Add a new function to discover all primary services without additional
> calls to fetch the remaining primary services, sub-procedure iterations
> is handled inside this function.
> 
> The next action are: clean the attribute client removing implicity service
> and characteristics discovery, issue the Discover Primary Service based on
> the remote properties and fetch the characteristic on demand.
> ---
>  attrib/manager.c  |   27 +++-------
>  src/device.c      |  106 +++++++++++++++++++++++++++++++-------
>  src/glib-helper.c |  147 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/glib-helper.h |    5 ++
>  4 files changed, 246 insertions(+), 39 deletions(-)

All five patches have been pushed upstream. Thanks.

Johan
