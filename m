Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] bluetooth: hci_bcsp: fix code style
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1458720017-21115-1-git-send-email-mussitantesmortem@gmail.com>
Date: Fri, 8 Apr 2016 10:13:43 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <CDB6AF69-F6A2-4B09-A9D9-A69D551DCB43@holtmann.org>
References: <1458720017-21115-1-git-send-email-mussitantesmortem@gmail.com>
To: Maxim Zhukov <mussitantesmortem@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Maxim,

> This commit fixed:
> trailing "*/"
> trailing spaces
> mixed indent
> space between ~ and (
> 
> Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
> ---
> drivers/bluetooth/hci_bcsp.c | 55 +++++++++++++++++++++++++-------------------
> 1 file changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 064f2fe..3cfbe1d 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -103,12 +103,12 @@ static const u16 crc_table[] = {
> #define BCSP_CRC_INIT(x) x = 0xffff
> 
> /*
> -   Update crc with next data byte
> -
> -   Implementation note
> -        The data byte is treated as two nibbles.  The crc is generated
> -        in reverse, i.e., bits are fed into the register from the top.
> -*/
> + * Update crc with next data byte
> + *
> + * Implementation note
> + *	The data byte is treated as two nibbles.  The crc is generated
> + *	in reverse, i.e., bits are fed into the register from the top.
> + */

please follow the networking subsystem comment style for multi-line comments.

Regards

Marcel

