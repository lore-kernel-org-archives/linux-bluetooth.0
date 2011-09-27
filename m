Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:17:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Use medium security level when reconnecting
Message-ID: <20110927091722.GQ3952@dell>
References: <1316528329-8149-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316528329-8149-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Sep 20, 2011, Claudio Takahasi wrote:
> For GATT based profiles encryption is mandatory. Proximity Monitor
> shall support LE Security Mode 1 and Security Level 2. Over basic rate,
> switch the security level to medium for testing purpose only.
> ---
>  src/device.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
