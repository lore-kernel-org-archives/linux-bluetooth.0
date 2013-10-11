Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 18:21:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Make LE scan interval and window a
 controller option
Message-ID: <20131011162128.GA8494@x220.p-661hnu-f1>
References: <1381505000-50787-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381505000-50787-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 11, 2013, Marcel Holtmann wrote:
> The scan interval and window for LE passive scanning and connection
> establishment should be configurable on a per controller basis. So
> introduce a setting that later on will allow modifying it.
> 
> This setting does not affect LE active scanning during device
> discovery phase. As long as that phase uses interleaved discovery,
> it will continuously scan.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 2 ++
>  net/bluetooth/hci_conn.c         | 4 ++--
>  net/bluetooth/hci_core.c         | 3 +++
>  3 files changed, 7 insertions(+), 2 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
