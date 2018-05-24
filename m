Return-Path: <j.w.r.degoede@gmail.com>
Subject: Re: RTL8723BS bluetooth almost working with serdev enumeration, need
 help
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jeremy Cline <jcline@redhat.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>,
 linux-serial@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>
References: <208ad44f-ade6-5f27-47f1-7fe012be1bdc@redhat.com>
 <7736C9F3-F500-45F6-B4C3-17337D3B7FD2@holtmann.org>
From: Hans de Goede <j.w.r.degoede@gmail.com>
Message-ID: <e44fead0-b17e-f20a-f001-d132017c27f6@gmail.com>
Date: Thu, 24 May 2018 22:22:45 +0200
MIME-Version: 1.0
In-Reply-To: <7736C9F3-F500-45F6-B4C3-17337D3B7FD2@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 24-05-18 09:36, Marcel Holtmann wrote:
> Hi Hans,
> 
>> The last 2 evenings I've been working on
>> $subject, based on:
>>
>> 1) The btrtl patches from Martin Blumenstingl; +
>> 2) The bt3wire driver from Marcel Holtmann; +
>> 3) ACPI serdev binding support for the bt3wire driver
>>    by Jeremy Cline
>>
>> See: https://github.com/jwrdegoede/linux-sunxi/commits/master
>> for the code, although there is not much to
>> see there really.
>>
>> I have this almost working, the problem I have
>> is really weird.
>>
>> If I start up a tablet with a RTL8723BS wifi
>> chip and then log in using a bluetooth keyboard
>> everything works.
>>
>> But if I log in with an USB keyboard, then I get
>> the following messages, first in journal we see
>> pulseaudio doing some setup to support bluetooth
>> audio (it seems to do this as soon as I login):
>>
>> Bluetoothd[1282]: Endpoint registered: sender=:1.51 path=/MediaEndpoint/A2DPSource
>> Bluetoothd[1282]: Endpoint registered: sender=:1.51 path=/MediaEndpoint/A2DPSink
>>
>> And then 2 seconds later I get:
>>
>> [  191.177256] Bluetooth: hci0: command 0x0c24 tx timeout
>> [  191.179538] Bluetooth: hci0: Acknowledgement packet
>> [  193.226082] Bluetooth: hci0: command 0x0c52 tx timeout
>>
>> And if I press a key on the bluetooth keyboard after this:
>>
>> [ 1739.156758] Bluetooth: hci0: Acknowledgement packet
>> [ 1741.182473] Bluetooth: hci0: command 0x0409 tx timeout
>>
>> Unloading and reloading the bt3wire module fixes this. Note
>> that the bt controller sends Acknowledgement packets instead
>> of a regular reply it seems, at least after the initial
>> timeout.
>>
>> If I hack the kernel to not do serdev enumeration for the uart
>> so I get a /dev/ttyS4 and then use:
>>
>> https://github.com/lwfinger/rtl8723bs_bt
>>
>> I do not get this problem.
> 
> you might want to compare what conf packet the hciattach_rtk code is sending. I have seen the Broadcom one send also different ones. I would attempt to duplicate what they did and check what is happening. Also I might have a bug in my sliding window accounting. I have seen these timeouts with Broadcom as well, but was never able to track it down. Maybe some TX packet processing is stalled.
> 
>> It almost is as if after we've initialized the bt controller
>> through bt3wire.c it is in a sleep state or something
>> and the bt keyboard sending data first wakes it up...?
>>
>> One thing which I found is that the hciattach_rtk.c
>> userspace code sends an ack to the controller after
>> it completes uploading the firmware. I tried to
>> duplicate this like this:
>>
>> --- a/drivers/bluetooth/bt3wire.c
>> +++ b/drivers/bluetooth/bt3wire.c
>>
>> @@ -788,6 +808,9 @@ static int bt3wire_btrtl_setup(struct bt3wire_dev *bdev)
>>
>>         err = btrtl_download_firmware(bdev->hdev, btrtl_dev);
>>
>> +       bt3wire_queue_pkt(bdev, PKT_TYPE_ACK, NULL, 0);
>> +       bt3wire_tx_wakeup(bdev);
>> +
>> out_free:
>>         btrtl_free(btrtl_dev);
>>
>>
>> But I believe that is not the right way, I think that instead I should
>> __hci_cmd_sync() but it is not entirely clear to me what I need to
>> pass to that function to get the equivalent of bt3wire_queue_pkt(bdev, PKT_TYPE_ACK, NULL, 0);
> 
> If this is just an out-of-order ACK or is this one that should be send to acknowledge an event that comes after the firmware download. The PKT_TYPE_ACK is a HCI transport detail and thus has nothing to do with HCI commands send via __hci_cmd_sync.
> 
> H:4 (UART) and H:5 (3-Wire UART) and H:2 (USB) are just transports for HCI. The extra headers or sync packets is their problem. This is hidden from the Bluetooth core that can send HCI commands, events etc.
> 
> Can you include the btmon part here. We might need to compare on what HCI events the firmware download causes. It could be well that there should be just a sleep so that the 3-Wire transport can settle and we cause an ACK to send. My code is rather simplistic when it goes for an ACK vs just the next TX packet acking the previous received one. Maybe that is also racy.

