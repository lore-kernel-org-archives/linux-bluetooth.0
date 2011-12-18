Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 Dec 2011 21:36:16 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 1/6] Bluetooth: Add HCI Read Data Block Size function
Message-ID: <20111218233616.GG2621@joana>
References: <1323266216-25261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1323266216-25261-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323266216-25261-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-12-07 15:56:51 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Implement block size read function. Use different variables for
> packet-based and block-based flow control.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |    8 ++++++++
>  include/net/bluetooth/hci_core.h |    5 +++++
>  net/bluetooth/hci_event.c        |   26 ++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 0 deletions(-)

Applied, thanks.

	Gustavo
