Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470303;
	b=p4IHLH0rFIm28HSxyqFioLrqz9mgIW1mV5pEAsTVVjryz24FRM8owVSavlTWfr5vDuQ5
	 UTB7hnjh2z+1cDe8nMO7NbrBORftJJmRZhw5hRdCuJmaVEnXaWFIQXAKgLJ1iYOOsbJCI
	 k2jkDb4TS37bQtZcHcwGBZKaL244dY4plUX6W0a/Ri+R7ugA6P3hOGArmRnruQ1xtNcmo
	 IShlc4BCXoteWEhGOaFHu08v/6s/aycxtRdwJ80IKfegnr7PP/zpXsRojn2Y0DXqOMUPU
	 P3beVNrLHJOF9d+nuS3gF5FYHvqODPNFhL2ZH3snHXuOZDzl0gxE2Es83seJMhxkbEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470303;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=lSeqIK0PBBgHtYRoXdEsfQM9jTkcgfWH9Q7VW8eoq0g=;
	b=dMUg8/cmrggfKVUmlAiyAyjjGNNYnZvdR6iaWH8rzEDN9OQUkzSjB1LJL+oOknwaZX0V
	 IHrz1jDaAArRu+O9NMFlo/YMIwbQPbIbjMTQd6lA00E0n374ECm4uhJI1P68jTDhJ1Qgv
	 EETZXAWlkxJ9HLJZR01tipXi10jHG9gR4m4jwPsQnXwudt7h9CJP0hxMdoCaY+N0DGxbj
	 7b8jTC7iw/Wju3WteqleaW8lHVGH7XRfVatRMQZDG8yJFklMKxhECx6H2pthq3nXYfa6d
	 HYWZxAaKquMdDX/01vnu/U+lpOcLlHc5Setu9b8i2uNeWfdWZQjUXzWr1dcTE6xomNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=B0wmpnMy;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9D606A31A;
	Sat, 31 Oct 2026 18:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85C9D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=B0wmpnMy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793470300; x=1793729500;
	bh=lSeqIK0PBBgHtYRoXdEsfQM9jTkcgfWH9Q7VW8eoq0g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B0wmpnMyLqtgFr7lDwsCcyVksLjd32kZMtSBGYn9XTZdy/6Fy9I26I5maeT1L6ncC
	 Kka9EgxsQ/718FRompnlBuwLaAF1hRr6Mk9aoVZ+bw7cuWE2nj5R2WUHS7bsdHFnJQ
	 +BhonP4s+zLhyoRf9oa8EXmV3jMZm6SpscUl5Hc3DSYHC57ulmBCZ8sxsR1JO4pSOD
	 QVmm9EFxFCquBc0AoesatIBQ7z18kI9o5TAj/rHvh0Q4H1eCN64TaZful+OIl18X1o
	 PfS+vCfRaK0lFCKve+PS0Ws0Nhro9cDx/XUoKjHswwW7VFe6evk1saknwcn62MR0lA
	 lu8ZbAP2i8U1w==
Date: Sat, 31 Oct 2026 18:11:34 +0000
To: "sean.wang@mediatek.com" <sean.wang@mediatek.com>
From: cochcoder <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Bluetooth: request LE data length for affected MT7922 firmware
Message-ID: <8KKEoS8MT2pzfktRobrq036IVbEiQd35GdzkqQhwmWGjLCoDzunM7ywDsZ29p2mTyFuLLdTFrGHBSslVj9f3H08_IdTQ62Bi3Z5m0sfKTRA=@proton.me>
In-Reply-To: <DJ38Anb7Pf2VQ5aDhvNBSOK4SWpeX-xdFIMH23jHtFrcLpmUBxpDhc_uoEFwr31ab1b2Igp9MUn1Qcyg4WG7n8w-rn-vWLsGUIHXRZ1XnQk=@proton.me>
References: <20261016170122.27119-1-cochcoder@proton.me> <CABBYNZ+fiAn9kNYUCVXRE1vjK_HggdVPzsA5rap5TZayqY11hg@mail.gmail.com> <DJ38Anb7Pf2VQ5aDhvNBSOK4SWpeX-xdFIMH23jHtFrcLpmUBxpDhc_uoEFwr31ab1b2Igp9MUn1Qcyg4WG7n8w-rn-vWLsGUIHXRZ1XnQk=@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: bf3266caf4653479932b4afad2eedf45a5dedd22
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Following up on this, has there been any updates on the affected firmware v=
ersions or a possible firmware fix?

