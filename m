Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1264027973.5591.241.camel@localhost.localdomain>
References: <1264017679-19324-1-git-send-email-lrodriguez@atheros.com>
	<1264019268.5591.223.camel@localhost.localdomain> <20100120210813.GF10113@tux>
	<1264027973.5591.241.camel@localhost.localdomain>
From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Date: Wed, 20 Jan 2010 15:01:17 -0800
Message-ID: <43e72e891001201501n2088a40fn7d6ca2bef50c7c10@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add DFU driver for Atheros Bluetooth chipset
	AR3011
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luis Rodriguez <Luis.Rodriguez@atheros.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Vikram Kandukuri <Vikram.Kandukuri@atheros.com>, SongXing Xu <SongXing.Xu@atheros.com>,
	David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 20, 2010 at 2:52 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> As I said, if Dave is willing to take it, then I cherry-pick it for you
> and include it with my next round of fixes.

Well it enables hardware, so yes, I think it'd be good to add to
2.6.33-rc5, despite its historical issues on route upstream. Otherwise
I have to poke distributions to carry the driver externally anyway,
and I don't see the point in that if we still have a few RC cycles
left and this driver is really small.

Dave, please let me know if including this driver is unacceptable. I
honestly fail to understand the reasons for it to not go into
2.6.33-rcX.

  Luis
