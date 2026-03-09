Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06652222A9
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070471; cv=pass; b=GtMn0GvgEvBn8vKk2ta/cK82wDSMF3kjRMlpj7xLcCTf0H8ijfniyuC5m74xVwDMylW9dpiRZY71duftBM3qqRFpvKMTiZ41Q3TkoBNBE54iXKxcDhuvsZ2xOJVVwSaxNi5+uVLPcqwCsN/c4ZUZMPouY/BcmitjrzgaWbd6uHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070471; c=relaxed/simple;
	bh=b9Jle3mSVYdkI/Snd88htWCT1v+blebNhVvU2yWsd84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/ZX+UhfQK2rzEHPn4nqG0vZcFqc04DHT3ILM5MG6qmXK5kMngc7Ui6hsLgvkb7Rm2cF7gaF0puSGkbagY2scQHUgcoivtZV6Ac06Yy6XHI5lxhyV2BoBqojlX+TwB0CfMCan2u6UR14te452lgZBKXPD3aBa1hBGArwyZ2DKVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMDJOsIh; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMDJOsIh"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-466f1c3c627so1265720b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2026 08:34:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773070469; cv=none;
        d=google.com; s=arc-20240605;
        b=T3j4N07ZCnmmNsvgt9umVoKYBc/3lAw9A8GSIKrtmMTpOKomhJKcEHpOejjICzFsN5
         SiLYvOwrNYwVm08nt2MZgPf4pf4wEWKAiO07aHn+nAjldQ9EmJcmCJsluKiyjJKxqwPd
         RHn4xyx/FjBAO9eF4MVeI+6oygw+PQm6Gz6E7gqHnridMSvwMy3DsWsCz1vURv6PQUYR
         LTOKiFkkt4dQFHR16LxBt9O61yK76JNLu3LGx3kwyzO41onWBdHoybUEO4MWSDSsHext
         K2x4X8r/TkN5rZuTL8xFfoppkKFjYPr4LyDWad/2kGw2EqbcOj54dSpj5JxWDw3JdAnf
         cRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUD8RVIOrVY2JoJBTrDLfJrUKS0IW86TFKg/Fwo2u2c=;
        fh=W1sgvYstQYlm7mFTn/OY3vKzB8eT1NVWMs07JRZPHbc=;
        b=TKpLXP4G4iFgIuYTwnjOhgDYjG1LvrcnbY9vJMTuCC0GQYCVNfDH2WRsDBYL87YXbu
         H7AvIgDv9JOGd4N4ImefmpR87F6bpko1m45Qems15DNs7Q1CCwMNFGkA1J6+iFhl4KVO
         oUjToAigFKuvmoIOvYIEZgK7iMDlOaAL6zPJa/FC5BmE7F3wufKd+Y5o91Eq7bpYL1zT
         CfN9wKzpq+iOqfSKDpDBgOpGSI5D/rhXs9xm3oOJEskc81E3aGDV+bVl4YdB3T/CctPy
         oY66DMGVSHvtDfBYaXk93ELyTtWPXd6mlIRzbntenPrF6SFoRtXlEdVi+JHdPcdz3P1z
         I+eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070469; x=1773675269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUD8RVIOrVY2JoJBTrDLfJrUKS0IW86TFKg/Fwo2u2c=;
        b=lMDJOsIhHtR2170b39IZrSnotpNCDPudFNBTwe1a7QmcAnk9uujI9QWtYcu/4aIVzU
         +Ik+E7+h27J8Ctmso8powfQfhyBjB/4v0aCY6P91z0ggqwewu22fRku8L0tkakfZW0SY
         nDy5L5udvvmq45ZtlZSn6dHxiZohSIz3uqWhKLfHZGNTT84LjV7RtcTtyxSqYbYrNSiM
         6b8y4TKzIfXV3SEuogQyMoNyNoS0X66auO6JqTe/q/Pf9iWPXwwpDwqlw4BsX351IWFZ
         OT6uNw+RFtepZM3SxekP8wVgl0B0YiXYiAftqZIZnw1vICLZPGZNsXUg+Ocmpcq2lhV9
         dGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070469; x=1773675269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUD8RVIOrVY2JoJBTrDLfJrUKS0IW86TFKg/Fwo2u2c=;
        b=JYRKgSWydMFy+/05UCzJw05Fg8w5uqh/lpAvxZ2lDRSEI4hVG9WjKqi+klBz/M3e9H
         /AfRZaOBzPRQ2jjxKyB5gK0exAxXVS4kFA3zPFB/AlwkDmi2LLmJrZd3Y40yQEpOdVgI
         ZVI8Zzfi2qggXflEMQxNI4wNdTzCcSBOuXSyAOBu29zJFJi+VW9hxy/yrcxxwhJUvyZg
         KZd3fPi3zvqckJPlkT1+oIWCsDyXnrn7WWLa8Ut38KpgQas46/ikR+ArjNwajfUcllry
         1fW5sjqcV6+KraTJV6qHosMi179kXGlx7LmDJWf0onDWt//bf93lFDbtB6AuOkJJdeJv
         aMqQ==
X-Gm-Message-State: AOJu0YzLrIBJa03UYAKA3g7gPyRVrrqjGcb8ikqfzO7Btk1KUfBTzr7B
	RLS4anSDMChYbsc8j/sC8JTIcD9z9M+XivOA0mClNi0rz7ocYuPpay6tG/XYQ6xJYCjJ/+XDf4T
	Ab3bm5XvRXcXE/y0MKb1OsUvC71atT4A=
