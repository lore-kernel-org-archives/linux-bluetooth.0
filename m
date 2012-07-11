Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jul 2012 10:07:56 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: debug: Use standard hex object specifiers in
 hci_event
Message-ID: <20120711130756.GA20103@joana>
References: <20120710183824.GD13847@joana>
 <1342006363-7803-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342006363-7803-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-07-11 14:32:43 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> To help debugging printed hex object use standard bluetooth
> specifiers in hci_event. The patch changes format from 0x%04x to 0x%4.4x;
> print manufacturer id and handle in hex instead of int; print opcode
> always in 0x%4.4x format; status in 0x%2.2x.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c |  170 ++++++++++++++++++++++-----------------------
>  1 file changed, 85 insertions(+), 85 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
