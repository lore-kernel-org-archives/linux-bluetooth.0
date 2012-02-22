Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Feb 2012 19:31:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Disabling discoverable with timeout is invalid
Message-ID: <20120222173127.GA27919@x220.ger.corp.intel.com>
References: <1329930394-6213-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329930394-6213-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 22, 2012, Marcel Holtmann wrote:
> Add one extra sanity check to ensure that the supplied timeout value is
> actually valid in this context.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
