Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <MAXPR01MB0218AF3FE3A6214F17D9047090ED0@MAXPR01MB0218.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR01MB0218AF3FE3A6214F17D9047090ED0@MAXPR01MB0218.INDPRD01.PROD.OUTLOOK.COM>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Aug 2016 11:21:43 +0300
Message-ID: <CABBYNZLLpO0TcozFuvorwCZOOAKr=96NJhZBoLxjeUgdM+G2UA@mail.gmail.com>
Subject: Re: Regarding IPSP over GATT Support in blueZ
To: Amith Raghunath <Amith.Raghunath@mindtree.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amith,

On Thu, Aug 25, 2016 at 12:55 PM, Amith Raghunath
<Amith.Raghunath@mindtree.com> wrote:
> Hi Jukka Rissanen,
>      I googled for for IPSP rev1.0.0 profile support in blueZ and also searched in the blueZ mailing list.
>      I could not find info for IPSP over GATT support in blueZ user space stack.
>      I could locate 6lowpan over LE code in blueZ kernel space code.
>      Kindly let me know of the IPSP over GATT support status in blueZ user space code. (i.e whether it is being developed in blueZ).

It is currently pending the implementation of MGMT interface, but you
can use it with debugfs:

$ modprobe bluetooth_6lowpan
$ echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable

Then to connect:

$echo "connect <bdaddr> <type>" > /sys/kernel/debug/bluetooth/6lowpan_control

-- 
Luiz Augusto von Dentz
