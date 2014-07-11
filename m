Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jul 2014 13:55:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Move struct hci_sec_filter next to its
 user
Message-ID: <20140711105508.GB14378@t440s.P-661HNU-F1>
References: <1405049800-40462-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405049800-40462-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 11, 2014, Marcel Holtmann wrote:
> There is only single location using struct hci_sec_filter and with
> that there is no point in putting this declaration into a global
> header file. So move it right next to its user and make the code
> a lot more simpler.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 9 ---------
>  net/bluetooth/hci_sock.c         | 8 ++++++++
>  2 files changed, 8 insertions(+), 9 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
