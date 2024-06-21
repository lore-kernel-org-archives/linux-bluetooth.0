Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B810A39
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985468; cv=pass; b=X9EqW9YMik6r+UDQA2dYBsz0Q/bccHGBePbaD2PYbjJiqu18hp0rEdw95v72xO6Ca5HbTm7OjsQ6I0fYelBaBfXj89yL1Bl3VAjy26o6GHNiuAk7dIjufxhCeyJfDPTbLXUO4jx2r/IlxoIc1Nc6oaHJIUCHfzMIUh7jBYvByHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985468; c=relaxed/simple;
	bh=b/J6CMaIUIi55C0xOuPn2HRLywaqUCuS9tT2kJSyyfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TauLknHtgDJ2ZtvBbKK6T+BJJL50HHXx4AfllKwRtsoYQyTf9Szc7/a/NXK6kIWiCyBAInTABZgICe0bVIcKdfcoVd4Fy15tK7D2aNAOY/ikERNz0ZD602wt1iKGjR8pR/ft8OjY9iiN8Zu3wCNA/e2r8q5T9NUafYqNJvpIYTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Emu9QGcv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Emu9QGcv"
Received: from monolith.lan (91-152-121-138.elisa-laajakaista.fi [91.152.121.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4W5MSb00nYzyRc;
	Fri, 21 Jun 2024 18:57:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1718985455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ptOo/314WARx8WRi2xCnxx+/NfXSGP6yuHuy0X3fvbc=;
	b=Emu9QGcvIVgqOkN4sdqens5MSi5EMVgoONmwfa15Us6ntszC82Bo0tmVDThUKxOjUscfak
	gSfKjJKVpkfGvD1NsgtN70iqla74KbWYF5wkZd88qwAiTrGb9a+ecgs3Y5edXpzeS5WIr7
	u51DW83zW71JG/Qqn46XxPV/1lFKf8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1718985455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ptOo/314WARx8WRi2xCnxx+/NfXSGP6yuHuy0X3fvbc=;
	b=BxY3hxrY76DwiPRfetggE8Uz8JSsUqZkghp2cVG0S3JXtJd6JHOQWz3Hoc0j9ZyJuHwbTo
	w4r1cnc9k8IDFt+UiuSNE6XC4nyptljTLsl1CKizb8LlVtbdws1tOp1aBcmdRKLgFy30Oc
	lPoyUG7q0rds6AEr+UW1fH6qIXWPztg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1718985455; a=rsa-sha256; cv=none;
	b=Pb72msDAoOx4Ud4WDIcTt5FWHCS7SUn7rPuD1GGEycdZZrE9oMnEDyafrGz5Gf3LYKtGBm
	nyjAbIQe9pF/VEfcTFpV1TLewF2Wpt/Qym8/YSekbduRX3HxObZSNyJiGzVEkZk6ifLUDV
	0m1Ij11FcKub08K4fblNQGllBc4YuJQ=
Message-ID: <624ee5406c56bf568d68d5fef1463d8fe9b4018d.camel@iki.fi>
Subject: Re: [PATCH] bluetooth/l2cap: sync sock recv cb and release
From: Pauli Virtanen <pav@iki.fi>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 21 Jun 2024 18:57:33 +0300
In-Reply-To: <tencent_8AF62ECF8CADE7DB86DA52DE864289872E06@qq.com>
References: 
	<CABBYNZLu-wAu6cdyDVim=bP+0Ld-P=YvENO=fa6r=rdY4UqukQ@mail.gmail.com>
	 <tencent_8AF62ECF8CADE7DB86DA52DE864289872E06@qq.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2024-06-21 kello 22:45 +0800, Edward Adam Davis kirjoitti:
> Hi Luiz Augusto von Dentz,
>=20
> On Thu, 20 Jun 2024 12:53:19 -0400, Luiz Augusto von Dentz wrote:
> > >         release_sock(sk);
> > > +       l2cap_chan_unlock(chan);
> > > +       l2cap_chan_put(chan);
> > >=20
> > >         return err;
> > >  }
> > > --
> > > 2.43.0
> >=20
> > Looks like this was never really tested properly:
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > 6.10.0-rc3-g4029dba6b6f1 #6823 Not tainted
> > --------------------------------------------
> > kworker/u5:0/35 is trying to acquire lock:
> > ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > l2cap_sock_recv_cb+0x44/0x1e0
> >=20
> > but task is already holding lock:
> > ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > l2cap_get_chan_by_scid+0xaf/0xd0
> >=20
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >=20
> >        CPU0
> >        ----
> >   lock(&chan->lock#2/1);
> >   lock(&chan->lock#2/1);
> >=20
> >  *** DEADLOCK ***
> >=20
> >  May be due to missing lock nesting notation
> >=20
> > 3 locks held by kworker/u5:0/35:
> >  #0: ffff888002b8a940 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
> > process_one_work+0x750/0x930
> >  #1: ffff888002c67dd0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
> > at: process_one_work+0x44e/0x930
> >  #2: ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
> > l2cap_get_chan_by_scid+0xaf/0xd0
> >=20
> > l2cap_sock_recv_cb is assumed to be called with the chan_lock held so
> > perhaps we can just do:
> >=20
> >        sk =3D chan->data;
> >        if (!sk)
> >                return -ENXIO;
>=20
> If the release occurs after this judgment, the same problem will still oc=
cur.=20
> Recv and release must be synchronized using locks, which can be solved by
> adding new lock.
>=20
> Can you provide a reproduction program for the AA lock mentioned above?

eg. l2cap_data_channel() calls l2cap_sock_recv_cb with chan->lock (and
conn->chan_lock) held.

All callsites eg. l2cap_raw_recv() don't seem to hold chan->lock, so
you'd probably need to check the locking on all of them, if you want to
use chan->lock for this synchronization.

--=20
Pauli Virtanen
