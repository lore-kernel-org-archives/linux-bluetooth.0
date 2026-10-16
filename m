Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BFD3C10A9
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186581; cv=none; b=THtSlL1ZpTg8KInkidyFUFV/+9hVIaj5NBAtsvEoyJkjtvl2DosXtHGmeRBBCKXNM4Oql5BwoEDp8z82XLMa6+T8fORT7R3ANdU89KCCiQ5C5luW2KVIr2aoZWPcYViO1Kxxr5maPDgB/PQPVX7vfYEHJ1v8fCgakvsfB2yFM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186581; c=relaxed/simple;
	bh=5ReyAF79Y2H5ZmKrnD6IlLJLEsiWCqO0Uq/Tbfbh1Xk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KatbJZSQ0vZT1Pxvl9cNXLBlI4q7B+pK2K9BHCJkzBCp6kiptNus4dmg+EjNJojFeMCWNVxrYwwhLwUKTlRHKWrHf/qjoyFPQIYgbo53XM/xQAuPMF2fo2ZU9+8GFnvj4Wq7g6h18r3HzDjeXEfbVyjFq0X5gUjEjWGU7ZFmhRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=h6Crjog7; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="h6Crjog7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792186567; x=1792445767;
	bh=gmLIym9rSN8vTpuPSf61EefSdlT3jVo3cGGN7mKkKTs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h6Crjog7ESPF3WamEwKtQ/0zZBH1QmvMhzysg+EqUGu5SATcDqeiUz6NKsVLvVycd
	 9LNYMTMAhtFNAl0aWA9kZtBiaVFtEtb+SHgF9I8VMT2GMDBkq8EdAvNZgWrvmSuo9F
	 o/mBGcIlSgPsgoYN1klDrwwjKO118SorVI6z7eP7HcMYVd15DBtL/YEdk5QhTU2LlF
	 3uqxjfIQT5v2us7RR5zW7N5C5+Ucc9mEFUmgQAfczLSaXif13/VZydpw3uBvUDJeWi
	 YZCF6B46+2qxVYEnWdu2tqIIqdAP7olMiIPurzYShe+YIyoRaCtpuY4ysNk7iOAy7w
	 GhtJ5dx3XbnsQ==
Date: Fri, 16 Oct 2026 21:36:00 +0000
To: "sean.wang@mediatek.com" <sean.wang@mediatek.com>
From: cochcoder <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Bluetooth: request LE data length for affected MT7922 firmware
Message-ID: <DJ38Anb7Pf2VQ5aDhvNBSOK4SWpeX-xdFIMH23jHtFrcLpmUBxpDhc_uoEFwr31ab1b2Igp9MUn1Qcyg4WG7n8w-rn-vWLsGUIHXRZ1XnQk=@proton.me>
In-Reply-To: <CABBYNZ+fiAn9kNYUCVXRE1vjK_HggdVPzsA5rap5TZayqY11hg@mail.gmail.com>
References: <20261016170122.27119-1-cochcoder@proton.me> <CABBYNZ+fiAn9kNYUCVXRE1vjK_HggdVPzsA5rap5TZayqY11hg@mail.gmail.com>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: cf88574b35ba52a78b8da1e5b1c0666c684bb84e
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz, Sean and the MediaTek team,

Thanks for your review Luiz. Sean/MediaTek team, could you help confirm whe=
ther a firmware fix is planned for this MT7922 behavior?

On my ASUS G614PR, with the Bluetooth USB ID 0489:e0f6 and firmware build 2=
0260724143815, the controller accepts the maximum LE suggested default data=
 lengths, but ASHA playback remains severely choppy. To the point that it's=
 unusable due to only hearing a half second of audio every second or so.=20

Sending an explicit LE Set Data Length request on the same connection produ=
ces a Data Length Change event reporting TX 251 octets/2120 =C2=B5s. Audio =
delivery then rises from about 21.5 to 50 SDUs/s, and peak outstanding pack=
ets fall from 32 to 3.

Is this a known firmware issue? Do you happen to know which firmware versio=
ns and devices are affected? And does there happen to be an expected timeli=
ne for a fix?

I haven't established if other versions are affected as well. I'll wait for=
 your guidance before revising the quirk scope.

Thanks,
Kyle




On Friday, October 16th, 2026 at 2:02 PM, Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:

