Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2014 21:13:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Add quirk for external configuration
 requirement
Message-ID: <20140704181334.GA17855@t440s.P-661HNU-F1>
References: <1404487415-15089-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404487415-15089-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 04, 2014, Marcel Holtmann wrote:
> When a controller requires external configuration, then setting this
> quirk will allow indicating this.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 9 +++++++++
>  net/bluetooth/hci_core.c    | 3 ++-
>  net/bluetooth/mgmt.c        | 9 ++++++++-
>  3 files changed, 19 insertions(+), 2 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
