Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for 0489:0xe0a2 QCA_ROME
 device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1497422520-26184-1-git-send-email-sylee@canonical.com>
Date: Wed, 14 Jun 2017 08:50:12 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <2C573F8F-CD0E-4017-BA1C-553ECCBB5D1B@holtmann.org>
References: <1497422520-26184-1-git-send-email-sylee@canonical.com>
To: "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shih-Yuan,

> T:  Bus=01 Lev=01 Prnt=01 Port=06 Cnt=03 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e0a2 Rev=00.01
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: Shih-Yuan Lee (FourDollars) <sylee@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

