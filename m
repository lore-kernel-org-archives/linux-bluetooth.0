Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Sep 2013 22:11:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add command for setting static address
Message-ID: <20130929191102.GA32665@x220.p-661hnu-f1>
References: <1380441937-55298-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380441937-55298-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 29, 2013, Marcel Holtmann wrote:
> Add command for setting static address for use as LE random address.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |  2 ++
>  include/net/bluetooth/hci_core.h |  1 +
>  include/net/bluetooth/mgmt.h     |  6 ++++++
>  net/bluetooth/hci_core.c         |  5 +++++
>  net/bluetooth/mgmt.c             | 43 +++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 56 insertions(+), 1 deletion(-)

This looks all pretty good to me. Did you have any particular thoughts
on resolvable private address generation (which we have to support as
soon as we support the privacy feature as a central) or is that
completely orthogonal to this feature? I suppose we'll be implementing
that through a "privacy" mgmt settings bit and leave the rest up to the
kernel?

Johan
