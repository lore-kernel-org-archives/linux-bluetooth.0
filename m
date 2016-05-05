Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 5 May 2016 16:19:06 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ganapathi Bhat <gbhat@marvell.com>
Subject: Re: [PATCH v10 1/3] Bluetooth: hci_uart: add prepare callbacks to
 hci_uart_proto structure.
Message-ID: <20160505161906.14267bd0@lxorguk.ukuu.org.uk>
In-Reply-To: <1462460902-25439-1-git-send-email-akarwar@marvell.com>
References: <1462460902-25439-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 5 May 2016 08:08:20 -0700
Amitkumar Karwar <akarwar@marvell.com> wrote:

> From: Ganapathi Bhat <gbhat@marvell.com>
> 
> The new callback is used to prepare the device before HCI becomes
> ready. One can use this to download firmware if the download process
> doesn't use HCI commands. Also recv_for_prepare callback is
> introduced for receiving data from devices during prepare phase.

If your device is not speaking HCI protocol then instead of hackig up the
HCI ldisc would it not make more sense to have a tiny ldisc for your
firmware loader instead of adding crap to the fast paths of what is
currently a clean properly separated out interface ?

Alan
