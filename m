Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459BE3FF8B9
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542861; cv=pass; b=REO1a+YK73WEWZ/KQ2SAjgKWP0RudbE5N2b3igLm7BZ4cO0metaDsT/oEhzrt0EtX0Pjw9S1WRZWWYuYPZ4pSOqDGthD+XNf+VaCJdad2ElnAOhxuxK/WGlLsNZZpJdLH8nU5Tow3+PDX8aduc5WFABN66F1Rp11oTX31VrKPic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542861; c=relaxed/simple;
	bh=eWK763odSd+RITsFu0TL+8Tv8kosnaCAYUAgpNhYL3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ql6nKV3+hYQjvvDI++0iX37rgmAYaEgoYKpOvHB3bt6DlIAfrG6iA8iYfZONfm7sXO1E4SQxTNYe90RgC2UawvZ9wPlG4cMU0dRQyOGCfrpq/DCuIgrptCDP+ybBuScOMpRQS5pWdsVPjs9VTOBhtLkr9X9NW6z9mJ/eVXOtiQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHRVaCij; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHRVaCij"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ef161129bso1095821d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 09:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542859; cv=none;
        d=google.com; s=arc-20240605;
        b=B16d/qdGWCs1u762Opg8DFOhKGPkkWqXtp+0qP0BtZPW8r96oQhdfxrgAzSf+q+qTO
         GfaW1iC90LQHYGlm2Znp0rXtoSzVvPg9lSEtOhFqe8C3ePjWYb606SX7HDWFcAJP3jDE
         wS8DnXUJst3tperyCjz8oUGWwAccGs+Ovj7fHVQDOzRZ+pTTfmDBJ3ezCmQ0Pk1CRQ1w
         nSv8ra9cSPQQPBCXDLZ5msG1mRAfFWfbaqhq4z77wNs8FTzczh7I1/2No0jsWcV0jdiW
         Jh4O1OtPRHiRBnznm8K0YUMofhAiIK69GRSe15F7Vn3uc5UnMj6B0TpeGS4JHhYxQyoJ
         MZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=11ZA0CAg+pKLn2xyVYStQmO75u3YDSroNUhodO9+5yc=;
        fh=bjZSPMB/xHqMYQgj/EqhWXmZ2gbcutFiaJyIl077YUc=;
        b=butg8xM3NjnX/ZPt6UY/bDPj0OgzlvtJgtWrcXbY2yyIQ6dIXzSRrnxpj4FE8cEVXY
         tycAmokWk34wypILCju3BwoPg97ByV3+cM3bSKZflijc35nPZEX6R8zLpwdhhzjY5SZu
         wFHTEHXm+lKpczOBpJo6YuRrh2aau+m1091wkOOb4Dn84eGVOsK4rSwWwpNdvSBX2Rzd
         X3+i+cxghOva8QYJKr0jJ5B1niAvdf3l71zjeWkuKDWc+SiSRVDd57ElpzTMW9PZfTKC
         ZrRwEbxkFLu+EwkZojGRujWuQyrct9580Ae2+9c34GJCjfoqF4LvKXC/iRbYvRQjsSy/
         XfPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542859; x=1775147659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11ZA0CAg+pKLn2xyVYStQmO75u3YDSroNUhodO9+5yc=;
        b=EHRVaCijwAMeis70XSZaQoNml1yiQuphZy0aQHwz7UFpoGF/QBMFcAEIBuR6wJLQkn
         fkxwNFFxn9PWdJ68yia2/zN+hNntt+dOH30vt1Dh2yhYeY4QAfJ59sL9U4AfPSkoEx/X
         TObDgYrRTluQIlRsxXzprVGpyfemrWQA9cC7Pspf/oRsQ2RnEmpQfBN1K3RJUTASN67A
         +r1y1Vmygj3FoFen6no9KRbZ+00/yhNMvv9E1EsIz77fgrg0KdbxqMz0g2FWiU8DzLrJ
         XARLHEKcrcgiOyS1VilP1xXbRtcG53ZwuE7JSocau2JkKEDaKyFXi8f4fSyuLYX8Y2gf
         uHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542859; x=1775147659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=11ZA0CAg+pKLn2xyVYStQmO75u3YDSroNUhodO9+5yc=;
        b=LYWm7lidw9FkYmQmDnbSFFpVu6JtptSwtEv/kag9waceXmslP4/vAJt5OrudfvOAA1
         ELokyKWOkfVzgsRhLDCPW06PcpvHOmhBeTNiLe0X0enCHN7Uwx+Xm1lQu+VtSiKMgg4N
         hqzQvxKBLj9tZdtbaXXEYMSzajVkw+fk6ojrqkRi1OUqYqWIgp1+NCyUYUZflDLejTpK
         L2UPyePdLQzMJLYpE10TBBCXuHGaQYQvOuSsvia4TSuQtCgbPpY1zd8W1rpwfNeeDv4M
         EE9z5MF+/8fsylVV+iJC5Ck7F3i942wB47fyXAB6J/htbUb78Ey34MuxOKQayzxsDfNu
         CfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+LMfzmJI26kLw3Z0g/HyoG1resIU1UMs538mi8/ais7M1VdZ6G94ugBmRd2sXwrDm5uKPKYFnNpekGYEukUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9RHyOA3PpxTea9KHzCo5WSjQJSRKWxSOEh11ICN+15LYzJlVA
	za5/uHJidv+rcs8U6VXxt0cTG+1gzHkAdhuiNfAjvcw13zsahZwwad0Z0TEwof8V5qb9X+Q8hZq
	AJ/euvogLrkcoNxjzoMLLMFv7DmyZar0=
