Received: from sonic313-14.consmr.mail.bf2.yahoo.com (sonic313-14.consmr.mail.bf2.yahoo.com [74.6.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AEC199230
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738094144; cv=none; b=REqsje3xdn3WTj6RbbqrQytIzl1WemuThBIMJRzJ9rLZvjtIJ07uVNZ8GZ5sfyVKsJfXek2cJftb+F1jo2CXZHgtWxvNU6tcTg4WnyUT4ZoARTzVMvdorJcfy+v2pzwkR2/CaTjMRu7142Tu5ybWah+tJTLwhUqsm8/RaGHPwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738094144; c=relaxed/simple;
	bh=0nD0hZPfs4ANXkHbvbZiMkW/D/Tt9merdXqs61TczNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2MpaMveiIvKNWzf5rB9AwxROygaSPjDcfym4D4xH+QYDVv9Ea++/QYxv1gesRFq3eFRMAXF9KOc8A2sv+OnIeI1SRkb3ZxhLHEdSH2CbN0Qnr0+3xhBzbo+MJSo8urUu5JorJUTielKYUj9xMtxM5BJ8bv0g4ywC3tUiRQFxUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=q9HgtxSd; arc=none smtp.client-ip=74.6.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="q9HgtxSd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738094136; bh=0nD0hZPfs4ANXkHbvbZiMkW/D/Tt9merdXqs61TczNE=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=q9HgtxSd2wL2NPLICd0YSk4D/XcuM1MaIVP+PaUC75gTyLksYYBGRwputePeoKlnJ2lpyEt0YExj7wfKzBTfBISxL+NHasIWuXrXzgcmXxh5DkdBQNAyIw+h2D59/sNJMJ6ZAaunH+twVT9k8tjYQWY3F049x3pDoR33M0KGPGwEwaZ5U7lovOY2sQHOkuRmWSVcOdbkgSIqi9APA7OeUBTZSDc0D2ljuEofllJaaqx7nzw/5r7OP3Ha16h48GzftFPbt5Ncd2egqvNpL6cfVsoac+j7+pGtQj2mAazroFvRfbvaQo9vdEAxVI8BQY3Eokk8uLMY+JoQ+wBkBPKJJw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738094136; bh=0ISaQw3OqRVPNrdx0iSoUcv9zOtZ+XR54DoekWoWN6u=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=hcxT8WPxQrQoP8DnAbyhVMgFSaIX+Dj7x3/kiwKLLlnV9PxOgFqFGgm0BkrDZv6aCEO7lVT9BLRAdKgawYRjt+bUKQ9ToJbP+iiuUu6+L77T9efhhALq6EbwxZWkQkIF/Auq2VPAuD7bU8u/nGyOb0rF6+fIPdPBzPB7nJeqFljPXoFbpiJTD3fK5KgHhBMj6mjhbsrxMhVUhd3p2lt1FoK69pu9gIdahfV0GuNaDx4baW3LZQfYSELNUm5bSvLGp+BfRBE22DJfv2cuzIHqRwOLRjeXQxoxw0Q6nJxEQaOQ962yTBGdukTBdWzhEp7VGWVv+bl9EibiE4T4Re/nwA==
X-YMail-OSG: n.cO0owVM1mtKaDDYGAR8xLztFdHSL9nZcuhaO4wcDo1YyLldQ_O.MYDtA3II8.
 tQPWGnNFOcj8k0bw1kDq9ecIBFJDllFafGqD41Wm08aY.gZ8WfXQT_hdEtVOxpduIsqyPt.NbcQU
 osNATPwbL0LS232b4FyP5Am_oicVHgG7LH9X9ZGem1_NJv4NiDcpxaGySEbFoMh6kWogi_FCkSOf
 3BSkJ6ZPgFDRD8gV9HcFmYKJODeHmFu_xb512iV82Dzn84MoMurPkw3juurdxd7EbWasJTW8DlUs
 D93rSp4kdkw33RPsw6EFeR6HqBkTsSvyFwkM9GTu_RJB27ODw8EPEBdm1PUuk8xtQL_el8vOKobK
 9E0TzKa4UfnqDOCX20T.W3o4oChBIH9ucSGqmBOlvmSN6VScwhSnrsa4gaEujlb7hKysfEzcsjTS
 z33K6ViaCz0jhlalpDKlLqjDwMRKy7MhnHdBpoIsEABXXgO8w.4P.kG90bY4fE2ITU_7GV93QebJ
 YexMa4Ood.8tAzilVTvGnWh5Ad9JrwMcYR24LTTXZkUjyZo6_kLRwQ30a3uXeBFFxPAsfchdmGdd
 TbkAGqrhlgQVUOV3vM5tO.UxQRjmYKA0UsZ74BncqX6zNGUUkYqGZUP1Q.A24TCL3Qm23bG85KCK
 GpPBZBfOAj4ljcenp6vNevDMi5miqlzDnbE_co.HOHRCu7reYt.ixoptUf93Q9EdIGXGueaKxdLx
 .EJ7G6n2gz8L1JBK9f_xmh5ih7xlmTvZ9Qe.XIQElcaaB3KJXChjJEDkbHPyatkhrU4xkjCF6Jci
 PsWegYKV1TqRoX1r79QdUfDUaWSxNtjzTS1HK1XTPifoHo_jbF7L.ZQLG4oVNGdQv2Wn_2XcjREV
 WAV1N0ypaFn0mHXPlqX72vFD9nybYg9YRjX1HJ61ZO8M16NLb.RJXmvQl0zB_tZJWCgcAQcNzP_T
 KtviubRQy9tqY6qJOBGJLnAfL4KS3n6EbR3DEKs6vWepmfqg6RWRSm1i11wel5k_Q7BaG95M_ELp
 AYulDx8_VWsFOj0reZi4MlIR6G215Ix1cXBTQGMp8CH6_UwgAbL_Na_pX5izh.vf6Vzrj37N2itF
 tROWfIuAgEV7bwZUfvHX3NfPrWPcbQziyuoRO92IJC89oV02a_H2qZE3zV5aghUdF6ZdMIQTRQ5a
 tJwT4p36AIUK1eh5oXSSgAHNBqCJ42BgKyqWbMZ7fj1zmMqjEYuFCq5a6.2eZ1KN9qEImdtqPNSx
 1ReU0eqb0coBPkvnbcvUMl6qM6KwD8SN2dqWuyRUHJCMQN0LYufyRmCjkCvENXyv.B_.oekg9hYX
 eeKQeGNqez_3LFvqRneq5HG1ecZu3wRRfOa3XxxDZ_LZKAMqbwBnwi4E8ejI7D98J9lkDaGyVx3r
 EhUOcQu9nKJ6kGEop6IbdLupR4Uje9lVTlj.v2L_cPvh81MZB5jeDsyTDMG0M0F7EGO.EXqy8oFi
 VQ_81rRkOzY9jYhrqCKZQrVLSr11a97zNSzahOCm6UpYJoKGY6pJMDvCCjat9Znyz8gz4JW57Tvg
 cPgtHwvBZCDPs.4WFQhOHajGnl06H53UWYHbEcU2bLuJjf6mwEZGfomrZe_TeB3HJAONA6DQkWhn
 Q.iXlnfBrXX1p5.TlwJ8wGruy6N4D6losQnoq4zaf1FQtJvzULza_WEm8h2K7iRSFMLsQ3Vvwiyo
 VWfaLQMJ6g4ntesAq32vAJXLn_ySgoboB1kPdCl0oAO3ovfFLCwt.q6Y1Kq89rlIzljneYSwyhgW
 8wfof02nuxgqGddJdLP0zMyMYRPOnTQLlEe3OxbNp7fY8EA5GD34_D1Adlyu3QS3sxrTU5DA146b
 ZaYc89M8K_Z6Enf.2zEXWq_04NUlXetgT3uOw7h74Pth2HF52uMrLtMVKWn4kb5lMPTQwg6jmRzn
 FOpJfzuITJvXX9_bnJ579lsgCmzIm09uSW.ddhbmpbWFw.9uqbRj48gGr.nQpJxY4t5fXjOJ.QKw
 x8Sr2TJdBSUSmbHbyhFX01j6_1ijdYm02nVERf5TBHz.uLX_GyYM9MhAx3ShZYsJ77ztFqy9DXr9
 a6uE053yqsznFVyxytv0X9_0sRfMJt5jnxMj3heNakrR7uCxRKeUuDof3TnN3X1r7TZ_jiXfad1o
 yKI39zlwTS7LxgdXMp8oJpWP2kWlUg7B3ke.nEd9qqac_VsmvM1Rl7xF7TJETb9eBXgnPJ.7EdvI
 dFrydCBs1wh1CduUXmUBP5Ym13JJJIoBfV.Av2LQqnbfbHonYK_vVsVH1Pw--
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: c3a475f7-310d-4f72-92fa-12eba9283003
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 Jan 2025 19:55:36 +0000
Received: by hermes--production-ir2-c694d79d9-2zgj2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c6dce5988e99f745a2e43a5498fa3cda;
          Tue, 28 Jan 2025 19:45:27 +0000 (UTC)
Date: Tue, 28 Jan 2025 20:45:24 +0100
From: Jeremy Dean <deaner92@yahoo.com>
To: linux-bluetooth@vger.kernel.org
Cc: markus.elfring@web.de, patchwork-bot@kernel.org
Subject: Re: Bluetooth: Remove unnecessary braces around single line statement
Message-ID: <Z5kz1KdeG8UUCZjN@vmi2410184.contaboserver.net>
References: <20250127221052.197899-2-deaner92@yahoo.com>
 <6798092a.170a0220.f56db.7782@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6798092a.170a0220.f56db.7782@mx.google.com>
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Mon, Jan 27, 2025 at 02:31:06PM -0800, bluez.test.bot@gmail.com wrote:

CCing Markus Elfring, your esmpt server kicked back the message.

Jeremy

