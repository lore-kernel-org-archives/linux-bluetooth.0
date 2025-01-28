Received: from sonic308-3.consmr.mail.bf2.yahoo.com (sonic308-3.consmr.mail.bf2.yahoo.com [74.6.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288616088F
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738045826; cv=none; b=XzkbpuUC4BRje4zw9Nvf8DdUiEZXAOgKGiLkhWR/JmwVGwZDvOZgOKH29mVn3riww/KIKu95xjOSCBO4m/5mms3GB04KMfuqWHKk2hZZxtXUAJ8EaM78PQSQaa0vxkEKk8nFIzIQM38E+crSYu/FKdtVIw7bbo3prVYPydcDjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738045826; c=relaxed/simple;
	bh=lDRdPqM9jyEkT3VLFfRsM04hvSLnWjkhL059gtX97BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7+mc/PWWQOoSQqd2gkbjXQi7Cgg4BIt/Q3pjMNXKws2QslXMHBezGkCiQ0Y8t5GaWrU/KXSf07amp+9b77/ztiZslPN41sis66Gc2YFZnX6VUGUXvHYr2R6CnFBx1vQ95mdN2lAMcD3dDRhD4KllhtzHQ6/T/YS7BKw8UwXkBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=GYjZPSom; arc=none smtp.client-ip=74.6.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GYjZPSom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738045824; bh=GIBvtRw/7lAUAg353RFiD/uYksZXlgQ8Twc+JjMDlcQ=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=GYjZPSomLD0DI+szjRgDwpnrke5kz8jDwBD5fX5MZ/RtWN6jZJEQt3VqPAMCXm2kRyLL6h/biwP5SHSg7tpZL0HMMJeUk7HirmwD851EZJf7TmsXAEpzk/uHrPPzguq4Fx/+zNZB/0VuKbYfM5C2K+7fNuZVoaJudIiY02Ra5wQsYTWG9dTpcoxxEG9ZZqN4673u2IDh3rOH4dgV3M0D0HulMrSGuxt07p6dztcNaRW9RpYYz2p9/j6toE7WX00Wj8OdKQjBsxYDu/Zf1c1QoBg++ZLnaNYehNbHhLp0oCDfDiDRDz3uSVhqbRpas28s7oA6yGLA3BYoodWmQQCRhw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738045824; bh=oGKQEZ5SKk8ZybYUBxH8iozA1czSxH6FFkzjyUvVAXn=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=KiMqhNjDgmmwJbd6v2+mt0RQl8ANwonDGr6xURvtYI0DCNj8L7ImXo8JoBQCPAHA6l1V8g/JEqc8UJ9P7Kio6+ZkNANlm8s8DOGIVRMuuiLGKj3vdtj1SvKs9o0DDvdFY9Wf9n+1/FZAgLBCNkGT9b4eB/IqnSeqiLUYfFniFxTMJA3eVXrR7Tv1DmfDnQDO3Xa6sGT3UjsRuOIqdfKutJcY0Qh+tK8TV0RV7fWt0fiFibydHeueZDrnc2Mkemwckv1zmYmIGJmLvwNDN7kRofCgktbRHlpcwkUxpw+WE1MHWuLJOWq0akjLqhdxcSkY5vgL3QYqNJnyaeaDkcdd8g==
X-YMail-OSG: glV15Y0VM1lbp0wGNQXle5bOrzskFLZuq16_dVU3vyysfdPFV5gUGI7GBMTvO2a
 fdE.oAYqaLlcfMa0LPqAxBvNBEMN04lhh8zgt373cvY0FZ5HGeXprP4QkSoQNFogzvrg9krguDCM
 9ezNNo6OuMCBbYIkW08Fjb9.gHTApr18wBlvSIZSJefH4OFg9QFPKt1_1SSGa0oyTg9Mio9WsK2V
 R8rZb6FJy71uZMDt8fMKfaI_JcU6OutoTU9bYypSplUeQbXv3l4SHrbVTnYHWZUSUDzobmay5xUA
 8uSwjfDYJKexqVgywx14EEoHR4Z3.DiJdT9212U98kFhRX0sX557k_g7eHZf33LfxS5_n_6FDxU9
 RRjy43TjdTOBI1tpvznIHFHNCkzwS9e5fknXlxorZCKo15Fn3nUce76heFRD0Xlh1UwXGKal4KXg
 axX15TWjLd3qzVlo4BnbnJ8X_.f9LOs9r2hrxAOZxqZF73ErcCuDNf4N01H2mmKJdkurtj.YXxw7
 qiuSBhtWzAKfCQRqP0QVuOllZ4cXJWCW.deQ7HxBNLtsg9prKc67eTp61ljxC4tpEiHz4bFnAmWS
 qYhFBZKgOb3zweXUNXi2Qkv0mwBjngn9IvvCmPmKM9VxFuW.HgAEBZNx9F3a0WwzlNfd5Z2jGpp7
 MhnTlF2kRwb2HbMp5OeJIY6DlBFMfaf7qgcDAX8oqmdPfQhTFHtEIXhJZthKbESzh1FO1.KbxoI5
 MCSjkqYwWUwfqsMzejk2el6gxXbljX4BIU3qRIBJemsvJIDwLldBxzfJLz91kn2UQaKu8NiZc87b
 nP9N2G.ro8ePXxE2CnWlKyIaPwQBmRJ4PAe.4W65F7cxhOFiB9cbZZ1_ArR9AVUJtoax3nhTAz4p
 2V4iahQOS.TahkegSkXXlx7DsNVpNFWndcZ.5Tktl2xJfR2ebivEPUeAphX56K1aNNR1S2qm972o
 nfMVKLAuMAn_EnylK4VGuIX2SXzbwrq4rd7o3h7tx7Tsa6Q9juG_2Af1nhNx0rX6NzJMllz2Uu6X
 BzT4qh0sru8dQYjOC8MQT5pD2kKfyXj574wbsEXQAK53CaU.Kg3i9Ar.n3g6GHgdh0.yNxZ4jUJP
 DTdXC5LrPMwnXXS7wKhqXEZ7vSl.vvAal3rYgmoUSUkLsIwe_Oqg6xYkJ02boFIcpJnPhp7g.GOH
 jD5nGcJc2ThPaRwRFIVjt8_k5ugQ.uoqn8EW3ax.0jnQYCjdqtWXwZ4fh0wY47rLwOZBexd57LI1
 ABUpJkLkSI_my2zYZOKevMG8fLRjhGLIBfS7_yfJthwD0giBp9wLP4vWIOslTIff64w1NLwRxSdv
 F2MXJniuOreN7o2m_.._WjtWGjilFSWMcInzCOto5.pTeaY0x9N7AdwxjIv0aXk5E_mNCCkpYGsC
 0Tq9LHJjjM_l5iEM4i6YPpkE2ILrSunFgLIc7CcRrY56bOdI2t32.o5RqK0_s6j9qO0KPSwjHxHm
 g2s2vT1Ey_ZX.uT6vPHWG0_pv3Ov9xI3oa5PyyZHK3jefT2urhd_saE_TTJ.JWgLdIjrclbyoTXL
 a.zDROrq.mrhS2iXLp3nWXL7M0Gbqd63VzwbXm4Qtp6L9N53rlxbamJaherV8UnY5UbF3NUhbjPW
 74EKjGUDuP7LJFH1X4YIsG8UOUVQmmK12ltEijXzloMa8m2TV2NHKXuSHFizoJU6l8J9kjiSizBP
 ug3UpfUdtnBx3g7HsYQpXjOxA2829iFCbZv1BFDFLiMVIUMjOEJ92C8j7NaofcXFkdiqz4jq50JI
 zDv8ocXtQpPPHo0foy1nHOchaMfPnqanXLzU0wlxSRcFM0SCypzNPv0YiZ1zQDa3zaP41Y54oBTm
 KQZQRdtu9jpUPUAT5d7nvW9luEFiEnOA_C88TqXd.QA1EEeDwpdEhBui1iL0IJxvzYK4XL4gn4i2
 tKn5NREmjcbA8HpMmHzXDe2AI_tioVFHfT37SgcMBuqk4EXTuDmKADMwPKYea0DhqIu8nOzkaCQy
 ZyGoPviBQfwi_mKQ5kvlSO_UocvcTsgVf1VBUriE2NUU60gFQ6lKMZ2Z6CXCs9ZERjEZtT46bUcP
 4DUlLI9crY.RU7ePv7r5e5Tf947BFLw4jlLGbsjpzVNfiB28eAXjvqlqzoiOxMEStB31MKM9Goon
 mA3LXPjp8Y_LhUjKAlWsZF_shfHdXc3UO3j9PKsbDpfZV5leV1XpLMm_6W8LV7xVHeWSdrvUnopC
 MmRSxS1MjZ7ij9UgiUaKiaiqhuLMdblqErxldBPrFid1cPYWdYHPaqec-
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 98e63f6c-0d99-43d8-ab5f-e1da6f23b045
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 Jan 2025 06:30:24 +0000
Received: by hermes--production-ir2-c694d79d9-jv96w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3afdec99d8b93eab151f4b080b1daff1;
          Tue, 28 Jan 2025 06:30:22 +0000 (UTC)
Date: Tue, 28 Jan 2025 07:30:07 +0100
From: Jeremy Dean <deaner92@yahoo.com>
To: linux-bluetooth@vger.kernel.org
Cc: markus.elfring@web.de, marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: Remove unnecessary braces around single line
 statement
Message-ID: <Z5h5b-YkINKqd01l@vmi2410184.contaboserver.net>
References: <20250127221052.197899-2-deaner92.ref@yahoo.com>
 <20250127221052.197899-2-deaner92@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127221052.197899-2-deaner92@yahoo.com>
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

It looks like this is failing a test case at
tedd_an/TestRunner_mgmt-tester.

Is this test failing because of the test itself?
How can test or description of the test be obtained so that 
the necessary modifications can be made?

Jeremy
