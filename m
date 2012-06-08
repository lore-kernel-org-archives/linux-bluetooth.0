Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Jun 2012 01:22:58 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: Re: [PATCH] Bluetooth: Fix flags of mgmt_device_found event
Message-ID: <20120608042258.GA1546@joana>
References: <1338577525-9182-1-git-send-email-jefferson.delfes@openbossa.org>
 <20120601231335.GI24769@joana>
 <CA+_d9qcuTEor62f9R5=1hLJNZLttvGXT--838mO-mQKtGSJanA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+_d9qcuTEor62f9R5=1hLJNZLttvGXT--838mO-mQKtGSJanA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

* Jefferson Delfes <jefferson.delfes@openbossa.org> [2012-06-04 09:31:13 -0=
400]:

> Hi Gustavo,
>=20
> On Fri, Jun 1, 2012 at 7:13 PM, Gustavo Padovan <gustavo@padovan.org> wro=
te:
> > Jefferson,
> >
> > * Jefferson Delfes <jefferson.delfes@openbossa.org> [2012-06-01 15:05:2=
5 -0400]:
> >
> >> Change flags field to matches userspace structure.
> >> This field needs to be converted to little endian before forward it.
> >>
> >> Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
> >> ---
> >> =A0include/net/bluetooth/mgmt.h | =A0 =A02 +-
> >> =A0net/bluetooth/mgmt.c =A0 =A0 =A0 =A0 | =A0 =A05 +++--
> >> =A02 files changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt=
=2Eh
> >> index ebfd91f..3a8a714 100644
> >> --- a/include/net/bluetooth/mgmt.h
> >> +++ b/include/net/bluetooth/mgmt.h
> >> @@ -435,7 +435,7 @@ struct mgmt_ev_auth_failed {
> >> =A0struct mgmt_ev_device_found {
> >> =A0 =A0 =A0 struct mgmt_addr_info addr;
> >> =A0 =A0 =A0 __s8 =A0 =A0rssi;
> >> - =A0 =A0 __u8 =A0 =A0flags[4];
> >> + =A0 =A0 __le32 =A0flags;
> >
> > Seems we are breaking API here, MGMT API is stable now and should have =
such
> > kind of change. However I wanna see what Marcel and Johan has to say ab=
out
> > this.
> >
> > =A0 =A0 =A0 =A0Gustavo
>=20
> As Johan pointed, we send the same bytes in same order. This patch
> just copy userspace changes in mgmt_ev_device_found structure. There
> was a possible bug on big endian in userspace, but it was fixed in
> previous patch.

Yes, this patch don't change the order of bytes, I tried to apply it but it
failed. Please rebase on bluetooth-next and resend it.

	Gustavo
