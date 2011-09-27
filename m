Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:25:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Add support for HandsfreeGateway to Media
Message-ID: <20110927092541.GW3952@dell>
References: <1315317353-14412-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1315317353-14412-1-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Sep 06, 2011, Frédéric Dalleau wrote:
> The first patch in this series fix the issue remaining in v2.
> It also fix a crash because the request_stream callback was run synchronously.
> After that various fixes.
> 
> Changes from v4 :
> Patch 2: take Luiz comment into account and create error domain for
> gateway
> Patch 4: also make sure gateway is set back to disconnected state in case of
> authorize errors.
> 
> Best regards,
> Frédéric
> 
> Frédéric Dalleau (6):
>   Fix disconnect SCO at same time than RFCOMM
>   Fix asynchronously run request stream cb
>   Fix state to "playing" on SCO establishment
>   Set state to "connecting" on connection requested
>   Fix reference count issue in incoming connections
>   Check all states before allowing gw connection
> 
>  audio/gateway.c |  194 ++++++++++++++++++++++++++++++++++++++-----------------
>  audio/gateway.h |   12 +++-
>  audio/manager.c |    8 ++-
>  audio/unix.c    |   13 +---
>  4 files changed, 155 insertions(+), 72 deletions(-)

Patches 1-5 have been applied. Thanks.

Johan
