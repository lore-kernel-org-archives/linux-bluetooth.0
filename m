Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A531E883
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040633; cv=pass; b=B8WeaDxY4Q6PTaJf0JcKWip9DDvnYCEwae+hLsI0A1vlkneFSZ2oYU6Fe8Z3wqoH33BqejOyZYsfkxTiZVQh+yBbxGlordgniGxuSDZvSwsynKlh/cGkJqAVSyHrw7hmbsqjgDH1QhtmOqTvZJDT2V3b85g8/a7XpEznqC+hMAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040633; c=relaxed/simple;
	bh=ox2eXhTeXHHByTFhITboX2UrpBsAObVB2TNR9hBC+44=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rbtixCePSytNezmJZmrMSZi4iPsDa6jpMv2mNsz84vi5CPvO3F5YhFmw/i7U0DkgmaAcB+Ej9FvQlPyFTNio4hLPUb1BD3D8rTOKy831ey26wCwo0eLAT7v+DUQaADWLuKOPORDjPs62UD0ZNb34enCMhJW5v5hrXTIbvozYVxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=CsEkT8xW; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="CsEkT8xW"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cR6xV63PHz49PsJ;
	Tue, 16 Sep 2025 19:37:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758040623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xKGxIU70V291/zi+iVAZsVT8XbCNdFeLcU+cghoYRAE=;
	b=CsEkT8xW18P7ipWPss62Y8CfAVMC43bAlOIocM6lvhvPrbPr9NIilkOvomPTcIcdfpX4Ce
	xiOWxCKbuHiL30p4To7fWdsH/yd8nyBJpmsNeyFZbQheT5HJlS2h5yekLdht6HBuwwgVHX
	7rTDWIDnttSRk5W3ZqCxe9jBpZnObRrKuhHMSDLm9G1PBzbPjKZPjaw5xb3OlMDzOkgS8c
	FUAllSTy0ZZljlLdk3ZKlyVLl7ojpqe8Q5QOrEDDb30VtZZc9J846a5eS4nEOTBd47AXuR
	cpfWCB2DhqKTjo3tKi4wqV4sOR4iAH2svQ6d3WPzlmCmDvsSJHZOCnam4/tpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758040623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xKGxIU70V291/zi+iVAZsVT8XbCNdFeLcU+cghoYRAE=;
	b=Rh6tW0TM8emEQTJtMDxHRsKg0JqoBA3NXxECe+Nu5FcXRYhAeoO6xDXErile+Gk35OOYKK
	aKwL+vz0Jtxp2Bp6rghAnhj4EPli3Ger1V+H4GlW+CUO5JOHs/R7oZ7c+39Mjg48SiVuD0
	GZCbwZ1O2oj5XFVGV/J0hqVgKgCv8vhRG331YkoWsjT1Up0cdDVaA6aoH0oJ5cSATti/eT
	r/1JALTI4ndXbUdjGtweJobf/kutL9g74csbU0ReAjg6NY6/IQqKCmSP2tWeH8e9zU71KN
	LiH+lBWXVsExVp5GCTlJ2jhFBI9tyX9/PyB8yZ/7mjw0tPjNYighLolZPSmsQg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758040623; a=rsa-sha256;
	cv=none;
	b=YgMQlqBTrGFptVBxQDiDH6gqRjj4IC5RHEToghfB4KCqQOVeSKb7yxG8auMDmF+f5Gn7kE
	5EFUvcYY+F7i5wdKjaXuF0p1YyXowuGAjDHoGAGTM3Rnsa0S5iy7NklCD83iWK+cALfSTo
	YrbdIhBENG9txO8xPc5G2kgctAoMn2oHryBpixj07Sw2GKZ++7EozfVv1c4kwRRZNJM8er
	RHGrKdYdZRxEct4LXruUGqC8gR3hiGhnne9FH/o0p0YF6BenbfgFJZYu6PyZ9anUZ8mxtQ
	ykdPHQ/f8E2aOiAErlc0hmFl5k/FJYir0jtWLPgchH3ngozagBptbwpfXjoq7w==
