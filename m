Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184F64C8B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272238; cv=none; b=Tot7zfJZ5XojdODsAzTmGAj0i7MzabXnKXokqnoewSOnUntFupzxebs8yQwQP6M6CNEpJK4Pz6WJQmPt6yCXGhXZT1mFYxo8PS3qT/AYVbU5niDe/b/ziTPTo/j20+OxnUeww3K2DyepLwNK4vruVi0iiCEN2v4R3QBOv1Yo11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272238; c=relaxed/simple;
	bh=W9C2Hi3R2DbZ1heOPBbDIHI8G2Y2/x8SwxrJPOxp+Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJWT3IWG34RFFQSEmmMDBWOKqlKojgu6o9GHagnl2fCKDZSBfXH94GhAlL+PIG1p2efr5jOXIXV84G2muRpOKGTy/qHf5DJdTiPzaiCzTLgLBlNJFdM/HA74FhfOpNZaKUOQc3S+3Kjgbn19nth2YlC/EEK5/hdQpeGvttZZvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIYhKk38; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIYhKk38"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2db101c11beso14249171fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2024 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715272234; x=1715877034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+PIPXlgt+itmpmOmsBK5FSpVEiKS9RB88Cz1m3u37s=;
        b=NIYhKk3846ohT1nk8mo0YdTJFv+1oBzkFK+vuRWcztTV1oBI1NJwEI9vUNBzid0Tij
         TW0MV8cn8rBm/GEdiCk2siZGrUnCtP4m4yeMx6/DdWv+aT53mMVJ2wwh8wMikyLUqcNo
         tYnrEr6i05sqvg3l5WGpNn0WYsRYC3bdX7xOAxVvA8T2jtPEGEiW+z7hkl3ln5wtMxY4
         ckGncFr0QA50NfgQ/9p7l98OmGvHIGrr/0+ITcziLxZWkC+spPDAQklxX9OZGD6FaqKT
         p0roUq6K/bVb/UNFN8DGmkE8bkRYcJOe+l37De6Hy8PPhi7SvRLWziqvP+PqoNgdosv3
         v0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272234; x=1715877034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+PIPXlgt+itmpmOmsBK5FSpVEiKS9RB88Cz1m3u37s=;
        b=cg104GMTILD6tlrspGc6mfnMSjV6jQIZdZvsk7KOSU5xYwUt6LCVJKC7PiWB7p08Ph
         GJVEETOK8J2uUFxlBZXPGwAfrnXXCdT9Vkq+9OZSVqeVQF9tw6i+zG1qSKOVH/etJ8iW
         doQ7M0ZIkG9STFLTAHRzybcj1/VRjd6sVYpgMOlKTxKm2fAhHeM1Y1wQEC8ZrQZp/6yL
         i04SKVEGeTmBqlPPWBDH7qxbX/8CjRGk4TSzFMMmKaJrHB+N9OXFK3ETxDRaNWNZGQIv
         DLk8bE/0kludXdazSoXR8KheBiZjulKRT9j+yLJAVe7ubeAHIeQED1vXcsATz8RLr4Kd
         5CFQ==
X-Gm-Message-State: AOJu0Yy5mKEFYp8zVLw0JgE8M8Gcnke4EM28nxB2XL+T6wFOk74nUAHo
	qkUTYPT31c+amC/FELaC5euuDMyYt2P7XgDgI2VRQ0oNWLzVxMlFZ60cyyrKK9FahNibyK+5c/i
	9v3w9neNYU8j3pRqdhRDYWPUxlmk=
X-Google-Smtp-Source: AGHT+IEmIhajQCza5jIEOie1N0QGQ99xJ4Id4qvcPjiJlrcvLLTVsuYIhyFEbPMo4Glue4u+FrdqS9nRYF5CCLby12I=
X-Received: by 2002:a2e:9843:0:b0:2e3:8fa:6438 with SMTP id
 38308e7fff4ca-2e4476ba0b1mr39325941fa.33.1715272233684; Thu, 09 May 2024
 09:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405204037.3451091-1-luiz.dentz@gmail.com> <Zjz0atzRhFykROM9@robin>
In-Reply-To: <Zjz0atzRhFykROM9@robin>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 May 2024 12:30:21 -0400
Message-ID: <CABBYNZLMODHp+jBu2oVDC5Pg6fyAKJugQF0N-XgarjWQJJPObg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
To: Janne Grunau <j@jannau.net>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Janne,

On Thu, May 9, 2024 at 12:06=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:
>
> Hej,
>
> On Fri, Apr 05, 2024 at 04:40:33PM -0400, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > The extended advertising reports do report the PHYs so this store then
> > in hci_conn so it can be later used in hci_le_ext_create_conn_sync to
> > narrow the PHYs to be scanned since the controller will also perform a
> > scan having a smaller set of PHYs shall reduce the time it takes to
> > find and connect peers.
> >
> > Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default=
")
>
> This commit in v6.8.9 apparently has regressed connecting to LE devices
> like Logitech mices with Apple/Broadcom BCM4388 devices. Those devices
> carry HCI_QUIRK_BROKEN_LE_CODED which became necessary after 288c90224eec
> ("Bluetooth: Enable all supported LE PHY by default").
> Tested so far only by reverting aaf06285498861d6caaff5b26d30af70dd2b819f
> on top of v6.8.9. Looking at the change I don't see anything obvious
> which would explain the breakage.
> I would assume v6.9-rc6 is affected as well but I haven't tested this
> yet.

