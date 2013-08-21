Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <228F27B6-D28E-4377-8C83-81D59E3EF924@holtmann.org>
References: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
	<1376089954-13639-6-git-send-email-andre.guedes@openbossa.org>
	<228F27B6-D28E-4377-8C83-81D59E3EF924@holtmann.org>
Date: Wed, 21 Aug 2013 17:41:36 -0300
Message-ID: <CACJA=fX5CY7R7cH3b+J3C1er9MYD7H-OUduUXqxX7ZV_oHA90w@mail.gmail.com>
Subject: Re: [PATCH 5/6] Bluetooth: Add LE connection parameters to debugfs
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Aug 10, 2013 at 1:10 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
>>
>> Only reading the parameters is supported for now.
>
> don't come me with this short kernel commits. Write a proper explanation on what you are doing here and why.

According to what we discussed in the anterior patch, I'll completely
rework this one and write a proper explanation here.

>>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
>> ---
>> net/bluetooth/hci_sysfs.c | 33 +++++++++++++++++++++++++++++++++
>> 1 file changed, 33 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
>> index 17ebc4a..5993150 100644
>> --- a/net/bluetooth/hci_sysfs.c
>> +++ b/net/bluetooth/hci_sysfs.c
>> @@ -603,6 +603,35 @@ static const struct file_operations discovery_parameters_fops = {
>>       .release        = single_release,
>> };
>>
>> +static int le_conn_parameters_show(struct seq_file *f, void *p)
>> +{
>> +     struct hci_dev *hdev = f->private;
>> +     struct le_conn_params *params = &hdev->le_conn_params;
>> +
>> +     hci_dev_lock(hdev);
>> +
>> +     seq_printf(f, "0x%.4x 0x%.4x 0x%.4x 0x%.4x 0x%.4x\n",
>> +                params->scan_interval, params->scan_window,
>> +                params->conn_interval_min, params->conn_interval_max,
>> +                params->supervision_timeout);
>> +
>> +     hci_dev_unlock(hdev);
>> +
>> +     return 0;
>> +}
>> +
>> +static int le_conn_parameters_open(struct inode *inode, struct file *file)
>> +{
>> +     return single_open(file, le_conn_parameters_show, inode->i_private);
>> +}
>> +
>> +static const struct file_operations le_conn_parameters_fops = {
>> +     .open           = le_conn_parameters_open,
>> +     .read           = seq_read,
>> +     .llseek         = seq_lseek,
>> +     .release        = single_release,
>> +};
>> +
>> void hci_init_sysfs(struct hci_dev *hdev)
>> {
>>       struct device *dev = &hdev->dev;
>> @@ -647,6 +676,10 @@ int hci_add_sysfs(struct hci_dev *hdev)
>>
>>       debugfs_create_file("discovery_parameters", 0644, hdev->debugfs, hdev,
>>                           &discovery_parameters_fops);
>> +
>> +     debugfs_create_file("le_conn_parameters", 0644, hdev->debugfs, hdev,
>> +                         &le_conn_parameters_fops);
>> +
>>       return 0;
>> }
>
> What is the point exactly of exposing this if you are BR/EDR only controller?

Yeah, there is no point. This will be fixed in v2.

BR,

Andre
