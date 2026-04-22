Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B145366DB5;
	Wed, 22 Apr 2026 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872916; cv=pass; b=C7pB8XeoSlsBpArdp6shAQwhcEJD6C/15cw2/GHw2kA9XR2DkmyFIbPW4wAYbm2i699t4Cs7P3Zhl99xJW55UGWuazMtkhHaQ+EO6C8QDVWrTbrVBgwhBY+KSW1aBZ2T6os2Pb8F4YWrc/FLWCUQbFkNbY+tutCnv0ZYlkIZo5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872916; c=relaxed/simple;
	bh=qIjzBdXnKCzxdoN144KjXzG83a3Ym+fkkiWHn5O77OQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BekY0OWeLhzXbtkB3CWyqY2nUCJr62dB0Yumr6JJN4DR/8iIpyeLRIpLoAl9q9Bn9cgJ75mx6hbEo377Dctz/f7G2PwZ8xlkLra+6ZPu/m0xWahzUebdf6+zoEJJboBaQT44qegN0thTJXvsghk8HxhH9mTgnSuy4XXtV7tfJ6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=SCnUeHW3; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="SCnUeHW3"
Received: from [10.71.99.228] (unknown [185.65.133.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4g13Xs6bhvzyQm;
	Wed, 22 Apr 2026 18:48:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1776872910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G6DEaEaZjJXJucBXhJKzjDt8uNV9l5tZ3qXgUv7LXrk=;
	b=SCnUeHW3k4fSdIbVrcXMrikm9I2pswNdakiDOY3LWRG7mbts89BO6DuhiNy0er41KjCGPi
	DR7ibJcleuTtxPuLvYZ7sbwiugYSmPL5mYu3lQpYLet1duuWJyg3MMNsyBySHl98y/IOVj
	FJw6Hw2ZcWmrHLKUdIEvk4zAyjJLxyo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1776872910;
	b=GaP0+uiLamMT8OvnfnD7b1JMQ65BQXEKKt9mHR3B86XyRR/5rphu30OKLTJ05uWIUVsjmH
	91zv3R62AXXXv2snB2BHt/cQZ+IujkDMWbJgOJRamum5lfKKMbditS6EkiP/Hpg5aqtoYk
	ghLVEt5COFrC6/3ubn3PQ6EVRdcyfYs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1776872910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G6DEaEaZjJXJucBXhJKzjDt8uNV9l5tZ3qXgUv7LXrk=;
	b=HZOYm5auCjTtoB2jLmqRpdasQZllmAXwApiaRIjVpmqw8SAq/qfK/1YqtiXN6/IoYI6DgQ
	AnUw5Dfk3BRJMjLc0k6bggzVyLBAyIRoevSB8Hk180Qj1dNKOcwwXHLADP0UJ3GFhaJc+w
	w8IZIkqrGgEEGn2KLRHeERE3LlsybGU=
Message-ID: <910465cac44a42a12c781b64f1d113940de73a06.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: HIDP: guard session->conn in
 hidp_connection_del
From: Pauli Virtanen <pav@iki.fi>
To: Michael Bommarito <michael.bommarito@gmail.com>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 22 Apr 2026 18:48:11 +0300
In-Reply-To: <CAJJ9bXxCMVzVASz64obn78Ob2CDKBZX3r4B5iE_=+hbnwXDirQ@mail.gmail.com>
References: <20260306023155.554597-1-luiz.dentz@gmail.com>
	 <20260422011437.176643-1-michael.bommarito@gmail.com>
	 <CABBYNZJu6bGZadWc10g=ZJPHoDZ_RKDosCgasow3oRpQchYZvw@mail.gmail.com>
	 <CAJJ9bXxCMVzVASz64obn78Ob2CDKBZX3r4B5iE_=+hbnwXDirQ@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2026-04-22 kello 11:09 -0400, Michael Bommarito kirjoitti:
> On Wed, Apr 22, 2026 at 10:55=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > We might need a lock in order to access the session->conn:
>=20
> This one is a little easier than the other txwin_size issue in terms
> of blast radius.
>=20
> What pattern would you prefer here?
>=20
> Option 1, smaller but ordering questions: hold the semaphore across
> check and use like this:
>=20
> down_read(&hidp_session_sem);
> if (session->conn)
>     l2cap_unregister_user(session->conn, &session->user);
> up_read(&hidp_session_sem)
>=20
>=20
> Option 2, more correct but more cycles: snapshot the conn and use outside
>=20
> down_read(&hidp_session_sem);
> conn =3D session->conn;
> if (conn)
>     l2cap_conn_get(conn);
> up_read(&hidp_session_sem);
> if (conn) {
>     l2cap_unregister_user(conn, &session->user);
>     l2cap_conn_put(conn);
> }

I'm not sure now (would need to rethink it through), but one probably
should check if dbf666e4fc9b is needed or whether 752a6c9596d alone
would be enough to address the original issue.

--=20
Pauli Virtanen
