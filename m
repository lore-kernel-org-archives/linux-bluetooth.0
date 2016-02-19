Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56C5F69E.6080207@prudentl.com>
References: <56C5F299.5080909@prudentl.com>
	<56C5F69E.6080207@prudentl.com>
Date: Fri, 19 Feb 2016 13:19:25 +0200
Message-ID: <CABBYNZJ=smBb3mjvidmx+0FNqx6OLHpt-jzOcCKuO91hxdg-VQ@mail.gmail.com>
Subject: Re: Bluez LE: Unable to get readings from LE devices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: ram <ram@prudentl.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 18, 2016 at 6:51 PM, ram <ram@prudentl.com> wrote:
> Hello,
>
> We are working on integrating a set of medical devices from TaiDoc using
> Bluez. These devices work very well on Android and iPhone. We can get it
> paired to a Linux machine successfully using our custom agent. However,
> after the first reading, our driver goes into a loop trying to retrieve the
> reading unsuccessfully.
>
> With release 5.37, the services and characteristics kept on loading and
> unloading. However, with the recent patches, btmon gives error asking for
> pin or key. The devices don't have any pin to authenticate. I'm attaching
> btmon and Bluez output. Would appreciate any feedback.
>
>> HCI Event: Encryption Change (0x08) plen 4 [hci0] 301.187517
>         Status: PIN or Key Missing (0x06)
>         Handle: 3585
>         Encryption: Disabled (0x00)

Usually this is cause when one of the sides remove the link key, some
controller may automatically attempt to repair but others don't so you
would have to remove the link keys of respective devices in both sides
and try again. Btw, the following indicate that it was actually
possible to connect at some point:

bluetoothd[6591]: profiles/gap/gas.c:read_device_name_cb() GAP Device
Name: TAIDOC TD3128
bluetoothd[6591]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0381

Perhaps you device does not really store the link keys persistently,
so whenever bluetoothd detects there is actually a LTK it will attempt
to use it:

bluetoothd[6591]: src/gatt-database.c:connect_cb() New incoming LE ATT
connection
bluetoothd[6591]: src/device.c:device_attach_att() Elevating security
level since LTK is available

Which seems to cause a missing link key, it may happen to work with
iOS and Android because they reattempt to pair but there exists an
option to tell the remote peer to not reuse the link keys across
connections you just need to use the no bonding value as per spec:

'No bonding' is used when the device is performing a
Secure Simple Pairing procedure, but does not intend to retain the link key
after the physical link is disconnected.

I would keep the policy of not redoing the pairing automatically in
case of missing link key error but perhaps the agent shall be called
in such case and then depending on the response start a new pairing,
so we keep this policy in the agent. Nevertheless it is still a good
idea to set the "No bonding' value in case you want to avoid this
extra steps while reconnecting.

-- 
Luiz Augusto von Dentz
