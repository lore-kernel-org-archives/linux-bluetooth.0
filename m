Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btusb: Disable autosuspend on QCA Rome devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180104085154.31377-1-hdegoede@redhat.com>
Date: Fri, 5 Jan 2018 15:31:45 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <FB7F6620-96C0-4539-B05D-96FA104CC166@holtmann.org>
References: <20180104085154.31377-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Commit fd865802c66b ("Bluetooth: btusb: fix QCA Rome suspend/resume") fixes
> a suspend/resume problem on QCA devices by doing a full reset on resume,
> reloading the firmware.
> 
> A similar problem happens when using runtime-pm / autosuspend, when this is
> enabled by the user the QCA Rome device stops working. Reloading the
> firmware after a runtime suspend is not really an option since the latency
> caused by this is unacceptable.
> 
> To fix the runtime-pm issues, this commit disables runtime-pm on QCA Rome
> HCIs, by getting (and not releasing) an usb autopm reference on the btusb
> interface.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 808c249845db..6ed3a0e5b8f6 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3122,8 +3122,15 @@ static int btusb_probe(struct usb_interface *intf,
> 		/* QCA Rome devices lose their updated firmware over suspend,
> 		 * but the USB hub doesn't notice any status change.
> 		 * Explicitly request a device reset on resume.
> +		 * And disable runtime pm by getting a pm reference, the USB
> +		 * core will drop our reference on disconnect.
> 		 */
> 		set_bit(BTUSB_RESET_RESUME, &data->flags);
> +		err = usb_autopm_get_interface(data->intf);
> +		if (err < 0) {
> +			BT_ERR("failed to get pm reference %d", err);
> +			goto out_free_dev;
> +		}
> 	}

is this still needed after commit 7d06d5895c159f6 that reverts this entry and adds a core USB quirk? See bluetooth-next tree for reference.

Regards

Marcel

