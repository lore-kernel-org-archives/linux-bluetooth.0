Return-Path: <cyrus@holtmann.org>
Message-ID: <1327963561.1955.195.camel@aeonflux>
Subject: Re: [PATCH 5/8] Bluetooth: Add MGMT handlers for dealing with SMP
 LTK's
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 14:46:01 -0800
In-Reply-To: <1327962558-25720-6-git-send-email-vinicius.gomes@openbossa.org>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1327962558-25720-6-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> This adds a method to notify that a new LTK is available and
> a handler to store keys coming from userspace into the kernel LTK
> list.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 +
>  net/bluetooth/mgmt.c             |   82 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index ae3f653..9e415dc 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -994,6 +994,8 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
>  int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  
> +int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
> +
>  /* HCI info for socket */
>  #define hci_pi(sk) ((struct hci_pinfo *) sk)
>  
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 8970799..57aa716 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2181,6 +2181,62 @@ done:
>  	return err;
>  }
>  
> +static int load_long_term_keys(struct sock *sk, u16 index,
> +					unsigned char *data, u16 len)
> +{
> +	struct hci_dev *hdev;
> +	struct mgmt_cp_load_long_term_keys *cp;
> +	u16 key_count, expected_len;
> +	int i;
> +
> +	cp = (void *) data;

can we get rid of this nasty casting by using proper void pointers in
the first place instead of unsigned char?

Regards

Marcel


