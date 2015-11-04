Return-Path: <johan.hedberg@gmail.com>
Date: Wed, 4 Nov 2015 08:13:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: Move BR/EDR default events behind its
 features
Message-ID: <20151104061326.GA26772@t440s.P-661HNU-F1>
References: <1446367191-67668-2-git-send-email-marcel@holtmann.org>
 <20151101134205.GB21304@t440s.P-661HNU-F1>
 <E4BDA832-3DD5-4EA4-9F9F-E065DB75A2E8@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E4BDA832-3DD5-4EA4-9F9F-E065DB75A2E8@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Nov 03, 2015, Marcel Holtmann wrote:
> Hi Johan,
> 
> >> There are some BR/EDR default events for Bluetooth 1.2 or later
> >> controllers that are not conditional on their features being present.
> >> 
> >> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >> ---
> >> net/bluetooth/hci_core.c | 12 ++++++++----
> >> 1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > I realize I already applied this one, but:
> > 
> >> +	if (lmp_esco_capable(hdev)) {
> >> +		events[5] |= 0x08; /* Synchronous Connection Complete */
> >> +		events[5] |= 0x10; /* Synchronous Connection Changed */
> >> +	}
> > 
> > Synchronous Connection Complete is relevant also for non-ESCO
> > controllers, isn't it?
> 
> that is true, but if you look at hci_conn.c and sco.c, then you see we
> use the same logic there to decide if we use Add SCO or Setup Sync
> Connection. So this just brings that in sync.

Understood, it took some time for me to figure out from the core spec
exactly under which conditions Conn Complete or Sync Conn Complete will
happen.

Johan
