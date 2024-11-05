Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A31D2B34
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848651; cv=pass; b=K/t0qrjOEIuedxHcI5y8xdL1kZ/TERIWupR/A2xw8VnlgtWu5EX7AVEcQU7I8az2x7hZog2WN5c1I8/UoxrvSxiUWjOTxa+Jv/2/m0tRtLnGg/iZ7FSRZnUaJx8FGTyw9yCB/ZWO/AvBWXGLAb5L2bSiIXF4ryYaUg6qyPCIwJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848651; c=relaxed/simple;
	bh=AtkbDNvlzJb8WQDaVHFho/XKlip+NHkhpblRQnASECg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdxIFPU5Ye4A8tPg8uCdaSWe308S5Ugy0s10c7VKH3boDOI1XzKPxwOKCUxY/xfRvLjhoMGcZcUMgA/5EiczOtDBKrRpGk0AN6xjyvTV4KcQVcra4D+D+5cfw4jPBw0+mTUxi3tUbyxykVUBKa2+ruegkO0H/Gfi0qUS4l/4GNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=LILDW/IC; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="LILDW/IC"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Xjkkp2GVXz49Q02;
	Wed,  6 Nov 2024 01:17:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1730848644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p4azzaHQjA8Cuc9WrESvyyxG3oaigvEHCVqgi8hDyJc=;
	b=LILDW/ICzBr5Usm3EiBOMhKpWHYoIq4RZTLuS+sXqHGxWEkR8hHTWLUT+oeyL1DO43+ENx
	LyKLmtZEz9nbN+TQ9o0sgp64q+agzOi98Ua/IZfZwZq2Cl/XGGLEcuIpmj0eVdK/COY7Wh
	GfZWlOsHwvI+7ucb2qcnn7NwDOWEMHrJ11xiTK80NJhLJYIqIH7r8Maah3rRu85x1AAMQo
	FKZXl1DZkjCqKADwEgfyUQgWHegUXVn/LZ8MkQsnvyBgqW/4Yrgzq1SJquBtLM0B7JXtuV
	Wc4i9hculBD+RxYhyw2bKobyZve5ERLyH9vnQP/uw7gfFtFPxfSubAOOaxfzyQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1730848644; a=rsa-sha256;
	cv=none;
	b=eQ9N562jtvFZI3QNpMo1mokfq19IYbrYsTfSNJPiyR1lkL7cweSTCyJ5l1uOJpyeVBRZkJ
	BtUPldt8lr7K9mFWdtWKzyVeX0jV9NOF2PVrGpbMuOAS7Ledw0cil7u8dvktNdMZFoL+9A
	is4cYje1le4y9HCpe13pSEe4t5sER0OzKcdW1WIcVYg8TryzsSoYJ4/MU2IKELyerkWLeq
	Dp2ZY0q9LzDQ+JJkiJ7aABkqP21Gr0qkO191jLd5DPpdofdXxYxwtXXb0Ixs9HSzp085tK
	U/hFMMpdMvpO+i9woqshde/P1TIpRdSpNadCldfURECAT0e2uEh8lR56JHJgwg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1730848644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p4azzaHQjA8Cuc9WrESvyyxG3oaigvEHCVqgi8hDyJc=;
	b=NYqn2PCwi7qWRglQV6nFC8S86suIArZGz0Ny8egF/AO9l9Hr9OEesVPOpz6xbq3PUH/myW
	P9YZ3c4Q5XvyI0ptt5O9xcQP8JZ1HVx2ycuOhVdK38dfczRm2ZfnS0Be4xoMwE6a33BJN+
	y9gv+HXcoKWokCXb7bUSwMW5lz4BndQfLKSkk6w658dVHQPN4r4pcz497saVQXXszRKmln
	QDYdXs41tmN3m0MHOBCNKFA63gllTOkN20TVWd1EbxDP0tGS8IdFTPDzzlv1wZ3sg+gWCP
	q55sXaK3jyCDHQcGs/h15yrL10tOApYdTsZSfaOGHk39wnU+V8j3OdOIsZlZWQ==
Message-ID: <99fa2643e4911947fc3b72df683dd88ee9f9ab4e.camel@iki.fi>
Subject: Re: [PATCH 1/4] Bluetooth: ISO: Do not emit LE PA Create Sync if
 previous is pending
From: Pauli Virtanen <pav@iki.fi>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>, 
	linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com, 
	andrei.istodorescu@nxp.com, luiz.dentz@gmail.com
Date: Wed, 06 Nov 2024 01:17:18 +0200
In-Reply-To: <20241101082339.4278-2-iulia.tanasescu@nxp.com>
References: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
	 <20241101082339.4278-2-iulia.tanasescu@nxp.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2024-11-01 kello 10:23 +0200, Iulia Tanasescu kirjoitti:
[clip]
> +	rcu_read_lock();
> +
> +	/* The spec allows only one pending LE Periodic Advertising Create
> +	 * Sync command at a time. If the command is pending now, don't do
> +	 * anything. We check for pending connections after each PA Sync
> +	 * Established event.
> +	 *
> +	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> +	 * page 2493:
> +	 *
> +	 * If the Host issues this command when another HCI_LE_Periodic_
> +	 * Advertising_Create_Sync command is pending, the Controller shall
> +	 * return the error code Command Disallowed (0x0C).
> +	 */
> +	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
> +		if (test_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags))
> +			goto unlock;
>  	}
> =20
> -	return hci_update_passive_scan_sync(hdev);
> +	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
> +		if (hci_conn_check_create_pa_sync(conn)) {
> +			struct bt_iso_qos *qos =3D &conn->iso_qos;
> +
> +			cp =3D kzalloc(sizeof(*cp), GFP_KERNEL);

AFAIK sleeping alloc in rcu critical section is not allowed, I suspect
this produces:

BUG: sleeping function called from invalid context at include/linux/sched/m=
m.h:321

if you run it on kernel compiled with CONFIG_DEBUG_ATOMIC_SLEEP=3Dy.

I've found the following useful when testing:

CONFIG_DEBUG_KERNEL=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_DEBUG_SPINLOCK=3Dy
CONFIG_DEBUG_LOCK_ALLOC=3Dy
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
CONFIG_PROVE_LOCKING=3Dy
CONFIG_PROVE_RCU=3Dy
CONFIG_LOCKDEP=3Dy
CONFIG_DEBUG_MUTEXES=3Dy
CONFIG_KASAN=3Dy

--=20
Pauli Virtanen
