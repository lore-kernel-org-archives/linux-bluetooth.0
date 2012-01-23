Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 11:00:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add alloc_skb chan operator
Message-ID: <20120123090046.GB8800@x220>
References: <1326978832-9888-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326978832-9888-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jan 19, 2012, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add channel-specific skb allocation method
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 +++
>  net/bluetooth/l2cap_core.c    |   22 +++++++++++++++-------
>  net/bluetooth/l2cap_sock.c    |    9 +++++++++
>  3 files changed, 27 insertions(+), 7 deletions(-)

Applied. Thanks.

Johan
