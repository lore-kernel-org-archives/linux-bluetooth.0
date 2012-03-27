Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 20:18:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Update management interface revision
Message-ID: <20120327171810.GA4398@x220.P-661HNU-F1>
References: <1332866942-6632-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332866942-6632-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Mar 27, 2012, Marcel Holtmann wrote:
> For each kernel release where commands or events are added to the
> management interface, the revision field should be increment by one.
> 
> The increment should only happen once per kernel release and not
> for every command/event that gets added. The revision value is for
> informational purposes only, but this simple policy would make any
> future debugging a lot simple.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to the new bluetooth-next tree. Thanks.

Johan