Would be great if you provide the HCI trace to confirm the problem.

> If you have an idea what could be responsible for the regression I'll
> happily test patches/changes.
>
> thanks,
> Janne
>
> #regzbot introduced: v6.8.9
>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci_core.h |  4 +++-
> >  net/bluetooth/hci_conn.c         |  6 ++++--
> >  net/bluetooth/hci_event.c        | 20 ++++++++++++--------
> >  net/bluetooth/hci_sync.c         |  9 ++++++---
> >  net/bluetooth/l2cap_core.c       |  2 +-
> >  5 files changed, 26 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index fd6fd4029452..f0e1f1ae39c5 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -744,6 +744,8 @@ struct hci_conn {
> >       __u8            le_per_adv_data[HCI_MAX_PER_AD_TOT_LEN];
> >       __u16           le_per_adv_data_len;
> >       __u16           le_per_adv_data_offset;
> > +     __u8            le_adv_phy;
> > +     __u8            le_adv_sec_phy;
> >       __u8            le_tx_phy;
> >       __u8            le_rx_phy;
> >       __s8            rssi;
> > @@ -1519,7 +1521,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_d=
ev *hdev, bdaddr_t *dst,
> >                                    enum conn_reasons conn_reason);
> >  struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> >                               u8 dst_type, bool dst_resolved, u8 sec_le=
vel,
> > -                             u16 conn_timeout, u8 role);
> > +                             u16 conn_timeout, u8 role, u8 phy, u8 sec=
_phy);
> >  void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status);
> >  struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
> >                                u8 sec_level, u8 auth_type,
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index ce94ffaf06d4..a3b226255eb9 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1266,7 +1266,7 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16=
 handle)
