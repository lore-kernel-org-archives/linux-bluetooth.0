Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F53E7BA6;
	Tue,  7 Jul 2026 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420070; cv=pass; b=jw+AIidM/FUee7Yhop1xvBrX/69e/mKJ+IMILrgm31veXChYYtUQ+MmypmF3MQOgIqNDZe2p7/urhlAfw4JRjUBIE29c83+N60ofOHi3u65WIWtwi8OL+yb6X+qAIIHWdJnaTIkkjoor2drSKdH7K7YpVZy7nsAh77mYha/JpX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420070; c=relaxed/simple;
	bh=DQ/VbJFlQaemDYdkjf3m2BYdcF3XK0O3TBbqovVLork=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eoO1tQGWoEVPQyF5+lTFnTpsunr64NxRsqlJS1T7V7iWwbGHS32AIRrV7a/z3xjCmuTrpYmq3aLAw8NfPTmjXedVAan9UMkT2n59+2ow+et3a/1ZZBk8myc91RyfCNGmbkVQe82SHx9wEtGzLY5jyg5eLP8T/P9L+pOo6pnZyPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=gc+MDjh6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="gc+MDjh6"
Received: from [192.168.1.196] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gvcqS080Rz49Px6;
	Tue, 07 Jul 2026 13:27:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783420052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WH+JHHWHLH6towODYmqrq1srrHtztg8t3fJNuOECDj4=;
	b=gc+MDjh65M9B5Zr8ugokUNwXEkRBwDtkpgeyAALUsXRQuW+GJkJ50fSGoHwEZgmbEJcAfz
	QmvNNZebBUQfqDnz40n9KL1JYhnZOEDOTuFlVcktqFTjA+0B/nnSyz57/dCj0+QTFhKVr1
	Qtw3I1knqGDEYQx8equQD8wmUxugXZ/a30M/gLtwZSAgW23064lMr/oOKxy9qRHaiO5c6d
	+BDfyXFOuWgyaNeMAjXHDM+rVzjh8fZYj9n+koSpDIevvLcj90bhC0RMnp069S8IfRgwmM
	3JWZqmC96H6K3NsUxJgXsQanLk/voZR83BFnb44wZwhtsy1kO2cznUKQENYBew==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1783420052;
	b=UksKkc44Ys1nvcDIZRZ2nIhUvrdv0PpSTKVju1XTdPijo0z8clNosUr5wP7fFZjpCwj5Ny
	ChmjkGvJdrxD64DDyIB7mrTDwoklThTv4KrRmnIygwz7Smz7E6199QZ8bEn/2HrNo374eh
	+yRNG2RhXmIM46uiM1dhJZZpoDzhVViYfYJl/defPgZpJzS4v27f6kmlMmHynoqdHAo92j
	Zdq1wOcHw7oLB4ioOD1FYkvKTw2hDGnfYAuuU8Qlpxc28mHZtCMxV8E9omPgmZT47uXlCi
	qr4HudW4tlq/FeDPRaKJIlpnEdCu5SdFiBZ8S/648vnOW+VKjMsaTD+J5dq77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1783420052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WH+JHHWHLH6towODYmqrq1srrHtztg8t3fJNuOECDj4=;
	b=eN9A/kKY7MWY6Kac/O/lK17ife6N/MZZKOSiCSvrXikleruZy9sB+BQetIDX4D+AXiqPms
	9j0n6cDHN+4nXUg0jyxoBONlk2SM/mGiFQyyCxTOZXUUuNnF1hk5AhCUCKAlf4OAYKVAwy
	4+W3NSTKfBGwkN9y66Lz87enxuvYtO3gm/+kZ5Z0+ZO3l6dvRnp+9t6URBmHQRB4Rlj06m
	iFJ0etm1DHOoGiQV1fAKlQT0+K4d1aLda6bsMnKRZkGZfvJep7/OutJLQzzHT/qpcQv8og
	Wlnx0lJNQCnS9Gwpxjxfarf0RzVDXWS40ei8GyfJbMqmdE4pQztYdf4abw09SA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <d1bc4472b4c4ee96f4b58ee6ebdc663da8c9d8a9.camel@iki.fi>
Subject: Re: [PATCH v2 4/4] Bluetooth: hci_sync: hold hdev->lock for
 hci_conn_params lookups
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 07 Jul 2026 13:27:30 +0300
In-Reply-To: <CABBYNZ++YgyOGAnvCVry7SgVC42NnsxCXHtT-Xciks4EdL3gPg@mail.gmail.com>
References: <cover.1783275015.git.pav@iki.fi>
	 <23725f0f3ad51aeece0501017e901d673876bc27.1783275015.git.pav@iki.fi>
	 <CABBYNZ++YgyOGAnvCVry7SgVC42NnsxCXHtT-Xciks4EdL3gPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-07-06 kello 12:56 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sun, Jul 5, 2026 at 6:43=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
