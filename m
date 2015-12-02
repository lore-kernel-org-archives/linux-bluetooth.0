Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 03/19] bluetooth: hci_ldisc: Remove dead code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448660356-6328-4-git-send-email-peter@hurleysoftware.com>
Date: Tue, 1 Dec 2015 21:47:38 -1000
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>,
	Andi Kleen <andi@firstfloor.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <7379E6C6-6CCE-4A6F-8232-25218ED6A34E@holtmann.org>
References: <1448660356-6328-1-git-send-email-peter@hurleysoftware.com> <1448660356-6328-4-git-send-email-peter@hurleysoftware.com>
To: Peter Hurley <peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> The N_HCI ldisc does not define a flush_buffer() ldisc method, so
> the check when opening the ldisc is always false.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: <linux-bluetooth@vger.kernel.org>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 8 +-------
> 1 file changed, 1 insertion(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

