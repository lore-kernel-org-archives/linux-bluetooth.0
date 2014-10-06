Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/1] Bluetooth: Add support for Acer [0489:e078]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412593309-3806-1-git-send-email-ananthk@codeaurora.org>
Date: Mon, 6 Oct 2014 13:08:13 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <C42CE744-9451-4F12-8411-35BCC5B6492D@holtmann.org>
References: <1412593309-3806-1-git-send-email-ananthk@codeaurora.org>
To: Anantha Krishnan <ananthk@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anantha,

please send these patches to the mailing list in the future.

> Add support for the QCA6174 chip.
> 
>    T:  Bus=06 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 0
>    D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>    P:  Vendor=0489 ProdID=e078 Rev=00.01
>    C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>    I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>    I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: Anantha Krishnan <ananthk@codeaurora.org>
> ---
> drivers/bluetooth/ath3k.c | 2 ++
> drivers/bluetooth/btusb.c | 1 +
> 2 files changed, 3 insertions(+)

Patch has been applied to bluetooth-next tree.

Regards

Marcel

