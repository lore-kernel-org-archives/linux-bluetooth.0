Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382191753-59287-3-git-send-email-marcel@holtmann.org>
References: <1382191753-59287-3-git-send-email-marcel@holtmann.org>
Date: Sat, 19 Oct 2013 13:07:20 -0400
Message-ID: <CAJdJm_NOH+P=uzoD4na6J3jwuPMrLcPNCx2r8bMXvKWNMg-=eQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: Expose debugfs settings for LE
 connection interval
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 19, 2013 at 10:09 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> +static int conn_min_interval_set(void *data, u64 val)
> +{
> +       struct hci_dev *hdev = data;
> +
> +       if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval)
> +               return -EINVAL;
> +
> +       hci_dev_lock(hdev);
> +       hdev->le_conn_min_interval= val;

Minor style issue: missing space before "=".

> +       hci_dev_unlock(hdev);
> +
> +       return 0;
> +}
> [snip]
> +static int conn_max_interval_set(void *data, u64 val)
> +{
> +       struct hci_dev *hdev = data;
> +
> +       if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval)
> +               return -EINVAL;
> +
> +       hci_dev_lock(hdev);
> +       hdev->le_conn_max_interval= val;

Same above.

> +       hci_dev_unlock(hdev);
> +
> +       return 0;
> +}

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
