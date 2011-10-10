Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 10 Oct 2011 15:44:42 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH 1/3] Bluetooth: Fix hci core device initialization
Message-ID: <20111010184442.GA6936@joana>
References: <1318078729-4158-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318078729-4158-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-10-08 14:58:47 +0200]:

> We must not call device_del() if we didn't use device_add(). See module.c for
> comments on that. Therefore, we need to call device_initialize() when allocating
> the hci device and later device_add() instead of device_register().
> 
> This also fixes a bug when hci_register_dev() failed and we call hci_free_dev()
> without a valid core device. hci_free_dev() segfaults while calling put_device()
> on invalid memory.

Please let me know if the following diff also fixes this problem.
It seems to fixes other issues like failing in usb_driver_claim_interface().

	Gustavo


diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b84458d..ac446a7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -922,9 +922,6 @@ EXPORT_SYMBOL(hci_alloc_dev);
 void hci_free_dev(struct hci_dev *hdev)
 {
        skb_queue_purge(&hdev->driver_init);
-
-       /* will free via device release */
-       put_device(&hdev->dev);
 }
 EXPORT_SYMBOL(hci_free_dev);
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 22f1a6c..1e5ccde 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -587,7 +587,7 @@ void hci_unregister_sysfs(struct hci_dev *hdev)
 
        debugfs_remove_recursive(hdev->debugfs);
 
-       device_del(&hdev->dev);
+       device_unregister(&hdev->dev);
 }
 
 int __init bt_sysfs_init(void)
