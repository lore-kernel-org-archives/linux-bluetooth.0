Return-Path: <foo00@h08.hostsharing.net>
Date: Mon, 8 Jan 2018 05:27:01 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frederic Danis <frederic.danis.oss@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>,
	Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 07/13] Bluetooth: hci_bcm: Document struct bcm_device
Message-ID: <20180108042701.GB13972@wunner.de>
References: <cover.1515348092.git.lukas@wunner.de>
 <2eb37dcf928e7f4be3f8f23e9f8ad0ceeb50f192.1515348092.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2eb37dcf928e7f4be3f8f23e9f8ad0ceeb50f192.1515348092.git.lukas@wunner.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jan 07, 2018 at 08:16:32PM +0100, Lukas Wunner wrote:
> + * @hu: pointer to HCI UART controller struct,
> + *	used to enable flow control during runtime suspend and system sleep
> + * @is_suspended: whether flow control is currently enabled

Botched this as well unfortunately, it should read "used to *disable*
flow control".

I didn't realize that the semantics of hci_uart_set_flow_control()
are reversed and that "false" actually *enables* flow control.
(What's the rationale for that anyway?)

Lukas
