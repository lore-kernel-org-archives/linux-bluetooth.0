Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Dec 2010 00:37:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 2/5] Change CreatePairedDevice to support LE devices
Message-ID: <20101223223717.GA32310@jh-x301>
References: <20101221084243.GA14108@jh-x301>
 <1293139790-9646-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293139790-9646-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Thu, Dec 23, 2010, Sheldon Demario wrote:
> CreatePairedDevice implements now the same behaviour of CreateDevice,
> triggering Discover All Primary Services when needed. SMP negotiation
> starts when the link is established. LE capable kernel is required to
> test this method properly.
> 
> Limitation: For dual mode devices, Discover All Primary Services is not
> being executed after SDP search if GATT record is found.
> ---
>  src/adapter.c     |  102 +++++++++++++++++++++++++++++++++++++----------------
>  src/device.c      |   89 ++++++++++++++++++++++++----------------------
>  src/device.h      |    5 ++-
>  src/glib-helper.c |   12 +++++-
>  src/glib-helper.h |    1 +
>  5 files changed, 132 insertions(+), 77 deletions(-)

Pushed upstream. Thanks.

Johan