Ok so your "sliding window accounting" remark seems to
be right on the spot. Comparing the bt3wire.c and
hci_h5.c code I noticed that bt3wire.c does not
seem to do much of flow control if any at all.

The hci_h5 dequeue code to get packets to transmit only
returns a packet if:

         if (h5->unack.qlen >= h5->tx_win)
                 goto unlock;

Does not trigger.

Perhaps Jeremy somehow ended up picking up an old
version ?  (I'm building on top of this work) here is
what I've been using:

https://github.com/jwrdegoede/linux-sunxi/commit/eda8af7264490a2491f65a559bc9e88494a8ee19


I noticed the following statement in hci_h5.c:

        BT_DBG("hu %p retransmitting %u pkts", hu, h5->unack.qlen);

So on a hunch I changed that to a dev_warn, and it triggers
in the scenario where bt3wire is not working. Which is
weird because AFAICT that means the controller actually
dropped a packet, even though we are doing flow-control,
which is a bit unexpected, so maybe the flow control is
not the (only?) problem and we also need to add retry
logic to resend unacked packets like hci_h5.c has...


It seems that the H5 protocol / code is a bit complicated
and somewhat tricky / finicky to get right, so I'm not
sure doing a second implementation is a good idea.

I know that now that we've serdev enumeration you eventually
want to get rid of the hci_uart man in the middle and
bt3wire.c is moving in that direction.

But IMHO since this is tricky code I do believe that
adding serdev support to hci_h5.c (which we won't be
able to remove for a while) is if not better certainly
easier (and uses well tested code). So I gave this a shot:

https://github.com/jwrdegoede/linux-sunxi/commit/e71884d8f7ffd75fbe7bd381c26d64b7a13bd361

As you can see adding basic serdev support takes only
40 lines and it works well.

I know this is not the direction you want to go in
but I believe that this is the right way for now,
rather then doing 2 implementations.

I know the hci_bcm code is a mess but that is because
of historic reasons with the ACPI integration being
in place while using hciattach from userspace. As
you can see the hci_h5.c serdev integration is
quite clean and only needs a tiny amount of code.

We of-course also need to add vendor specific init
to load the firmware, etc. to hci_h5.c for this to
work, but that is no different then using bt3wire.c
where we need the same.

I actually ended up porting Jeremy's patches to add
vendor specific init to bt3wire.c pretty much 1:1 to
hci_h5.c and now I have a setup which works, see:

https://github.com/jwrdegoede/linux-sunxi/commits/master

This is currently lacking GPIO support, so it won't work
unless you poke the enable and device-wake GPIOs through
sysfs. I plan to add GPIO support tomorrow, run some more
tests and then post this series upstream.

Regards,

Hans
