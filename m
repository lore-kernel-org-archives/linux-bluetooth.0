Return-Path: <cyrus@holtmann.org>
Message-ID: <bd5b16740801102358q3587e5cdp7a949be4d982828@mail.gmail.com>
Date: Fri, 11 Jan 2008 09:58:46 +0200
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH][FIX] Bluetooth: always send explicit hci_ll wake-up acks
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org,
	bluez-devel@lists.sourceforge.net
In-Reply-To: <20080110.222456.209443591.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <tkrat.091a3ceefb96c3e3@bencohen.org>
	 <20080110.222456.209443591.davem@davemloft.net>
List-ID: <bluez-devel.lists.sourceforge.net>

n 1/11/08, David Miller <davem@davemloft.net> wrote:
> From: Ohad Ben-Cohen <ohad@bencohen.org>
> Date: Mon, 7 Jan 2008 18:22:48 +0200 (IST)
>
> > In the (rare) event of simultaneous mutual wake up requests,
> > do send the chip an explicit wake-up ack. This is required
> > for Texas Instruments's BRF6350 chip.
> >
> > Signed-off-by: Ohad Ben-Cohen <ohad@bencohen.org>
>
> Applied, thanks.

Thanks.
