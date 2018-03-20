Return-Path: <tony@atomide.com>
Date: Tue, 20 Mar 2018 13:14:49 -0700
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, robh@kernel.org
Subject: Re: [RFC] Bluetooth: hci_ll: Convert to use h4_recv_buf helper
Message-ID: <20180320201449.GV5796@atomide.com>
References: <20180320083704.11705-1-marcel@holtmann.org>
 <4DBD77C5-BBFD-4952-A296-30187D85A07F@holtmann.org>
 <20180320172827.ohla5v4a23v3u3qq@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180320172827.ohla5v4a23v3u3qq@earth.universe>
List-ID: <linux-bluetooth.vger.kernel.org>

* Sebastian Reichel <sre@kernel.org> [180320 17:30]:
> Hi,
>=20
> On Tue, Mar 20, 2018 at 04:50:37PM +0100, Marcel Holtmann wrote:
> > Hi,
> >=20
> > > The HCILL or eHCILL protocol from TI is actually an H:4 protocol with=
 a
> > > few extra events and thus can also use the h4_recv_buf helper. Instead
> > > of open coding the same funtionality add the extra events to the pack=
et
> > > description table and use h4_recv_buf.
> > >=20
> > > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > > ---
> > > drivers/bluetooth/Kconfig  |   1 +
> > > drivers/bluetooth/hci_ll.c | 214 +++++++++++++++---------------------=
---------
> > > 2 files changed, 70 insertions(+), 145 deletions(-)
> >=20
> > is anybody able to test this change for me and verify that it doesn=E2=
=80=99t break things.
>=20
> The diffstat looks nice :) I can give it a test on Motorola Droid 4
> later this week. If you want feedback a bit earlier, maybe Tony
> can give it a try (added to cc).

I tried applying it from the mailing list archive against
current Linux next and -rc6 but it failed:

patching file drivers/bluetooth/Kconfig
Hunk #1 succeeded at 147 with fuzz 2 (offset -13 lines).
patching file drivers/bluetooth/hci_ll.c
Hunk #2 succeeded at 88 (offset 4 lines).
Hunk #3 FAILED at 364.

Any ideas which patch(es) I might be missing?

Regards,

Tony