X-Gm-Gg: ATEYQzwue6x99VlXlEwMPeUurWbOoH7PWHn70f5mIwP0GX7o/nGe03aRshrhXIJmCis
	KKXjobpQPXoN2uE0L2FujuhPu0unt7Q6RGw9cxwn0G/U0j5z1SZSzRzBhKmdVbvysVwrxoHBLvz
	vSuH0+G7NV6wjMuz7biDSFfWopgdykNVMvh7Azi6dr+HES/dxNqroAgj2QXM5VpMvavZvkv918Y
	bM0CKGWcNOrfnH+sRZZsi1DykTwI2MsjeB4JPFYEdB7pbUc2Xoq/vjL/zhoNLwpOZ8XX1pEbOzR
	UMIbHNucjRMmTwkd6gK/M87HVTmuHzTwgZ2F6fC/9FwQJ1v6PbhriAd/uySyfJ1USS0xCWoPPra
	OWWxy
X-Received: by 2002:a53:b708:0:b0:64c:b7c9:dffd with SMTP id
 956f58d0204a3-64ee613febdmr6574503d50.58.1774542858977; Thu, 26 Mar 2026
 09:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9b8a0917d56b4a67ba541e8a5eb3abb8.security@1.0.0.127.in-addr.arpa>
 <2026032626-rinsing-component-ed00@gregkh> <PA4PR04MB767961D26B5B1D402A7328AF9256A@PA4PR04MB7679.eurprd04.prod.outlook.com>
 <PA4PR04MB76792C61C4A06C089ACC4A689256A@PA4PR04MB7679.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB76792C61C4A06C089ACC4A689256A@PA4PR04MB7679.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Mar 2026 12:34:07 -0400
X-Gm-Features: AQROBzAw1P5BKdk8Xzoyg39QliwJx-P5YS8DTaO9YFAX6tsdLyhxnvNbyt7JOPw
Message-ID: <CABBYNZKXqe2qDf-j8AxD1s0TD1x67EqynyZUUTSWDmrLDpEKtg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
To: Oleh Konko <security@1seal.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleh,

On Thu, Mar 26, 2026 at 12:22=E2=80=AFPM Oleh Konko <security@1seal.org> wr=
ote:
>
> v5 now applies cleanly and gets through build/sparse, but the
> current CI run still shows runtime regressions (mgmt/iso/sco/mesh).

Those are probably the already existing errors, so no need to spin a v6.

