Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1288009280-5149-3-git-send-email-ville.tervo@nokia.com>
References: <1288009280-5149-1-git-send-email-ville.tervo@nokia.com>
	<1288009280-5149-3-git-send-email-ville.tervo@nokia.com>
Date: Mon, 25 Oct 2010 16:33:05 -0400
Message-ID: <AANLkTi=3VB-q-H6vcTAMAC1hYdYVJiF9wVOBKchYEktt@mail.gmail.com>
Subject: Re: [PATCH 2/6] Bluetooth: Add LE connect support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 25, 2010 at 8:21 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 0b1e460..0944c0c 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -45,6 +45,32 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>
> +void hci_le_connect(struct hci_conn *conn)

This function could be made static, right? (just noticed this now)

> +{
> +       struct hci_dev *hdev = conn->hdev;
> +       struct hci_cp_le_create_conn cp;
> +
> +       conn->state = BT_CONNECT;
> +       conn->out = 1;
> +
> +       memset(&cp, 0, sizeof(cp));
> +       cp.scan_interval = cpu_to_le16(0x0004);
> +       cp.scan_window = cpu_to_le16(0x0004);
> +       bacpy(&cp.peer_addr, &conn->dst);
> +       cp.conn_interval_min = cpu_to_le16(0x0008);
> +       cp.conn_interval_max = cpu_to_le16(0x0100);
> +       cp.supervision_timeout = cpu_to_le16(0x0064);
> +       cp.min_ce_len = cpu_to_le16(0x0001);
> +       cp.max_ce_len = cpu_to_le16(0x0001);
> +
> +       hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
> +}

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
