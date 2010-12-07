Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 15:27:13 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 5/9] Bluetooth: Add support for using the crypto
 subsystem
Message-ID: <20101207172713.GF2944@vigoh>
References: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
 <1291671832-13435-6-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291671832-13435-6-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2010-12-06 18:43:48 -0300]:

> This will allow using the crypto subsystem for encrypting data. As SMP
> (Security Manager Protocol) is implemented almost entirely on the host
> side and the crypto module already implements the needed methods
> (AES-128), it makes sense to use it.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_core.c         |   10 ++++++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0687e2f..d0a9f5d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -135,6 +135,8 @@ struct hci_dev {
>  	__u32			req_status;
>  	__u32			req_result;
>  
> +	struct crypto_blkcipher	*tfm;
> +
>  	struct inquiry_cache	inq_cache;
>  	struct hci_conn_hash	conn_hash;
>  	struct list_head	blacklist;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 12c6735..b96c3dd 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -41,6 +41,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/notifier.h>
>  #include <linux/rfkill.h>
> +#include <linux/crypto.h>
>  #include <net/sock.h>
>  
>  #include <asm/system.h>
> @@ -961,6 +962,13 @@ int hci_register_dev(struct hci_dev *hdev)
>  	if (!hdev->workqueue)
>  		goto nomem;
>  
> +	hdev->tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
> +	if (IS_ERR(hdev->tfm)) {
> +		BT_ERR("Failed to load transform for ecb(aes): %ld",
> +							PTR_ERR(hdev->tfm));
> +		goto nomem;

You are leaking hdev->workqueue here.

Also you will need to add CRYPTO_BLKCIPHER dependence in the Kconfig.
Maybe we should add a CONFIG_BLUETOOTH_SMP, and just build with blkcipher
in the case SMP was selected to be built.

-- 
Gustavo F. Padovan
http://profusion.mobi
