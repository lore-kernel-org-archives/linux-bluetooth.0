Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8141F95A;
	Fri, 15 Nov 2024 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654134; cv=none; b=NoBFNldc+TlLWUtoUkFXJtfu1FgapFNRzDRXCWVrOwreGwiGNk/OCZayybgKij1EYosJ7ZKcQGx2fRtnV9da8/DAAxhTDXXJ5GdxVu82FlitVAYNInioYxveGzPnx2oHHGxC97p+d8QWWx71XcagagiACVMrwWuVVBeaja4GbXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654134; c=relaxed/simple;
	bh=5tGM067wa+AlamSiUyUvtOdtPcUbA7Xj4tjlcN8ACzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InJGiU0FJikL6oVfbQxFwDoU3azef3L5YdiH94opUr/MQQML4bumGwB9/ltIbgNigu5g7QO1lT3rUNRqWDyKdAbjlmthpTMFR2Lgp3HsMJ2qCN06k9srUIsDb/1Spik6NCgyAJKRl1XLElOya6BcgCZ1SyKEhZGC8LQWV1Up7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=U40jpFcQ; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="U40jpFcQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1731654130; x=1732258930;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=5tGM067wa+AlamSiUyUvtOdtPcUbA7Xj4tjlcN8ACzY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U40jpFcQkDmDy7VO+9uK1dBRbMvylijWgJQmVu/0DqXKrePCE3Hkw4n4VZd8xPQJ
	 6ZuA6VzS0y2UuKK4wEQP/4oVjJFoNnJuKVx+GYbv0hZFkKTUk9yLFpx65gxAjhsqk
	 wgVGN+MOD2Y00/1ECPB1PENhuVLVq9owgcV/Zczcxlf8I6qfssiKBFg6o5pUhWGgg
	 q+EQPwaPYt/7RhsWfRthfQhHIhBaC05z2QMyea7Mq5ebx9oQ3GSlA6aJgts1vs+Gg
	 bydnDYRiN9F9tg0MWjx0nesaaJMB56zAEUbthZCyalbX0QmWz6aIhKUZ002PSs7Jm
	 IeoOWST4Dd3XT3vFDg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.174] ([91.64.229.215]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MnaTt-1tbEnz3qC5-00dzeD; Fri, 15 Nov 2024 07:49:03 +0100
Message-ID: <8d26f1f2-8d75-4dec-ae77-28e4cae81ab3@oldschoolsolutions.biz>
Date: Fri, 15 Nov 2024 07:49:01 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] bluetooth: qca: generate nvm fw name from boardid for
 WCN6855
To: quic_zijuhu <quic_zijuhu@quicinc.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steev Klimaszewski <steev@kali.org>, Bjorn Andersson <bjorande@quicinc.com>
References: <20241003-bt-nvm-firmware-v1-1-79028931214f@oldschoolsolutions.biz>
 <8500baf7-59e4-4d8c-8485-3ef7aa106f16@quicinc.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <8500baf7-59e4-4d8c-8485-3ef7aa106f16@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:POfjw7Ee0aU2xz7lJI3a/GQzJrRzifurxdY8BMePB2PZiBu1j0w
 Ccg89dA5BmAXcFc2TRjTnIvWyU39/k0qaSXecRigNltvACYIMzLXaPs/RM4kGsQStGzDZu0
 4ycQkIURY+pzODHIMzoPm/LXUxV0orwagOqk8PI7RaZr6G6ifNAf3jrm1dPxMKd0lANMYu/
 izCeNoTINn548QnMf/uAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ed7+KrzYIys=;IdcJCvQvXnw/JnCBr4vd9ruLI7R
 vHWNwSyKYZahVU/3+ltzESoZ6cNxajac3IRVEVf4iVyXRo1ttpXpRui0K+0lrKSBRN0wCIHUu
 PeyklkO7d1S6buOLjsgkpC9qivP/Ox2sQpeb7vYzUD1TCao66mgcI+cc5u24H5zzuk/0ZBhi8
 YyK3VJV+bFaIgLRhHiXVkqVHhnHO3PbmDTcHhDVtj9ObgNb8+B5Wf6FHVhmP7Spz8xE53X152
 XA2TmxM1opdiFkGi+HbiZShCz5i2pBIT8bloGNXgSC+lVpzeOBz+Kablwb1uuIDCNMnfSA5Zt
 IiAVN/hqgCXGE97G3qG+gJWZBEifOLqyRZg1+FIIYEY9zZFOw+12EFGgnoism7IAjt/QzJP9x
 B5Co5ViAgxAOE98jmPb5lFSve9TncUDCu6wdmJjHX/yikr75T4WdizmZFnzS3UBTvzgD3VJPK
 QuyqOlYFErAorpQ39MieX07jF5SfFZSRsTGU2Pkesn7fkSPw5Ai17j9m/cYq0Vy5PiLSsLhpr
 zLRO87Q5P8PCc4sjvZUq1u+KGQNmbnjFNcW+3D+jE95A3GcRobj9JfU3lLdSsdJyfl5KQ1QKZ
 98y/S1mS5+lEl3FTohwI/NZxQ0BfKsMEHiyRve78HreZ8H2z4KLFZ8Pq0z9EzyoURsFQiG8Nt
 iKlI5appWnBsuILNdCL0kwvDkRixppZHxtkXCbgut1U/dBrg6canXxeICx2GNCEECxKJ01Roq
 oJcchHLbqBPzS9VFkIpktWKWJi5seTp8Z/SnML+Ses9Xq7cEw9AdsSWALLYPQQdD2/y9JvvuH
 ugk/1weUxksGNjaa2xDxuGsnGWsJWsXkUiWmhkcsz7JSJhsGXBx9mcy90/aiuXdT9M

On 14.11.24 07:17, quic_zijuhu wrote:
> On 10/4/2024 3:21 AM, Jens Glathe wrote:
> why not to refer to existing qca_get_nvm_name_generic().
>
> i will post a patch and cc you.
>
Hi Ziju,

tested the patch [1] and works nicely. It is the cleaner solution
(having dedicated fw name generator functions) than the one I proposed.
Future-proof.

with best regards

Jens

[1]
https://lore.kernel.org/all/20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@qu=
icinc.com/

