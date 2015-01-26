Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Jan 2015 22:19:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Enforce zero-valued hash/rand192 for LE OOB
Message-ID: <20150126201930.GA30866@t440s.P-661HNU-F1>
References: <1422277671-26069-1-git-send-email-johan.hedberg@gmail.com>
 <4114F7BB-C37B-4D42-B182-7F2685817ED3@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4114F7BB-C37B-4D42-B182-7F2685817ED3@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 26, 2015, Marcel Holtmann wrote:
> > Until legacy SMP OOB pairing is implemented user space should be given a
> > clear error when trying to use it. This patch adds a corresponding check
> > to the Add Remote OOB Data handler function which returns "invalid
> > parameters" if non-zero Rand192 or Hash192 parameters were given for an
> > LE address.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > net/bluetooth/mgmt.c | 14 ++++++++++++++
> > 1 file changed, 14 insertions(+)
> > 
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 25e40e82b9a2..cf257cc0e09d 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -3673,6 +3673,20 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
> > 		u8 status;
> > 
> > 		if (bdaddr_type_is_le(cp->addr.type)) {
> > +			static const u8 z16[16] = { 0 };
> 
> aren't these suppose to be done as = { 0, }; to ensure that the whole
> array is zeroed?

I think either way should work. Even if there was no initialization at
all the C-standard guarantees that static variables are initialized to
zero unless initialized explicitly (this includes aggregate types like
arrays). We could however leave out the 'static' part with something
like you suggested since it's essentially redundant as far as the
initialization is concerned.

Johan
