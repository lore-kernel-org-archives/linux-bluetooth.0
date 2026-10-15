Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30752758B;
	Thu, 15 Oct 2026 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087352; cv=none; b=XpwrZ7W8ksYgYBrgZEKTQzTsAaoIwdMsecmxBQ59xoyg9mXPIfE2bjcV75lFTAPJxQwHLarV6nCvQxO9vJ3qfrGt6RI43/B3Vj8WzznmR09TS6PVAFWxrRgTFLNzGG1qgVBE5K/Xkabs0+0GBDQNj9bAQq7HMoPTrzkoyk670WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087352; c=relaxed/simple;
	bh=5xpAOZ2dHwAaV2SZNdyxS8bNqKNE+I4JQX0/dpO3UWQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON7PpXKcJWI1LfmKStgeUmkOdphBJ0PyJwdjGcP7dRJb20DoBu6M6BwB7JvCDHUT5BB+5ZhdyVOI42JnbmbkQQZIwYP7d3LHuGrjA6bf7n5N9VsejudDMjlZzkaKxa0KMZcghYkjA2rKAd7byU1TPC4zxLNz5gWbx3ZDzPmbNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H8oxJ0bd; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H8oxJ0bd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792087334; x=1792346534;
	bh=RtRdsCei9ouBoVymLPVc2LE6Qb0xtdrX+KUUFxos8qA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H8oxJ0bd9usvpPAojg/0bA6Usf7ZFYJBEKpk8uFJyStXW97tyFbmGCyH3isBq0tLJ
	 EtsAgBNKAPpZo8gmkRdAuJtvOulB1m8pGHZKep5UMkw/JfOIDfRc9C845UYBtrECpB
	 WPbBfilhO6IxWfQzU2TvBaElgyhUMJTnv3z6cAy+VzYFPzSo/OwrBe+oLdNTfQW/hy
	 Mff0wAfvVJZNp3kz6oqVTy9fbDe/o+ouBxRLVZ72+am7PKj0Cv9ugByigIFuFfr6fZ
	 RyzvQaJePIGzhdP8phNxUl1gw76LxjUgyZyOKuyUkqhyw2NDoDhQdmyPOjd4Rmupc8
	 xJ+SpFzwIo+tg==
Date: Thu, 15 Oct 2026 18:02:08 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: cochcoder <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Bluetooth: hci_event: negotiate LE Data Length after features
Message-ID: <sUQ5y5uXw0_-CyhVfQyKH1qTr5UKr5axqzE2xZEj5Aolf7W2zjyQArJbCZESSSIkPlBAjmQTfafriHlOnD2rNrDAkVdgS4hF7ri9rThvDGU=@proton.me>
In-Reply-To: <CABBYNZJ=cg5vK=_bmLd9XemzLrS7NtaUgMFj_-4afP1RnSY7Sg@mail.gmail.com>
References: <20261013033452.505349-1-cochcoder@proton.me> <CABBYNZJ=cg5vK=_bmLd9XemzLrS7NtaUgMFj_-4afP1RnSY7Sg@mail.gmail.com>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 0b61f2c4a5e62bfe1c0b4af12b8d22b43cc28e50
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for pointing that out! Initialization already programs the suggested=
 default data length. I also need to correct my previous submission notes, =
the N8 returns to environmental sound while Bluetooth remains connected. Th=
e longer idle transition showed continued host audio before STOP. Instead o=
f a demonstrated DLE negotiation failure.

I=E2=80=99ll withdraw this RFC. I don=E2=80=99t have evidence of an affecte=
d controller that justifies a manual-DLE quirk.



On Tuesday, October 13th, 2026 at 10:30 AM, Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:

