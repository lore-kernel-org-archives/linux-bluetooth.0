Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93F2E7623;
	Tue,  4 Aug 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859617; cv=pass; b=tPPzj0k52Ml/d+tClwUeacNQGTNyAH78mQ2NQ4hqySHixmuXDkvPeqKr5MoOT9rLMvcF//BYxFkfvvuhsY8o8IQ9qEr79EkLW3urNsdyPl3Kib7nVF+GSJcbdVSQqxskQChTcrAm6RgnLs6USiNxoSdeGzIlEBP36XlN2HAIPEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859617; c=relaxed/simple;
	bh=hDyPUZpaBybyE11s5tUtcextma2jui3cHI1yTaxi6Ns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ube5aqWZCCECHguSWHqcSAU6HcWkNQxNVsA6pi+XFpFlV8EG1doh9Gc8HtwimsnAmzEO9v4bBc7RgcvXgQEnFwwanTs9atp/il2/bEegK8jRbwMKQy9DY8STP8lFGJCuDY273gOG/LKxZszicB+w6wbUySKS/m+sGMqNQ6Zcl+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=EJd8B0Rv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="EJd8B0Rv"
Received: from [IPv6:2001:99a:2493:f500::df3] (n13ie2z95jmgikgluos3-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:2493:f500::df3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hDz1s1pxJzyPv;
	Tue, 04 Aug 2026 19:06:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1785859601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xyCwLtLrgkwxlxvRdFy1gI7+Z1/vVbbKEQZpg3Lj8CM=;
	b=EJd8B0RvBkKmM3OmuigApKJSz683b99GHLlDgMaC+BML0EBbw4i1IBj+I44pITzJFCJM2M
	tazWZaYwW2R7A6Co1EV8f5OYJO+CA5JIR1iFl4XDpydNs2qHaLXwEzW40YknMrhVKyfb3j
	fU5ZcNXgz37/EtlRNBv3a8SDkHaGmXg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1785859601;
	b=l6eaC1VseTzarDrEWlsONeDBQ9ZoacJRKEuGtmYB8DSJbYXKLLA2WElqWT34L7szBSU9M1
	QI/3fmfJeOIUfWnnOtU0ywgCcpTz7fJSQHtSOzRw3xaXwdleJq9uy5Sk3T8JgyMsAoEYMO
	xVN9qSHjOodBcuwhzmbu2dnmxSZd5kI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1785859601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xyCwLtLrgkwxlxvRdFy1gI7+Z1/vVbbKEQZpg3Lj8CM=;
	b=aLm5bdZZ6e/ytYqBsn75OClwv0ukIeeSXhk8CmH1X15zB0TfdXhthpCweBBH1QfQS9BNqA
	5pI8eErAhlT5MhI/KxelxoVD+pLOHaFsR6JMs4BE+SeV1ecoZPZzpjef+bNeaf6lRlcx2d
	SLzisiEzS6I88qNDmvzMfKYtW5NqA1c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
Message-ID: <9558081fc92cdceafcef8a348dad46a338f79348.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen()
 vs. put_chan
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, 	linux-kernel@vger.kernel.org, 
	syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Tue, 04 Aug 2026 19:06:40 +0300
In-Reply-To: <20260804081650.937-1-hdanton@sina.com>
References: <20260804081650.937-1-hdanton@sina.com>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2026-08-04 kello 16:16 +0800, Hillf Danton kirjoitti:
> On Tue, 04 Aug 2026 08:40:16 +0300 Pauli Virtanen wrote:
> > ti, 2026-08-04 kello 08:47 +0800, Hillf Danton kirjoitti:
> > > On Mon, 03 Aug 2026 19:53:31 +0300 Pauli Virtanen wrote:
> > > >
> > > >    [Task 1]                         [Task 2 (hdev->workqueue)]
> > > >    l2cap_sock_release(parent)       l2cap_disconn_cfm
> > > >      l2cap_sock_cleanup_listen        l2cap_conn_del
> > > >        bt_accept_dequeue                l2cap_chan_del
> > > >          lock_sock(sk)                    l2cap_sock_teardown_cb
> > > >          bt_accept_unlink
> > > >            bt_sk(sk)->parent =3D NULL
> > > >          release_sock(sk) ----------------> lock_sock(sk)
> > > >                                             parent =3D bt_sk(sk)->p=
arent /* =3D=3D NULL */
> > > >        lock_sock(sk) <--------------------- release_sock(sk)
> > > >                                             sock_set_flag(sk, SOCK_=
ZAPPED)
> > > >                                         l2cap_sock_close_cb
> > > >                                           l2cap_sock_kill(sk)
> > > >                                             l2cap_sock_put_chan
> > > >        chan =3D READ l2cap_pi(sk)->chan         l2cap_pi(sk)->chan =
=3D NULL
> > > >        l2cap_chan_hold_unless_zero            l2cap_put_chan(chan)
> > > >          kref_get_unless_zero(&chan->ref)
> > >
> > > The race window is still open after this work.
> > >
> > > 					     release_sock(sk)
> > >                                              sock_set_flag(sk, SOCK_Z=
APPED)
> > >                                          l2cap_sock_close_cb
> > >                                            l2cap_sock_kill(sk)
> > >                                              l2cap_sock_put_chan
> > > 					       l2cap_pi(sk)->chan =3D NULL
> > > 					       l2cap_put_chan(chan)
> > > 					     sock_set_flag(sk, SOCK_DEAD);
> > > 					     sock_put(sk); // free sk
> > >         lock_sock(sk) // uaf
> > >         chan =3D READ l2cap_pi(sk)->chan
> > >         l2cap_chan_hold_unless_zero
> >=20
> > There is no UAF there, Task 1 holds a reference on sk at this point, if
> > you look at the code sock_put() follows.
> >=20
> If the subsequent put works without both race and mm leak, then it is the
> very evidence of uaf with race.

This and the "// uaf" and "// free sk" above appear to ignore what is
explained also in the comment in l2cap_sock_cleanup_listen():

	 * bt_accept_dequeue() returns sk with its temporary queue-
walk
	 * reference held, so a concurrent l2cap_conn_del()
	 * -> l2cap_sock_kill() cannot free sk under us.

bt_accept_dequeue() returns a new temporary reference to sk,=C2=A0which is
owned by the caller who needs to put it after use.

The "sock_put(sk); // free sk" cannot free sk, because
bt_accept_dequeue(sk) got a new reference on sk before it, so the
refcount is at least 2 here. Then "lock_sock(sk) // uaf" cannot be UAF.

If chan !=3D NULL in Task 1, it schedules l2cap_chan teardown. That
eventually ends up in l2cap_sock_kill() to put the reference owned by
l2cap_chan & sk_socket.

If chan =3D=3D NULL in Task 1, l2cap_chan cleanup is completed or
concurrent, and nothing more needs to be done.

--=20
Pauli Virtanen
