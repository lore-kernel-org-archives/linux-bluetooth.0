Return-Path: <cyrus@holtmann.org>
Date: Sat, 5 Jul 2014 15:49:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Use a more simpler style for HCI event
 callbacks
Message-ID: <20140705124935.GA8406@t440s.P-661HNU-F1>
References: <1404550083-29418-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404550083-29418-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jul 05, 2014, Marcel Holtmann wrote:
> The HCI event callbacks have grown over the last years and some
> functions handle status checking different than others. For the
> simple ones, check the status at the beginning and exit if an
> error with the HCI command occured.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c | 142 ++++++++++++++++++++++++++++------------------
>  1 file changed, 88 insertions(+), 54 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
