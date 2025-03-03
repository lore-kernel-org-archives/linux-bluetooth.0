Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE11EF0B7;
	Mon,  3 Mar 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026007; cv=none; b=ctLLeJUCQdIwQWSeUS6FstDK4MidcvtaaSDW9RdwkU0QF393fapR2G9KauoX5RAOhZfX9Ck2N1ObD/1xB4daiR3Mig8Q7W62sw3iUBFihbC8zERKVC01QcZT3UXvg1Zn0K/s5rLfBTiXyWRS3FukfbY97PG1rLpMDBwkb3b63zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026007; c=relaxed/simple;
	bh=DmizAxNlJuAviiyRww3so53b+eUC7H+dI7+Jqm+4JpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ij1LzZYuD+Auz/0k7hRkGEF//tloKIpO8CrD6rz2KxssZ6V33oqVL2WFll69cjFs6qxotj8te2LbIwYoj/AfzY71n36M6QuARBcSohDsU6BpWGYSvUGvlfaovCeA1gSLQOd/1+qs55JPZ11tf0s7S378uHeS2aiMy5QQ61LWkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTwHZN1L; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTwHZN1L"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bb184ab24so16247861fa.0;
        Mon, 03 Mar 2025 10:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741026001; x=1741630801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M58+VkXsEA4mif6LInS3jCCc4BHD0Nl1zisvDwV9ck4=;
        b=gTwHZN1LrOKDml8mhz3wUWCFCiSoYevT27Aq8uUDRGAGnuyFzbupSriTT6Bk+lpEA4
         xIdG6aAcN+5pz9o5bFiTWFVYSNelEBYxYrImwDRodOUac2NF9nCk+vEWmLhR4m6ASX5C
         WWr8tPUpvE3Y1Nd2Vg7Sd93rAP4RnJ/JeUCyMsdpD2vpUAaYYhDA5NzSVm+G3bT4R4T+
         9taB+OUYBq53dAwmk9KppHYrmv5GlHy2PDXo8OcoNOR3zxEu0NF5G1PSv+Cu39eHlXTs
         82T4SlxK9n8gLXmzMW+Z05X156Rro8mYI4Ws8GcElcBMLyZkDGTHw0MKtFAbc5PPelb0
         P5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026001; x=1741630801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M58+VkXsEA4mif6LInS3jCCc4BHD0Nl1zisvDwV9ck4=;
        b=ddJ6Vw51iWegO2//IIabazOk25JM9doKsaUHL1dOzz0NhGYPdT5y0wVpTNI9dHkynx
         nozD4olkBnB5QTSupxO1TcpLTiRB0PV/BF43dinlGpSR6DQbypK5B5fsrON1i0rzAfL2
         +eeHyqmy5ASplMiwmNYw50K8CvQqchsJVtGb6wlat1PBvdvlN9hw9VAfDESmaUrWHgK9
         Zo0t+maiYef+Br/+mUWbTRUiWcgq2ZjdK167XmrG68jEQQBtZK1e8wbzn+TDGAlKqXNu
         KiCfYO4sXGQBcaT6uK2sy3pj0gEIwiwR6SyQ3dHHrABz1x/ITQSFuTLjnut/+SOwimWK
         6Ztg==
X-Forwarded-Encrypted: i=1; AJvYcCWVhgm7RKBAvqJ1cKV4lUp3vr+m5NPscMbJWprkYBsQqFU2NxWGgHMHie0IScgyoCMjNPgWEIGwNeZFJsZQVjw=@vger.kernel.org, AJvYcCXsOXDyel8kdq7ZIRtA6OpP5/F2OCl/Knwg+gyr1EBblk6RA7v+fsWfi1fX6VJSFCkyajRQw18zXzMy9CF3@vger.kernel.org
X-Gm-Message-State: AOJu0YwrsfDQpeKSUls+1ey6wSY6kqoPMBxzgkK2b7phd9XHahF3FQnP
	hJcEoed0jbLsdwJ4viZ0HPnSZ/bhLwzx/LyaGcpaMcoTUlKakNGD0qwI9QtX6A9FKZrXxsNQ7QQ
	iOKaH38ODV7Y9hxf38HvIc4CebmFHsYIAMSA=
X-Gm-Gg: ASbGncvERSXk241aG3K/Vtr5WGAUFeRdxKFXClpcYHmUgjiOS9jvblqX2FVEJ+zQPS6
	/SN6CxtH5j8Q0Z+Sp4obzYEQvY1Oj4amGbPvJw4jsi7wWGVij2Yfm9IeK1NNg0qYvgJ27wkwZIw
	PTfd0wDQRfilVqhkHcZEf5/Yr/
X-Google-Smtp-Source: AGHT+IGOF0svxK3qQRi/8A/pDtDENw4ULI4zl6MXAPbotcB3/SQjSXOkeKRKQmZ6vdPoTmxY9mTBNFvvyWdc65qlq1w=
X-Received: by 2002:a2e:be2a:0:b0:308:fd11:7715 with SMTP id
 38308e7fff4ca-30b9344e0d1mr50640961fa.33.1741026000335; Mon, 03 Mar 2025
 10:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a5a3ah2y.wl-tiwai@suse.de> <CABBYNZJOW-YSOLS0tBdUQmxqbOmgT2n2jVheyxbvWbYmBicqyg@mail.gmail.com>
 <877c56dub7.wl-tiwai@suse.de> <CABBYNZJ6Gfmpur2by01B9+XxBX+VBzBY95v+9f5-VpiantunfQ@mail.gmail.com>
 <87y0xmcdl4.wl-tiwai@suse.de> <CABBYNZJsqXLRuY6ZMPujio7-tx82SHRZyZh=tChonVs-XiWMjw@mail.gmail.com>
 <87tt8acbmw.wl-tiwai@suse.de> <52df2ea6bac070c015987547840c78ac27538def.camel@iki.fi>
