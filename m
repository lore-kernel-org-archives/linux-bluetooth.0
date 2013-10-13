Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 22:32:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use SCO addresses from HCI connection directly
Message-ID: <20131013193219.GA30265@x220.p-661hnu-f1>
References: <1381684522-35575-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381684522-35575-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> Instead of storing a pointer to the addresses for the HCI device
> and HCI connection, use them directly. With the recent changes
> to address tracking of HCI connections, this becomes simple.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/sco.h |  3 ---
>  net/bluetooth/sco.c         | 20 ++++++++------------
>  2 files changed, 8 insertions(+), 15 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
