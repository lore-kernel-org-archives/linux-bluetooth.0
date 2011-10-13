Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 16:47:32 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 10/16] Bluetooth: EWS: rewrite handling POLL (P) bit
Message-ID: <20111013194732.GA20892@joana>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318329476-30153-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318329476-30153-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-11 13:37:50 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Handle POLL (P) bit in L2CAP ERTM using information about control field type.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |   16 ++++++++++++++++
>  net/bluetooth/l2cap_core.c    |   14 +++++++-------
>  2 files changed, 23 insertions(+), 7 deletions(-)

Patches up to this one were applied. Thanks for doing this work.

	Gustavo
