Return-Path: <cyrus@holtmann.org>
Date: Sat, 4 Jan 2014 20:12:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add quirk for disabling Delete Stored
 Link Key command
Message-ID: <20140104181218.GA11461@x220.p-661hnu-f1>
References: <1388746956-9944-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388746956-9944-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jan 03, 2014, Marcel Holtmann wrote:
> Some controller pretend they support the Delete Stored Link Key command,
> but in reality they really don't support it.
> 
>   < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
>       bdaddr 00:00:00:00:00:00 all 1
>   > HCI Event: Command Complete (0x0e) plen 4
>       Delete Stored Link Key (0x03|0x0012) ncmd 1
>       status 0x11 deleted 0
>       Error: Unsupported Feature or Parameter Value
> 
> Not correctly supporting this command causes the controller setup to
> fail and will make a device not work. However sending the command for
> controller that handle stored link keys is important. This quirk
> allows a driver to disable the command if it knows that this command
> handling is broken.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 3 ++-
>  net/bluetooth/hci_core.c    | 7 ++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)

Both patches have been applied to the bluetooth-next tree. Thanks.

Johan
