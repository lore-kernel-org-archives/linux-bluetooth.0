Return-Path: <hdegoede@redhat.com>
To: Jeremy Cline <jcline@redhat.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Marcel Holtmann <marcel@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: RTL8723BS bluetooth almost working with serdev enumeration, need help
Cc: linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-acpi <linux-acpi@vger.kernel.org>
Message-ID: <208ad44f-ade6-5f27-47f1-7fe012be1bdc@redhat.com>
Date: Wed, 23 May 2018 23:04:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

The last 2 evenings I've been working on
$subject, based on:

1) The btrtl patches from Martin Blumenstingl; +
2) The bt3wire driver from Marcel Holtmann; +
3) ACPI serdev binding support for the bt3wire driver
    by Jeremy Cline

See: https://github.com/jwrdegoede/linux-sunxi/commits/master
for the code, although there is not much to
see there really.

I have this almost working, the problem I have
is really weird.

If I start up a tablet with a RTL8723BS wifi
chip and then log in using a bluetooth keyboard
everything works.

But if I log in with an USB keyboard, then I get
the following messages, first in journal we see
pulseaudio doing some setup to support bluetooth
audio (it seems to do this as soon as I login):

Bluetoothd[1282]: Endpoint registered: sender=:1.51 path=/MediaEndpoint/A2DPSource
Bluetoothd[1282]: Endpoint registered: sender=:1.51 path=/MediaEndpoint/A2DPSink

And then 2 seconds later I get:

[  191.177256] Bluetooth: hci0: command 0x0c24 tx timeout
[  191.179538] Bluetooth: hci0: Acknowledgement packet
[  193.226082] Bluetooth: hci0: command 0x0c52 tx timeout

And if I press a key on the bluetooth keyboard after this:

[ 1739.156758] Bluetooth: hci0: Acknowledgement packet
[ 1741.182473] Bluetooth: hci0: command 0x0409 tx timeout

Unloading and reloading the bt3wire module fixes this. Note
that the bt controller sends Acknowledgement packets instead
of a regular reply it seems, at least after the initial
timeout.

If I hack the kernel to not do serdev enumeration for the uart
so I get a /dev/ttyS4 and then use:

https://github.com/lwfinger/rtl8723bs_bt

I do not get this problem.

It almost is as if after we've initialized the bt controller
through bt3wire.c it is in a sleep state or something
and the bt keyboard sending data first wakes it up...?

One thing which I found is that the hciattach_rtk.c
userspace code sends an ack to the controller after
it completes uploading the firmware. I tried to
duplicate this like this:

--- a/drivers/bluetooth/bt3wire.c
+++ b/drivers/bluetooth/bt3wire.c

@@ -788,6 +808,9 @@ static int bt3wire_btrtl_setup(struct bt3wire_dev *bdev)

         err = btrtl_download_firmware(bdev->hdev, btrtl_dev);

+       bt3wire_queue_pkt(bdev, PKT_TYPE_ACK, NULL, 0);
+       bt3wire_tx_wakeup(bdev);
+
  out_free:
         btrtl_free(btrtl_dev);


But I believe that is not the right way, I think that instead I should
__hci_cmd_sync() but it is not entirely clear to me what I need to
pass to that function to get the equivalent of bt3wire_queue_pkt(bdev, PKT_TYPE_ACK, NULL, 0);

Regards,

Hans
