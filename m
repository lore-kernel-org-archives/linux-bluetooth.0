Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Feb 2014 19:49:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add missing index added event on user
 channel failure
Message-ID: <20140217174930.GA7285@x220.p-661hnu-f1>
References: <1392657679-32983-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392657679-32983-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 17, 2014, Marcel Holtmann wrote:
> When the setup of user channel fails, the index added event is not sent
> and will cause issues with user interaction. This problem can be easily
> triggered with a LE only controller without a public address. In that
> case hci_dev_open() fails and that error case is not sending an event
> saying that the controller is available for normal use again.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 1 +
>  1 file changed, 1 insertion(+)

Both patches have been applied to bluetooth-next. Thanks.

Johan
