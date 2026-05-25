Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D73264F2
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718075; cv=none; b=tvSrfSbe745T5gcDhIJRFZLOwgVH1X4IVCLTQH/QXiF+qlWzOO9bTZ0Aol+mQDV4RL1d7Oa0hViO2Q+N8ckEGQG8zymk6SN/eFLdgrVwQkWT7f4wgj72ohwp3vjgndJnG8G+ZVBoCM07rLRONc7zOkakJBxZsEK77QZoJAGjVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718075; c=relaxed/simple;
	bh=2Ho2IoV59LwkMD+Wa6e3K4Vn8fLL93pSqnoD57gbJEU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jhESMjkImtREvmS3sSjb7fGDX3B+SRqfBkUiNR5MGUPWBgNEwfMOu2B2KxzXfZx8nzxGFiWIhn8oILd4OhwXgMYXbUGeDE0pV6JmNy8rPcaTFpF938wAxVifBV1k1UwacpawSNkb3DUm4ngYdarYkL4j4RhBTTWfBWFlfFNnZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=IXduTA2s; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="IXduTA2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Subject: Cc: To: From: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1779718073;
 bh=2Ho2IoV59LwkMD+Wa6e3K4Vn8fLL93pSqnoD57gbJEU=;
 b=IXduTA2s4V4sLkEQHkNFX2pXACy/KU9cYjEMOU5bWy+lFNVbZKI+qc09amJw+lSWrWNvGqyrt
 +dLXVeo2M1ZImCGKq3WojKgvP/DZaxqJ31Mfl9dHQEcwem4SUnCzsDU9DSTklbRRHhVhXc4YlVB
 5pk2SLqLCr35q5HlJDMY1wHeZE6aSziUiHNmxe55z5nrivtcp+RpX1H0NRR3ymCcuI9Dc6axoRj
 19kAas8i8JbYu67GV9Z/sPddqucXxhK8c3NXM8xk3tYJW6glFrUVqSQIOsCYXRX+463uIkzqoPU
 VlU3Z0IJSc6FIX66ekrcNV53Pbwe3I8ovikh2hiQ+knw==
X-Forward-Email-ID: 6a1457b79efc2641fb7d3a63
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Mon, 25 May 2026 10:07:50 -0400
Message-Id: <DIRTEIGVL56X.1W49YU67DXNUQ@ubuntu.com>
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Sasha Finkelstein" <k@chaosmail.tech>, "Joshua Peisach"
 <jpeisach@ubuntu.com>
Cc: "Sven Peter" <sven@kernel.org>, "Janne Grunau" <j@jannau.net>, "Neal
 Gompa" <neal@gompa.dev>, "Marcel Holtmann" <marcel@holtmann.org>, "Luiz
 Augusto von Dentz" <luiz.dentz@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
 <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Add Broadcom channel priority commands
X-Mailer: aerc 0.21.0
References: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>
 <DIRT7260SRQZ.1BFF8CX3FJ57G@ubuntu.com>
 <172D11E7-AF98-43F8-B41B-907738749EA5@chaosmail.tech>
In-Reply-To: <172D11E7-AF98-43F8-B41B-907738749EA5@chaosmail.tech>

On Mon May 25, 2026 at 10:05 AM EDT, Sasha Finkelstein wrote:
>
>> On May 25, 2026, at 15:58, Joshua Peisach <jpeisach@ubuntu.com> wrote:
>>=20
>> On Mon May 25, 2026 at 8:11 AM EDT, Sasha Finkelstein wrote:
>>>=20
>>> + cmd.enable =3D !!enable;
>>> +
>>=20
>> Probably a dumb question, but worth asking - what is the purpose of the
>> "!!"? Wouldn't just passing "enable" be sufficient?
>
> This is a way to enforce that the value is exactly 0 or 1, not 0 or non-z=
ero.
>
>>=20
>> Also, currently, cmd.enable seems to just be set and used in the case
>> of boolean conditions. Would it make sense for the enable field in
>> brcm_prio_cmd to be a bool or does it not really matter?
>>=20
> Opposite, actually, this struct is fed to firmware, and it needs to be
> specifically a u8.

Got it, thanks!

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