Message-ID: <38ece9403b84095b1d65d1f52d987a2ec7534f0e.camel@iki.fi>
Subject: Re: [PATCH v6 3/3] Bluetooth: MGMT: Fix possible UAFs
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 16 Sep 2025 19:37:02 +0300
In-Reply-To: <20250915161504.814410-3-luiz.dentz@gmail.com>
References: <20250915161504.814410-1-luiz.dentz@gmail.com>
	 <20250915161504.814410-3-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2025-09-15 kello 12:15 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This attemps to fix possible UAFs caused by struct mgmt_pending being
> freed while still being processed like in the following trace, in order
> to fix mgmt_pending_valid is introduce and use to check if the
> mgmt_pending hasn't been removed from the pending list, on the complete
> callbacks it is used to check and in addtion remove the cmd from the list
> while holding mgmt_pending_lock to avoid TOCTOU problems since if the cmd
> is left on the list it can still be accessed and freed.
>=20
> BUG: KASAN: slab-use-after-free in mgmt_add_adv_patterns_monitor_sync+0x3=
5/0x50 net/bluetooth/mgmt.c:5223
> Read of size 8 at addr ffff8880709d4dc0 by task kworker/u11:0/55
>=20
> CPU: 0 UID: 0 PID: 55 Comm: kworker/u11:0 Not tainted 6.16.4 #2 PREEMPT(f=
ull)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubunt=
u1 04/01/2014
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xca/0x240 mm/kasan/report.c:482
>  kasan_report+0x118/0x150 mm/kasan/report.c:595
>  mgmt_add_adv_patterns_monitor_sync+0x35/0x50 net/bluetooth/mgmt.c:5223
>  hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
[clip]
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index a88a07da3947..be6d9b8db51b 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -320,6 +320,29 @@ void mgmt_pending_remove(struct mgmt_pending_cmd *cm=
d)
>  	mgmt_pending_free(cmd);
>  }
> =20
> +bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *c=
md,
> +			bool remove)
> +{
> +	struct mgmt_pending_cmd *tmp;
> +
> +	if (!cmd)
> +		return false;
> +
> +	mutex_lock(&hdev->mgmt_pending_lock);
> +
> +	list_for_each_entry(tmp, &hdev->mgmt_pending, list) {
> +		if (cmd =3D=3D tmp) {
> +			if (remove)
> +				list_del(&cmd->list);
> +			mutex_unlock(&hdev->mgmt_pending_lock);
> +			return true;

There seems to be a theoretical UAF left:

Task 1: [in mgmt_pending_foreach, remove=3Dtrue] mutex_lock()

Task 2: [in here, remove=3Dfalse] mutex_unlock()

Task 1: mgmt_pending_free(cmd)

Task 2: return true

mgmt_pending_valid(hdev, cmd, false) returns true even though cmd is
already freed.

This function could leave locking to caller and have
lockdep_assert_held(&hdev->mgmt_pending_lock).=C2=A0

Or maybe always remove=3Dtrue, and caller has to add it back to the list
if needed.

> +		}
> +	}
> +
> +	mutex_unlock(&hdev->mgmt_pending_lock);
> +	return false;
> +}
> +
>  void mgmt_mesh_foreach(struct hci_dev *hdev,
>  		       void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
>  		       void *data, struct sock *sk)
> diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
> index 024e51dd6937..5aeba4c7b07f 100644
> --- a/net/bluetooth/mgmt_util.h
> +++ b/net/bluetooth/mgmt_util.h
> @@ -65,6 +65,8 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock *=
sk, u16 opcode,
>  					  void *data, u16 len);
>  void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
>  void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
> +bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *c=
md,
> +			bool remove);
>  void mgmt_mesh_foreach(struct hci_dev *hdev,
>  		       void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
>  		       void *data, struct sock *sk);

--=20
Pauli Virtanen