Thanks,
Kyle


On Friday, October 16th, 2026 at 5:36 PM, cochcoder <cochcoder@proton.me> w=
rote:

> Hi Luiz, Sean and the MediaTek team,
>=20
> Thanks for your review Luiz. Sean/MediaTek team, could you help confirm w=
hether a firmware fix is planned for this MT7922 behavior?
>=20
> On my ASUS G614PR, with the Bluetooth USB ID 0489:e0f6 and firmware build=
 20260724143815, the controller accepts the maximum LE suggested default da=
ta lengths, but ASHA playback remains severely choppy. To the point that it=
's unusable due to only hearing a half second of audio every second or so.
>=20
> Sending an explicit LE Set Data Length request on the same connection pro=
duces a Data Length Change event reporting TX 251 octets/2120 =C2=B5s. Audi=
o delivery then rises from about 21.5 to 50 SDUs/s, and peak outstanding pa=
ckets fall from 32 to 3.
>=20
> Is this a known firmware issue? Do you happen to know which firmware vers=
ions and devices are affected? And does there happen to be an expected time=
line for a fix?
>=20
> I haven't established if other versions are affected as well. I'll wait f=
or your guidance before revising the quirk scope.
>=20
> Thanks,
> Kyle
>=20
>=20
>=20
>=20
> On Friday, October 16th, 2026 at 2:02 PM, Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:
>=20
> > Hi Kyle,
> >
> > On Fri, Oct 16, 2026 at 1:01=E2=80=AFPM Kyle Pepper <cochcoder@proton.m=
e> wrote:
> > >
> > > On an ASUS G614PR, the MT7922 USB controller 0489:e0f6 accepts maximu=
m
> > > LE suggested default data lengths, but ASHA playback remains severely
> > > choppy until the host sends an explicit LE Set Data Length request.
> > >
> > > With the firmware image dated 2026-07-24 14:38:15, a request on the s=
ame
> > > Cochlear Nucleus 8 connection produces a Data Length Change event wit=
h
> > > TX 251 octets/2120 us. Delivery rises from 21.5 to 50 audio SDUs/s an=
d
> > > the peak outstanding packet count falls from 32 to 3. Wi-Fi power sav=
e
> > > remains enabled. Playback also works with the automatic request in th=
e
> > > local 7.2.9 kernel build.
> > >
> > > Keep the existing suggested-default initialization and add a driver-s=
et
> > > quirk for the tested USB ID, chip and firmware image only. After a
> > > successful remote feature exchange, queue a request using the current
> > > host defaults if the central-role link and controller support DLE and
> > > the controller advertises LE Set Data Length.
> > >
> > > Hold a connection reference while queued and recheck its membership,
> > > state, role and capabilities before constructing the command. Release
> > > the reference on completion, cancellation or queue failure. Failure o=
f
> > > this optional request must not reject connection setup. Other control=
ler
> > > matches, PHY fallback and suggested defaults are unchanged.
> > >
> > > Assisted-by: OpenCode:gpt-6.1-sol
> > > Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> > > ---
> > > This is the first submission of this MediaTek-specific fix. It follow=
s
> > > Luiz's suggestion, in review of a separate generic DLE RFC on October=
 13,
