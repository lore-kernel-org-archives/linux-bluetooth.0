Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 May 2015 20:21:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2015-05-04
Message-ID: <20150506182102.GA16001@t440s>
References: <20150504093436.GB9096@t440s.lan>
 <20150504.153627.768616765733905013.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150504.153627.768616765733905013.davem@davemloft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

On Mon, May 04, 2015, David Miller wrote:
> From: Johan Hedberg <johan.hedberg@gmail.com>
> Date: Mon, 4 May 2015 12:34:36 +0300
> 
> > Here's the first bluetooth-next pull request for 4.2:
> > 
> >  - Various fixes for at86rf230 driver
> >  - ieee802154: trace events support for rdev->ops
> >  - HCI UART driver refactoring
> >  - New Realtek IDs added to btusb driver
> >  - Off-by-one fix for rtl8723b in btusb driver
> >  - Refactoring of btbcm driver for both UART & USB use
> > 
> > Please let me know if there are any issues pulling. Thanks.
> 
> Pulled, thanks Johan.

Seems you pulled this into net.git and not net-next.git?

Meanwhile, the bluetooth.git request I also made on the 4th is still
untouched.

Johan
