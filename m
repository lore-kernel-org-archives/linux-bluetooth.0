Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 17:16:18 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/5 v2] Bluetooth: make use of connection number to
 optimize the scheduler
Message-ID: <20110824201618.GE2662@joana>
References: <1313587384-2653-1-git-send-email-luiz.dentz@gmail.com>
 <1313587384-2653-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313587384-2653-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-17 16:23:00 +0300]:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This checks if there is any existing connection according to its type
> before start iterating in the list and immediately stop iterating when
> reaching the number of connections.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   16 ++++++++++++++++
>  net/bluetooth/hci_core.c         |   15 +++++++++++++++
>  2 files changed, 31 insertions(+), 0 deletions(-)

Applied, thanks.

	Gustavo
