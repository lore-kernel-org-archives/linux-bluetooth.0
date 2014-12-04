Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Dec 2014 14:15:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 1/7] Bluetooth: Simplify the error handling of Start
 Discovery command
Message-ID: <20141204121547.GA25764@t440s.lan>
References: <1417689400-128063-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417689400-128063-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 04, 2014, Marcel Holtmann wrote:
> The Start Discovery command has some complicated code when it comes
> to error handling. With the future introduction of Start Service
> Discovery simplifying this makes it easier to read.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

As the first three patches in this set are rather uncontroversial and
seem to work I've applied them to bluetooth-next. Thanks.

Johan
