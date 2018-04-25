Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <B39D4D6F-96FB-442E-84D8-BEA603E7A053@holtmann.org>
References: <1524506380-7417-1-git-send-email-loic.poulain@linaro.org>
 <1524506380-7417-2-git-send-email-loic.poulain@linaro.org> <B39D4D6F-96FB-442E-84D8-BEA603E7A053@holtmann.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Wed, 25 Apr 2018 09:58:47 +0200
Message-ID: <CAMZdPi8ABhv8EDaE+afFpHexuMKjst5djiMt4HFoGqPNHs+akQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: btqca: Add AR3002 rampatch support
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	kkapra@codeaurora.org, bgodavar@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

+Balakrishna Godavarthi, I've just seen that his recent patch for
wcn3990 support deals with the same download issue.

On 24 April 2018 at 17:13, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Loic,
>
>> This patch adds rampatch download compatibility for ROME >= 3.2.
>> Starting with ROME 3.2, the 'download mode' field of the rampatch
>> header indicates if the controller acknowledges (or not) the received
>> rampatch segments. If not, we need to send all the segments without
>> expecting any event from the controller (except for the last segment).
>> Goal is (I assume) to speed-up rampatch download.
>
> WHYYYYYYYYYY ???
>
> I have done the measurement with the Intel chips and it is insignificant on Linux. The Linux USB subsystem is a lot better than the one from Windows.

To be honest, I have no much information (so maybe Windows
optimization is the point), I mainly extracted info from a Yocto
hciattach patch:
https://github.com/boundarydevices/meta-boundary/blob/krogoth/recipes-connectivity/bluez5/bluez5/0001-hciattach-add-QCA9377-Tuffello-support.patch

My module version use HCI UART as transport layer.


> Is there any chance we can just switch this back on and keep waiting for the event?

I tried to change the fw/rampatch header on  the fly to 'standard
download mode' before starting flashing.
It seems to be supported since pretty all segments are correctly sent
and acked by the vendor event.
However the last segment is nacked:

    Bluetooth: hci0: TLV with error stat 0x0 rtype 0x4 (0x3)

I suppose the rampatch contains a checksum which is verified once
download is complete, hacking the header would cause a corruption of
the rampatch, leading to this NACK.
So in theory, the download behavior seems to depend only on the
rampatch file(header) and is not hard-coded on controller side.

Since rampatchs are not under our control, I think it's good to
support this download mode anyway.

Regards,
Loic
