Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Enable LTK distribution to slave devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1391032559-25183-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 30 Jan 2014 13:39:06 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <7AA3B141-D2F8-4D1B-AC1A-FB359D358178@holtmann.org>
References: <1391032559-25183-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> So far we've only been requesting the LTK to be distributed to the
> master (initiator) of pairing, which is usually enough since it's the
> master that will establish future connections and initiate encryption.
> However, in the case that both devices support switching to the opposing
> role (which seems to be increasingly common) pairing will have to
> performed again since the "new" master will not have all information.
> 
> As there is no real harm in it, this patch updates the code to always
> try distributing the LTK also to the slave device, thereby enabling role
> switches for future connections.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

