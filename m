Return-Path: <cyrus@holtmann.org>
Message-ID: <52A850BF.1000408@hurleysoftware.com>
Date: Wed, 11 Dec 2013 06:47:11 -0500
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Huang Shijie <b32955@freescale.com>
CC: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH RFC] tty_ldisc: add more limits to the @write_wakeup
References: <1384327803-5925-1-git-send-email-b32955@freescale.com> <52A1A84B.80409@freescale.com> <52A1F8BF.5030204@hurleysoftware.com> <52A809BC.2040909@freescale.com>
In-Reply-To: <52A809BC.2040909@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 12/11/2013 01:44 AM, Huang Shijie wrote:
> 于 2013年12月07日 00:18, Peter Hurley 写道:
>> hci_uart_tx_wakeup() should perform the actual tx in a work item.
> Does the "work item" mean a workqueue or a tasklet?
> This patch is used to tell the line discipline writers to send the data in the workqueue or a tasklet.

Yes, "work item" means struct work_struct.

Regards,
Peter Hurley
