Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 Aug 2017 08:29:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, Miao-chen Chou <mcchou@chromium.org>,
        Waldemar Rymarkiewicz <ext.waldemar.rymarkiewicz@tieto.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btusb: add ID for LiteOn 04ca:3016
Message-ID: <20170801052948.GA12310@x1c.home>
References: <20170801005939.109205-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170801005939.109205-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Mon, Jul 31, 2017, Brian Norris wrote:
> Contains a QCA6174A-5 chipset, with USB BT. Let's support loading
> firmware on it.
> 
> From usb-devices:
> T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=04ca ProdID=3016 Rev=00.01
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2:
>  * include usb-devices info in commit message
> 
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to bluetooth-next. Thanks.

Johan
