Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369724867-31011-1-git-send-email-johan.hedberg@gmail.com>
References: <1369724867-31011-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 May 2013 06:55:16 -0400
Message-ID: <CAJdJm_Mwp_xGNVPtV-ntbUtfZj63kuzcAPYy1yTHTATWofAqZA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix mgmt handling of power on failures
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, May 28, 2013 at 3:07 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> +int mgmt_set_powered_failed(struct hci_dev *hdev, int err)
> +{
> +       struct pending_cmd *cmd;
> +
> +       cmd = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
> +       if (!cmd)
> +               return -ENOENT;
> +
> +       err = cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_POWERED,
> +                        MGMT_STATUS_FAILED);
> +
> +       mgmt_pending_remove(cmd);
> +
> +       return err;
> +}
> +

Was the "err" parameter value supposed to be used on this function?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
