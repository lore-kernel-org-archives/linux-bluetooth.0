Return-Path: <cyrus@holtmann.org>
Message-ID: <1339144452.1817.141.camel@aeonflux>
Subject: Re: [PATCHv1 3/4] Bluetooth: Add debug print specifier
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 08 Jun 2012 17:34:12 +0900
In-Reply-To: <1339143166-6523-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1339143166-6523-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Some functions print opcode as "0xc03" others as "0x0c03". Patch
> ensures that opcodes printed are the in the same format.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8f35f2e..c7be1bc 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2097,7 +2097,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
>  	struct hci_command_hdr *hdr;
>  	struct sk_buff *skb;
>  
> -	BT_DBG("%s opcode 0x%x plen %d", hdev->name, opcode, plen);
> +	BT_DBG("%s opcode 0x%04x plen %d", hdev->name, opcode, plen);

please use 0x%4.4x to be consistent with our cases.

Regards

Marcel


