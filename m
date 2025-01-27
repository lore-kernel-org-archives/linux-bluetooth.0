Received: from sonic308-2.consmr.mail.bf2.yahoo.com (sonic308-2.consmr.mail.bf2.yahoo.com [74.6.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A41B4F0C
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015978; cv=none; b=RUmGiIajVQ44uDgkI2Xv0PGst8JPGU7CJmc6MgrD43O4Ow8dJkfEwNyPOjRo6ZQ55hhtZ50h3rf0jdsbXhvAdG5O5pQJ4VrENZokH6OEo1GdYnZ5UGD1Y0SnfU+Gxi1YBt4WYbJoZV8sRg48kCk84TgbO8hWpCIi5BP0MsdJSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015978; c=relaxed/simple;
	bh=9DX6gHNh1jUxz43LTsiTJ2dcvuCXJphH0wO8tPfQZUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiFtb8Cc/efriW1+t2YrVSTNQb58L2j03LWpj4j2Cp+kVOi/jtJxITsSeCve05XakRaohS173UcLOOKQdGrVkX4Lp07ewjFwDpzFjk4K77qeIhCp7nQo7R5PWGpcFtG/dOYDbtLP34yqXg+3n9GJx9vIyorVUiyj0z8/E221AxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=t8fQFgKR; arc=none smtp.client-ip=74.6.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t8fQFgKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738015975; bh=9DX6gHNh1jUxz43LTsiTJ2dcvuCXJphH0wO8tPfQZUs=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=t8fQFgKRzLhSBFncGco+2cYTsTK/MwWKC9UO0VSMOL43dVqpT23qmY15aBw+oO72U/boWklXVRKOtivckq/qsjd5lfgXaL79lUJZOOBJLdxA8nfeAsaefE54hQo9cQxq9tdLVuBRorHuSoi3p0FPtfBkhxHGwqSC44CKLHwLW+p2066TSjArGeYjnLSvjjmYoX3MKIoLT0avsFeI+BnpwURxa6vlvdQa/TVN6NzSMEC8LXd3H4zRDsUzQRS4Ksqt58+mdsUtV8kTAZWKJRo2aA6OgVbzMQLrocQoWL86fKs1htr6gTbGp1nm3ykGdJlnlWllZjFihdV+DKcqzV6pmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738015975; bh=hKKz0PMF/c6OupbBVxpTcuLzS3X5U2FPOZMZxuXzg6i=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=NhGTG//aF6vbmVdIxtCGH4jFiUelSCmLsZuFIc0+QsB4yV2dfAVEjq6SG39L8PLT+XsDWTpdgasYwMK1J1Tf9EUWDFyyzeF0jFqd22RY2pv/PXH2syNyQoji0fobqlpPiSyQr/MzE+QCPwrgqoBRv++zBhnNJoE+huflfOFYW9xPffVgEMsBcjMVkDtHdUfhX6kbUsaB1LFzxn1mJt0aoFOmsoS4QJtoeofNA5cYzsaImgdUCYxYoadSfnKZPD3hsFoYMCNDkdRvZsKozhFwqven7Bf0uwsOtOqun9o5a/y4/klygGJtw75OaM++MKcG8OdAqJl0wG6wYb/yfBiE5w==
X-YMail-OSG: y5OgX.UVM1nDFG_z8_cAV.8O__tGE5Wns3CP91GWa83BxD4Fjv20VTbO1_I3fPr
 tkf4XppDvMBicPQH2Q8MJHXf8UuM_pOXyN6j40keh6FgXAkjG4l8IyU_E7GZ.fR19GmAhMuESats
 hzijLYtekj6Rha5fm5cKOvkR1GDDmIDNma.ZOCpeeYb_YNx6M7_ipwSdEhJBaHunAzNbLXr80Aba
 vBRrdZwlrMlCxl9mUbxeLozu99GEstbx6kF4X5lDklIDsM9QOoXbkOpZM48swxpDAbn5Iu0eaGij
 tlFPJ1sI8d6j4r0LkztcIJXgG1qCZi4cJHyydleurC1_u4FGmeERn59pweBxmxUzEDIHiscBsVI3
 z8crHllK3l0Ca90xIczBs3QzfQYZ9SpCipYQUiAopfGvT_NRfOSFKASlFyu5U9xFUJXNysfxoS7_
 YimAwQWR2jFSaKI0mLyBnLH8.fc7jRLkExGqMySdx_lLIZPjL1XYIuMfw0mGrXbQXsOuXzUemjJ_
 TnntgDH1yG6YGePEpqvkwd2MBbwLUK0NfrWDXGTQfVo2wj.HXiBNRzn5EJ8t68B5e8dV6a2ghVIs
 qV9gHhXQlOhz8fkw7ow3gopoeSgLVGhIvG2xQnGo6eE3D.NBTP05I.ms.y3wNOjSDALwPiYobV.U
 mxxuOnK6yLygOZ9xtZOCwizAZPKF7_HOaeKv96Y47rC2tLn._L6ajYk6dbzHQBSCzFKKgwm5v6eA
 5Sxp.vXeL0ZrWEO1atzD3Ma8T1IiOPyfqL2WArVKVlWKsf9M5JHGKYW1d51FdNjlZVffmTcUr5Ew
 jwXGiqlDwq6uY0eZZngnLfCLD9xM00XqYhLGqbisu5Yc.kjVEWEKW3W5BF58Ee1jBZ7GyHl5Qm1p
 VbwNskhdtD9b1SjGukOmZlC8i3HrVTFbb8jIr0gLK.NfwsxeH6sWZ5eW0AoeRAULgZg0WxiQHiRR
 wNMRddklTQBfRaszrqTtVTHczNhklhHlKdUppsE.doszm9u.UeRMLuzlVHQiiDYpfodVxhENnP1R
 f5ebtfV52uZUp3L8Q8jWAl9ykxILTKfOE2cWYiwe2yj3ozDuG5P0xuliki5GFl1_zX8BByP5NcJE
 LeD0JSPcb4hl69WEkYYPULsZLmDUvu1LkB2uI56kBIRfSF2vk7jxlJ_LSG.kJgL_H4kJYK2q7ANM
 aeuD5GRa6x_TEME768CZLyfPMl_oveDnqPVTXDMKMDYLdHaZprW3UCGGemirLqj1W7z2MXadbiMd
 3QM0oftFBa0z6ihggiU7t3vsMx1lHrNLOZNkNZVOXJoEfQG80pePm..wM1A1Sfc7BPjITKlshLMx
 RLnttwc1h5nam04pM7jdNqJgP7k.MUotELx3008fIO5pjrQdmrzCeH8CI048vdxhbC8iT3e6D8YL
 oYPF8yDMoTzVMe4P8Wcof3tQvK8UYqB7M80255LsX0WRjo6Iw3DPlGf1CHg4kSIMldXN7l959l8T
 E03fGjESGWBR_flMx0hZ1f.1hjdWDAAZttRTcDZ3ROQ.n9U4ZfIGW.af20gd_QZwXHp_PSX.pLOn
 wbIsGX.B1GeVb0YwqgbNJqUGRHZSapwkd_Wx8KbrW3ufBrNGBLoKUv6XbD6G0PKdH.CC0C9js1Br
 tfK0CIhQX9VUMzYbhziybI2Jzgx4Bx3bK3PvyFpvoIMlDw8.JgcBpSijb1SiAgcCWkmWdDQKUyrA
 dMRbWtc9f0J9Sw5U8Mwg04DP_OeG8UKDTw2X.QHuDthYCyRgflIRBrSaYQmu2qSHke0AhcvLY3Mg
 GsGYUFK9etXN4.9I9Ob8AqpCdALRcn9bwpJaBfEQZJcRk9YRRdBV8G1OowaCto.u6qCv36cvWTF4
 Uvk2dubeFhFW6SZhkDiknnFohz4k9Ojp6zcI7lnu9eFhtMTk0w9MxoOwiraPilo.NZX2eBFqF6u0
 dZcPLyVyb_f.DaZ_QFmWU9JHkvzk5V1i2Vb_ZDElxxxvAy7KgKRvqUXJVK_4T6T_xnzMZPOqeFUQ
 6Ic3249jJ8uvN7yQF4AEXrSvz98jlot_8LEeYQr_y.Uv5Ui0xDtXJI9vKZuooMb5VG5idqC10baP
 ssSLPVqhRwms.kEkx7Be.QU3kqEbu_PJGiK5E85.2ytSZZ.wAvUw7kVGv.DXlyz916Sk7h5rKmZh
 y5Mp9L_z.So5n6xCLgZWkDRuCz_ljJupfyHbVIIA7zUVcUVjtU5XWgsyFXm.L5KCjsGzL_JMggaB
 lipc71yIw53iNmF.joUosxIPvDeRJO3oWz.7ZfWwRJjPoByDnmRU3yw--
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: c44999c9-2a2a-40fa-8bb8-72653ad7c6a3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Mon, 27 Jan 2025 22:12:55 +0000
Received: by hermes--production-ir2-c694d79d9-mr45v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6a4cbe09f41ba2e327cf52594d733ec8;
          Mon, 27 Jan 2025 21:52:39 +0000 (UTC)
Date: Mon, 27 Jan 2025 22:52:37 +0100
From: Jeremy Dean <deaner92@yahoo.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: markus.elfring@web.de, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: Remove unnecessary braces around single line statement
Message-ID: <Z5gAJboUiYtDWdSr@vmi2410184.contaboserver.net>
References: <Z5aMrXwnmEXxKWkC@vmi2410184.contaboserver.net>
 <452f118f-2a0d-4b54-9285-063ccbe6e5ab@web.de>
 <Z5f7BcSERmImx0_H@vmi2410184.contaboserver.net>
 <CABBYNZKxhq33FXEb_8LMLV4whhX0jc100tUPYCAs9t1q9_5MBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZKxhq33FXEb_8LMLV4whhX0jc100tUPYCAs9t1q9_5MBA@mail.gmail.com>
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Mon, Jan 27, 2025 at 04:38:22PM -0500, Luiz Augusto von Dentz wrote:
Luiz,

> I normally don't require Fixes tag for coding style adjustments
> submitted to bluetooth-next, these are not typically backported since
> there is no change on the logic or final binary.

And so the only thing you need is the subject/title rewritten?

Regards, Jeremy
