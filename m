Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AFC210F6A;
	Mon,  3 Mar 2025 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024073; cv=pass; b=AqOFUUUmIrbF7abrd9IEd6OvN+X93bUWeww7eD1pIlUPTqxnqwuTx1Iw5v0L2WglJvw8uZjBpH3k4gwqW19Eb7RZTibvmrPjkbnpyhpaC9f2NlOZDzUf8n72qX9fr/opRapHhpui7y3PijlUsa0LcJOesdY1LPvh4T4dco0MHPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024073; c=relaxed/simple;
	bh=/9oba9d8QKtUF/0pHKuUAsmhxdCrNWzKYk8PvZrGrPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FCCENgfxmxUbxBaych+/mNqlbQG4nOtKhUYzMSNiob7twH4yPbXGtacBP1LLA3KC0hJ4LlS1nOg9dmrDf7GZg52mAGcwQTbCIHQAzwIichVcQ2ziyHrRNGZzuJn+1JSvzZFaon5zqU6x6RzBSrFf82FZr+v9/rReAiBe7d+myus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=NhaEARma; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="NhaEARma"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z65r319tmz49Psm;
	Mon,  3 Mar 2025 19:47:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741024068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VDSMVvHO56dJUyYJgwu3LoGl+5HvCtV/DfpUPOgNVHU=;
	b=NhaEARmaqAmEVEw5XHGdY6AjSuMIK78enrndpZA88ucktNGiQUTnYU9A+REDtixzH1ij45
	g0oy61VLpFapiIQEGGz6E0iGj0efltIRsImgMecOBJMOamnAIUU2okfgmQIWSUy5ejtenc
	RDqvtNdGUbzoL+F11k1KJ/kbSTr5PkJG5mhGx5K1TyYCLw5A0YQVXVqUCa8auerCHYbocw
	uvuRS0NFJXsKi3Zx9WSo4zzjZNXERTGBt8EwqyzVazOAOWiejXC/OvetNaTeXD588L/VKs
	MIbH8yFrRsXjqeega/5qo9iYyjeQvF4l9dbgajRW3CRiupTlNeNrweSlimQxcA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741024068; a=rsa-sha256;
	cv=none;
	b=DqiATuV8hdX+3b/qWEa7eyoMRyawFxAsu5x+PIBKEcRkrh6pKnQHIr7USKYGNKBuA8tHGi
	kki/HoHid5LcdexgNFadZu1b89EMdp+Irlq83NjDMvBRvaQcRafY/lgwf53IaCpK9DN3kQ
	/nDfz85nF6RBsUSp81ILkDivhgX8ieLp7kQi4w3y1r4YWy24x5BBo35P4fYsUJVTvZ+5Iz
	/JQDq/q3MeYofkFyGxxrD7jM4UB5TZ5/yKPGFqqPO1OyN38O6BJxG9nYemIekG3lqr5yz2
	5lJIEshiPRiswzkIAC43llc0vgXFQgkPaaFwZiaoU2lS/0LGsjdDoZFnNvQkKw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741024068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VDSMVvHO56dJUyYJgwu3LoGl+5HvCtV/DfpUPOgNVHU=;
	b=Cis0eDkmgqN0IFAG5P0isEy1It47v/HFE9KVFUnA53+zyHDkhDBDCf1NHZgU58CSD2V2/z
	EatoLOsNKpQPJJLlC/H0vWgaEgPuA+MtrTR8Tol+OhJSe+PvuWHI0+0hYXvZ/QsCM9UgQc
	UKQBrRXGZ0/KxZqk1BK0ZAPDKKANubfLUdEODmhOUXwEgFyeRReZO7SUKmyfjzvsS7Te66
	ohRvNnyqvvbL1EvOhsn6aCng85nbjT+/Tn9hXjoKktDmyiKYLKg8Jc/FYVIg/sfWihSBGM
	Hm8RRQaaJe5jXIS7crhqX2iyULeBGdT+X/JMfdoLuzYgxAxecmnDf6S98mdXbQ==
