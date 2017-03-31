Return-Path: <huxm@marvell.com>
From: Xinming Hu <huxm@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Amitkumar Karwar
	<akarwar@marvell.com>, Cathy Luo <cluo@marvell.com>,
        Guenter Roeck
	<groeck@chromium.org>
Subject: Re: [PATCH v2 2/2] Bluetooth: btmrvl: remove unnecessary wakeup
 interrupt number sanity check
Date: Fri, 31 Mar 2017 06:31:52 +0000
Message-ID: <1490941911668.26500@marvell.com>
References: <1490884636-18684-1-git-send-email-huxm@marvell.com>
 <1490884636-18684-2-git-send-email-huxm@marvell.com>,<21885C64-CE14-49C9-AB01-7EA44027B245@holtmann.org>
In-Reply-To: <21885C64-CE14-49C9-AB01-7EA44027B245@holtmann.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,=0A=
________________________________________=0A=
=0A=
=0A=
>Hi Xinming,=0A=
=0A=
>> Sanity check of interrupt number in interrupt handler is unnecessary and=
=0A=
>> confusion, remove it.=0A=
>>=0A=
>> Signed-off-by: Xinming Hu <huxm@marvell.com>=0A=
>> Signed-off-by: Guenter Roeck <groeck@chromium.org>=0A=
>> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>=0A=
>> ---=0A=
>> v2: fix apply error in v1=0A=
>> ---=0A=
>> drivers/bluetooth/btmrvl_sdio.c | 8 +++-----=0A=
>> 1 file changed, 3 insertions(+), 5 deletions(-)=0A=
=0A=
>patch has been applied to bluetooth-next tree.=0A=
=0A=
Thanks ! we might need send V3 patches based on Guenter's comments.=0A=
=0A=
Regards,=0A=
Simon=0A=
=0A=
>Regards=0A=
=0A=
>Marcel=0A=
=0A=
