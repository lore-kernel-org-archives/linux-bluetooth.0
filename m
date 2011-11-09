Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] Bluetooth: Remove redundant hci_dev comparisons in
 mgmt lookups
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <padovan@profusion.mobi>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Date: Wed, 09 Nov 2011 23:46:11 +0900
In-Reply-To: <20111109143831.GI25584@joana>
References: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
	 <1320839938-24873-2-git-send-email-johan.hedberg@gmail.com>
	 <20111109143831.GI25584@joana>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320849974.15441.341.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > Now that pending commands are hci_dev specific there's no need to check
> > whether a command matches hci_dev when iterating through them.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> >  net/bluetooth/mgmt.c |   15 ++-------------
> >  1 files changed, 2 insertions(+), 13 deletions(-)
> 
> Patch 1 and 2 were applied, thanks. 
> I'll leave patch 3 here for more one or two days in case someone has a comment
> to do. It's fine with me btw.

this is fine with me as well.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


