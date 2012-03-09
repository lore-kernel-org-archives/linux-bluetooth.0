Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Mar 2012 09:57:10 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check FINDING state in interleaved discovery
Message-ID: <20120309125710.GG16366@joana>
References: <1331073426-11427-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331073426-11427-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-03-06 19:37:06 -0300]:

> In order to do interleaved discovery we should be in DISCOVERY_
> FINDING state. Otherwise, discovery should be stopped.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

	Gustavo
