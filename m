Return-Path: <cyrus@holtmann.org>
Message-ID: <52A809BC.2040909@freescale.com>
Date: Wed, 11 Dec 2013 14:44:12 +0800
From: Huang Shijie <b32955@freescale.com>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>
CC: <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
	<marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH RFC] tty_ldisc: add more limits to the @write_wakeup
References: <1384327803-5925-1-git-send-email-b32955@freescale.com> <52A1A84B.80409@freescale.com> <52A1F8BF.5030204@hurleysoftware.com>
In-Reply-To: <52A1F8BF.5030204@hurleysoftware.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

=E4=BA=8E 2013=E5=B9=B412=E6=9C=8807=E6=97=A5 00:18, Peter Hurley =E5=86=99=
=E9=81=93:
> hci_uart_tx_wakeup() should perform the actual tx in a work item.=20
Does the "work item" mean a workqueue or a tasklet?
This patch is used to tell the line discipline writers to send the data=20
in the workqueue or a tasklet.

thanks
Huang Shijie
