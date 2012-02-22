Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Feb 2012 19:31:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix handling of discoverable setting with
 timeout
Message-ID: <20120222173139.GB27919@x220.ger.corp.intel.com>
References: <1329931260-9460-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329931260-9460-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 22, 2012, Marcel Holtmann wrote:
> The current handling of the discoverable timeout was missing the proper
> handling of the timeout when the mode was already set. Now the command
> can be used to expire or retrigger the timeout.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
