Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: Fix missing HCI_RAW check when binding USER_CHANNEL socket
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442214864-30292-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Sep 2015 04:44:24 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EC024EB4-D49E-4833-82B9-CD4D0EFE4243@holtmann.org>
References: <1442214864-30292-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> HCI devices in RAW mode will have the HCI_UP flag set. The existing
> hci_sock_bind code, when invoked on a HCI_CHANNEL_USER socket, tests
> for this flag and will return EBUSY, making it impossible to bind any
> HCI device RAW mode. This patch adds an extra condition for the
> HCI_RAW flag to make it possible for bind() to succeed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_sock.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 150556345263..6588929b4d26 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -754,6 +754,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
> 		    hci_dev_test_flag(hdev, HCI_SETUP) ||
> 		    hci_dev_test_flag(hdev, HCI_CONFIG) ||
> 		    (!hci_dev_test_flag(hdev, HCI_AUTO_OFF) &&
> +		     !test_bit(HCI_RAW, &hdev->flags) &&
> 		     test_bit(HCI_UP, &hdev->flags))) {
> 			err = -EBUSY;
> 			hci_dev_put(hdev);

since we keep extending this single check into something that becomes really hard to understand why it is correct we need a large comment above explaining what we are doing and why that is correct.

Especially in conjunction with the HCI_RAW flag since that is an indication of user channel being active. You can no longer set it via an ioctl. Which means it has turned into special meaning.

This means I do not want to return EBUSY in case user channel is already active, I want to return EUSERS. I am not sure you have actually checked that this might no longer do the right thing. And I have the feeling we need a test case for that in userchan-tester.

Which means that this HCI_RAW check might need to be paired with the HCI_QUIRK_RAW_DEVICE to achieve the proper effect or we have to re-think the handling of HCI_QUIRK_RAW_DEVICE.

Regards

Marcel

