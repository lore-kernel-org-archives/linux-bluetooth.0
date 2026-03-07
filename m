Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE45323D7FB
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Mar 2026 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772882085; cv=pass; b=KX62pwdMRSNkvqd3elxeZsQ16FFtJRG33nA0spSQO5sxpu0+D7PJ1W0Z5qlQb8rJkxjfqgQP5F7f4OhAwkqsI6PKMnxqE6xk1GITINKG46VXPQxesUuoS8Jsj/g057UaDAZEEv9a31/w4oAzG0m1ssVMPL2WfDW/2oT0/M0B6Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772882085; c=relaxed/simple;
	bh=ELPw2bZP+odfNcH8IwrRLCNeQlE9KtKWOJIqqiUCSHM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQTm8e7Qp5KQmpaaDpxDE6pPZ9sFvDggDVgfPq9TB9WBRNjaiWAlZQkZlT4Vnjjuz6FxAmK2+wlYRKusQjie46fNF5FUKXIRIPODP16vvu05ulHI48+KvSEDe4wmLmVKLXNHd+eZpDMXSAkbT0QtTuMXGil0MBfjovNaAIciY6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=FtYGS2Hq; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="FtYGS2Hq"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fSgf95CHZz49Q6d
	for <linux-bluetooth@vger.kernel.org>; Sat, 07 Mar 2026 13:14:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772882081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SL/gbOlGtDzB4qc992jvWZ8G6u96ZA9fwlF6sqRVH+Y=;
	b=FtYGS2HqgOi6kR3wYe4SM7zbOzr0ccehAy6tDrwbRYfjEzcm3QDbK91XZSXxuIxBOmfsA1
	6NcYG3HUT448bzYVFozTi3HtZmSj4Co4Hqw2m1l3y7jIIstxny2S+cnKTHAhySk7guSQEQ
	hvQDAhkLXebC5lgo3jRKE5uxK+nDr8MwblcSWxMIWW89NrAAXUsMDAWBEfZOiTMgfijQlF
	NOSdHgE1sV23EulsHxzbbOUC5oBLRh/n1vUH4AT/JGDjZqqYCeAQOh3Pv5/6kCuHGZRNE8
	xyx1S+cznHGpQG4zX+8C3PSf9uuX0spM49p6tXoW3M5RVvIuneBk4WtjRPKsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1772882081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SL/gbOlGtDzB4qc992jvWZ8G6u96ZA9fwlF6sqRVH+Y=;
	b=g0W6tFPh5x1izMKHvDp6F646+qo3B/YUER2m1yYqfmvU6YmDsnGT9APHB3OLRRlWUyxFAY
	Up82wakwD6/hRR1NIoYxCxL3B0j6mex2RLeJWMvBjauWcprdZLsJ261mmTldRraApHYZGD
	PAtSxIokCELwn8i96OBXZVjDX5bkixsBqngNWQjLozIGISb0ujlTyoI+5PlzK4Qtm5TTWf
	1ITABRGqsvxe5fnAKDTf7XN2vsEU01zRzupPspKUcpFmITuaTfNw2rldRfrZSzDSz9fgSu
	DkdLQSv9kqV0Eb48/qtgsdnDZkeZbCiAFQWVQtj2/kQlO5Xt2XLtmaOdm/KsMg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1772882081;
	b=VCtWDLxTJ7vzWATJMfT3n3UgJLytXN+togLG9SK5V1w5lyi9u+UYixHt11yxPMTKTfZ58F
	m+nhBybNt/wzBDk3JKqIhuf9ppBq5gBytC3kkDKWoVehP9JFrD7Vlw33TNM1B4IWDLF62c
	v1uGuVx3S72fsEZAK4j25K1t1I/NtUXG4Tkkxyh0/d187K+Mvy/4Cl7M9eIWnh33nZVSS+
	iNbv2YGu3qDjEM0iBWfc+4ktZx3pQQKGD5xAGbD8OVT8qBm1c0/aDl8EM/K70OB9SuVtcv
	nb1Rje+R+2ZeLxK78CcYCG9SUYnJpc6/A4IxV+wC7AY5adADw3KvoYJVhInB+w==
Message-ID: <d92c0dfa0b66bb9313ec1bcdf2be4f7f5fab3a1c.camel@iki.fi>
Subject: Re: [RESEND] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_unregister_user
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 07 Mar 2026 13:14:41 +0200
In-Reply-To: <5c93792d0d75a84b0df4f9828d20f33c7a1e71fb.camel@iki.fi>
References: <20260306210427.703454-1-luiz.dentz@gmail.com>
			 <625d3721ef07c7c15488af80fbfc53620921611b.camel@iki.fi>
		 <a36a0c60c12b6a8e09776875f2836f2e03894639.camel@iki.fi>
	 <5c93792d0d75a84b0df4f9828d20f33c7a1e71fb.camel@iki.fi>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