> > > to use a driver-set quirk if a controller needs explicit DLE. It is n=
ot
> > > a revision or resend of that generic request.
> > >
> > > Differences from the separate generic RFC:
> > > - Require the exact tested USB ID, chip and firmware image build.
> > > - Keep the existing suggested-default write unchanged.
> > > - Require a central-role link, local/peer DLE and command support.
> > > - Use current host defaults, not hard-coded transmit limits.
> > > - Keep referenced queued work, cancellation and locked revalidation.
> > >
> > > Tested on ASUS G614PR with MT7922 and a Cochlear Nucleus 8:
> > > - Manual same-connection request: 21.5 -> 50 SDUs/s, peak queue 32 ->=
 3.
> > > - Automatic request: local 7.2.9-arch1-2-asha-mediatek boots and play=
back
> > >   is reported working; the matching firmware and quirk log are presen=
t.
> > >   This local kernel/userspace stack has other ASHA patches. This is n=
ot
> > >   a vanilla upstream-kernel hardware test or a post-boot throughput t=
race.
> > > - Broader suspend/resume, battery, other-profile and native concurren=
cy
> > >   coverage is not claimed. An earlier brief quality drop is not assig=
ned
> > >   a cause or declared independently resolved.
> > >
> > > Validation on Bluetooth upstream base 185c11232d5f:
> > > - Four native Bluetooth objects compile with W=3D1 on an x86_64 diagn=
ostic
> > >   configuration (Rust disabled); this is not a full upstream kernel b=
uild.
> > > - 37 source-extracted ASan/UBSan controls pass, with unpatched baseli=
ne
> > >   and negative controls. These are not in-kernel concurrency tests.
> > > - Equivalent backports pass the same controls on pinned 7.2.y, 6.18.y
> > >   and 6.12.y snapshots. The 6.18.y and 6.12.y variants also compile t=
he
> > >   four native objects with W=3D1. No older-kernel hardware boot is cl=
aimed.
> > >
> > > The firmware gate uses the selected image header. If setup reuses an
> > > already-resident image, this is not an independent read of that image=
's
> > > identity; the observed boot log matches the tested image. Please revi=
ew
> > > this limitation before widening the match to other firmware or device=
s.
> > >
> > > Stable consideration: this fixes a real firmware interoperability iss=
ue,
> > > but the change exceeds the usual 100-line-with-context stable guideli=
ne.
> > > Please assess stable suitability after upstream review. No introducin=
g
> > > kernel commit has been established, so no speculative Fixes tag is ad=
ded.
> > > The 6.18.y backport uses the older connection-feature layout. The 6.1=
2.y
> > > backport also uses scalar quirks and checks queued duplicates before
> > > taking a reference, since queue_once() there returns zero for duplica=
tes.
> > > Backport application/API differences and checks are documented locall=
y;
> > > no stable acceptance, older-kernel hardware test or public issue clos=
ure
> > > is claimed. Please do not queue an unreviewed backport directly.
> > >
> > >  drivers/bluetooth/btmtk.c        | 29 ++++++++++++++++
> > >  include/net/bluetooth/hci.h      |  6 ++++
> > >  include/net/bluetooth/hci_sync.h |  1 +
> > >  net/bluetooth/hci_event.c        |  8 +++++
> > >  net/bluetooth/hci_sync.c         | 58 ++++++++++++++++++++++++++++++=
++
> > >  5 files changed, 102 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > > index 75483d823..cab5c4c36 100644
> > > --- a/drivers/bluetooth/btmtk.c
> > > +++ b/drivers/bluetooth/btmtk.c
> > > @@ -47,6 +47,24 @@ struct btmtk_global_desc {
> > >         __le32 section_num;
> > >  } __packed;
> > >
> > > +static bool btmtk_needs_manual_dle(struct hci_dev *hdev, u32 dev_id,
> > > +                                  const struct btmtk_patch_header *h=
dr)
> > > +{
> > > +       static const u8 affected_build[16] =3D "20260724143815";
> > > +       struct btmtk_data *data;
> > > +
> > > +       if (hdev->bus !=3D HCI_USB || dev_id !=3D 0x7922)
> > > +               return false;
> > > +
> > > +       data =3D hci_get_priv(hdev);
> > > +       if (!data->udev)
> > > +               return false;
> > > +
> > > +       return le16_to_cpu(data->udev->descriptor.idVendor) =3D=3D 0x=
0489 &&
> > > +              le16_to_cpu(data->udev->descriptor.idProduct) =3D=3D 0=
xe0f6 &&
> > > +              !memcmp(hdr->datetime, affected_build, sizeof(affected=
_build));
> > > +}
> > > +
> > >  struct btmtk_section_map {
> > >         __le32 sectype;
> > >         __le32 secoffset;
> > > @@ -219,6 +237,9 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hde=
v, const char *fwname,
> > >         u32 section_num, dl_size, section_offset;
> > >         u8 cmd[64];
> > >
> > > +       /* Re-evaluate the firmware-specific workaround on every setu=
p. */
> > > +       hci_clear_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN);
> > > +
> > >         err =3D request_firmware(&fw, fwname, &hdev->dev);
> > >         if (err < 0) {
> > >                 bt_dev_err(hdev, "Failed to load firmware file (%d)",=
 err);
> > > @@ -347,6 +368,14 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hd=
ev, const char *fwname,
> > >         /* Wait a few moments for firmware activation done */
> > >         usleep_range(100000, 120000);
> > >
> > > +       /* This firmware accepts maximum suggested defaults but needs=
 an
> > > +        * explicit per-link request to negotiate a larger TX data le=
ngth.
> > > +        */
> > > +       if (btmtk_needs_manual_dle(hdev, dev_id, hdr)) {
> > > +               hci_set_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN);
> > > +               bt_dev_info(hdev, "Using explicit LE data length requ=
ests");
> > > +       }
> > > +
> > >  err_release_fw:
> > >         release_firmware(fw);
> > >
> > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.=
h
> > > index 1c992e875..513ca226d 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -340,6 +340,12 @@ enum {
> > >          */
> > >         HCI_QUIRK_BROKEN_LE_CODED,
> > >
> > > +       /* The controller needs an explicit LE Set Data Length reques=
t for
> > > +        * each central-role connection despite accepting suggested d=
efaults.
> > > +        * Set during the vendor setup callback for affected firmware=
 only.
> > > +        */
> > > +       HCI_QUIRK_NEEDS_LE_SET_DATA_LEN,
> > > +
> > >         /*
> > >          * When this quirk is set, the HCI_OP_READ_ENC_KEY_SIZE comma=
nd is
> > >          * skipped during an HCI_EV_ENCRYPT_CHANGE event. This is req=
uired
> > > diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth=
/hci_sync.h
> > > index 59cb918d1..5a37d3e50 100644
> > > --- a/include/net/bluetooth/hci_sync.h
> > > +++ b/include/net/bluetooth/hci_sync.h
> > > @@ -194,3 +194,4 @@ int hci_le_read_remote_features(struct hci_conn *=
conn);
> > >
> > >  int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
> > >  int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys);
> > > +int hci_le_set_data_len(struct hci_conn *conn);
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 56ad10ab9..d78f330e3 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -6875,6 +6875,14 @@ static void hci_le_remote_feat_complete_evt(st=
ruct hci_dev *hdev, void *data,
> > >                                 conn->le_tx_def_phys &=3D ~HCI_LE_SET=
_PHY_CODED;
> > >                                 conn->le_rx_def_phys &=3D ~HCI_LE_SET=
_PHY_CODED;
> > >                         }
> > > +
> > > +                       if (hci_test_quirk(hdev, HCI_QUIRK_NEEDS_LE_S=
ET_DATA_LEN) &&
> > > +                           conn->role =3D=3D HCI_ROLE_MASTER &&
> > > +                           (hdev->commands[33] & BIT(6)) &&
> > > +                           (hdev->le_features[0] & HCI_LE_DATA_LEN_E=
XT) &&
> > > +                           (conn->le_features[0] & HCI_LE_DATA_LEN_E=
XT) &&
> > > +                           hdev->le_def_tx_len > 27)
> > > +                               hci_le_set_data_len(conn);
> > >                 }
> > >
> > >                 if (conn->state =3D=3D BT_CONFIG) {
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index 7ac26daba..f919249e9 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -8152,3 +8152,61 @@ int hci_le_set_phy(struct hci_conn *conn, u8 t=
x_phys, u8 rx_phys)
> > >
> > >         return (err =3D=3D -EEXIST) ? 0 : err;
> > >  }
> > > +
> > > +static void le_set_data_len_complete(struct hci_dev *hdev, void *dat=
a, int err)
> > > +{
> > > +       struct hci_conn *conn =3D data;
> > > +
> > > +       bt_dev_dbg(hdev, "err %d", err);
> > > +       if (err && err !=3D -ECANCELED && err !=3D -ENODEV)
> > > +               bt_dev_warn(hdev, "Failed to set LE data length (%d)"=
, err);
> > > +       hci_conn_put(conn);
> > > +}
> > > +
> > > +static int hci_le_set_data_len_sync(struct hci_dev *hdev, void *data=
)
> > > +{
> > > +       struct hci_conn *conn =3D data;
> > > +       struct hci_cp_le_set_data_len cp;
> > > +
> > > +       hci_dev_lock(hdev);
> > > +
> > > +       if (!hci_conn_valid(hdev, conn) || conn->type !=3D LE_LINK ||
> > > +           conn->role !=3D HCI_ROLE_MASTER ||
> > > +           (conn->state !=3D BT_CONNECTED && conn->state !=3D BT_CON=
FIG)) {
> > > +               hci_dev_unlock(hdev);
> > > +               return -ECANCELED;
> > > +       }
> > > +
> > > +       /* Use the current suggested defaults, including later host c=
hanges. */
> > > +       if (!hci_test_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN) ||
> > > +           !(hdev->commands[33] & BIT(6)) ||
> > > +           !(hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) ||
> > > +           !(conn->le_features[0] & HCI_LE_DATA_LEN_EXT) ||
> > > +           hdev->le_def_tx_len <=3D 27) {
> > > +               hci_dev_unlock(hdev);
> > > +               return 0;
> > > +       }
> > > +
> > > +       cp.handle =3D cpu_to_le16(conn->handle);
> > > +       cp.tx_len =3D cpu_to_le16(hdev->le_def_tx_len);
> > > +       cp.tx_time =3D cpu_to_le16(hdev->le_def_tx_time);
> > > +
> > > +       hci_dev_unlock(hdev);
> > > +
> > > +       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DATA_LEN,
> > > +                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT=
);
> > > +}
> > > +
> > > +int hci_le_set_data_len(struct hci_conn *conn)
> > > +{
> > > +       struct hci_dev *hdev =3D conn->hdev;
> > > +       int err;
> > > +
> > > +       err =3D hci_cmd_sync_queue_once(hdev, hci_le_set_data_len_syn=
c,
> > > +                                     hci_conn_get(conn),
> > > +                                     le_set_data_len_complete);
> > > +       if (err)
> > > +               hci_conn_put(conn);
> > > +
> > > +       return (err =3D=3D -EEXIST) ? 0 : err;
> > > +}
> > >
> > > base-commit: 185c11232d5f586489bb3b74e6bcc7a6560ddd40
> >
> > Perhaps before we go into the whole trouble of adding a quirk we
> > should check with MediaTek folks if there is a fix planned for this,
> > since this is actually a firmware bug. If there isn't one and a fix
> > would take time to be validated, I'd proceed with the quirk but I
> > don't think gating it on a specific build is a good idea; there might
> > be other firmware releases affected by this, unless MediaTek can
> > confirm this is exclusive to a single image in which case we should
> > treat it as a regression.
> >
> > --
> > Luiz Augusto von Dentz
> >
