Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 15:13:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use helper functions for enabling/disabling
 advertising
Message-ID: <20131006131337.GC32754@x220.p-661hnu-f1>
References: <1381053321-9760-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381053321-9760-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> The tasks of enabling and disabling advertising are required in many
> cases. So refactor the actual HCI operations into two common helpers
> to make the code simpler.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)

Applied. Thanks.

Johan