X-Gm-Gg: ATEYQzxgf7ZzvaBKAet+rmaWbOvts3B6Tbo+ct28I8J3BlUINnXLBMNY1hMih9rIYjl
	xX9zUiUKWMnwetlu8iu85VF5KypYqRv8VIZDRRD16qoMouBYTWBnCNhpabiUFaR+9n25yTOiVoO
	cSE3fdfWNWtWQ9pZgt54xv5jfNmGf9I6L7qXJBD2Q1fudECuR3DiGHz6KW8fyuMWjxcUdfxlFaC
	LW4yGaH0Nu5gfFur47jmIFxCqVuaMEO/H6YVoUwCMCAvf+ohYEfV87v9ff4gDnk6B8v52QJ/CKL
	KoSiB/l1ygwxd1K/Xt1z2TZuFmJ4zJe4Mk5W7NfIfWC3Bk4D4FboJUsD+5FWz8r7MiHj0Q==
X-Received: by 2002:a05:6820:c82:b0:67b:aec3:f4a5 with SMTP id
 006d021491bc7-67baec3f7c0mr3487050eaf.0.1773070469533; Mon, 09 Mar 2026
 08:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306210427.703454-1-luiz.dentz@gmail.com> <625d3721ef07c7c15488af80fbfc53620921611b.camel@iki.fi>
In-Reply-To: <625d3721ef07c7c15488af80fbfc53620921611b.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Mar 2026 11:34:15 -0400
X-Gm-Features: AaiRm53muLjPf3kLvHDLuo0LmrwJnkasd4PNZzM2jr1BFm4ymN3Mr6cayWXzj6M
Message-ID: <CABBYNZ+QMy6ES5hJCFPmP1-ig0_toOhjWERSXaaddFb6NqqUHg@mail.gmail.com>
Subject: Re: [RESEND] Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Mar 7, 2026 at 3:59=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> pe, 2026-03-06 kello 16:04 -0500, Luiz Augusto von Dentz kirjoitti:
> > From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> >
> > After commit ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in
> > hci_chan_del"), l2cap_conn_del() uses conn->lock to protect access to
> > conn->users and conn->hchan. However, l2cap_register_user() and
> > l2cap_unregister_user() still use hci_dev_lock(), creating a race
> > condition where these functions can access conn->users and conn->hchan
> > concurrently with l2cap_conn_del().
>
> AFAIK the above text from the original submitter is a bit inaccurate,
> as l2cap_conn_del() is called with hdev lock held, so conn->users/hchan
> should be safe.

Yeah, I did amend the commit message since I don't think the hchan and
hci_dev_lock are relevant here, so it only keeps the information
conn->lock must be used to protect the l2cap_conn and l2cap_user.

> However, using conn->mutex should fix the use-after-free in
>
>         conn->hcon->hdev
>         hci_dev_lock(hdev);
>         hci_dev_unlock(hdev);
>
> by making l2cap_unregister_user() safe to call after the hcon/hdev are
> no longer alive.
>
> The change looks OK to me, but probably worth to double check with
> syzbot it fixes the original issue
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th-next.git master
>
> > This can lead to use-after-free and list corruption bugs, as reported
> > by syzbot.
> >
> > Fix this by changing l2cap_register_user() and l2cap_unregister_user()
> > to use conn->lock instead of hci_dev_lock(), ensuring consistent lockin=
g
> > for the l2cap_conn structure.
> > Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D14b6d57fb728e27ce23c
> > Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_=
del")
> > Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 14131e427efd..6606d7f12534 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1678,17 +1678,15 @@ static void l2cap_info_timeout(struct work_stru=
ct *work)
> >
> >  int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *us=
er)
> >  {
> > -     struct hci_dev *hdev =3D conn->hcon->hdev;
> >       int ret;
> >
> >       /* We need to check whether l2cap_conn is registered. If it is no=
t, we
> > -      * must not register the l2cap_user. l2cap_conn_del() is unregist=
ers
> > -      * l2cap_conn objects, but doesn't provide its own locking. Inste=
ad, it
> > -      * relies on the parent hci_conn object to be locked. This itself=
 relies
> > -      * on the hci_dev object to be locked. So we must lock the hci de=
vice
> > -      * here, too. */
> > +      * must not register the l2cap_user. l2cap_conn_del() unregisters
> > +      * l2cap_conn objects under conn->lock, and we use the same lock =
here
> > +      * to protect access to conn->users and conn->hchan.
> > +      */
> >
> > -     hci_dev_lock(hdev);
> > +     mutex_lock(&conn->lock);
> >
> >       if (!list_empty(&user->list)) {
> >               ret =3D -EINVAL;
> > @@ -1709,16 +1707,14 @@ int l2cap_register_user(struct l2cap_conn *conn=
, struct l2cap_user *user)
> >       ret =3D 0;
> >
> >  out_unlock:
> > -     hci_dev_unlock(hdev);
> > +     mutex_unlock(&conn->lock);
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(l2cap_register_user);
> >
> >  void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user =
*user)
> >  {
> > -     struct hci_dev *hdev =3D conn->hcon->hdev;
> > -
> > -     hci_dev_lock(hdev);
> > +     mutex_lock(&conn->lock);
> >
> >       if (list_empty(&user->list))
> >               goto out_unlock;
> > @@ -1727,7 +1723,7 @@ void l2cap_unregister_user(struct l2cap_conn *con=
n, struct l2cap_user *user)
> >       user->remove(conn, user);
> >
> >  out_unlock:
> > -     hci_dev_unlock(hdev);
> > +     mutex_unlock(&conn->lock);
> >  }
> >  EXPORT_SYMBOL(l2cap_unregister_user);
> >



--=20
Luiz Augusto von Dentz
