Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Feb 2014 06:22:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Provide option for changing LE advertising
 channel map
Message-ID: <20140221042253.GA17039@x220.p-661hnu-f1>
References: <1392926156-4599-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392926156-4599-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 20, 2014, Marcel Holtmann wrote:
> For testing purposes it is useful to provide an option to change the
> advertising channel map. So add a debugfs option to allow this.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
>  net/bluetooth/mgmt.c             |  2 +-
>  3 files changed, 33 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