In-Reply-To: <52df2ea6bac070c015987547840c78ac27538def.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Mar 2025 13:19:47 -0500
X-Gm-Features: AQ5f1JplAqjd7PYGQ3BuVifAplBFjnB0tr2QgVmDinNxIFQrIf_XvMo-1Gzgvhs
Message-ID: <CABBYNZJHSoDzo7DmB84LrBw3Zi+F_QsNcD5MBJHijCo-v_KzGw@mail.gmail.com>
Subject: Re: Is commit 4d94f0555827 safe?
To: Pauli Virtanen <pav@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli, Takashi,

On Mon, Mar 3, 2025 at 12:47=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ma, 2025-03-03 kello 17:38 +0100, Takashi Iwai kirjoitti:
> > On Mon, 03 Mar 2025 17:29:58 +0100,
> > Luiz Augusto von Dentz wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Mar 3, 2025 at 10:56=E2=80=AFAM Takashi Iwai <tiwai@suse.de> =
wrote:
> > > >
> > > > On Mon, 03 Mar 2025 16:50:37 +0100,
> > > > Luiz Augusto von Dentz wrote:
> > > > >
> > > > > Hi Takashi,
> > > > >
> > > > > On Mon, Mar 3, 2025 at 10:10=E2=80=AFAM Takashi Iwai <tiwai@suse.=
de> wrote:
> > > > > >
> > > > > > On Mon, 03 Mar 2025 15:57:16 +0100,
> > > > > > Luiz Augusto von Dentz wrote:
> > > > > > >
> > > > > > > Hi Takashi,
> > > > > > >
> > > > > > > Well the assumption was that because we are doing a copy of t=
he struct
> > > > > > > being unregistered/freed would never cause any errors, so to =
trigger
> > > > > > > something like UAF like the comment was suggesting the functi=
on
> > > > > > > callback would need to be unmapped so even if the likes of is=
o_exit is
> > > > > > > called it function (e.g. iso_connect_cfm) remains in memory.
> > > > > >
> > > > > > But it doesn't guarantee that the callback function would reall=
y
> > > > > > work.  e.g. if the callback accesses some memory that was immed=
iately
> > > > > > freed after the unregister call, it will lead to a UAF, even th=
ough
> > > > > > the function itself is still present on the memory.
> > > > > >
> > > > > > That said, the current situation makes hard to judge the object=
 life
> > > > > > time.
> > > > > >
> > > > > > > You can find the previous version here:
> > > > > > >
> > > > > > > https://syzkaller.appspot.com/text?tag=3DPatch&x=3D100c0de858=
0000
> > > > > > >
> > > > > > > Problem with it was that it is invalid to unlock and relock l=
ike that.
> > > > > >
> > > > > > Thanks for the pointer!
> > > > > >
> > > > > >
> > > > > > BTW, I saw another patch posted to replace the mutex with spinl=
ock
> > > > > > (and you replied later on that it's been already fixed).
> > > > > > Is it an acceptable approach at all?
> > > > >
> > > > > I don't remember if I saw that, but yeah anything that makes the =
issue
> > > > > go away, and doesn't create new problems, would probably be
> > > > > acceptable.
> > > >
> > > > I saw this one:
> > > >   https://lore.kernel.org/all/20230907122234.146449-1-william.xuanz=
iyang@huawei.com/
> > >
> > > Ive might have missed it, we will probably need to rebase it but othe=
r
> > > than that it should be acceptable.
> >
> > Does it mean that you'd revert the change and apply the above one
> > (with rebase or modification)?  Or would you keep a part of the
> > current change (e.g. match callback looks neat) while applying the
> > similar fix using the spinlock?
>
> My current understanding of this is that the actual problem for
> 4d94f0555827 was incorrect RCU use at the callsite in
> hci_le_create_big_complete_evt(). That part was rewritten in
>
> commit 581dd2dc168f ("Bluetooth: hci_event: Fix using rcu_read_(un)lock
> while iterating")

In that case maybe we can just revert the 4d94f0555827 ("Bluetooth:
hci_core: Fix sleeping
function called from invalid context") and see if that works, might
need to trigger syzbot just to confirm we don't introduce the original
problem.

> and now it no longer calls hci_connect_cfm() from atomic context. I
> suspect there were no other callsites that needed hci callbacks be rcu-
> safe, so the original mutex is maybe OK as well.
>
> For the other patch
>
> https://lore.kernel.org/all/20230907122234.146449-1-william.xuanziyang@hu=
awei.com/
>
> The current code is doing rcu_read_unlock() in list_for_each_entry_rcu,
> so it's not quite correct. This could be reorganized to restart the
> loop after unlock and skip if (conn->abort_reason), which may be
> preferable to spinlock in rcu critical section.

I guess you referring to hci_cmd_sync_clear, yeah that is doing
unlock/lock in the loop which is incorrect, that said we don't really
need this change if for the above issue, although we need to
re-evaluate the use of mutex vs spin locks given that apparently there
could be issues other than just the BIG code hitting this sort of
problem.

> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
