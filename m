Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Feb 2012 12:46:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix parameter list for setting local name
Message-ID: <20120221104645.GA28661@x220>
References: <1329808466-30669-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329808466-30669-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 21, 2012, Marcel Holtmann wrote:
> The parameter list for setting the local name via management interface
> was missing the short name parameter.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
