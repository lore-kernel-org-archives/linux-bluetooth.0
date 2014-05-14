Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1400064583-12623-3-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400064583-12623-1-git-send-email-andrzej.kaczmarek@tieto.com> <1400064583-12623-3-git-send-email-andrzej.kaczmarek@tieto.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Wed, 14 May 2014 13:30:54 +0200
Message-ID: <CAF3PWx3MDMQqGAsENRsfz07dbmeZYF5Uy+nWzybGpyQtM6Xy-Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] Bluetooth: Add support to get connection information
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Please ignore this set, some unnecessary #define is still present here
 - I'll send v5 in a moment.

On 14 May 2014 12:49, Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com> wrote:
> This patch adds support for Get Connection Information mgmt command
> which can be used to query for information about connection, i.e. RSSI
> and local TX power level.
>
> In general values cached in hci_conn are returned as long as they are
> considered valid, i.e. do not exceed age limit set in hdev. This limit
> is calculated as random value between min/max values to avoid client
> trying to guess when to poll for updated information.
>
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  include/net/bluetooth/hci_core.h |   2 +
>  include/net/bluetooth/mgmt.h     |  14 +++
>  net/bluetooth/mgmt.c             | 196 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 4623f45..cbbab63 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -384,6 +384,8 @@ struct hci_conn {
>         __s8            tx_power;
>         unsigned long   flags;
>
> +       unsigned long   conn_info_timestamp;
> +
>         __u8            remote_cap;
>         __u8            remote_auth;
>         __u8            remote_id;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index d4b571c..b74309a 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -409,6 +409,20 @@ struct mgmt_cp_load_irks {
>  } __packed;
>  #define MGMT_LOAD_IRKS_SIZE            2
>
> +#define MGMT_CONN_INFO_DATA_TX_POWER   0x00000001

This should be removed.

BR,
Andrzej
