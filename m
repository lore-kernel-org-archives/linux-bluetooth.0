Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252613C80C;
	Mon, 27 Jan 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994667; cv=none; b=OiTlDGvAIFc+YVZre4qiQrhHmCwAFqR6DlPsDufTNlYfgfQDxyuA97oTxogigcyRQVud8G9PwgpvkWxeP92X1Au/x9sw+BXNORMmQQotFhmTKEwpHTmk0r+/c3R6L8VETVjWKPs4ZuLbt3SqMbhi4QSM+S3+kfgtyzqbrS+8ZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994667; c=relaxed/simple;
	bh=o44SE9ibSopRDk8+zfA2i0HcIVDWnoiymOm5EyAKnck=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jK3cVJAInbXwKx4D/z9Oo6scJkCAtYbR2cduWG4zjYnWcTQuHy7xNP4pe9lHDBwhpcdbgpVHBNjMhoFaAGAH9pj2xSrhyIKSE/DyL+pU0oeA7M0CEALQ8T8kWHOougAuq2kV4UQZ09Jshw+OI3b2kA8OgKf3Xzkmi4cTSYAkbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Fd2rqr3k; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Fd2rqr3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737994641; x=1738599441; i=markus.elfring@web.de;
	bh=o44SE9ibSopRDk8+zfA2i0HcIVDWnoiymOm5EyAKnck=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fd2rqr3kiOiMGy95fJCPon0rQx2xhKPrbjRjs6gNKgkHhJwTgPqku4dUAixXEFpo
	 UfVd9Zmo9Dq5JhTkhTE5BZX9soxzMSBPUKhyUCRaL9WHQHN9WycW+Srpmnp9f5N49
	 S3oHlAU/koauSLCw5wHFvUwoHVrwJDi9w2VDyIzkZmK5zRFen6C+joWqbDkOsQmlM
	 RXEgdxSU22ImIakDL8wjTxf7V2bEBwwRi6E/1v8Uu6H6WhyLvNGslj1QmXk9dZ2s6
	 s27EglM0VUkelpN8ZfHlGJzejWBiskfn+ut8gDJnuChW1KzvYHdbbq5Xoc51Msjb5
	 NkvOPTiUXXdHZgLJ9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.10]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1tQVpK15j9-00zhxC; Mon, 27
 Jan 2025 17:17:21 +0100
Message-ID: <452f118f-2a0d-4b54-9285-063ccbe6e5ab@web.de>
Date: Mon, 27 Jan 2025 17:17:20 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jeremy Dean <deaner92@yahoo.com>, linux-bluetooth@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, Luiz Von Dentz
 <luiz.dentz@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <Z5aMrXwnmEXxKWkC@vmi2410184.contaboserver.net>
Subject: Re: Bluetooth: Remove unnecessary braces around single line statement
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Z5aMrXwnmEXxKWkC@vmi2410184.contaboserver.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RRXSHfQqtAcg7biaJIVTvHg9O3cdG07qRwWlxzs4PsQU6cWHzbm
 2cvj1idGLDUYbZiHOMBdvSohjlCx8iWkNzWxkS/ZIXoB20pOMCUyFmuj0NxrjN/JjYyBL5g
 3WyLNJTN5iOMqvDtpHAVDEIVgJiTmJavjNp69BLJpoWA3YkaAawpOdoVm5Odm2vT+6aefmX
 1Th2B79XY9EXB8lTKisFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZwEOEFxC22g=;tFVoc6VXWROdeQgLn23N5Fp7oxI
 1g84e+sM3xN5cCIdronKMs745mDvTRDEtEvaMQT6GpbMq3UMCMDvZd3KeO5h1P++WMNf6FJWc
 gWU6pHWSYh6+v70gjrRxqHMkA2FvO1U6Jvj69udHayWiW7wmST3cGSHhyX+oC2i0g48++gl6L
 ZLX8cnRd6KrQK6wBri9VUX1pogXU/3mzGWWu9eDH8UurDDXJ79NnS5goBUJlHl0dvQoyl/N1G
 m7pC/BXQBzY/NuXqMAZkCHgE2Jhppg6JHnqwHBKfZ7u0EXAoDpPcxwt14Ikk0xZ/4vv8TmdcX
 R3Irhuqp0G7iSJEIVROe/u3qzPCGo4L4+mOtgqXIg4alTgJFNaXoCHfqFs140kQTwd7nBE5Fl
 +H72oDCwKpCi77UagSk67v09LV55d/8TsVLA3yTcNVmcaSCGnogtS/rmlogQkQTAjYHRzFtrY
 MCPU/boKlPOMG/3OYwGnfBNooOXeioDTNpuoVM0fGSI0ajDELjyOLa/Psf1dcCle36QJQhXgH
 nHZAYYjdXSrAkkCylvIVreQInCJsrDGqHdrQWaqqTyysfmcfZq1UBSRpVf0NMsv95J3gGk5vP
 8c+mQ1f/3/Bj+1PW7c2sszav9u+f4ZJ3QoYvFTimv8FKO43onyZ0tRElExl8mKty1CjsSZTZx
 bsx8NuwqPRarVCGFxWjEzanPvRGt0zRe0T59CH5TOqpK+Hb4QUaP9UbHAGF/6VzLGLaJ75+Y1
 OczHb8RFVvXkBl6ytv9RO92hypW2CF/X2T4kPr+Xp/Js51AyUQ6cGQA3xHytNbHODeKlQLydU
 fPGYvpxr8Rxg8u5Ph5qSg9BXikmDK+OhCCSb98n5iTc/tYHMZnUrfYJRO8ka9MjIIZAZ/q+nt
 IifY/ErJjYMsWW+322n1VL5uODZCStw+WgsULQ1Rtx5/We1fhOOEZybHg39LqSDibVS9WbNgm
 ByuIHm8FzN4bwna59bKZnC7xYiPmf0cZxu19VR1XiQaO7B3jQyVcALCTSczcwAPcRc/CPBm5T
 022YcxzfBTizyIby1VX8EFVf/63VCU1DDmiyJyfILowkjdSbffbV7htAhpAGJ9rxsHzAKpX8B
 V1+5pK8Es/iGD2gH7BTs41WDjg2QBwKwZAsSzhReCvrcjDhsiJOJQgRq0VVUEdseF7sfo1lkc
 CVKtgA9a0LPLNaO6HJd3puMA0+pj5UJzfeCP3a8LBqw==

> I have changed the subject.
>
> Fixes: Coding style, unnecessary braces

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13#n145

Is such a tag really relevant for a coding style adjustment?


https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22

Regards,
Markus
