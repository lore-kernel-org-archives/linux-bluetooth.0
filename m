Received: from mail-200173.simplelogin.co (mail-200173.simplelogin.co [176.119.200.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B293DFC92
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972172; cv=pass; b=sgktpP2GvIiP/zOPyHjRj6MOs7PMyY904z0nY/LDo5bE7/7abbhkYfwtaCeFZByMKL5/HxQcJ2VJPKYdkm7qwtbVzZqnnpdKFjbXSmHt3o9+oVVNHmFUFJ3Uie7LjvJYsA1gXijUQO9K5WuZ137HWdD6oPCFdoNKsakdLLJsLCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972172; c=relaxed/simple;
	bh=DDbnyMUgcPWBKr202T9QLEXSXY/0pnL2T996ZFfK1ZU=;
	h=Date:Subject:In-Reply-To:MIME-Version:Content-Type:From:To:Cc:
	 Message-ID:References; b=lr/x7sIHbLMQIoSZJghmjLj9Dre7eCp1SZG19DRao25LoypqJEoq6j1y5ZJCQnCjqYUpD3L8wm1wLd0fnSWq6HdMxXQXD13WdmzYr+Tulih4eWdw8esuWpWGexaKlqZLDeuef1OmmM1tMnGKVgBX6R4Me5lvAvuK8D5SSxRukz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kaiser.moe; spf=pass smtp.mailfrom=kaiser.moe; dkim=pass (1024-bit key) header.d=kaiser.moe header.i=@kaiser.moe header.b=OCX32WCL; arc=pass smtp.client-ip=176.119.200.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kaiser.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaiser.moe header.i=@kaiser.moe header.b="OCX32WCL"
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1786972163;
	cv=none; b=s+odKJ/GaeHvE6kiQNAHF7SXZpnbih3VEpVQYlDhtsfUjgGJvFZaVoUbsS3Wp5uhd04jaBQgJlLSUHtFZ6JiJWrw4qGlSy0CGZMYh4Tj8uUhEg74hskf8S2ennPPNzwGwNVJTY8TbbVWIpTAZJ/IezCfCWRFfe4VE9tJpPegfxTtPWb+fSd2s5r0uVSkSIccvfnNaJty7GHyCWFeNkeEJUN9kZlrCExw/tu2VwARssxPAtDh1fOkladTxSAzkHChqS0KRsuAsmMXGaHGhcMWzV4xIwNVgZ6dSRG0ZJeiSnYNIGv8KtbWDv4Zh3yi/mEhnGVXJK4j4n9oiBenn1dCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1786972163; c=relaxed/simple;
	bh=DDbnyMUgcPWBKr202T9QLEXSXY/0pnL2T996ZFfK1ZU=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=kdRMnvq1irGNcqqAtwKj6AUbyE6oYV70HG/+EaccBjYeBledfC7nj81CLA+uqdAhCDlJIR4DeIMJvv2ktASXtQA4DX9+hQ/X/BF3/snirJW/I9WlGFDXs+XkI78hnkEyGJJHn9wPT/uddiW9Aml6mSHi27pQgSI0CeVlr4xn79mJuXJjN/QsagNYaosJ6AR6H/2qiXUfm4bylAQj87ZEIA0Sp9hURv4f7oFX6PS11RALum2bBhu1qR8uULSiudT1Jf2z3Y4b11+vpLQcg3aPlqzKYBXvWWgDaq0P9hP69aVDu4KHENg2bEryzB8lJ7134/k8FJfbc4nltpEP4I+VsQ==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaiser.moe; s=dkim;
	t=1786972163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qQN/F4//n7xZ4MdZ3eZXzKIdfjCsnb/7wxmgx9Md1A=;
	b=OCX32WCLqfgaC5CKm0DUy7DKDSDgHi1R8FQovYWc18NCfjRGSet48q6RdBUwIoda5IMT+3
	VCrhC+5qDGQynZGbbhZudPGlStblvrHr11gb8nt6807OWT/Vhy7wnaFpMcGnvx2G0j8aef
	LHBThOrxYHwSFFMvyrnJaB03V6HBpTQ=
Date: Mon, 17 Aug 2026 13:09:16 +0000
Subject: Re: MT7902 Bluetooth (0489:e156) not supported - btusb/btmtk
In-Reply-To: <520e859a-57c6-4ae1-b1d8-a9f6eaf51c36@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Kaiser Bh <kernel@kaiser.moe>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,linux-bluetooth@vger.kernel.org
Message-ID: <178697216269.7.17668187426720180988.1555039931@kaiser.moe>
References: <178695324809.6.15793290053564777912.1554499092@kaiser.moe>
 <520e859a-57c6-4ae1-b1d8-a9f6eaf51c36@molgen.mpg.de>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1555039934
X-SimpleLogin-Want-Signing: yes

Hi Paul,

Thanks for the reply. I went to prepare the patches and found both changes
are already in bluetooth-next:

  btusb.c: { USB_DEVICE(0x0489, 0xe156), ... BTUSB_MEDIATEK ... }
  btmtk.c: case 0x7902:

So there's nothing to submit =E2=80=94 apologies for the noise. My running =
kernel
(7.1.8) predates them, which is why I hit the issue.


Kind Regards,
Kaiser Bh

On Monday, 17 August 2026 at 18:27, Paul Menzel - pmenzel at molgen.mpg.de =
<pmenzel_at_molgen_mpg_de_jgzeoazf@simplelogin.co> wrote:

> Dear Kaiser,
>=20
>=20
> Am 17.08.26 um 09:54 schrieb Kaiser Bh:
> > Reporting this rather than submitting a patch. Happy for a maintainer t=
o
> > pick these up.
>=20
> [=E2=80=A6]
>=20
> Thank you for the report. It would be great if you could submit two
> patches for these.
>=20
>=20
> Kind regards,
>=20
> Paul
>=20
> 

