Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/8 v2]Bluetooth: Fix warning: variable 'tty' set but
 not used
From: Marcel Holtmann <marcel@holtmann.org>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <1276565200-5583-1-git-send-email-justinmattock@gmail.com>
References: <1276565200-5583-1-git-send-email-justinmattock@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 18:07:08 -0300
Message-ID: <1278623228.10421.70.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Justin,

> Resend of this patch to fix whitespace issues
> The patch below fixes a warning message
> when using gcc 4.6.0
> 
>   CC [M]  drivers/bluetooth/hci_ldisc.o
> drivers/bluetooth/hci_ldisc.c: In function 'hci_uart_send_frame':
> drivers/bluetooth/hci_ldisc.c:213:21: warning: variable 'tty' set but not used
> 
> 
>  Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
>  Reviewed-By: Gustavo F. Padovan <gustavo@padovan.org>

patch has been applied to bluetooth-next-2.6 tree. Thanks.

Regards

Marcel


