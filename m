Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] drivers/bluetooth: Toshiba Qualcomm AR9565 (ath3k) bluetooth fix
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1500387.0D3PNSTLgV@venture>
Date: Mon, 4 Aug 2014 08:30:08 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FAD0FF20-81D3-4FC0-A059-BC4BFCE47B51@holtmann.org>
References: <1500387.0D3PNSTLgV@venture>
To: Vincent Elger Zwanenburg <vincentezw@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vincent,

> From:  Vincent Elger Zwanenburg <vincentz@topmail.ie>
> Date:   Mon Aug 4 01:34:27 2014 +0100
> 
> Fixes bluetooth support on Toshiba C55-B-138 notebooks by 1) adding an ignore 
> line into btusb.c for its PID/VID combination and 2) assigning the VID/PID 
> combination in ath3k.c to load the BTUSB_ATH3012 driver.
> 
> relevant usb-devices command output:
> 
> T:  Bus=01 Lev=02 Prnt=05 Port=00 Cnt=01 Dev#= 10 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0930 ProdID=0227 Rev=00.02
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: Vincent Elger Zwanenburg <vincentz@topmail.ie>
> ---
> diff -uprN -X linux-3.16-rc7-vanilla/Documentation/dontdiff linux-3.16-rc7-
> vanilla/drivers/bluetooth/ath3k.c /usr/src/linux-
> mine/drivers/bluetooth/ath3k.c
> --- linux-3.16-rc7-vanilla/drivers/bluetooth/ath3k.c    2014-07-27 
> 20:41:55.000000000 +0100
> +++ /usr/src/linux-mine/drivers/bluetooth/ath3k.c       2014-08-03 
> 04:24:37.449746557 +0100
> @@ -75,6 +75,7 @@ static const struct usb_device_id ath3k_
>        /* Atheros AR3012 with sflash firmware*/
>        { USB_DEVICE(0x0489, 0xe04d) },
>        { USB_DEVICE(0x0489, 0xe04e) },
> +       { USB_DEVICE(0x0930, 0x0227) },
>        { USB_DEVICE(0x0489, 0xe057) },
>        { USB_DEVICE(0x0489, 0xe056) },
>        { USB_DEVICE(0x0489, 0xe05f) },

please fix your mail client since this message is broken. With this it is impossible to apply the patch.

Regards

Marcel

