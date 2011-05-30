Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 May 2011 19:37:22 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 5/9] Bluetooth: Advertising entries lifetime
Message-ID: <20110530223721.GL2556@joana>
References: <1306437837-18263-1-git-send-email-andre.guedes@openbossa.org>
 <1306437837-18263-5-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306437837-18263-5-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2011-05-26 16:23:53 -0300]:

> This patch adds a timer to clear 'adv_entries' after three minutes.
> 
> After some amount of time, the advertising entries cached during
> the last LE scan should be considered expired and they should be
> removed from the advertising cache.
> 
> It was chosen a three minutes timeout as an initial attempt. This
> value might change in future.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_core.c         |   14 ++++++++++++++
>  net/bluetooth/hci_event.c        |    6 +++++-
>  3 files changed, 21 insertions(+), 1 deletions(-)

Patches 1 to 5 have been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
