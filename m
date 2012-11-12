Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Nov 2012 11:36:14 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 2/3] Bluetooth: Add LE connection parameters to debugfs
Message-ID: <20121112093613.GB10008@aemeltch-MOBL1>
References: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
 <1352121943-18001-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352121943-18001-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Nov 05, 2012 at 02:25:42PM +0100, Vinicius Costa Gomes wrote:
> Only reading the parameters is supported for now.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_sysfs.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 55cceee..a9554ec 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -532,6 +532,36 @@ static int auto_accept_delay_get(void *data, u64 *val)
>  DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
>  			auto_accept_delay_set, "%llu\n");
>  
> +
> +static int le_conn_parameters_show(struct seq_file *f, void *p)
> +{
> +	struct hci_dev *hdev = f->private;
> +	struct le_conn_params *params = &hdev->le_conn_params;
> +
> +	hci_dev_lock(hdev);
> +
> +	seq_printf(f, "0x%.4x 0x%.4x 0x%.4x 0x%.4x 0x%.4x\n",

BTW: you might want to use format "0x%4.4x" we use in hci_core.c

Best regards 
Andrei Emeltchenko 

