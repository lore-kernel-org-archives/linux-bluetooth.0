Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 5/6] Bluetooth: Add LE connection parameters to debugfs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1376089954-13639-6-git-send-email-andre.guedes@openbossa.org>
Date: Sat, 10 Aug 2013 09:10:56 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Message-Id: <228F27B6-D28E-4377-8C83-81D59E3EF924@holtmann.org>
References: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org> <1376089954-13639-6-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> 
> Only reading the parameters is supported for now.

don't come me with this short kernel commits. Write a proper explanation on what you are doing here and why.

> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
> net/bluetooth/hci_sysfs.c | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
> 
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 17ebc4a..5993150 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -603,6 +603,35 @@ static const struct file_operations discovery_parameters_fops = {
> 	.release	= single_release,
> };
> 
> +static int le_conn_parameters_show(struct seq_file *f, void *p)
> +{
> +	struct hci_dev *hdev = f->private;
> +	struct le_conn_params *params = &hdev->le_conn_params;
> +
> +	hci_dev_lock(hdev);
> +
> +	seq_printf(f, "0x%.4x 0x%.4x 0x%.4x 0x%.4x 0x%.4x\n",
> +		   params->scan_interval, params->scan_window,
> +		   params->conn_interval_min, params->conn_interval_max,
> +		   params->supervision_timeout);
> +
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}
> +
> +static int le_conn_parameters_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, le_conn_parameters_show, inode->i_private);
> +}
> +
> +static const struct file_operations le_conn_parameters_fops = {
> +	.open		= le_conn_parameters_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> void hci_init_sysfs(struct hci_dev *hdev)
> {
> 	struct device *dev = &hdev->dev;
> @@ -647,6 +676,10 @@ int hci_add_sysfs(struct hci_dev *hdev)
> 
> 	debugfs_create_file("discovery_parameters", 0644, hdev->debugfs, hdev,
> 			    &discovery_parameters_fops);
> +
> +	debugfs_create_file("le_conn_parameters", 0644, hdev->debugfs, hdev,
> +			    &le_conn_parameters_fops);
> +
> 	return 0;
> }

What is the point exactly of exposing this if you are BR/EDR only controller?

Regards

Marcel

