Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        johan.hedberg@gmail.com, marcel@holtmann.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180823112935.17342-2-bgodavar@codeaurora.org>
Cc: mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
References: <20180823112935.17342-1-bgodavar@codeaurora.org>
 <20180823112935.17342-2-bgodavar@codeaurora.org>
Message-ID: <153509324560.28926.8058929411568681471@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v1 1/1] Bluetooth: hci_qca: Add poweroff support during hci down
 for wcn3990
Date: Thu, 23 Aug 2018 23:47:25 -0700
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Quoting Balakrishna Godavarthi (2018-08-23 04:29:35)
> This patch enables power off support for hci down and power on support
> for hci up. As wcn3990 power sources are ignited by regulators, we will
> turn off them during hci down, i.e. an complete power off of wcn3990.
> So while hci up, we will call vendor specific open/close and setup which
> will turn on the regulators, requests BT chip version and download the
> firmware.
> =

> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> =

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e182f6019f68..98d33c6b8909 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -595,6 +595,9 @@ static int qca_close(struct hci_uart *hu)
>         struct qca_serdev *qcadev;
>         struct qca_data *qca =3D hu->priv;
>  =

> +       if (!qca)
> +               return 0;

Does this happen? If it does it seems like a failure in the caller to
know what's going on.
