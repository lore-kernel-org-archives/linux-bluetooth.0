Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Feb 2012 19:56:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Send management event for class of device
 changes
Message-ID: <20120222175645.GA28313@x220.ger.corp.intel.com>
References: <1329932281-15409-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329932281-15409-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 22, 2012, Marcel Holtmann wrote:
> Currently there are no events to other management sockets if the class of
> device got changed. So make sure they are sent.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |   13 +++++++++----
>  net/bluetooth/mgmt.c             |    9 +++++++++
>  3 files changed, 19 insertions(+), 4 deletions(-)

Applied (after fixing a couple of 82-character lines). Thanks.

Johan
