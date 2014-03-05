Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Mar 2014 20:58:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Valentin Ilie <valentin.ilie@gmail.com>
Cc: marcel@holtmann.org, gustavo@padovan.org, Dean_Jenkins@mentor.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Remove assignment in if
Message-ID: <20140305185852.GB10094@localhost.P-661HNU-F1>
References: <1376225793-22981-1-git-send-email-valentin.ilie@gmail.com>
 <1376322360-28824-1-git-send-email-valentin.ilie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376322360-28824-1-git-send-email-valentin.ilie@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Valentin,

On Mon, Aug 12, 2013, Valentin Ilie wrote:
> Remove assignment in if
> 
> Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>
> ---
>  drivers/bluetooth/ath3k.c       |  7 +++----
>  drivers/bluetooth/bfusb.c       | 14 ++++++++++----
>  drivers/bluetooth/bluecard_cs.c |  9 ++++++---
>  drivers/bluetooth/bt3c_cs.c     |  7 ++++---
>  drivers/bluetooth/btuart_cs.c   |  6 ++++--
>  drivers/bluetooth/dtl1_cs.c     |  9 ++++++---
>  drivers/bluetooth/hci_bcsp.c    | 26 +++++++++++++++-----------
>  drivers/bluetooth/hci_h5.c      |  6 ++++--
>  drivers/bluetooth/hci_ldisc.c   |  9 ++++++---
>  9 files changed, 58 insertions(+), 35 deletions(-)

Applied (with a minor coding style fix) to the bluetooth-next tree.
Thanks.

Johan