> >
> >  struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> >                               u8 dst_type, bool dst_resolved, u8 sec_le=
vel,
> > -                             u16 conn_timeout, u8 role)
> > +                             u16 conn_timeout, u8 role, u8 phy, u8 sec=
_phy)
> >  {
> >       struct hci_conn *conn;
> >       struct smp_irk *irk;
> > @@ -1329,6 +1329,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *h=
dev, bdaddr_t *dst,
> >       conn->dst_type =3D dst_type;
> >       conn->sec_level =3D BT_SECURITY_LOW;
> >       conn->conn_timeout =3D conn_timeout;
> > +     conn->le_adv_phy =3D phy;
> > +     conn->le_adv_sec_phy =3D sec_phy;
> >
> >       err =3D hci_connect_le_sync(hdev, conn);
> >       if (err) {
> > @@ -2276,7 +2278,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *=
hdev, bdaddr_t *dst,
> >               le =3D hci_connect_le(hdev, dst, dst_type, false,
> >                                   BT_SECURITY_LOW,
> >                                   HCI_LE_CONN_TIMEOUT,
> > -                                 HCI_ROLE_SLAVE);
> > +                                 HCI_ROLE_SLAVE, 0, 0);
> >       else
> >               le =3D hci_connect_le_scan(hdev, dst, dst_type,
> >                                        BT_SECURITY_LOW,
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 868ffccff773..539bbbe26176 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6046,7 +6046,7 @@ static void hci_le_conn_update_complete_evt(struc=
t hci_dev *hdev, void *data,
> >  static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
> >                                             bdaddr_t *addr,
> >                                             u8 addr_type, bool addr_res=
olved,
> > -                                           u8 adv_type)
> > +                                           u8 adv_type, u8 phy, u8 sec=
_phy)
> >  {
> >       struct hci_conn *conn;
> >       struct hci_conn_params *params;
> > @@ -6101,7 +6101,7 @@ static struct hci_conn *check_pending_le_conn(str=
uct hci_dev *hdev,
> >
> >       conn =3D hci_connect_le(hdev, addr, addr_type, addr_resolved,
> >                             BT_SECURITY_LOW, hdev->def_le_autoconnect_t=
imeout,
> > -                           HCI_ROLE_MASTER);
> > +                           HCI_ROLE_MASTER, phy, sec_phy);
> >       if (!IS_ERR(conn)) {
> >               /* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owne=
d
> >                * by higher layer that tried to connect, if no then
> > @@ -6136,8 +6136,9 @@ static struct hci_conn *check_pending_le_conn(str=
uct hci_dev *hdev,
> >
> >  static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t=
 *bdaddr,
> >                              u8 bdaddr_type, bdaddr_t *direct_addr,
> > -                            u8 direct_addr_type, s8 rssi, u8 *data, u8=
 len,
> > -                            bool ext_adv, bool ctl_time, u64 instant)
> > +                            u8 direct_addr_type, u8 phy, u8 sec_phy, s=
8 rssi,
> > +                            u8 *data, u8 len, bool ext_adv, bool ctl_t=
ime,
> > +                            u64 instant)
> >  {
> >       struct discovery_state *d =3D &hdev->discovery;
> >       struct smp_irk *irk;
> > @@ -6225,7 +6226,7 @@ static void process_adv_report(struct hci_dev *hd=
ev, u8 type, bdaddr_t *bdaddr,
> >        * for advertising reports) and is already verified to be RPA abo=
ve.
> >        */
> >       conn =3D check_pending_le_conn(hdev, bdaddr, bdaddr_type, bdaddr_=
resolved,
> > -                                  type);
> > +                                  type, phy, sec_phy);
> >       if (!ext_adv && conn && type =3D=3D LE_ADV_IND &&
> >           len <=3D max_adv_len(hdev)) {
> >               /* Store report for later inclusion by
> > @@ -6371,7 +6372,8 @@ static void hci_le_adv_report_evt(struct hci_dev =
*hdev, void *data,
> >               if (info->length <=3D max_adv_len(hdev)) {
> >                       rssi =3D info->data[info->length];
> >                       process_adv_report(hdev, info->type, &info->bdadd=
r,
> > -                                        info->bdaddr_type, NULL, 0, rs=
si,
> > +                                        info->bdaddr_type, NULL, 0,
> > +                                        HCI_ADV_PHY_1M, 0, rssi,
> >                                          info->data, info->length, fals=
e,
> >                                          false, instant);
> >               } else {
> > @@ -6456,6 +6458,8 @@ static void hci_le_ext_adv_report_evt(struct hci_=
dev *hdev, void *data,
> >               if (legacy_evt_type !=3D LE_ADV_INVALID) {
> >                       process_adv_report(hdev, legacy_evt_type, &info->=
bdaddr,
> >                                          info->bdaddr_type, NULL, 0,
> > +                                        info->primary_phy,
> > +                                        info->secondary_phy,
> >                                          info->rssi, info->data, info->=
length,
> >                                          !(evt_type & LE_EXT_ADV_LEGACY=
_PDU),
> >                                          false, instant);
> > @@ -6761,8 +6765,8 @@ static void hci_le_direct_adv_report_evt(struct h=
ci_dev *hdev, void *data,
> >
> >               process_adv_report(hdev, info->type, &info->bdaddr,
> >                                  info->bdaddr_type, &info->direct_addr,
> > -                                info->direct_addr_type, info->rssi, NU=
LL, 0,
> > -                                false, false, instant);
> > +                                info->direct_addr_type, HCI_ADV_PHY_1M=
, 0,
> > +                                info->rssi, NULL, 0, false, false, ins=
tant);
> >       }
> >
> >       hci_dev_unlock(hdev);
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index c5d8799046cc..4c707eb64e6f 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -6346,7 +6346,8 @@ static int hci_le_ext_create_conn_sync(struct hci=
_dev *hdev,
> >
> >       plen =3D sizeof(*cp);
> >
> > -     if (scan_1m(hdev)) {
> > +     if (scan_1m(hdev) && (conn->le_adv_phy =3D=3D HCI_ADV_PHY_1M ||
> > +                           conn->le_adv_sec_phy =3D=3D HCI_ADV_PHY_1M)=
) {
> >               cp->phys |=3D LE_SCAN_PHY_1M;
> >               set_ext_conn_params(conn, p);
> >
> > @@ -6354,7 +6355,8 @@ static int hci_le_ext_create_conn_sync(struct hci=
_dev *hdev,
> >               plen +=3D sizeof(*p);
> >       }
> >
> > -     if (scan_2m(hdev)) {
> > +     if (scan_2m(hdev) && (conn->le_adv_phy =3D=3D HCI_ADV_PHY_2M ||
> > +                           conn->le_adv_sec_phy =3D=3D HCI_ADV_PHY_2M)=
) {
> >               cp->phys |=3D LE_SCAN_PHY_2M;
> >               set_ext_conn_params(conn, p);
> >
> > @@ -6362,7 +6364,8 @@ static int hci_le_ext_create_conn_sync(struct hci=
_dev *hdev,
> >               plen +=3D sizeof(*p);
> >       }
> >
> > -     if (scan_coded(hdev)) {
> > +     if (scan_coded(hdev) && (conn->le_adv_phy =3D=3D HCI_ADV_PHY_CODE=
D ||
> > +                              conn->le_adv_sec_phy =3D=3D HCI_ADV_PHY_=
CODED)) {
> >               cp->phys |=3D LE_SCAN_PHY_CODED;
> >               set_ext_conn_params(conn, p);
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index cf3b8e9b7b3b..3e5d2d8a2a66 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -7028,7 +7028,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, _=
_le16 psm, u16 cid,
> >               if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
> >                       hcon =3D hci_connect_le(hdev, dst, dst_type, fals=
e,
> >                                             chan->sec_level, timeout,
> > -                                           HCI_ROLE_SLAVE);
> > +                                           HCI_ROLE_SLAVE, 0, 0);
> >               else
> >                       hcon =3D hci_connect_le_scan(hdev, dst, dst_type,
> >                                                  chan->sec_level, timeo=
ut,
> > --
> > 2.44.0
> >



--=20
Luiz Augusto von Dentz
