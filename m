Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Jun 2014 22:39:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] core: Fix cleaning pending services when ACL
 connection failed
Message-ID: <20140604193930.GA6929@t440s.P-661HNU-F1>
References: <1401894885-7444-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401894885-7444-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Jun 04, 2014, Andrzej Kaczmarek wrote:
> In case ACL connection failed to establish, all pending services shall
> be always removed. At the moment it's only done in case there's pending
> Connect message which does not take into account reconnect scenario,
> i.e. service connection was triggered by reconnection timeout and there
> is no pending message.
> 
> In such case, when reconnection failed there will be some services on
> pending list and subsequent reconnect attempts will fail with EBUSY
> immediately.
> ---
>  src/device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Both patches have been applied. Thanks.

Johan