> >=20
> > hci_conn_params_lookup requires hdev->lock be held, otherwise the list
> > iteration or param access is not safe.
> >=20
> > Hold hdev->lock for params lookups in hci_sync.
> >=20
> > Fixes: c530569adc19 ("Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST=
")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >=20
> > Notes:
> >     v2:
> >     - no change
> >=20
> >  net/bluetooth/hci_sync.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 5dddeed11372..edcaf72baf87 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -6677,6 +6677,8 @@ static int hci_le_create_conn_sync(struct hci_dev=
 *hdev, void *data)
> >         if (!hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES))
> >                 hci_pause_advertising_sync(hdev);
> >=20
> > +       hci_dev_lock(hdev);
> > +
> >         params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_t=
ype);
> >         if (params) {
> >                 conn->le_conn_min_interval =3D params->conn_min_interva=
l;
> > @@ -6690,6 +6692,8 @@ static int hci_le_create_conn_sync(struct hci_dev=
 *hdev, void *data)
> >                 conn->le_supv_timeout =3D hdev->le_supv_timeout;
> >         }
> >=20
> > +       hci_dev_unlock(hdev);
>=20
> Couldn't we make the hci_conn_params_lookup behave like
> hci_pend_le_action_lookup and take a RCU read lock and then make
> hci_conn_params_del use synchronize_rcu?

Some of these fields are mutable,=C2=A0so to do conversion to RCU someone
has to first think through data races in field access. In the
hci_pend_le only few fields were accessed (as copied to struct
conn_params in hci_sync.c)=C2=A0and=C2=A0it was in code that is rerun if
something changes, so lockless READ_ONCE/WRITE_ONCE for mutable fields
appeared OK there. Here, we'd maybe need RCU + spinlock for field
access.

It seems to me hdev->lock would be the simplest option here.

> >         /* If controller is scanning, we stop it since some controllers=
 are
> >          * not able to scan and connect at the same time. Also set the
> >          * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
> > @@ -7247,13 +7251,13 @@ static void create_pa_complete(struct hci_dev *=
hdev, void *data, int err)
> >  }
> >=20
> >  static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_co=
nn *conn,
> > -                                  struct hci_conn *acl, struct bt_iso_=
qos *qos)
> > +                                  u16 acl_handle, struct bt_iso_qos *q=
os)
> >  {
> >         struct hci_cp_le_past_params cp;
> >         int err;
> >=20
> >         memset(&cp, 0, sizeof(cp));
> > -       cp.handle =3D cpu_to_le16(acl->handle);
> > +       cp.handle =3D cpu_to_le16(acl_handle);
> >         /* An HCI_LE_Periodic_Advertising_Sync_Transfer_Received event =
is sent
> >          * to the Host. HCI_LE_Periodic_Advertising_Report events will =
be
> >          * enabled with duplicate filtering enabled.
> > @@ -7318,16 +7322,26 @@ static int hci_le_pa_create_sync(struct hci_dev=
 *hdev, void *data)
> >          * 2. Check if that HCI_CONN_FLAG_PAST has been set which indic=
ates that
> >          *    user really intended to use PAST.
> >          */
> > +       hci_dev_lock(hdev);
> > +
> >         le =3D hci_conn_hash_lookup_le(hdev, &conn->dst, conn->dst_type=
);
> >         if (le) {
> >                 struct hci_conn_params *params;
> > +               u16 le_handle =3D le->handle;
> >=20
> >                 params =3D hci_conn_params_lookup(hdev, &le->dst, le->d=
st_type);
>=20
> Aside from the RCU, couldn't we just unlock here so we don't have to
> do it in every branch below?

Yes, we could copy params->flags and then unlock to make it simpler

-> v3

> >                 if (params && params->flags & HCI_CONN_FLAG_PAST) {
> > -                       err =3D hci_le_past_params_sync(hdev, conn, le,=
 qos);
> > +                       hci_dev_unlock(hdev);
> > +
> > +                       err =3D hci_le_past_params_sync(hdev, conn, le_=
handle,
> > +                                                     qos);
> >                         if (!err)
> >                                 goto done;
> > +               } else {
> > +                       hci_dev_unlock(hdev);
> >                 }
> > +       } else {
> > +               hci_dev_unlock(hdev);
> >         }
> >=20
> >         /* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to =
update
> > --
> > 2.55.0
> >=20
>=20

--=20
Pauli Virtanen
