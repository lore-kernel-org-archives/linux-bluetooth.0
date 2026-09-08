Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F994B4896;
	Tue,  8 Sep 2026 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900095; cv=none; b=o3zwTBQUmJ9cyOX+L7cFSitGmUOVuxXHGYtRSb2+T9BtYr7dsr56CdV6Rhr0uJ7SxpMfxrA5mnLmy1loJoFgAuqjVERHCOfGh+OEtWHHwrbhWId9DrclQL90vMwxyTSxlJ0WOdztz8JsFUK4kPWTEOCZfsxeCSNacneosJMuF/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900095; c=relaxed/simple;
	bh=4OHkdEQV28o6pnXRX6FdqeR6gcoFN+9ehn1p6uGLvo0=;
	h=From:Date:Message-ID:MIME-Version:Content-Type:To:Cc:Subject:
	 In-Reply-To:References; b=JfzzAQsLHYVRUYBhgXf5IrriQm5+3qObKiN6320neL8O/VQWSzFhGKSCuv0VPwl+Rbu000KT+WIMzKYFxAOvmlcRfIjIhs3eOR192iDCqltDlk0k4MG+78ZqMhU8B3tuh9RRZWGySzQlXfHWtmDBdp0w3Kj/KjaT/T8Mn3GJ0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=eIRQxUcx; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="eIRQxUcx"
Received: from email.seznam.cz
	by smtpc-mxb-7db765f675-9qx89
	(smtpc-mxb-7db765f675-9qx89 [2a02:598:128:8a00::1000:909])
	id 75b6e557c38c484e7039ff1f;
	Tue, 08 Sep 2026 22:41:19 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1788900079;
	bh=FvohqEqpRbk/3xtts6Z1WbO7rYe/NKtUylnLrQskce8=;
	h=From:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Subject;
	b=eIRQxUcxQo46HOrJBzxEfQJidYBpTldYYX5/Ixfl1A5TJHbgVdi6r1x3noopjjyn2
	 TyDwxTgTxMinBoJmCq1wYo8NJOqH6PUW36mI7T5obwWTq8bxh5l3iRTPygaICHT+Z7
	 GwWp8Nhq2Mcq563DaoKrn+9/C+0uWqVc1+4WW1L8lL4uios0uWTzqqYIG/12rNamdo
	 e3dDJG0mO+kDvULkdkbFKdVScds5t8ShIfM9DlyTnNewH+pvhMUd847kqXrRH4nDCj
	 hZ4G/DF9iwNoZ+Mdwx4ND1ZKcF/7GX3Z3uJzZsAB/AuJOz81OucQ5LimI3NRfcgyZn
	 417tKer8IEvZQ==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-6ffbffc97b-d7f5l (szn-email-smtpd/2.0.82) with ESMTPA
	id 4890f59a-5364-404a-b92a-817db19a330d;
	Tue, 08 Sep 2026 22:40:33 +0200
From: Radek Podgorny <radek@podgorny.cz>
Date: Tue, 08 Sep 2026 22:40:31 +0200
Message-ID: <178890003160.100543.8134592214245196581@podgorny.cz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
    Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
    linux-bluetooth@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: put the peer's on-air address on air when we cannot resolve
In-Reply-To: <CABBYNZ+nWb0m=qMvxADM2HvuLhopxG7L+io2JTmGXQM51YOYhA@mail.gmail.com>
References: <20260908012048.3681904-2-radek@podgorny.cz> <20260908012048.3681904-4-radek@podgorny.cz> <CABBYNZ+nWb0m=qMvxADM2HvuLhopxG7L+io2JTmGXQM51YOYhA@mail.gmail.com>

Hi Luiz,

On Tue, Sep 8, 2026 at 4:00 PM Luiz Augusto von Dentz wrote:

> Ok, the problem is then that we are trying to an indentity address to
> connect when LL Privacy is not supported, so we probably can just
> revert to use the private address at hci_conn_add in LL Pirvacy is not
> supported or we didn't program the address in the resolving list.

Agreed, that is the better place. v2 does exactly that: __hci_conn_add()
keeps the RPA that hci_connect_le() swapped in unless
HCI_LL_RPA_RESOLUTION is set and the peer's identity is actually in
le_resolv_list. All of the hci_sync.c changes are gone;
le_conn_complete_evt() already resolves conn->dst back to the identity
once the link is up, so the round trip comes for free.

One cost worth naming: with the RPA in conn->dst from creation,
hci_conn_params_lookup() in hci_le_create_conn_sync() misses the
identity-keyed conn params and the connection falls back to the default
intervals. That is the pre-14b06c3a88f7 behaviour, so nothing regresses
relative to the code this fixes; if it matters it can be done on top by
resolving through hci_get_irk() the way hci_connect_le_scan_cleanup()
already does.

> Not really following why this is needed though, we always scan before
> connecting, so perhaps we need to update the rpa whenever we resolve
> at process_adv_report:
>
> /* Check if we need to convert to identity address */
> irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
> if (irk) {
> bdaddr = &irk->bdaddr;
> bdaddr_type = irk->addr_type;
> }
>
> So we do translate the advertisements to back to the identity address,
> but we don't update the irk->rpa, which is probably what shall be used
> in case the controller cannot resolve.

irk->rpa is already kept current on that path, one call deeper than the
snippet: hci_get_irk() routes any RPA to hci_find_irk_by_rpa(), whose
second loop does

	if (smp_irk_matches(hdev, irk->val, rpa)) {
		bacpy(&irk->rpa, rpa);

so every advertising report the host resolves refreshes the cached RPA,
including across a rotation. That is what the old swap in
hci_connect_le() fed on, and it still runs today.

Which also answers the timestamp question. Since every
scan-then-connect path refreshes irk->rpa from the report that triggered
the connect, the freshness check only matters for a peer that
distributed an IRK, used RPAs, and later went back to advertising its
identity address - the cached RPA then stays stale forever and keeps
being dialled. That corner predates 14b06c3a88f7 and has shipped that
way for years, so I have dropped the rpa_jiffies patch entirely; it can
come back as a separate change if that corner is ever worth closing.

v2 follows as a single patch.

Radek
