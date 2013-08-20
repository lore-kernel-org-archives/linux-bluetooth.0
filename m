Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1375298729-23513-1-git-send-email-andre.guedes@openbossa.org>
References: <1375298729-23513-1-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 20 Aug 2013 09:14:22 -0300
Message-ID: <CACJA=fVcg95b_nCk6s_OFSc3c=yQUCPcpYP9-J2RPa8zZpVO2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Fix security level for peripheral role
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

On Wed, Jul 31, 2013 at 4:25 PM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> While playing the peripheral role, the host gets a LE Long Term Key
> Request Event from the controller when a connection is established
> with a bonded device. The host then informs the LTK which should be
> used for the connection. Once the link is encrypted, the host gets
> an Encryption Change Event.
>
> Therefore we should set conn->pending_sec_level instead of conn->
> sec_level in hci_le_ltk_request_evt. This way, conn->sec_level is
> properly updated in hci_encrypt_change_evt.
>
> Moreover, since we have a LTK associated to the device, we have at
> least BT_SECURITY_MEDIUM security level.
>
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 50e39f4..ea993ab 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3556,7 +3556,9 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>         cp.handle = cpu_to_le16(conn->handle);
>
>         if (ltk->authenticated)
> -               conn->sec_level = BT_SECURITY_HIGH;
> +               conn->pending_sec_level = BT_SECURITY_HIGH;
> +       else
> +               conn->pending_sec_level = BT_SECURITY_MEDIUM;
>
>         hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
>
> --
> 1.8.3.4
>
