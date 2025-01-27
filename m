Received: from sonic308-2.consmr.mail.bf2.yahoo.com (sonic308-2.consmr.mail.bf2.yahoo.com [74.6.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA341917D8
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013461; cv=none; b=pVMKLkCh2/dqW6XiEmpXdyUyWZBirjbFOvYc3nJyb7QOTIiwqui684un4it5iCpcDGALDO22LJU9dlkGUhnGwt0iNhAksiAP6a4bN0FkMOKOj38Tc9KarRrg7hdHOximlKzLlwqEHIfZN9L7o49e53v72F1n4aQ5kGMAArWde3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013461; c=relaxed/simple;
	bh=7aV8SkUZKiRdCY5HbhOFaCwMQsO1zyIWBFNvcpXE5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIgqy87FPgXjvxXTKxi+riIY5H+IpwrjLNciEW5MM2X58Kf68o2EY22vsT4LxNYpDZkpSj200T5Tk6l/Mtn5bpFb6tHM8YFZq/k7S0bdQtuJp2fCl33B38YNaRYoBsrQHVrjFIFJqZxmMXR48DncMPWGXBeeLPwq2yBO0WGeEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IbPqT2dZ; arc=none smtp.client-ip=74.6.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IbPqT2dZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738013453; bh=GGsRP5bH+jrw2e2OAOANCDE/4adOk22V4csL37xiLg8=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=IbPqT2dZHSA+GZCQabQzaIdXesuxtj23+z7OKcDVAjNICrP0Es/PKtF0eJ0mF9cz46A/W88vSyLea+aNPZUBewxivbmNRwI+Pp2IuoJqZoRzB6clauOJL4Y00Vu3Ec3SqVS0demoheOrCfpNlMBeXdzh+BBYHX1QJJE9BQgkPKl/sf4mlmGY39q6zCvzRLbK0Qvl20YyZLgdv/RZVk+67FTr1PIwpomRD8W0P7c6rG3whB3lx12xDr31Ef3oEDzq74EM22awHmJ9YeOfkm3to8Ddlzo8pM/RN+jc8+rjnnFruKE7XGxrNSY79j4M3ihL77PNDU/vrPadhWNowGSqtg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738013453; bh=n0vzTGTB1mwt9dNmH/sHlqg33xBDVr+kjKKTIqi26w2=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=e+YgMQ3tYmS23k4AQH5VobRzZQ3XOCOY9Vq9zdEnhnArDp5+sYcLwsTz2zgHduk5+iueJ/+1siXQBFdoeCMWi18B9FARUV2ynV6FTeNzdUaFBwx51RGF6zxf98PBdckj6EY058ki2iRHxEQ/lVln54jpT1IjNwDahuoQZT4J4u41z0ns+ACL65UqCsws25POyJ2tlJmUChEKjwsAPmJyllb5SQNHJPfXrWjmyjr96KNxbGsA6XidnX8/fG2JgZxtUo7q2HFddCGCO1iF4T1d0+YJ9E9DrKrK0z1CO2N3l2ejNBKadMVjZW57PnpGb1DZocCkmjSG9emBHkIWG0/D/g==
X-YMail-OSG: TMZWs_YVM1lJXaEiAhuODlJmruMDKzXj5iU.D7D1109LnBnh3fzyaJZ5yr3yDuh
 S6hlnAqLvEubSN4LrVIt1dBk2xSxXRUSGHGiG6LpuFV3k6PIHjgC7nlaarbs4mwEOhx8.zD04mvQ
 FtAkQ0X5i2X4cKmlA.dTaN2GxIjJuxpkUfO2BM8IvEAP2xyqGdcQ0C8Pmi_Kmn8c3cyuy5Zx0fYZ
 v4tKNrKIvDUP0AtFoDM8fq.KjnmdHdCRlO9Rdifxj9PrqJL.8GbofoqVKZNx2nLpHSQBAy5GRhSo
 6uwHyB9Hny6a_LPK4EA53cnlAtyq_QqQ12jBe9.Abk35b06vXguQylwD4ueP54eFciUypCGbZt4s
 Ft6mRk8hWdE.keL9QpnePZ92NPUxphsNECk_Wt1lJUC_g09br6xr3qF9XLoCqwhUJziSEQgolpy3
 UjLGdBq9QV2.YTFUvPVJP28W9yhwsqWpsJjIeRbqrg15CGiEEPYm4PkIgDXCgn7yUWCBbb5.qZ.Z
 48zp1ChUv8I_qF_NF261A74EZNb.J.XX42C72iDGkZPrFip6o.hNVTgfywX8NS.iFQnWDSu1MUbe
 lrttoLUtYRJMnye5sMhYRGAZcI5pnqq.FVa_2j573dWQW2qKxIrQjtkkbBAHZR_SV_u4iVXJzYDA
 NmJepo3mZdDxIkUUi_CkFaPpRJBqW2.CimzkPPBtTc0Rc5x5myicwn3I__IpeY.7NseDcYO7G1Hd
 .NkJcXBH.LePvPkPEy7p20il8YZhd2rarkSxMAZAhePjCOYDG9i6byYBEFKlfl_p9BKKGX9hjWSb
 WfWIcjnBie2HgWrNo56H6BC4QUqTYVoT1hQFNDw2CyAyHQ7.y_0RAapGAQpZ1wF8FmQ0OoHDu.Up
 Y8xfA7irFmKzN2VYWOvb20ZuXEtlMF5ZRHapIPiDJ1KsDon1s4u0rHg0f8Ml9x1SR1LraTG4A.0z
 STGBM4WjCsDKWzemxxQR2li5sUNxYU8.Oh46cc6kMKMKpTpckI4rBjvDEUQti20P4ht5qW2aZ6ks
 XbUjwID_6LndKvk7r4fACKWIpRVvZzJhhT0f6pu7sEZJ0wTZZw3eb3f1VrMYVU.D0VkAJGExKNiy
 Q1c3qeO_qjoCcN.FC93ueCkQmAWaxj103LtQPlU9SSnZTYLHkbLDq_.V0yEuoQclO36ha9Xr4rDn
 Y2A1z46ek2xNfQ77UasXbkx7lmd0hR_8n_rfPOfwf4V.euw2BQJdnRg8p4b71xgJIJA17TH2ko98
 zmD86pYfm9ufxlkC1E0TbLcUY1e77VJGLdXFmgTGIZzw8zB7AQCPbLeml4.SWHjSnAnqgkCA3kPw
 ZKzjm_EApaMeyel7iaVkA0jenRrbjz2K8Koga52We5YOlfVhBeS1I2maGffoMwK9NTWdSfXlyQru
 BDWUxhVgBKJr.v5MiYo7NHBwtNxQB64sUzM3x_A51g059SL.g.v8nImCru_BQO1cK7Lq4X0U6kqh
 K2ZIoakk0He_x6GciwhToKDKWLa.U5XylxeVIIR6252HSuoQeWqE55tuzFtE6C1EDgjAWyQD.LI_
 8GiuaAdDyksp_MzgcvXrK37jYaIHH5a2NNjfWZmYBAF1QN8GBBuCDtIbuxyPyro1tdrHbFpxquRH
 j8iJIWRisSZCcmYJN0ZKu_GvV_lM_M.sfZsJAya8M9g4vpDftklnN3tJSOuDGvr4pBUzHU38_Vno
 hTX_C04CtYCiTPT1VM_4bfFk4Vi.S4RLp_zur6OaM7pri3b9K1sf9oz6uPL8eAnWHHtSnkdAqFYD
 YDspJpB1zsbzyoUUk_56.6k_WdM3fK66QUcFUPVIuaNohOdpRLWM9ASN4niqiZ1mQ7EXuMga2vIR
 hRuniE82Y1R2xRFxG6G2TaHtUuJpCcDdF52t4jlqHF5f.c5CvEqZpTYsRQaXH9ThHYHZTDngdjEK
 BdTpjMPdEv14CgkvLL2GjmyMikvkUr3xDa.3dPpC189ZZhLFntq_kTjgDmMPifgaQknxGbuO0M9t
 re6I0jX3NMAglSsxiaZMK0eksmXcoN31idVbT4GUqF3_vFVBv.pF5nKuprmRhocvo1SIlmHoeAEe
 ZXn.4K3ENVH_WwMMfkZNt5xPpRhm3MfZiKWa9v7N5Y8MfM6g0EURn1SNiKtx4UIxcNk72kgvcBH2
 JCPU027db5wxETInHBJXnmTVzks8ZmqFi4kF1KB_2J43LWi4SWuq8Pa_nDLSJtUBO65cL0tGogPJ
 ETmAJMxXXSpJw0AOyE6ee3NLSw7b66OZ37eEOtUdp7jNtbo.Z
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 835c0d90-d36b-4c3e-b545-8330702d2ee1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Mon, 27 Jan 2025 21:30:53 +0000
Received: by hermes--production-ir2-c694d79d9-sckcc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d77150ffad601b11f3476e20759cf592;
          Mon, 27 Jan 2025 21:30:49 +0000 (UTC)
Date: Mon, 27 Jan 2025 22:30:45 +0100
From: Jeremy Dean <deaner92@yahoo.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	luiz.dentz@gmail.com
Subject: Re: Bluetooth: Remove unnecessary braces around single line statement
Message-ID: <Z5f7BcSERmImx0_H@vmi2410184.contaboserver.net>
References: <Z5aMrXwnmEXxKWkC@vmi2410184.contaboserver.net>
 <452f118f-2a0d-4b54-9285-063ccbe6e5ab@web.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452f118f-2a0d-4b54-9285-063ccbe6e5ab@web.de>
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Mon, Jan 27, 2025 at 05:17:20PM +0100, Markus Elfring wrote:
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.13#n145

I read it.

> Is such a tag really relevant for a coding style adjustment?
Is it? I think it would work. So before I submit my patch I'll need to add
a Fixes: line. I have already edited my commit message. How can I find
the SHA-1code of my commit from 1-25 
