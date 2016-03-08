Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <B1E75638-E1BA-4E30-88CE-9E6FBC6BCE1F@numberfour.eu>
References: <B1E75638-E1BA-4E30-88CE-9E6FBC6BCE1F@numberfour.eu>
Date: Tue, 8 Mar 2016 10:34:10 +0200
Message-ID: <CABBYNZL9FK-nMVCm0jvr=BPcgsCfMGhimJPyOq5pyXG08sV+HA@mail.gmail.com>
Subject: Re: BlueZ 5.37 experimental D-Bus GattCharacteristic1.WriteValue
 results in BT_ATT_ERROR_UNLIKELY
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sven Harmstorf <sven.harmstorf@numberfour.eu>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sven,

On Mon, Mar 7, 2016 at 7:50 PM, Sven Harmstorf
<sven.harmstorf@numberfour.eu> wrote:
> Hello,
>
> I am running BlueZ 5.37 on Linux kernel 4.1.6 with an Atheros AR3012 adapter configured to advertise a service using the experimental D-Bus GATT API on a Freescale i.MX6 Quad (ARMv7l).
>
> The advertising is working fine (verified this via Nordic’s Android App 'nRF Master Control Panel‘).
> Connecting and discovering services/characteristics is also working without any issues.
>
> One of the characteristics has the property "flags" set to ["write-without-response“, "notify“].
> Centrals should write their data quickly without the need to wait for a response (accepting the potential data loss) and get value changes only via notification. Explicit read is not supported.
>
> When a central sends multiple writes of 1-20 bytes in a row, only the first write succeeds. Any following writes fail in src/shared/gatt-server.c:786. As a result of this, only a few writes happen to be sent as a signal on the D-Bus.

Actually there is a simple fix for this which is to use no reply
messages, it perhaps was the intention given the lack of queuing of
bt_gatt_server, for regular write this should never happen.

-- 
Luiz Augusto von Dentz
