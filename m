Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Jul 2014 13:31:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Change hci_conn_params_add to return the
 parameter struct
Message-ID: <20140701103113.GB4781@t440s.lan>
References: <1404209466-64712-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404209466-64712-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jul 01, 2014, Marcel Holtmann wrote:
> When adding new connection parameters, it is useful to return either
> the existing struct or the newly created one.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  3 ++-
>  net/bluetooth/hci_core.c         | 11 ++++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
