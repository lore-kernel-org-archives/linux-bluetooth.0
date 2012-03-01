Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 19:38:56 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Save remote L2CAP fixed channel mask
Message-ID: <20120301013856.GA26492@x220>
References: <1330504901-28428-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330504901-28428-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Feb 29, 2012, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fixed channel mask needs to be stored to decide whether to
> use A2MP for example. So far save only one relevant byte which
> keeps all information we need.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> 	*v2: changed fc_mask -> fixed_chan_mask.
> 
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |    9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
