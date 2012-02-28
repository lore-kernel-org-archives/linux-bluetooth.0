Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330386094-19501-1-git-send-email-johan.hedberg@gmail.com>
References: <1330386094-19501-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Feb 2012 14:31:04 -0300
Message-ID: <CACJA=fWCarASqDoKkSSU-QnrC2uvVnmncH44Cbjc9em44poE2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Don't send unnecessary write_le_enable command
From: Andre Guedes <andre.guedes@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Feb 27, 2012 at 8:41 PM,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> If the local host features indicate that LE is already in the state that
> is desired there's no point in sending the HCI command to try to change
> the setting.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 27830f4..5373bc1 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1260,7 +1260,7 @@ static int set_le(struct sock *sk, u16 index, void *data, u16 len)
>        struct pending_cmd *cmd;
>        struct hci_dev *hdev;
>        int err;
> -       u8 val;
> +       u8 val, enabled;
>
>        BT_DBG("request for hci%u", index);
>
> @@ -1280,8 +1280,9 @@ static int set_le(struct sock *sk, u16 index, void *data, u16 len)
>        }
>
>        val = !!cp->val;
> +       enabled = !!(hdev->host_features[0] & 0x02);

You may use lmp_host_le_capable macro here. There are other places
in patch 2/2 you may wanna change too.

BR,

Andre
