Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 09:34:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Restrict loading of long term keys to LE
 capable controllers
Message-ID: <20131003063430.GB20600@x220.p-661hnu-f1>
References: <1380773768-12958-2-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380773768-12958-2-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 02, 2013, Marcel Holtmann wrote:
> Loading long term keys into a BR/EDR only controller make no sense.
> The kernel would never use any of these keys. So instead of allowing
> userspace to waste memory, reject such operation with a not supported
> error message.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
