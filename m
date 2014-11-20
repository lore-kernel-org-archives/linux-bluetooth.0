Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Xinming Hu <huxm@marvell.com>, Cathy Luo
	<cluo@marvell.com>,
        Avinash Patil <patila@marvell.com>
Date: Thu, 20 Nov 2014 07:41:22 -0800
Subject: RE: [PATCH v2] Bluetooth: btmrvl add firmware dump support
Message-ID: <5FF020A1CFFEEC49BD1E09530C4FF5951821E916B6@SC-VEXCH1.marvell.com>
References: <1416478065-5678-1-git-send-email-akarwar@marvell.com>
 <56E9D4AD-8014-4261-BEE8-11A40C206A42@holtmann.org>
In-Reply-To: <56E9D4AD-8014-4261-BEE8-11A40C206A42@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for your review

>> +
>> +	ret =3D kstrtol(buf, 10, &result);
>> +	if (ret)
>> +		return ret;
>
>I wonder why not use strtobool and check for the result being true.
>

Sure. We will change this in updated version.

>> +
>> +	if (result)
>> +		btmrvl_firmware_dump(priv);
>> +
>> +	return count;
>> +}
>> +
>> +static const struct file_operations btmrvl_fwdump_fops =3D {
>> +	.write	=3D btmrvl_fwdump_write,
>> +	.open	=3D simple_open,
>> +	.llseek =3D default_llseek,
>> +};
>> +
>> void btmrvl_debugfs_init(struct hci_dev *hdev) {
>> 	struct btmrvl_private *priv =3D hci_get_drvdata(hdev); @@ -197,6
>+225,8
>> @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
>> 			    priv, &btmrvl_hscmd_fops);
>> 	debugfs_create_file("hscfgcmd", 0644, dbg->config_dir,
>> 			    priv, &btmrvl_hscfgcmd_fops);
>> +	debugfs_create_file("fw_dump", 0444, dbg->config_dir,
>> +			    priv, &btmrvl_fwdump_fops);
>
>Shouldn't this be 0200 actually? Since you can only write to it, right?
>

Right.

>> 	int (*hw_process_int_status) (struct btmrvl_private *priv);
>> +	void (*firmware_dump)(struct btmrvl_private *priv);
>
>While we can do this as a first step to get this merged, but I wonder if
>we might want to make this generic and just add a hdev->firmware_dump
>that drivers then can implement.
>
>We could actually add an option to Controller Configuration of the
>management interface and add a command to trigger the firmware dump.
>Something to think about. However just starting with a debugfs trigger
>via Bluetooth core might be a good idea no matter what. That why more
>drivers could start looking implementing this without having to
>duplicate the trigger.
>

Sounds good to me.

Regards,
Amitkumar
