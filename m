Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 May 2013 17:59:41 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/2] Bluetooth: Remove unneeded flag
Message-ID: <20130520205941.GC17712@joana>
References: <20130507114116.GA11873@x220>
 <1368521057-20931-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1368521057-20931-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368521057-20931-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2013-05-14 11:44:17 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Remove HCI_LINK_KEYS flag since using HCI_MGMT is enough for test that
> user space expects the kernel managing link keys.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h | 1 -
>  net/bluetooth/mgmt.c        | 2 --
>  2 files changed, 3 deletions(-)

Since patch one went to bluetooth.git, I'll have to wait for a merge of both
trees to apply this one. Once the bluetooth.git gets merged in
bluetooth-next.git I'll apply this patch.

	Gustavo
