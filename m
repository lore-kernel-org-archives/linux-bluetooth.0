Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998C38333A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117823; cv=pass; b=B/0NKHLuC1xCUHDZ12GILP3nO16HKwNW/So6zYJd9tGc+dwE6Q+SQcwe58/mDL7YhhLJp9JaajWnWfmZe8WL6F6W64sSlKDEneSyQN6CQLWYN3NAU7wFQsHvMxxaBIijuqYxb87WKf4159xSw33/dlJdEa/UZbZOk2r6vaKAKLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117823; c=relaxed/simple;
	bh=5hZYlt6hYCz6LguU+w3n01grazUVwsdYgyMDvWa96nk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5k7V/qr5JHf4uK7y+dAyrWL//8t9pKz3vvAet/uaZgH4dVWlVP4+TS042NCmmul6RK1LpO3s4DcB339o4gv9ePxNJmnQnHiN/8bfUyxJjNrdb9e14D9tT28zEtLBbb2JJHE3yhuuizgqU89ksNJq6oJBtBbGHJ1a5sBcMLpy7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=aKAsYaY3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="aKAsYaY3"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hGpWN6Gfhz49Q69;
	Fri, 07 Aug 2026 18:50:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1786117809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5hZYlt6hYCz6LguU+w3n01grazUVwsdYgyMDvWa96nk=;
	b=aKAsYaY3By4wpDhHZUhj6bpj8EBW3iJookTN29SqV5CMEUZxFwvAk52zj4evdiX0uVyi9t
	9pgydS4ndxITp8h0+Yl79VzZB2n34FNfp/5YAy8wBoTqBdYUcIAbeW59/MW1jSRFXIYtBL
	WLmQu7tfj0BWUXloWvLmKQ84WgXVRwTYhJLiuEH8EETOez8DL4ZWNPxQyu3h5DViNZzb4D
	GCgn5uwNKOIHVLt9hJvfi75fBWPvn87Adf13tO9vjePO0XQphR09ytcfVUzoizHttWxMfX
	qb5WobjtriTVSkQtTPV539YtK+rm6e6fCu//0jCLgnlTaUeoKbY659T8OK5QGQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1786117809;
	b=Dm2OkXFM1T6LgKvTUM9TYuzLpRJEKdc/i0ZYtpznlulLuiMwxZxoZzZiDud9VcD58gRO7H
	zi+0amOWhlJ3in9vNsS2XYpt+D0yxPoHqqMxAm4fHLZywEna/WbSEL058sFC5ONy0Kis6d
	QzCWutRmJdzASoe33tbmj5IHkAo19c8fu1FfkNCsU6E9fvleQrolO1Ot4dbejpJujpLwZM
	6Hj1TFPtaMXwbdPFwuOPzELwYM7bDKfiqBSWpUh7ZSNdOKUUNUlZQVSqPfU7cF3fe15ASI
	3c2DGNLESnNZO7zFHxqtCvIqgIMO5V6pKCcVWrx49rJXjombnB3ObcQGKlMMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1786117809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5hZYlt6hYCz6LguU+w3n01grazUVwsdYgyMDvWa96nk=;
	b=hiqXOcnJGvWY7l0aGhD80XkMZjQVgZh0t8YyTqxdh2c6WtNcV6d4JJCWOVHWnHu0s/Hr+7
	/dKgOZ8b5UvUrGrrv0mm6FDmC/TlKjtOlmpR4Bu7zB6uY8J7cQcWFnhsFrMGRc9Djfux4E
	oryTgRR6qjlkZPxfrnWH+YhkfXns7SDp1OpxPEjY7UklBX2LKeo4/CFEVThmgOa0TAAZIc
	CBPYinO69Sq3753Yby6uQGRUYS7vEq51fUk62ec76phaSJMO6U3+FFyIUaeQpgfzW3A/a5
	RTlaIgPC8eojka6I1LzZ6fT2XymDY5fdtgKVbwmogMHNqmpUIvVYdp0z5z+qOw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <82419f940f030e932e0fbf6bac973257893bea30.camel@iki.fi>
Subject: Re: Fwd: Use-after-free in net/bluetooth/iso.c (iso_sock_connect
 race)
From: Pauli Virtanen <pav@iki.fi>
To: vova tokarev <vladimirelitokarev@gmail.com>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: security@kernel.org, linux-bluetooth@vger.kernel.org
Date: Fri, 07 Aug 2026 18:50:08 +0300
In-Reply-To: <CAGBKPgNOmrroYBCrDekf7g92DoAvXeHJqZXoJo+vuzz-QtLwkQ@mail.gmail.com>
References: 
	<CAGBKPgM0Qm9UWQwKi4GBf+dB_b0PnBoST1WjWrh9-Pg=jupN9w@mail.gmail.com>
	 <CAGBKPgNOmrroYBCrDekf7g92DoAvXeHJqZXoJo+vuzz-QtLwkQ@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
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

Hi,

pe, 2026-08-07 kello 13:36 +0300, vova tokarev kirjoitti:
> It's been almost two months since I reported this, and I haven't heard
> back. Reaching out to you directly as the Bluetooth maintainer.
>=20
> The bug: iso_sock_connect() in net/bluetooth/iso.c drops the socket lock
> (release_sock at line 1118) BEFORE iso_connect_cis() acquires
> hci_dev_lock. During this window, a concurrent HCI Disconnection
> Complete event can free the iso_conn via iso_conn_del() ->
> iso_conn_free(), resulting in use-after-free when iso_connect_cis()
> subsequently accesses it.

I'm not maintainer, but there are several UAF fixes for iso_conn races
in iso.c in=C2=A0v7.2-rc6

Probably useful if you could verify whether the KASAN crash still
reproduces on that version.

--=20
Pauli Virtanen
