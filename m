Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1237911625-20893-1-git-send-email-npelly@google.com>
References: <1237911625-20893-1-git-send-email-npelly@google.com>
Date: Tue, 24 Mar 2009 09:22:12 -0700
Message-ID: <35c90d960903240922y2f956ccnd4f1c81092235fa@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fallback from eSCO to SCO on error code 0x1f
	(unspecified error).
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here is the hcidump that prompted this patch:

009-03-23 17:43:50.727376 < HCI Command: Setup Synchronous Connection
(0x01|0x0028) plen 17
  handle 1 voice setting 0x0060
2009-03-23 17:43:50.746969 > HCI Event: Command Status (0x0f) plen 4
  Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
2009-03-23 17:43:50.909963 > HCI Event: Synchronous Connect Complete
(0x2c) plen 17
  status 0x1f handle 257 bdaddr 00:14:0A:01:E1:67 type eSCO
  Error: Unspecified Error

I have confirmed that with this patch we successfully fall back to SCO
with the Kyocera ED-8800


On Tue, Mar 24, 2009 at 9:20 AM, Nick Pelly <npelly@google.com> wrote:
> Kyocera ED-8800 headset returns this error code when eSCO is attempted.
>
> Signed-off-by: Nick Pelly <npelly@google.com>
> ---
>  net/bluetooth/hci_event.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 5553424..42cb717 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1646,7 +1646,8 @@ static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_bu
>                conn->type = SCO_LINK;
>        }
>
> -       if (conn->out && ev->status == 0x1c && conn->attempt < 2) {
> +       if (conn->out && (ev->status == 0x1c || ev->status == 0x1f) &&
> +                       conn->attempt < 2) {
>                conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
>                                        (hdev->esco_type & EDR_ESCO_MASK);
>                hci_setup_sync(conn, conn->link->handle);
> --
> 1.5.5
>
>
