Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC V1 00/16] hci_ldisc hci_uart_tty_close() fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
Date: Thu, 30 Mar 2017 12:11:25 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <AA3DD0DD-5CAC-4ADD-9B0C-4E652C93E4D6@holtmann.org>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> This is RFC patchset V1 which reorganises hci_uart_tty_close() to overcome a
> design flaw. I would like some comments on the changes.
> 
> Design Flaw
> ===========
> 
> An example callstack is as follows
> 
> Have Bluetooth running using a BCSP based UART Bluetooth Radio Module.
> 
> Now kill the userland hciattach program by doing
> killall hciattach

is there any chance we can convert BCSP support to run fully inside the kernel with the new parts we have put in. And with that then also use btattach. The split of some parts of BCSP in userspace seems never been a good idea.

I am a bit reluctant to change major hci_ldisc pieces because of just one broken protocol. Running BCSP fully in the kernel seems a better solution to deal with some of these issues.

Regards

Marcel

