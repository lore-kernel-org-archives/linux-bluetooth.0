Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 22:32:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Store SCO address information in its own
 socket structure
Message-ID: <20131013193249.GB30265@x220.p-661hnu-f1>
References: <1381685643-57066-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381685643-57066-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> The address information of SCO sockets should be stored in its own
> socket structure. Trying to generalize them is not helpful since
> different transports have different address types.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/sco.h |  2 ++
>  net/bluetooth/sco.c         | 36 ++++++++++++++++++------------------
>  2 files changed, 20 insertions(+), 18 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
