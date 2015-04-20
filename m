Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [patch] Bluetooth: btusb: off by one in rtl8723b_parse_firmware()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150420155135.GB10518@mwanda>
Date: Mon, 20 Apr 2015 19:14:23 +0200
Cc: Daniel Drake <drake@endlessm.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-Id: <D6EE667A-6BA5-487A-B98A-7D84A355CEEB@holtmann.org>
References: <20150420155135.GB10518@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> The ">" should be ">=" so that we don't read past the end of the array.
> 
> Fixes: 9d9a113e3695 ('Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

patch has been applied to bluetooth-next tree.

Regards

Marcel

