Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Oct 2013 09:21:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/9] Bluetooth: Make mgmt_index_added() and
 mgmt_index_removed() return void
Message-ID: <20131007072107.GB5838@x220.p-661hnu-f1>
References: <1381128953-32080-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381128953-32080-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> The return value from mgmt_index_added() and mgmt_index_removed()
> functions is never used. So do not pretend that returning an error
> would actually be handled and just make both functions return void.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  4 ++--
>  net/bluetooth/mgmt.c             | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
