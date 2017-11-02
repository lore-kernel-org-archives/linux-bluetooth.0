Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 5/7] core: Add LEAdvertising1 to bluetooth.conf
Date: Thu, 02 Nov 2017 15:24:15 +0100
Message-ID: <15892817.n9M0BT5LRN@ix>
In-Reply-To: <20171102141519.28446-5-luiz.dentz@gmail.com>
References: <20171102141519.28446-1-luiz.dentz@gmail.com> <20171102141519.28446-5-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thursday, 2 November 2017 15:15:17 CET Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> LEAdvertising1 must be included in order to be able to call Release.
> ---
>  src/bluetooth.conf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
> index 60e75955c..74a2d3147 100644
> --- a/src/bluetooth.conf
> +++ b/src/bluetooth.conf
> @@ -20,7 +20,7 @@
>      <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
>      <allow send_interface="org.bluez.GattCharacteristic1"/>
>      <allow send_interface="org.bluez.GattDescriptor1"/>
> -    <allow send_interface="org.bluez.LEAdvertisement1"/>
> +    <allow send_interface="org.bluez.LEAdvertisement1"/>
>      <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
>      <allow send_interface="org.freedesktop.DBus.Properties"/>
>    </policy>

Some rebase issue with this and patch 4/7 ?

Also subject has a typo LEAdvertis_ing_1

-- 
pozdrawiam
Szymon Janc
