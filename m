Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Feb 2013 14:31:30 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Josh Boyer <jwboyer@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	niktr@mail.ru
Subject: Re: [PATCH] bluetooth: Add support for atheros 04ca:3004 device to
 ath3k
Message-ID: <20130220173130.GA30757@joana>
References: <20130219165415.GE362@hansolo.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130219165415.GE362@hansolo.jdub.homelinux.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Josh,

* Josh Boyer <jwboyer@redhat.com> [2013-02-19 11:54:16 -0500]:

> Yet another version of the atheros bluetooth chipset
> 
> T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=04ca ProdID=3004 Rev=00.01
> S:  Manufacturer=Atheros Communications
> S:  Product=Bluetooth USB Host Controller
> S:  SerialNumber=Alaska Day 2006
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> 
> This resolves https://bugzilla.redhat.com/show_bug.cgi?id=844750
> 
> Reported-by: niktr@mail.ru
> Signed-off-by: Josh Boyer <jwboyer@redhat.com>
> ---
>  drivers/bluetooth/ath3k.c | 2 ++
>  drivers/bluetooth/btusb.c | 1 +
>  2 files changed, 3 insertions(+)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
