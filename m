Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jan 2012 22:30:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove magic number from ACL TO
Message-ID: <20120108203035.GE16731@x220.P-661HNU-F1>
References: <1325688146-19896-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325688146-19896-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Jan 04, 2012, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adds HCI_ACL_TX_TIMEOUT and clear conversion from msec to jiffies
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |    1 +
>  net/bluetooth/hci_core.c    |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
