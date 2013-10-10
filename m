Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 00:21:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remote return value from hci_send_frame()
 function
Message-ID: <20131010222156.GD4228@x220.p-661hnu-f1>
References: <1381437360-55235-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381437360-55235-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013, Marcel Holtmann wrote:
> The return value of hci_send_frame() is never checked. So just make
> this function void and print an error when the hdev->send driver
> callback returns a negative value.
> 
> Having the error printed is actually an improvement over the
> current situation where any driver error just gets ignored.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
