Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Add support for Acer [13D3:3432]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404827708-23154-1-git-send-email-ananthk@codeaurora.org>
Date: Tue, 8 Jul 2014 17:21:22 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <410ABCB7-4D78-4126-AECA-03E3A3D5A13B@holtmann.org>
References: <1404827708-23154-1-git-send-email-ananthk@codeaurora.org>
To: Anantha Krishnan <ananthk@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anantha,

> Add support for the QCA6174 chip.
> 
>    T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 30 Spd=12  MxCh= 0
>    D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>    P:  Vendor=13d3 ProdID=3432 Rev=00.02
>    C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>    I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>    I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> Signed-off-by: Anantha Krishnan <ananthk@codeaurora.org>
> ---
> drivers/bluetooth/ath3k.c | 2 ++
> drivers/bluetooth/btusb.c | 1 +
> 2 files changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

