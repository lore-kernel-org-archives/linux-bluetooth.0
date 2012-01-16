Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jan 2012 11:57:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] Bluetooth: Use chan instead of sk
Message-ID: <20120116095713.GA19971@x220>
References: <1326468103-12731-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326468103-12731-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jan 13, 2012, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Remove unneeded conversion from sk to chan.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)

Both patches have been applied to my bluetooth-next tree. Thanks.

Johan
