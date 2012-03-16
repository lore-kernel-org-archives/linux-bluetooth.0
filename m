Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:34:26 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/6] Bluetooth: Correct ediv in SMP
Message-ID: <20120316153426.GD21196@x220>
References: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331547191-15307-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331547191-15307-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Mar 12, 2012, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/smp.h |    2 +-
>  net/bluetooth/smp.c         |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

All patches in this set have been applied to my bluetooth-next tree. I
also checked patch 3/6 (which Marcel had doubts about) and concluded
that it was correct.

Johan
