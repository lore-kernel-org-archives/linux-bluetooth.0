Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jun 2014 20:53:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Replace le_auto_conn debugfs with device_list
 entry
Message-ID: <20140629175354.GB19150@t440s.P-661HNU-F1>
References: <1404051349-28707-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404051349-28707-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 29, 2014, Marcel Holtmann wrote:
> Since the auto-connection handling has gained offical management
> command support, remove the le_auto_conn debugfs entry.
> 
> For debugging purposes replace it a simple device_list debugfs
> entry that allows listing of the current internal auto-connection
> list used for passive scanning.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 93 +++++-------------------------------------------
>  1 file changed, 9 insertions(+), 84 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
