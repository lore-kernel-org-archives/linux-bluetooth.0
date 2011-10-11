Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111010184442.GA6936@joana>
References: <1318078729-4158-1-git-send-email-dh.herrmann@googlemail.com>
	<20111010184442.GA6936@joana>
Date: Tue, 11 Oct 2011 14:35:01 +0200
Message-ID: <CANq1E4S2gngG9CfFSxHUsefA2HTij0-ToGDGjDx1eyOOzLYxRw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: Fix hci core device initialization
From: David Herrmann <dh.herrmann@googlemail.com>
To: David Herrmann <dh.herrmann@googlemail.com>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo

On Mon, Oct 10, 2011 at 8:44 PM, Gustavo Padovan <padovan@profusion.mobi> w=
rote:
> Hi David,
>
> * David Herrmann <dh.herrmann@googlemail.com> [2011-10-08 14:58:47 +0200]=
:
>
>> We must not call device_del() if we didn't use device_add(). See module.=
c for
>> comments on that. Therefore, we need to call device_initialize() when al=
locating
>> the hci device and later device_add() instead of device_register().
>>
>> This also fixes a bug when hci_register_dev() failed and we call hci_fre=
e_dev()
>> without a valid core device. hci_free_dev() segfaults while calling put_=
device()
>> on invalid memory.
>
> Please let me know if the following diff also fixes this problem.
> It seems to fixes other issues like failing in usb_driver_claim_interface=
().

Could you elaborate more? I what way does may patch not fix this issue?

> =A0 =A0 =A0 =A0Gustavo
>
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b84458d..ac446a7 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -922,9 +922,6 @@ EXPORT_SYMBOL(hci_alloc_dev);
> =A0void hci_free_dev(struct hci_dev *hdev)
> =A0{
> =A0 =A0 =A0 =A0skb_queue_purge(&hdev->driver_init);
> -
> - =A0 =A0 =A0 /* will free via device release */
> - =A0 =A0 =A0 put_device(&hdev->dev);

This does not work. We need to drop a reference here, otherwise this
function is totally useless except cleaning up the skb queue. In fact,
this function will be called on an HCI device without having a
reference.

> =A0}
> =A0EXPORT_SYMBOL(hci_free_dev);
>
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 22f1a6c..1e5ccde 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -587,7 +587,7 @@ void hci_unregister_sysfs(struct hci_dev *hdev)
>
> =A0 =A0 =A0 =A0debugfs_remove_recursive(hdev->debugfs);
>
> - =A0 =A0 =A0 device_del(&hdev->dev);
> + =A0 =A0 =A0 device_unregister(&hdev->dev);

This drops the last reference in most cases and hence "hdev" will get
deleted here and the caller (hci_unregister_dev) will fail cleaning up
the device.
The problem is, we actually have two reference counts. The
device_get/device_put reference count (which actually cleans up the
hdev device with kfree() when dropping the last reference) and the
hdev->refcnt which is in charge of cleaning up the caller's data. We
need to take a reference with device_get() in hci_alloc_dev and drop
it in hci_free_dev, otherwise we have inconsistent behaviour.

> =A0}
>
> =A0int __init bt_sysfs_init(void)
>
>

Regards
David
