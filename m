Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F2159DC.4090408@babioch.de>
References: <4F204BDC.1010007@babioch.de>
	<CABBYNZJk+n2Rh4K2J_fc8A_WXjyBwck4qhYcfe6wCmK7vK7t-Q@mail.gmail.com>
	<4F2145AF.4050401@babioch.de>
	<4F2159DC.4090408@babioch.de>
Date: Thu, 26 Jan 2012 17:17:22 +0200
Message-ID: <CABBYNZJ09fo8X69Hqs+d_NiHmq9f2a1JHcSZnot4RXy0fk-u+g@mail.gmail.com>
Subject: Re: Changed default configuration in bluez 4.97 and higher?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Karol Babioch <karol@babioch.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karol,

On Thu, Jan 26, 2012 at 3:49 PM, Karol Babioch <karol@babioch.de> wrote:
> Hi,
>
> Am 26.01.2012 13:29, schrieb Luiz Augusto von Dentz:
>> do you have any logs when Socket is disabled?
>
> Jan 26 14:28:10 localhost bluetoothd[813]: Discovery session
> 0x7f5a22e73c50 with :1.41 activated
> Jan 26 14:28:13 localhost bluetoothd[813]: Stopping discovery
> Jan 26 14:28:24 localhost kernel: [  349.752870] input:
> 00:16:94:0B:XX:XX as /devices/virtual/input/input17
> Jan 26 14:28:24 localhost pulseaudio[1072]: [pulseaudio]
> module-bluetooth-device.c: Bluetooth audio service not available
> Jan 26 14:28:24 localhost pulseaudio[1072]: [pulseaudio]
> module-bluetooth-device.c: Service not connected
> Jan 26 14:28:24 localhost pulseaudio[1072]: [pulseaudio] module.c:
> Failed to load module "module-bluetooth-device" (argument:
> "address="00:16:94:0B:XX:XX"
> path="/org/bluez/813/hci0/dev_00_16_94_0B_XX_XX""): initialization failed.
>
> So you were right, it seems that PulseAudio is the culprit here. However
> it works with bluez-4.96, although sockets are not enabled explicitly?
> So the question stays whether bluez 4.96 uses sockets implicitly, or
> whether PulseAudio doesn't work with bluez-4.98.

4.96 uses Socket by default, now it seems from the logs that it did
not configure a transport for some reason, can you check if you get
anything on bluetoothd logs like this:

bluetoothd[17465]: Endpoint registered: sender=:1.250
path=/MediaEndpoint/A2DPSource

Btw, to enable debug logs just run bluetoothd with -d option

Regards

-- 
Luiz Augusto von Dentz
