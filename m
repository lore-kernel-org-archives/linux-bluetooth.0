Return-Path: <cyrus@holtmann.org>
Message-ID: <1328228410.2062.18.camel@aeonflux>
Subject: Re: [PATCH v2 1/7] Bluetooth: Fix doing some useless casts when
 receiving MGMT commands
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 02 Feb 2012 16:20:10 -0800
In-Reply-To: <1328227685-27245-2-git-send-email-vinicius.gomes@openbossa.org>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1328227685-27245-2-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> Every command handler of mgmt does a cast to the command structure
> so it can properly interpreted. So we can avoid that cast if we
> make those functions receive a void * directly.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |  210 +++++++++++++++++++++-----------------------------
>  1 files changed, 88 insertions(+), 122 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 00ab083..f8720de 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -611,15 +611,13 @@ static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
>  	return cmd_complete(sk, hdev->id, opcode, &settings, sizeof(settings));
>  }
>  
> -static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
> +static int set_powered(struct sock *sk, u16 index, void *cp_data, u16 len)
>  {
> -	struct mgmt_mode *cp;
> +	struct mgmt_mode *cp = cp_data;

why are we doing the rename to cp_data here. I rather keep this as
*data. Otherwise this is fine.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


