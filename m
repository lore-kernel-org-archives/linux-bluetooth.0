Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Feb 2014 18:29:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 01/10] Bluetooth: Remove SMP data specific crypto context
Message-ID: <20140218162926.GB13953@x220.p-661hnu-f1>
References: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
 <1392736479-8808-2-git-send-email-johan.hedberg@gmail.com>
 <596B741F-5844-4C49-BE66-5413510692C4@holtmann.org>
 <20140218162438.GA13953@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140218162438.GA13953@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 18, 2014, Johan Hedberg wrote:
> > so I am curious now to what happens if we are running SMP and at the
> > same time are doing RPA resolving. Can the same crypto context be used
> > that way?
> 
> That's a fair point, and after a quick look through the crypto API it
> seems like this might not be safe. A simple fix would be to ensure that
> any access is between hci_dev_lock & hci_dev_unlock.

A quick check shows that all access external to smp.c is already done
under the hdev lock but the two places internal to smp.c are not (both
of which are from within workqueue callbacks, so taking the lock there
should be safe). Do you agree that this is the simplest/best solution?

Johan
