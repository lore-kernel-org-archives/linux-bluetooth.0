Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Add reset_resume function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433207682-15064-2-git-send-email-labbott@fedoraproject.org>
Date: Tue, 2 Jun 2015 03:32:05 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Takashi Iwai <tiwai@suse.de>, Oliver Neukum <oneukum@suse.com>,
	Ming Lei <ming.lei@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>
Message-Id: <C3A9A104-993C-4C8F-A323-93FF58F03162@holtmann.org>
References: <1433207682-15064-1-git-send-email-labbott@fedoraproject.org> <1433207682-15064-2-git-send-email-labbott@fedoraproject.org>
To: Laura Abbott <labbott@fedoraproject.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Laura,

> Some USB hubs may lose power across suspend/resume.
> Add a reset_resume callback to properly reset those bluetoot devices.
> 
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> ---
> Now the setup function is called again with the HCI_RESET_RESUME
> flag set. The various functions could then use that RESET_RESUME
> flag to determine if loading the firmware is appropriate or not.
> ---
> drivers/bluetooth/btusb.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3c10d4d..34884cf 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3382,6 +3382,21 @@ done:
> 
> 	return err;
> }
> +
> +static int btusb_reset_resume(struct usb_interface *intf)
> +{
> +	struct btusb_data *data = usb_get_intfdata(intf);
> +	struct hci_dev *hdev = data->hdev;
> +	int ret;
> +
> +	BT_DBG("intf %p", intf);
> +
> +	ret = btusb_resume(intf);
> +	if (ret)
> +		return ret;
> +
> +	return hci_reset_resume_dev(hdev);
> +}

it seems convenient to call btusb_resume, but I would really prefer if we didn’t. From what I know is that when reset_resume callback is called, then the device has been reset. So that means any prior transfer we have remembered is null and void. So even trying to replay any of it is just a lost cause.

Instead we should clear any pending transfers and clear everything and instead pretend that we bring the transport back to its virgin state. It also means that isochronous transfers should be all killed since we will have no SCO connections after this. Remember that we are telling the Bluetooth core to reset this device.

Regards

Marcel

