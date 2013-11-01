Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH 3/3] Bluetooth: btmrvl: operate on 16-bit opcodes instead of ogf/ocf
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F70430F45757D88@SC-VEXCH1.marvell.com>
Date: Fri, 1 Nov 2013 23:33:54 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mike Frysinger <vapier@chromium.org>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <758D809C-CDC1-46FD-8F61-3465C90DBF11@holtmann.org>
References: <1383257311-1430-1-git-send-email-bzhao@marvell.com> <1383257311-1430-3-git-send-email-bzhao@marvell.com> <5C5FA2A6-6FC9-4BCC-B153-419D64AD3FCA@holtmann.org> <477F20668A386D41ADCC57781B1F70430F45757D88@SC-VEXCH1.marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

>>> Replace ogf/ocf and its packing with 16-bit opcodes.
>>> 
>>> Signed-off-by: Bing Zhao <bzhao@marvell.com>
>>> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
>>> ---
>>> drivers/bluetooth/btmrvl_drv.h  | 19 +++++++++++--------
>>> drivers/bluetooth/btmrvl_main.c | 21 +++++++++------------
>>> 2 files changed, 20 insertions(+), 20 deletions(-)
>> 
>> patch looks fine to me. Since you send it as 3/3, I don’t know if you want me to apply it right away
>> or just when the whole series is ready to be applied.
> 
> Please apply 3/3 first if that's convenient for you.
> I will resend 1/3 and 2/3 in v2 series.

patch has been applied to bluetooth-next tree.

Regards

Marcel

