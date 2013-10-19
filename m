Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 20:51:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix UUID values in blacklist debugfs file
Message-ID: <20131019175144.GA8080@x220.p-661hnu-f1>
References: <1382200319-26951-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382200319-26951-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 19, 2013, Marcel Holtmann wrote:
> The uuid entry struct is used for the UUID byte stream. That is
> actually the wrong value. The correct value is uuid->uuid.
> 
> Besides fixing this up, use the %pUb modifier to print the UUID
> string. However since the UUID is stored in big endian with
> reversed byte order, change the byte order before printing.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Applied (after removing the bogus "blacklist" word from the subject).
Thanks.

Johan
