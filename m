Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 18:37:10 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 5/5] Bluetooth: Assure BREDR HCI device first in the
 list
Message-ID: <20111116203710.GB6027@joana>
References: <1321366547-29462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1321366547-29462-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321366547-29462-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-11-15 16:15:47 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Using different list_add to make sure that BR/EDR HCI device is the
> first device in the hci_dev_list. This is needed for e.g. A2MP Discover
> Command which requires that "entry for Controller ID 0x00 (Primary
> BR/EDR controller) shall always be sent and shall be the first entry
> in the Controller List.
> Also output from hciconfig looks nicer :-)
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
