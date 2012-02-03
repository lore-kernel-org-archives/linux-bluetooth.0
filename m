Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1321992859-12473-3-git-send-email-andre.guedes@openbossa.org>
References: <1321992859-12473-1-git-send-email-andre.guedes@openbossa.org>
	<1321992859-12473-3-git-send-email-andre.guedes@openbossa.org>
Date: Fri, 3 Feb 2012 20:17:10 -0300
Message-ID: <CACJA=fXG1pfJc1EwTzXRdzF+5gUQUE+=5kaP5o7nm=Jnk1d4Xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Add BT_DBG to mgmt_discovering()
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Please consider applying this patch. It is really helpful during
discovery debugging.

On Tue, Nov 22, 2011 at 5:14 PM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index f615a5a..19503f9 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2680,6 +2680,8 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
>  {
>        struct pending_cmd *cmd;
>
> +       BT_DBG("%s discovering %u", hdev->name, discovering);
> +
>        if (discovering)
>                cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
>        else
> --
> 1.7.7.1
>

Andre
