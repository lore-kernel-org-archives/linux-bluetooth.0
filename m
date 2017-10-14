Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH] Bluetooth: mark expected switch fall-throughs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171012222402.GA31769@embeddedor.com>
Date: Sat, 14 Oct 2017 09:26:45 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <DE14B971-2E3F-4A4B-994E-7B2793CE1383@holtmann.org>
References: <20171012222402.GA31769@embeddedor.com>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> In this particular case, notice that I replaced the
> "deliberate fall-through..." comment with a "fall through"
> comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
> drivers/bluetooth/bcm203x.c | 2 +-
> drivers/bluetooth/hci_ll.c  | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
