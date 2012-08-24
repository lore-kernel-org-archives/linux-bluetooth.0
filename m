Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <453EEB4CD4162742B6EF3D3F84E88A6E01ADB2AAC3@MOPESMBX01.eu.thmulti.com>
References: <453EEB4CD4162742B6EF3D3F84E88A6E01ADB2AAC3@MOPESMBX01.eu.thmulti.com>
Date: Fri, 24 Aug 2012 13:19:49 +0300
Message-ID: <CABBYNZ+AXcthLm0p=+V2T3Ro+c8SP_-qybMC=t2OL+6W5QFpRQ@mail.gmail.com>
Subject: Re: duplicate devices found when using StartDiscovery API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Geay Franck <franck.geay@technicolor.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Geay,

On Fri, Aug 24, 2012 at 11:12 AM, Geay Franck
<franck.geay@technicolor.com> wrote:
> Hi
>
> I have a problem with bluez scanning API
> When I call StartDiscovery dbus API, I get some duplicate devices found signal whereas using hcitool scan doesn't list duplicate devices
> Is it normal, do I have to filter duplicate devices based on the BD address ? Is there a fix for this problem ?
> I am using bluez version 4.87
>
> root@localhost ~]# /usr/lib/bluez/test/test-discovery  | grep -e Name -e Addres
>     Name = MyLapTop
>     Address = 00:16:41:DB:FF:F2
>     Name = C1-01
>     Address = 78:2E:EF:10:F4:7B
>     Name = Dell Wireless 370 Bluetooth Mini-card
>     Address = 00:25:56:E4:0E:0C
>     Name = Nokia 2730
>     Address = C8:DF:7C:CF:CE:E7
>     Name = MyLapTop
>     Address = 00:16:41:DB:FF:F2
>     Name = Nokia 2730
>     Address = C8:DF:7C:CF:CE:E7
>     Name = Dell Wireless 370 Bluetooth Mini-card

It works as intended as they could be found in different scan rounds
or due to rssi signal has been changed, hcitool in the other hand is a
single shot and is not rssi aware so it just need to return one entry
of each device found but if you use hcidump you will see that the
inquiry result may contain more than one entry for each device.


-- 
Luiz Augusto von Dentz
