Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Jun 2012 00:20:15 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Use %pMR BT addr print spec instead of batostr
Message-ID: <20120612031846.GF24440@joana>
References: <1339419200-581-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339419200-581-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-11 15:53:20 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Clean up old unsafe batostr function and use %pMR print specifier
> for printing Bluetooth addresses.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> 	* Note that the patch shall be only applied when the tree is rebased against
> 	very latest linux-next where specifier patch is added.
> <------8<-----------------------------------------------------
> |
> |  The patch titled
> |       Subject: vsprintf: add %pMR for Bluetooth MAC address
> |  has been added to the -mm tree.  Its filename is
> |       vsprintf-add-%pmr-for-bluetooth-mac-address.patch
> |
> <------8<-----------------------------------------------------

The patch looks good to me. So please carry this patch on your tree until we
are able to apply it in bluetooth-next.

	Gustavo
