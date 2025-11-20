Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A11E0DCB
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599409; cv=none; b=QJoIRUXVZxouZUvw1g7KawKED1KazNgsSIGJRkt0T6QKBRYeVyyujr206dSEJOqKXx4U5z2zhLNGDzZWYR3iO/mNhrdVUWTO83bYmPprDvqKPuWmKLu25B7DLCEs6ZadW838xKZoSR0k7uWRns5xRA2jJdMX8yhwfOC/jnY50UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599409; c=relaxed/simple;
	bh=41NiR58rA8Uo3kPAcNb2YCpkD+F41Pko/JHZbu2VJOw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNvTmlKL0ib6HmrU4Oa4IecoUtKPUIYvEdt84Qqs5wIJtLWKTcAxBC8th+TOUXJfeexqOr1BIHvpBPgXaIbE+78HhUGQsJmzddZnzosQ0b8yO06Y/RzTWNOqLIRrRsWWfA8Tyu3vrDZMJtaHmhZp5DYgvPnvPIKRRXsRFJFeL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cr0nooMC; arc=none smtp.client-ip=109.224.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cr0nooMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=gyf523wcoba57jigfp6lzgm2ry.protonmail; t=1763599399; x=1763858599;
	bh=41NiR58rA8Uo3kPAcNb2YCpkD+F41Pko/JHZbu2VJOw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cr0nooMCAoN0YrN2yksRfbB5mtWBIMzhYUnRAK8RR0qEQbE4rwksLy5/JArny70Jd
	 u6BSHT8MAHtED3s8VGQDMXbSlNF2A5v4cfbhCEpbJbionE+o2lecUiVPTRXob/qw1V
	 tPkesN16WLjO60GAiw0A6hlZACz0ayLYra91av/oPIJdwBlseN2n1bAJAa+joYYawL
	 4NFshBUHYjhhhGmfKXZ/Q/yyQXZ4NtO3D1L9TNxEZybR9xnZ8Nw4sN8TRbPdJ1Tfmk
	 quvwLn3uWsAUIF7uiHQmLOZlGzrtY8uqzLUEFkQ/XYl9mX9DCExc4PUrXuNOYkdtjk
	 jivkQ5Bg5LjtA==
Date: Thu, 20 Nov 2025 00:43:15 +0000
To: Doug Anderson <dianders@chromium.org>
From: incogcyberpunk@proton.me
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized since v6.13.2
Message-ID: <5rFwJreAVujrYXDGZZxW32PHa6HZ29PEP4R5-dqS9dbU3FI__qe3zIUx31TIHO_LjuURCSwaGucSFBPeXAjf00XzAxTzXbmf1AaY6neyQ3Q=@proton.me>
In-Reply-To: <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com>
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me> <1b59d3c2-1ed0-40df-a3ba-cca2316e866b@leemhuis.info> <a03739b9-3a54-4ecb-b55f-6aaa69da3fc6@leemhuis.info> <a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info> <CAD=FV=Xt58+WGK_j_TvTxpUfXrm-=Cec1-oodkuf5xiDGrsKuA@mail.gmail.com> <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me> <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com>
Feedback-ID: 139104781:user:proton
X-Pm-Message-ID: 38271f5c241bc87bae3a227b4fdccc0cc867a055
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yes, manually updating `drivers/btusb/btusb.c` , with the below proposed pa=
tch fixes the regression issue.
The proposed patch solves the regression of `bluetooth adapter provided by =
btusb not being recognized in both the stable and the mainline kernel since=
 6.13.2`

The proposed patch:=20
`
index a722446ec73d..1466e0f1865d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2714,6 +2714,11 @@ static void btusb_mtk_claim_iso_intf(struct btusb_da=
ta *data)
 =09struct btmtk_data *btmtk_data =3D hci_get_priv(data->hdev);
 =09int err;
=20
+=09if (!btmtk_data->isopkt_intf) {
+=09=09bt_dev_err(data->hdev, "Can't claim NULL iso interface");
+=09=09return;
+=09}
+
 =09/*
 =09 * The function usb_driver_claim_interface() is documented to need
 =09 * locks held if it's not called from a probe routine. The code here
`

I applied the patch as suggested, but now what do I have to do to get this =
fixed upstream and fixed in the next mainline & stable releases.

Also, could you brief a bit, on how this proposed patch containing , a NULL=
 check for the `btmtk_data->isopkt_intf`; solves the problems introduced by=
 the problematic commit with: [ Upstream commit e9087e828827e5a5c85e124ce77=
503f2b81c3491 ]


Regards,
IncogCyberpunk
