Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 19:07:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: Add support for setting SSP debug mode
Message-ID: <20131019160726.GA29273@x220.p-661hnu-f1>
References: <1382191753-59287-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382191753-59287-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 19, 2013, Marcel Holtmann wrote:
> Enabling and disabling SSP debug mode is useful for development. This
> adds a debugfs entry that allows to configure the SSP debug mode.
> 
> On purpose this has been implemented as debugfs entry and not a public
> API since it is really only useful during testing and development.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |  2 ++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 54 +++++++++++++++++++++++++++++++++++++++-
>  net/bluetooth/hci_event.c        |  2 ++
>  4 files changed, 58 insertions(+), 1 deletion(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
