Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jan 2008 22:24:56 -0800 (PST)
Message-Id: <20080110.222456.209443591.davem@davemloft.net>
To: ohad@bencohen.org
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org,
 bluez-devel@lists.sourceforge.net
Subject: Re: [PATCH][FIX] Bluetooth: always send explicit hci_ll wake-up
 acks
From: David Miller <davem@davemloft.net>
In-Reply-To: <tkrat.091a3ceefb96c3e3@bencohen.org>
References: <tkrat.091a3ceefb96c3e3@bencohen.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

From: Ohad Ben-Cohen <ohad@bencohen.org>
Date: Mon, 7 Jan 2008 18:22:48 +0200 (IST)

> In the (rare) event of simultaneous mutual wake up requests,
> do send the chip an explicit wake-up ack. This is required
> for Texas Instruments's BRF6350 chip.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@bencohen.org>

Applied, thanks.
