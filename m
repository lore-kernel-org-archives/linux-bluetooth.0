Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 11:23:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Add alloc_skb chan operator
Message-ID: <20120123092304.GB9471@x220>
References: <1327061283-17323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327061283-17323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jan 20, 2012, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add channel-specific skb allocation method
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> 
> ---
> v2: removed unused variable
> 
>  include/net/bluetooth/l2cap.h |    3 +++
>  net/bluetooth/l2cap_core.c    |   23 +++++++++++++++--------
>  net/bluetooth/l2cap_sock.c    |    9 +++++++++
>  3 files changed, 27 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
