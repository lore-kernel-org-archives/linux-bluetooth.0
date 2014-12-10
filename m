Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Dec 2014 14:37:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: JAGANATH KANAKKASSERY <jaganath.k@samsung.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Fix missing hci_dev_lock/unlock
Message-ID: <20141210123752.GA30555@t440s.lan>
References: <935145568.61511418213470087.JavaMail.weblogic@epmlwas05a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <935145568.61511418213470087.JavaMail.weblogic@epmlwas05a>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath & Marcel,

On Wed, Dec 10, 2014, JAGANATH KANAKKASSERY wrote:
> >> 	err = hci_dev_do_open(hdev);
> >> 	if (err < 0) {
> >> +		hci_dev_lock(hdev);
> >> 		mgmt_set_powered_failed(hdev, err);
> >> +		hci_dev_unlock(hdev);
> >> 		return;
> >> 	}
> 
> >I wonder is some of the mgmt_ function should just take the hci_dev
> >lock. Are there cases where we don't want them to take the look?
> 
> There are many mgmt_functions called from hci_event.c which don't
> require lock.  You prefer moving the lock inside
> mgmt_set_powered_failed()?

This should be kept consistent imo. Either all mgmt_* functions called
from hci_core/event.c should be responsible for taking the lock
themselves or none should be. I think right now the general rule is that
hci_core/event.c take the lock first, and this is mainly because a lot
of code that needed calling into mgmt.c was already holding the lock.
I.e. moving the taking into mgmt.c would for many places have required
awkward looking hdev_unlock(); mgmt_foo(); hdev_lock(); constructions.

Johan