> Hi Kyle,
>=20
> On Mon, Oct 12, 2026 at 11:35=E2=80=AFPM Kyle Pepper <cochcoder@proton.me=
> wrote:
> >
> > Request the controller transmit limits once both peers support DLE.
> > Queue the connection with a reference so pending requests coalesce and
> > connection deletion cancels them. Check the connection under the device
> > lock before constructing the command.
> >
> > Assisted-by: OpenCode:gpt-6.1-sol
> > Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> > ---
> > Submission review notes (not part of the commit message):
> > The user reports that retaining the explicit DLE request enables the N8
> > to disconnect automatically after audio stops, whereas removing it
> > leaves the device connected. This idle-transition behavior is the
> > reported reason for retaining the topic, not an in-stream timeout.
> > October 9 no-DLE trials already negotiate TX 251 octets / 2120 us and
> > stream successfully; startup throughput alone does not test idle behavi=
or.
> > The supplied captures do not establish a controlled post-STOP compariso=
n
> > or the causal mechanism. This patch requests data length during setup;
> > it does not itself implement STOP or issue a disconnect command.
> > The claimed ASHA idle-disconnect requirement needs a protocol citation.
> > The corrected ownership implementation is included in the working kerne=
l.
> > Native disconnect/handle reuse, LL ordering and post-snapshot races rem=
ain
> > unproved. Submit as an independent RFC with these limitations disclosed=
.
> >
> >  include/net/bluetooth/hci_sync.h |  1 +
> >  net/bluetooth/hci_event.c        | 10 +++++++
> >  net/bluetooth/hci_sync.c         | 47 ++++++++++++++++++++++++++++++++
> >  3 files changed, 58 insertions(+)
> >
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
> > index c055d16cf..4035f2659 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6846,6 +6846,16 @@ static void hci_le_remote_feat_complete_evt(stru=
ct hci_dev *hdev, void *data,
> >                                 conn->le_tx_def_phys &=3D ~HCI_LE_SET_P=
HY_CODED;
> >                                 conn->le_rx_def_phys &=3D ~HCI_LE_SET_P=
HY_CODED;
> >                         }
> > +
> > +                       /* Request the controller maximum when both sid=
es support
> > +                        * LL Data Length Extension. The Link Layer neg=
otiates
> > +                        * the remote limits (Core v5.4, Vol 6, Part B,
> > +                        * Sec. 4.5.10).
> > +                        */
> > +                       if ((hdev->le_features[0] & HCI_LE_DATA_LEN_EXT=
) &&
> > +                           (conn->le_features[0] & HCI_LE_DATA_LEN_EXT=
) &&
> > +                           hdev->le_max_tx_len > 0x001b)
> > +                               hci_le_set_data_len(conn);
>=20
> We use HCI_OP_LE_WRITE_DEF_DATA_LEN to setup this for every
> connection, so either the controller has a bug and doesn't trigger
> trigger DLE or something else is off here. In case it is really a
> specific controller then we might need a quirk which once set by the
> driver indicates the host has to perform the DLE procedure manually
> like above.
>=20
> >                 }
> >
> >                 if (conn->state =3D=3D BT_CONFIG) {
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index efbd2e538..20c690007 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -8123,3 +8123,50 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_=
phys, u8 rx_phys)
> >
> >         return (err =3D=3D -EEXIST) ? 0 : err;
> >  }
> > +
> > +static void le_set_data_len_complete(struct hci_dev *hdev, void *data,
> > +                                    int err)
> > +{
> > +       struct hci_conn *conn =3D data;
> > +
> > +       bt_dev_dbg(hdev, "err %d", err);
> > +
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
> > +           (conn->state !=3D BT_CONNECTED && conn->state !=3D BT_CONFI=
G)) {
> > +               hci_dev_unlock(hdev);
> > +               return -ECANCELED;
> > +       }
> > +
> > +       cp.handle =3D cpu_to_le16(conn->handle);
> > +       cp.tx_len =3D cpu_to_le16(hdev->le_max_tx_len);
> > +       cp.tx_time =3D cpu_to_le16(hdev->le_max_tx_time);
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
> > base-commit: 964430c038967fd06643e866f68115664e1a1bd1
> >
>=20
>=20
> --
> Luiz Augusto von Dentz
> 
