Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Mar 2015 14:08:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Gracefully response to enabling LE on LE only
 devices
Message-ID: <20150320120817.GA20503@t440s.ger.corp.intel.com>
References: <1426720507-28458-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426720507-28458-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Mar 18, 2015, Marcel Holtmann wrote:
> Currently the enabling of LE on LE only devices causes an error. This
> is a bit difference from other commands where trying to set the same
> existing settings causes a positive response. Fix this behavior for
> this single corner case.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
