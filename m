Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Oct 2013 09:28:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Send new settings event when changing high
 speed option
Message-ID: <20131001062829.GA5699@x220.p-661hnu-f1>
References: <1380604658-34364-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380604658-34364-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Sep 30, 2013, Marcel Holtmann wrote:
> When enabling or disabling high speed setting it is required to send
> a new settings event to inform other management interface users about
> the changed settings.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