> Hi Kyle,
>=20
> On Fri, Oct 16, 2026 at 1:01=E2=80=AFPM Kyle Pepper <cochcoder@proton.me>=
 wrote:
> >
> > On an ASUS G614PR, the MT7922 USB controller 0489:e0f6 accepts maximum
> > LE suggested default data lengths, but ASHA playback remains severely
> > choppy until the host sends an explicit LE Set Data Length request.
> >
> > With the firmware image dated 2026-07-24 14:38:15, a request on the sam=
e
> > Cochlear Nucleus 8 connection produces a Data Length Change event with
> > TX 251 octets/2120 us. Delivery rises from 21.5 to 50 audio SDUs/s and
> > the peak outstanding packet count falls from 32 to 3. Wi-Fi power save
> > remains enabled. Playback also works with the automatic request in the
> > local 7.2.9 kernel build.
> >
> > Keep the existing suggested-default initialization and add a driver-set
> > quirk for the tested USB ID, chip and firmware image only. After a
> > successful remote feature exchange, queue a request using the current
> > host defaults if the central-role link and controller support DLE and
> > the controller advertises LE Set Data Length.
> >
> > Hold a connection reference while queued and recheck its membership,
> > state, role and capabilities before constructing the command. Release
> > the reference on completion, cancellation or queue failure. Failure of
> > this optional request must not reject connection setup. Other controlle=
r
> > matches, PHY fallback and suggested defaults are unchanged.
> >
> > Assisted-by: OpenCode:gpt-6.1-sol
> > Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> > ---
> > This is the first submission of this MediaTek-specific fix. It follows
> > Luiz's suggestion, in review of a separate generic DLE RFC on October 1=
3,
> > to use a driver-set quirk if a controller needs explicit DLE. It is not
> > a revision or resend of that generic request.
> >
> > Differences from the separate generic RFC:
> > - Require the exact tested USB ID, chip and firmware image build.
> > - Keep the existing suggested-default write unchanged.
> > - Require a central-role link, local/peer DLE and command support.
> > - Use current host defaults, not hard-coded transmit limits.
> > - Keep referenced queued work, cancellation and locked revalidation.
> >
> > Tested on ASUS G614PR with MT7922 and a Cochlear Nucleus 8:
> > - Manual same-connection request: 21.5 -> 50 SDUs/s, peak queue 32 -> 3=
.
> > - Automatic request: local 7.2.9-arch1-2-asha-mediatek boots and playba=
ck
> >   is reported working; the matching firmware and quirk log are present.
> >   This local kernel/userspace stack has other ASHA patches. This is not
> >   a vanilla upstream-kernel hardware test or a post-boot throughput tra=
ce.
> > - Broader suspend/resume, battery, other-profile and native concurrency
> >   coverage is not claimed. An earlier brief quality drop is not assigne=
d
> >   a cause or declared independently resolved.
> >
> > Validation on Bluetooth upstream base 185c11232d5f:
> > - Four native Bluetooth objects compile with W=3D1 on an x86_64 diagnos=
tic
> >   configuration (Rust disabled); this is not a full upstream kernel bui=
ld.
> > - 37 source-extracted ASan/UBSan controls pass, with unpatched baseline
> >   and negative controls. These are not in-kernel concurrency tests.
> > - Equivalent backports pass the same controls on pinned 7.2.y, 6.18.y
> >   and 6.12.y snapshots. The 6.18.y and 6.12.y variants also compile the
> >   four native objects with W=3D1. No older-kernel hardware boot is clai=
med.
> >
> > The firmware gate uses the selected image header. If setup reuses an
> > already-resident image, this is not an independent read of that image's
> > identity; the observed boot log matches the tested image. Please review
> > this limitation before widening the match to other firmware or devices.
> >
> > Stable consideration: this fixes a real firmware interoperability issue=
,
> > but the change exceeds the usual 100-line-with-context stable guideline=
.
> > Please assess stable suitability after upstream review. No introducing
> > kernel commit has been established, so no speculative Fixes tag is adde=
d.
> > The 6.18.y backport uses the older connection-feature layout. The 6.12.=
y
> > backport also uses scalar quirks and checks queued duplicates before
> > taking a reference, since queue_once() there returns zero for duplicate=
s.
> > Backport application/API differences and checks are documented locally;
> > no stable acceptance, older-kernel hardware test or public issue closur=
e
> > is claimed. Please do not queue an unreviewed backport directly.
> >
> >  drivers/bluetooth/btmtk.c        | 29 ++++++++++++++++
> >  include/net/bluetooth/hci.h      |  6 ++++
> >  include/net/bluetooth/hci_sync.h |  1 +
> >  net/bluetooth/hci_event.c        |  8 +++++
> >  net/bluetooth/hci_sync.c         | 58 ++++++++++++++++++++++++++++++++
> >  5 files changed, 102 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > index 75483d823..cab5c4c36 100644
> > --- a/drivers/bluetooth/btmtk.c
> > +++ b/drivers/bluetooth/btmtk.c
> > @@ -47,6 +47,24 @@ struct btmtk_global_desc {
> >         __le32 section_num;
> >  } __packed;
> >
> > +static bool btmtk_needs_manual_dle(struct hci_dev *hdev, u32 dev_id,
> > +                                  const struct btmtk_patch_header *hdr=
)
> > +{
> > +       static const u8 affected_build[16] =3D "20260724143815";
> > +       struct btmtk_data *data;
> > +
> > +       if (hdev->bus !=3D HCI_USB || dev_id !=3D 0x7922)
> > +               return false;
> > +
> > +       data =3D hci_get_priv(hdev);
> > +       if (!data->udev)
> > +               return false;
> > +
> > +       return le16_to_cpu(data->udev->descriptor.idVendor) =3D=3D 0x04=
89 &&
> > +              le16_to_cpu(data->udev->descriptor.idProduct) =3D=3D 0xe=
0f6 &&
> > +              !memcmp(hdr->datetime, affected_build, sizeof(affected_b=
uild));
> > +}
> > +
> >  struct btmtk_section_map {
> >         __le32 sectype;
> >         __le32 secoffset;
> > @@ -219,6 +237,9 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev,=
 const char *fwname,
> >         u32 section_num, dl_size, section_offset;
> >         u8 cmd[64];
> >
> > +       /* Re-evaluate the firmware-specific workaround on every setup.=
 */
> > +       hci_clear_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN);
> > +
> >         err =3D request_firmware(&fw, fwname, &hdev->dev);
> >         if (err < 0) {
> >                 bt_dev_err(hdev, "Failed to load firmware file (%d)", e=
rr);
> > @@ -347,6 +368,14 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev=
, const char *fwname,
> >         /* Wait a few moments for firmware activation done */
> >         usleep_range(100000, 120000);
> >
> > +       /* This firmware accepts maximum suggested defaults but needs a=
n
> > +        * explicit per-link request to negotiate a larger TX data leng=
th.
> > +        */
> > +       if (btmtk_needs_manual_dle(hdev, dev_id, hdr)) {
> > +               hci_set_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN);
> > +               bt_dev_info(hdev, "Using explicit LE data length reques=
ts");
> > +       }
> > +
> >  err_release_fw:
> >         release_firmware(fw);
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 1c992e875..513ca226d 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -340,6 +340,12 @@ enum {
> >          */
> >         HCI_QUIRK_BROKEN_LE_CODED,
> >
> > +       /* The controller needs an explicit LE Set Data Length request =
for
> > +        * each central-role connection despite accepting suggested def=
aults.
> > +        * Set during the vendor setup callback for affected firmware o=
nly.
> > +        */
> > +       HCI_QUIRK_NEEDS_LE_SET_DATA_LEN,
> > +
> >         /*
> >          * When this quirk is set, the HCI_OP_READ_ENC_KEY_SIZE command=
 is
> >          * skipped during an HCI_EV_ENCRYPT_CHANGE event. This is requi=
red
> > diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/h=
ci_sync.h
> > index 59cb918d1..5a37d3e50 100644
> > --- a/include/net/bluetooth/hci_sync.h
> > +++ b/include/net/bluetooth/hci_sync.h
> > @@ -194,3 +194,4 @@ int hci_le_read_remote_features(struct hci_conn *co=
nn);
> >
> >  int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
> >  int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys);
> > +int hci_le_set_data_len(struct hci_conn *conn);
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 56ad10ab9..d78f330e3 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6875,6 +6875,14 @@ static void hci_le_remote_feat_complete_evt(stru=
ct hci_dev *hdev, void *data,
> >                                 conn->le_tx_def_phys &=3D ~HCI_LE_SET_P=
HY_CODED;
> >                                 conn->le_rx_def_phys &=3D ~HCI_LE_SET_P=
HY_CODED;
> >                         }
> > +
> > +                       if (hci_test_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET=
_DATA_LEN) &&
> > +                           conn->role =3D=3D HCI_ROLE_MASTER &&
> > +                           (hdev->commands[33] & BIT(6)) &&
> > +                           (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT=
) &&
> > +                           (conn->le_features[0] & HCI_LE_DATA_LEN_EXT=
) &&
> > +                           hdev->le_def_tx_len > 27)
> > +                               hci_le_set_data_len(conn);
> >                 }
> >
> >                 if (conn->state =3D=3D BT_CONFIG) {
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 7ac26daba..f919249e9 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -8152,3 +8152,61 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_=
phys, u8 rx_phys)
> >
> >         return (err =3D=3D -EEXIST) ? 0 : err;
> >  }
> > +
> > +static void le_set_data_len_complete(struct hci_dev *hdev, void *data,=
 int err)
> > +{
> > +       struct hci_conn *conn =3D data;
> > +
> > +       bt_dev_dbg(hdev, "err %d", err);
> > +       if (err && err !=3D -ECANCELED && err !=3D -ENODEV)
> > +               bt_dev_warn(hdev, "Failed to set LE data length (%d)", =
err);
> > +       hci_conn_put(conn);
> > +}
> > +
> > +static int hci_le_set_data_len_sync(struct hci_dev *hdev, void *data)
> > +{
> > +       struct hci_conn *conn =3D data;
> > +       struct hci_cp_le_set_data_len cp;
> > +
> > +       hci_dev_lock(hdev);
> > +
> > +       if (!hci_conn_valid(hdev, conn) || conn->type !=3D LE_LINK ||
> > +           conn->role !=3D HCI_ROLE_MASTER ||
> > +           (conn->state !=3D BT_CONNECTED && conn->state !=3D BT_CONFI=
G)) {
> > +               hci_dev_unlock(hdev);
> > +               return -ECANCELED;
> > +       }
> > +
> > +       /* Use the current suggested defaults, including later host cha=
nges. */
> > +       if (!hci_test_quirk(hdev, HCI_QUIRK_NEEDS_LE_SET_DATA_LEN) ||
> > +           !(hdev->commands[33] & BIT(6)) ||
> > +           !(hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) ||
> > +           !(conn->le_features[0] & HCI_LE_DATA_LEN_EXT) ||
> > +           hdev->le_def_tx_len <=3D 27) {
> > +               hci_dev_unlock(hdev);
> > +               return 0;
> > +       }
> > +
> > +       cp.handle =3D cpu_to_le16(conn->handle);
> > +       cp.tx_len =3D cpu_to_le16(hdev->le_def_tx_len);
> > +       cp.tx_time =3D cpu_to_le16(hdev->le_def_tx_time);
> > +
> > +       hci_dev_unlock(hdev);
> > +
> > +       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DATA_LEN,
> > +                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +}
> > +
> > +int hci_le_set_data_len(struct hci_conn *conn)
> > +{
> > +       struct hci_dev *hdev =3D conn->hdev;
> > +       int err;
> > +
> > +       err =3D hci_cmd_sync_queue_once(hdev, hci_le_set_data_len_sync,
> > +                                     hci_conn_get(conn),
> > +                                     le_set_data_len_complete);
> > +       if (err)
> > +               hci_conn_put(conn);
> > +
> > +       return (err =3D=3D -EEXIST) ? 0 : err;
> > +}
> >
> > base-commit: 185c11232d5f586489bb3b74e6bcc7a6560ddd40
>=20
> Perhaps before we go into the whole trouble of adding a quirk we
> should check with MediaTek folks if there is a fix planned for this,
> since this is actually a firmware bug. If there isn't one and a fix
> would take time to be validated, I'd proceed with the quirk but I
> don't think gating it on a specific build is a good idea; there might
> be other firmware releases affected by this, unless MediaTek can
> confirm this is exclusive to a single image in which case we should
> treat it as a regression.
>=20
> --
> Luiz Augusto von Dentz
> 
