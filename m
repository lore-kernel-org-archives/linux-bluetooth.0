Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Jun 2012 00:15:06 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 5/5] Bluetooth: Fix not setting HCI_RESET flag for AMP
Message-ID: <20120612031506.GE24440@joana>
References: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1339402390-32320-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1339402390-32320-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339402390-32320-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-11 11:13:10 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Move reset function to common initialization section fixing
> not setting HCI_RESET flag for amp_init.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

All 5 patches were applied to bluetooth-next. Thanks.

	Gustavo
