Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1360921920-14080-8-git-send-email-johan.hedberg@gmail.com>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
	<1360921920-14080-8-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 19 Feb 2013 16:36:01 -0300
Message-ID: <CACJA=fUaDvgD6Tiv3TOwehw4keavA+=prkZ_=L15e=mh7zyZWg@mail.gmail.com>
Subject: Re: [PATCH 07/12 v3] Bluetooth: Fix mgmt powered indication by using
 a HCI transaction
From: Andre Guedes <andre.guedes@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Feb 15, 2013 at 7:51 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> The response to mgmt_set_powered should be returned only when all
> related HCI commands have completed. To properly do this make use of a
> HCI transaction with a callback to indicate its completion.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   43 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 39395c7..042a6c7 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3058,19 +3058,33 @@ static int set_bredr_scan(struct hci_dev *hdev)
>         return hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
>  }
>
> +static void powered_complete(struct hci_dev *hdev, u16 opcode, int status)
> +{
> +       struct cmd_lookup match = { NULL, hdev };
> +
> +       mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
> +
> +       new_settings(hdev, match.sk);
> +
> +       if (match.sk)
> +               sock_put(match.sk);
> +}
> +
>  int mgmt_powered(struct hci_dev *hdev, u8 powered)
>  {
>         struct cmd_lookup match = { NULL, hdev };
> +       u8 status = MGMT_STATUS_NOT_POWERED;
> +       u8 zero_cod[] = { 0, 0, 0 };
>         int err;
>
>         if (!test_bit(HCI_MGMT, &hdev->dev_flags))
>                 return 0;
>
> -       mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
> -
>         if (powered) {
>                 u8 link_sec;
>
> +               hci_start_transaction(hdev);
> +

What if this hci_start_transaction returns error? For example, if we
have another transaction being built.

Regards,

Andre