Message-ID: <52df2ea6bac070c015987547840c78ac27538def.camel@iki.fi>
Subject: Re: Is commit 4d94f0555827 safe?
From: Pauli Virtanen <pav@iki.fi>
To: Takashi Iwai <tiwai@suse.de>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 03 Mar 2025 19:47:45 +0200
In-Reply-To: <87tt8acbmw.wl-tiwai@suse.de>
References: <87a5a3ah2y.wl-tiwai@suse.de>
		<CABBYNZJOW-YSOLS0tBdUQmxqbOmgT2n2jVheyxbvWbYmBicqyg@mail.gmail.com>
		<877c56dub7.wl-tiwai@suse.de>
		<CABBYNZJ6Gfmpur2by01B9+XxBX+VBzBY95v+9f5-VpiantunfQ@mail.gmail.com>
		<87y0xmcdl4.wl-tiwai@suse.de>
		<CABBYNZJsqXLRuY6ZMPujio7-tx82SHRZyZh=tChonVs-XiWMjw@mail.gmail.com>
	 <87tt8acbmw.wl-tiwai@suse.de>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2025-03-03 kello 17:38 +0100, Takashi Iwai kirjoitti:
> On Mon, 03 Mar 2025 17:29:58 +0100,
> Luiz Augusto von Dentz wrote:
> >=20
> > Hi,
> >=20
> > On Mon, Mar 3, 2025 at 10:56=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wr=
ote:
> > >=20
> > > On Mon, 03 Mar 2025 16:50:37 +0100,
> > > Luiz Augusto von Dentz wrote:
> > > >=20
> > > > Hi Takashi,
> > > >=20
> > > > On Mon, Mar 3, 2025 at 10:10=E2=80=AFAM Takashi Iwai <tiwai@suse.de=
> wrote:
> > > > >=20
> > > > > On Mon, 03 Mar 2025 15:57:16 +0100,
> > > > > Luiz Augusto von Dentz wrote:
> > > > > >=20
> > > > > > Hi Takashi,
> > > > > >=20
> > > > > > Well the assumption was that because we are doing a copy of the=
 struct
> > > > > > being unregistered/freed would never cause any errors, so to tr=
igger
> > > > > > something like UAF like the comment was suggesting the function
> > > > > > callback would need to be unmapped so even if the likes of iso_=
exit is
> > > > > > called it function (e.g. iso_connect_cfm) remains in memory.
> > > > >=20
> > > > > But it doesn't guarantee that the callback function would really
> > > > > work.  e.g. if the callback accesses some memory that was immedia=
tely
> > > > > freed after the unregister call, it will lead to a UAF, even thou=
gh
> > > > > the function itself is still present on the memory.
> > > > >=20
> > > > > That said, the current situation makes hard to judge the object l=
ife
> > > > > time.
> > > > >=20
> > > > > > You can find the previous version here:
> > > > > >=20
> > > > > > https://syzkaller.appspot.com/text?tag=3DPatch&x=3D100c0de85800=
00
> > > > > >=20
> > > > > > Problem with it was that it is invalid to unlock and relock lik=
e that.
> > > > >=20
> > > > > Thanks for the pointer!
> > > > >=20
> > > > >=20
> > > > > BTW, I saw another patch posted to replace the mutex with spinloc=
k
> > > > > (and you replied later on that it's been already fixed).
> > > > > Is it an acceptable approach at all?
> > > >=20
> > > > I don't remember if I saw that, but yeah anything that makes the is=
sue
> > > > go away, and doesn't create new problems, would probably be
> > > > acceptable.
> > >=20
> > > I saw this one:
> > >   https://lore.kernel.org/all/20230907122234.146449-1-william.xuanziy=
ang@huawei.com/
> >=20
> > Ive might have missed it, we will probably need to rebase it but other
> > than that it should be acceptable.
>=20
> Does it mean that you'd revert the change and apply the above one
> (with rebase or modification)?  Or would you keep a part of the
> current change (e.g. match callback looks neat) while applying the
> similar fix using the spinlock?

My current understanding of this is that the actual problem for
4d94f0555827 was incorrect RCU use at the callsite in
hci_le_create_big_complete_evt(). That part was rewritten in

commit 581dd2dc168f ("Bluetooth: hci_event: Fix using rcu_read_(un)lock
while iterating")

and now it no longer calls hci_connect_cfm() from atomic context. I
suspect there were no other callsites that needed hci callbacks be rcu-
safe, so the original mutex is maybe OK as well.

For the other patch=20

https://lore.kernel.org/all/20230907122234.146449-1-william.xuanziyang@huaw=
ei.com/

The current code is doing rcu_read_unlock() in list_for_each_entry_rcu,
so it's not quite correct. This could be reorganized to restart the
loop after unlock and skip if (conn->abort_reason), which may be
preferable to spinlock in rcu critical section.

--=20
Pauli Virtanen
