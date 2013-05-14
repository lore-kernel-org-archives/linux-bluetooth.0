Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 May 2013 12:03:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/2] Bluetooth: Remove unneeded flag
Message-ID: <20130514090309.GB12420@x220.ger.corp.intel.com>
References: <20130507114116.GA11873@x220>
 <1368521057-20931-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1368521057-20931-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368521057-20931-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, May 14, 2013, Andrei Emeltchenko wrote:
> Remove HCI_LINK_KEYS flag since using HCI_MGMT is enough for test that
> user space expects the kernel managing link keys.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h | 1 -
>  net/bluetooth/mgmt.c        | 2 --
>  2 files changed, 3 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
