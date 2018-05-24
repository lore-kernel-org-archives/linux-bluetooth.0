Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: RTL8723BS bluetooth almost working with serdev enumeration, need
 help
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <208ad44f-ade6-5f27-47f1-7fe012be1bdc@redhat.com>
Date: Thu, 24 May 2018 09:36:41 +0200
Cc: Jeremy Cline <jcline@redhat.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        linux-acpi <linux-acpi@vger.kernel.org>
Message-Id: <7736C9F3-F500-45F6-B4C3-17337D3B7FD2@holtmann.org>
References: <208ad44f-ade6-5f27-47f1-7fe012be1bdc@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> The last 2 evenings I've been working on
> $subject, based on:
> 
> 1) The btrtl patches from Martin Blumenstingl; +
> 2) The bt3wire driver from Marcel Holtmann; +
> 3) ACPI serdev binding support for the bt3wire driver
>   by Jeremy Cline
> 
> See: https://github.com/jwrdegoede/linux-sunxi/commits/master
> for the code, although there is not much to
> see there really.
> 
> I have this almost working, the problem I have
> is really weird.
> 
> If I start up a tablet with a RTL8723BS wifi
> chip and then log in using a bluetooth keyboard
> everything works.
> 
> But if I log in with an USB keyboard, then I get
> the following messages, first in journal we see
> pulseaudio doing some setup to support bluetooth
> audio (it seems to do this as soon as I login):
> 
> Bluetoothd[1282]: Endpoint registered: sender=:1.51 path=/MediaEndpoint/A2DPSource
> Bluetoothd[1282]: Endpoint registered: sender=:1.51 path=/MediaEndpoint/A2DPSink
> 
> And then 2 seconds later I get:
> 
> [  191.177256] Bluetooth: hci0: command 0x0c24 tx timeout
> [  191.179538] Bluetooth: hci0: Acknowledgement packet
> [  193.226082] Bluetooth: hci0: command 0x0c52 tx timeout
> 
> And if I press a key on the bluetooth keyboard after this:
> 
> [ 1739.156758] Bluetooth: hci0: Acknowledgement packet
> [ 1741.182473] Bluetooth: hci0: command 0x0409 tx timeout
> 
> Unloading and reloading the bt3wire module fixes this. Note
> that the bt controller sends Acknowledgement packets instead
> of a regular reply it seems, at least after the initial
> timeout.
> 
> If I hack the kernel to not do serdev enumeration for the uart
> so I get a /dev/ttyS4 and then use:
> 
> https://github.com/lwfinger/rtl8723bs_bt
> 
> I do not get this problem.

you might want to compare what conf packet the hciattach_rtk code is sending. I have seen the Broadcom one send also different ones. I would attempt to duplicate what they did and check what is happening. Also I might have a bug in my sliding window accounting. I have seen these timeouts with Broadcom as well, but was never able to track it down. Maybe some TX packet processing is stalled.

> It almost is as if after we've initialized the bt controller
> through bt3wire.c it is in a sleep state or something
> and the bt keyboard sending data first wakes it up...?
> 
> One thing which I found is that the hciattach_rtk.c
> userspace code sends an ack to the controller after
> it completes uploading the firmware. I tried to
> duplicate this like this:
> 
> --- a/drivers/bluetooth/bt3wire.c
> +++ b/drivers/bluetooth/bt3wire.c
> 
> @@ -788,6 +808,9 @@ static int bt3wire_btrtl_setup(struct bt3wire_dev *bdev)
> 
>        err = btrtl_download_firmware(bdev->hdev, btrtl_dev);
> 
> +       bt3wire_queue_pkt(bdev, PKT_TYPE_ACK, NULL, 0);
> +       bt3wire_tx_wakeup(bdev);
> +
> out_free:
>        btrtl_free(btrtl_dev);
> 
> 
> But I believe that is not the right way, I think that instead I should
> __hci_cmd_sync() but it is not entirely clear to me what I need to
> pass to that function to get the equivalent of bt3wire_queue_pkt(bdev, PKT_TYPE_ACK, NULL, 0);

If this is just an out-of-order ACK or is this one that should be send to acknowledge an event that comes after the firmware download. The PKT_TYPE_ACK is a HCI transport detail and thus has nothing to do with HCI commands send via __hci_cmd_sync.

H:4 (UART) and H:5 (3-Wire UART) and H:2 (USB) are just transports for HCI. The extra headers or sync packets is their problem. This is hidden from the Bluetooth core that can send HCI commands, events etc.

Can you include the btmon part here. We might need to compare on what HCI events the firmware download causes. It could be well that there should be just a sleep so that the 3-Wire transport can settle and we cause an ACK to send. My code is rather simplistic when it goes for an ACK vs just the next TX packet acking the previous received one. Maybe that is also racy.

Regards

Marcel

