Return-Path: <domen@coderock.org>
Date: Sat, 19 Feb 2005 00:43:53 +0100
From: Domen Puncer <domen@coderock.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, kernel-janitors@lists.osdl.org,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: bluetooth/bluecard_cs: remove interruptible_sleep_on_timeout() usage
Message-ID: <20050218234353.GA3840@masina.coderock.org>
References: <20050202225855.GY2546@us.ibm.com> <1107386189.11944.21.camel@pegasus> <20050203002502.GB2546@us.ibm.com> <1107562301.6921.115.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1107562301.6921.115.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On 05/02/05 01:11 +0100, Marcel Holtmann wrote:
> Hi Nish,
...
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
...
> EIP is at prepare_to_wait+0x32/0xa0
...


I think this is because wait_queue_head_t variable is uninitialized.
(task_list is at offset 4, __add_wait_queue from prepare_to_wait uses it)

DECLARE_WAIT_QUEUE_HEAD should take care of it.


	Domen
