Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1381907811-33872-3-git-send-email-marcel@holtmann.org>
References: <1381907811-33872-3-git-send-email-marcel@holtmann.org>
Date: Wed, 16 Oct 2013 08:10:49 -0400
Message-ID: <CAJdJm_NtG8XyMYFL5DbiAiuwN=-kf-WFzckiiY_7uSpowTGKYA@mail.gmail.com>
Subject: Re: [PATCH 3/6] Bluetooth: Set the scan response data when needed
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 16, 2013 at 3:16 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> +static void update_scan_rsp_data(struct hci_request *req)
> +{
> +       struct hci_dev *hdev = req->hdev;
> +       struct hci_cp_le_set_scan_rsp_data cp;
> +       u8 len;
> +
> +       if (!lmp_le_capable(hdev))
> +               return;
> +
> +       memset(&cp, 0, sizeof(cp));
> +
> +       len = create_scan_rsp_data(hdev, cp.data);
> +
> +       if (hdev->adv_data_len == len &&
> +           memcmp(cp.data, hdev->adv_data, len) == 0)
> +               return;
> +
> +       memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> +       hdev->adv_data_len = len;

Shouldn't you be using hdev->scan_rsp_data/scan_rsp_data_len here?

(I still haven't read the later patches, so this may already be fixed.)

> +
> +       cp.length = len;
> +
> +       hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
> +}

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