la, 2026-03-07 kello 12:32 +0200, Pauli Virtanen kirjoitti:
> la, 2026-03-07 kello 11:45 +0200, Pauli Virtanen kirjoitti:
> > la, 2026-03-07 kello 10:59 +0200, Pauli Virtanen kirjoitti:
> > > pe, 2026-03-06 kello 16:04 -0500, Luiz Augusto von Dentz kirjoitti:
> > > > From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> > > >=20
> > > > After commit ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in
> > > > hci_chan_del"), l2cap_conn_del() uses conn->lock to protect access =
to
> > > > conn->users and conn->hchan. However, l2cap_register_user() and
> > > > l2cap_unregister_user() still use hci_dev_lock(), creating a race
> > > > condition where these functions can access conn->users and conn->hc=
han
> > > > concurrently with l2cap_conn_del().
> > >=20
> > > AFAIK the above text from the original submitter is a bit inaccurate,
> > > as l2cap_conn_del()=C2=A0is called with hdev lock held, so conn->user=
s/hchan
> > > should be safe.
> > >=20
> > > However, using conn->mutex should fix the use-after-free in
> > >=20
> > > 	conn->hcon->hdev
> > > 	hci_dev_lock(hdev);
> > > 	hci_dev_unlock(hdev);
> > >=20
> > > by making l2cap_unregister_user() safe to call after the hcon/hdev ar=
e
> > > no longer alive.
> > >=20
> > > The change looks OK to me, but probably worth to double check with
> > > syzbot it fixes the original issue
> >=20
> > syzbot seems to have hit some internal error, another try on upstream
> > branch instead
> >=20
>=20
> No luck, test the patch setting session->conn =3D NULL; in case it fixes
> the syzcaller failure. If that passes, maybe the conn->mutex locking
> overlooks something that I don't see right now,
>=20
> #syz test

Looks like I can't get syzbot to test either patch. Probably this has
nothing to do with the patch content, and is instead some other syzbot
internal issue.


> > > > This can lead to use-after-free and list corruption bugs, as report=
ed
> > > > by syzbot.
> > > >=20
> > > > Fix this by changing l2cap_register_user() and l2cap_unregister_use=
r()
> > > > to use conn->lock instead of hci_dev_lock(), ensuring consistent lo=
cking
> > > > for the l2cap_conn structure.
> > > > Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3D14b6d57fb728e27ce=
23c
> > > > Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_c=
han_del")
> > > > Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > ---
> > > >  net/bluetooth/l2cap_core.c | 20 ++++++++------------
> > > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > > >=20
> > > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.=
c
> > > > index 14131e427efd..6606d7f12534 100644
> > > > --- a/net/bluetooth/l2cap_core.c
> > > > +++ b/net/bluetooth/l2cap_core.c
> > > > @@ -1678,17 +1678,15 @@ static void l2cap_info_timeout(struct work_=
struct *work)
> > > > =20
> > > >  int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user=
 *user)
> > > >  {
> > > > -	struct hci_dev *hdev =3D conn->hcon->hdev;
> > > >  	int ret;
> > > > =20
> > > >  	/* We need to check whether l2cap_conn is registered. If it is no=
t, we
> > > > -	 * must not register the l2cap_user. l2cap_conn_del() is unregist=
ers
> > > > -	 * l2cap_conn objects, but doesn't provide its own locking. Inste=
ad, it
> > > > -	 * relies on the parent hci_conn object to be locked. This itself=
 relies
> > > > -	 * on the hci_dev object to be locked. So we must lock the hci de=
vice
> > > > -	 * here, too. */
> > > > +	 * must not register the l2cap_user. l2cap_conn_del() unregisters
> > > > +	 * l2cap_conn objects under conn->lock, and we use the same lock =
here
> > > > +	 * to protect access to conn->users and conn->hchan.
> > > > +	 */
> > > > =20
> > > > -	hci_dev_lock(hdev);
> > > > +	mutex_lock(&conn->lock);
> > > > =20
> > > >  	if (!list_empty(&user->list)) {
> > > >  		ret =3D -EINVAL;
> > > > @@ -1709,16 +1707,14 @@ int l2cap_register_user(struct l2cap_conn *=
conn, struct l2cap_user *user)
> > > >  	ret =3D 0;
> > > > =20
> > > >  out_unlock:
> > > > -	hci_dev_unlock(hdev);
> > > > +	mutex_unlock(&conn->lock);
> > > >  	return ret;
> > > >  }
> > > >  EXPORT_SYMBOL(l2cap_register_user);
> > > > =20
> > > >  void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_u=
ser *user)
> > > >  {
> > > > -	struct hci_dev *hdev =3D conn->hcon->hdev;
> > > > -
> > > > -	hci_dev_lock(hdev);
> > > > +	mutex_lock(&conn->lock);
> > > > =20
> > > >  	if (list_empty(&user->list))
> > > >  		goto out_unlock;
> > > > @@ -1727,7 +1723,7 @@ void l2cap_unregister_user(struct l2cap_conn =
*conn, struct l2cap_user *user)
> > > >  	user->remove(conn, user);
> > > > =20
> > > >  out_unlock:
> > > > -	hci_dev_unlock(hdev);
> > > > +	mutex_unlock(&conn->lock);
> > > >  }
> > > >  EXPORT_SYMBOL(l2cap_unregister_user);
> > > > =20

--=20
Pauli Virtanen
