Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Jul 2014 15:49:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: Fix merge of advertising data and scan
 response data
Message-ID: <20140701124924.GA18736@t440s.P-661HNU-F1>
References: <1404216681-51713-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404216681-51713-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jul 01, 2014, Marcel Holtmann wrote:
> The advertising data and scan response data are merged in the wrong
> order. It should be advertsing data first and then scan response data
> and not the other way around.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org # 3.16
> ---
>  net/bluetooth/hci_event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
