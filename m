Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jul 2013 13:56:01 -0700
From: "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
To: Hector Palacios <hector.palacios@digi.com>
CC: Marcel Holtmann <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"surajs@qca.qualcomm.com" <surajs@qca.qualcomm.com>
Subject: Re: [PATCH] bluetooth: remove wrong dependency for BT_ATH3K
Message-ID: <20130730205601.GI17130@pogo>
References: <1375114325-25498-1-git-send-email-hector.palacios@digi.com>
 <5438CD3C-E28C-485C-94B8-F743E8B13D4A@holtmann.org>
 <51F7722E.9050708@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <51F7722E.9050708@digi.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 30, 2013 at 09:58:38AM +0200, Hector Palacios wrote:
> This brings an interesting question: shouldn't the firmware download
> part be isolated from the USB driver? After all, I want to
> communicate with a UART bluetooth chip.

There are a few BT firmware upload modules (last I checked at least 2),
I believe it should be possible to stuff all that code a shared
module or even as FreeBSD does it -- treat fw uploading in userspace,
however just keep in mind for quirks [0]. So patches welcomed.

[0] http://wireless.kernel.org/en/users/Drivers/ath3k#AR3011_over_USB

  Luis
