Return-Path: <cyrus@holtmann.org>
Message-ID: <1349346078.27233.29.camel@aeonflux>
Subject: Re: [RFC 2/2] Bluetooth: Add BT USB mini driver template
From: Marcel Holtmann <marcel@holtmann.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	johan.hedberg@intel.com, albert.o.ho@intel.com,
	tedd.hj.an@gmail.com
Date: Thu, 04 Oct 2012 12:21:18 +0200
In-Reply-To: <2904542.YtJ1Wo3BEY@tedd-ubuntu>
References: <2904542.YtJ1Wo3BEY@tedd-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch adds BT USB mini driver template.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/Makefile         |    1 +
>  drivers/bluetooth/btusb.c          |    3 ++
>  drivers/bluetooth/btusb_template.c |   78 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 drivers/bluetooth/btusb_template.c

we would have samples/ for this.

Regards

Marcel