> looking at the delta, the most suspicious part is not the move of
> wake-address storage into validated handlers itself, but the new global
> fallback after hci_event_func(). that changes both timing and semantics:
> it adds a post-handler hci_dev_lock() path, and it also changes the old
> HCI_EV_LE_META fallback behavior into MGMT_WAKE_REASON_UNEXPECTED for
> cases that previously stayed on the remote-wake path.
>
> my plan for v6 is therefore to narrow the change:
> - keep wake address storage only in validated event handlers
> - drop the global post-handler fallback in hci_event_packet()
> - restore the non-address fallback paths without reintroducing the
>   pre-validation dereference
> - handle the LE meta fallback separately so its old semantics are
>   preserved without touching unvalidated payload
>
> unless you object, i'll respin in that direction rather than send
> another blind reroll.
>
> thanks,
> Oleh
> ________________________________
> =D0=9E=D1=82: Oleh Konko <security@1seal.org>
> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE: 26 =D0=BC=
=D0=B0=D1=80=D1=82=D0=B0 2026 =D0=B3. 16:06
> =D0=9A=D0=BE=D0=BC=D1=83: gregkh@linuxfoundation.org <gregkh@linuxfoundat=
ion.org>
> =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: linux-bluetooth@vger.kernel.org <linux-bl=
uetooth@vger.kernel.org>; marcel@holtmann.org <marcel@holtmann.org>; luiz.d=
entz@gmail.com <luiz.dentz@gmail.com>; linux-kernel@vger.kernel.org <linux-=
kernel@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>
> =D0=A2=D0=B5=D0=BC=D0=B0: RE: [PATCH v3] Bluetooth: hci_event: move wake =
reason storage into validated event handlers
>
> hi Greg,
>
> thanks. the embedded headers were a formatting issue on my side.
>
> i have now resent the patch as v5 with proper inline formatting. this
> revision also adds the lock contract you asked for:
> __must_hold(&hdev->lock) on hci_store_wake_reason(), plus
> lockdep_assert_held(&hdev->lock) inside the helper.
>
> thanks,
> Oleh
> ________________________________
> =D0=9E=D1=82: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE: 26 =D0=BC=
=D0=B0=D1=80=D1=82=D0=B0 2026 =D0=B3. 15:57
> =D0=9A=D0=BE=D0=BC=D1=83: Oleh Konko <security@1seal.org>
> =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: linux-bluetooth@vger.kernel.org <linux-bl=
uetooth@vger.kernel.org>; marcel@holtmann.org <marcel@holtmann.org>; luiz.d=
entz@gmail.com <luiz.dentz@gmail.com>; linux-kernel@vger.kernel.org <linux-=
kernel@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>
> =D0=A2=D0=B5=D0=BC=D0=B0: Re: [PATCH v3] Bluetooth: hci_event: move wake =
reason storage into validated event handlers
>
> On Thu, Mar 26, 2026 at 01:32:50PM +0000, Oleh Konko wrote:
> > From f0e8b2abaf4a895fad81756277014582c773808d Mon Sep 17 00:00:00 2001
> > From: Oleh Konko <security@1seal.org>
> > Date: Thu, 26 Mar 2026 14:29:58 +0100
> > Subject: [PATCH v3] Bluetooth: hci_event: move wake reason storage into
> >  validated event handlers
>
> If you use git send-email, the header will not be in the body like this.
>
> > hci_store_wake_reason() is called from hci_event_packet() immediately
> > after stripping the HCI event header but before hci_event_func()
> > enforces the per-event minimum payload length from hci_ev_table.
> > This means a short HCI event frame can reach bacpy() before any bounds
> > check runs.
> >
> > Rather than duplicating skb parsing and per-event length checks inside
> > hci_store_wake_reason(), move wake-address storage into the individual
> > event handlers after their existing event-length validation has
> > succeeded. Convert hci_store_wake_reason() into a small helper that onl=
y
> > stores an already-validated bdaddr while the caller holds hci_dev_lock(=
).
> > Use the same helper after hci_event_func() with a NULL address to
> > preserve the existing unexpected-wake fallback semantics when no
> > validated event handler records a wake address.
> >
> > Call the helper from hci_conn_request_evt(), hci_conn_complete_evt(),
> > hci_le_adv_report_evt(), hci_le_ext_adv_report_evt(), and
> > hci_le_direct_adv_report_evt().
> >
> > Fixes: 2f20216c1d6f ("Bluetooth: Emit controller suspend and resume eve=
nts")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Oleh Konko <security@1seal.org>
> > ---
> > v3:
> > - route the unexpected-wake fallback through hci_store_wake_reason(NULL=
, 0)
> >   after hci_event_func(), as suggested in review
> >
> >  net/bluetooth/hci_event.c | 89 +++++++++++++--------------------------
> >  1 file changed, 29 insertions(+), 60 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 286529d2e..c0e0b4a1c 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -80,6 +80,9 @@ static void *hci_le_ev_skb_pull(struct hci_dev *hdev,=
 struct sk_buff *skb,
> >        return data;
> >  }
> >
> > +static void hci_store_wake_reason(struct hci_dev *hdev,
> > +                               const bdaddr_t *bdaddr, u8 addr_type);
> > +
> >  static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
> >                                struct sk_buff *skb)
> >  {
> > @@ -3111,6 +3114,7 @@ static void hci_conn_complete_evt(struct hci_dev =
*hdev, void *data,
> >        bt_dev_dbg(hdev, "status 0x%2.2x", status);
> >
> >        hci_dev_lock(hdev);
> > +     hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
> >
> >        /* Check for existing connection:
> >         *
> > @@ -3274,6 +3278,10 @@ static void hci_conn_request_evt(struct hci_dev =
*hdev, void *data,
> >
> >        bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_=
type);
> >
> > +     hci_dev_lock(hdev);
> > +     hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
> > +     hci_dev_unlock(hdev);
> > +
> >        /* Reject incoming connection from device with same BD ADDR agai=
nst
> >         * CVE-2020-26555
> >         */
> > @@ -6403,6 +6411,8 @@ static void hci_le_adv_report_evt(struct hci_dev =
*hdev, void *data,
> >                                        info->length + 1))
> >                        break;
> >
> > +             hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> > +
> >                if (info->length <=3D max_adv_len(hdev)) {
> >                        rssi =3D info->data[info->length];
> >                        process_adv_report(hdev, info->type, &info->bdad=
dr,
> > @@ -6491,6 +6501,8 @@ static void hci_le_ext_adv_report_evt(struct hci_=
dev *hdev, void *data,
> >                                        info->length))
> >                        break;
> >
> > +             hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> > +
> >                evt_type =3D __le16_to_cpu(info->type) & LE_EXT_ADV_EVT_=
TYPE_MASK;
> >                legacy_evt_type =3D ext_evt_type_to_legacy(hdev, evt_typ=
e);
> >
> > @@ -6834,6 +6846,8 @@ static void hci_le_direct_adv_report_evt(struct h=
ci_dev *hdev, void *data,
> >        for (i =3D 0; i < ev->num; i++) {
> >                struct hci_ev_le_direct_adv_info *info =3D &ev->info[i];
> >
> > +             hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_t=
ype);
> > +
> >                process_adv_report(hdev, info->type, &info->bdaddr,
> >                                   info->bdaddr_type, &info->direct_addr=
,
> >                                   info->direct_addr_type, HCI_ADV_PHY_1=
M, 0,
> > @@ -7517,73 +7531,27 @@ static bool hci_get_cmd_complete(struct hci_dev=
 *hdev, u16 opcode,
> >        return true;
> >  }
> >
> > -static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
> > -                               struct sk_buff *skb)
> > +/* hdev lock must be held. pass NULL bdaddr to record an unexpected wa=
ke. */
> > +static void hci_store_wake_reason(struct hci_dev *hdev,
> > +                               const bdaddr_t *bdaddr, u8 addr_type)
>
> If the lock must be held, why aren't you both adding the static test for
> this at build time __must_hold(), and the runtime lock test so that we
> know this lock is held?  That way any changes in any code paths in the
> future will properly trigger at build and runtime to know to be fixed
> up.
>
> thanks,
>
> greg k-h



--=20
Luiz Augusto von Dentz
