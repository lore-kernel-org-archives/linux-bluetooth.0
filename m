Return-Path: <johan.hedberg@gmail.com>
Date: Sun, 25 Mar 2018 15:54:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_ll: Convert to use h4_recv_buf
 helper
Message-ID: <20180325125418.GA28028@x1c.home>
References: <20180324091954.73229-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180324091954.73229-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Mar 24, 2018, Marcel Holtmann wrote:
> The HCILL or eHCILL protocol from TI is actually an H:4 protocol with a
> few extra events and thus can also use the h4_recv_buf helper. Instead
> of open coding the same funtionality add the extra events to the packet
> description table and use h4_recv_buf.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Tested-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bluetooth/Kconfig  |   1 +
>  drivers/bluetooth/hci_ll.c | 214 +++++++++++++++------------------------------
>  2 files changed, 70 insertions(+), 145 deletions(-)

All three patches in this set have been applied to bluetooth-next.
Thanks.

Johan
