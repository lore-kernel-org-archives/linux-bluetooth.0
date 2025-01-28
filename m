Received: from sonic304-56.consmr.mail.bf2.yahoo.com (sonic304-56.consmr.mail.bf2.yahoo.com [74.6.128.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F59383A5
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048821; cv=none; b=g7EwWfizSXR9k4g08DBYGqgceCrBVNU9NDyNvNtUiyk1FKbVrDmw7XT9p5lOhALYf/IOzF93Ptk5I27GqaF+grsL4gOBdadk6nt+G/h17PUamKXSoLB4Bbm6RQlVmyetvwYPywEMMOEPWQnrjHveM4ZIIacmhjT2RlTm7xILynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048821; c=relaxed/simple;
	bh=vnd+tt5L0s2uUIZDSw0r3wMiVW6hjIFOmEc1KRUkyNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjR/3W1QeUKegzWV0sggcjxlG9FAbx8SAB7G42yJz4fIaHzxhXU2t29tJg9LhQGomtCfMo3Aroh7/Z1O33mk2HazRYYzz05n0I0aFSXEW3lahj++YHaqLsZgPNGNUcPbLQ2RqwjHBzDOO2xVglwBGP+rMvUZil1odsY5thNPGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bTwYnuUR; arc=none smtp.client-ip=74.6.128.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bTwYnuUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738048818; bh=TdU5KOCCFxWFOfOWK7non4SI5f8wrRoGIihvtUdujgw=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=bTwYnuUR+Ym9/wV4HNTJUt9XHVUkmWm6JQZ8osFbAHU6gz3e4Yj/lvUIfL/SDeCly7IpGH2eeyf3aWP7PHIyIbBb0t2p8FVlb6W7qn5b6gpVwGkTG+7VXCkxqsPRtzFbR1AhhhdV2or6nLznXtffoB7pM6h7G7RWER5NZKE2eDqz2f6zIiSSPYBqKzCPnBmaddm3Q2ote7QdxJkTCADY+QHsZN7ydFeX15Yd95nvKHL2jCvc0w5nxmK+AZ+ADilOjaupQ0qOk+7Ex9MgPTt5rtnftqPMNHnpOai86YmRJ28M3FtOM2Lj28scBJZLY8M3np3a1wfXI3LloC17OlCJog==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738048818; bh=ANwebel4fXnmS+VVlBFX2S+ewY7/WVS14aK4/pQkf86=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=TtS8h1AV40syZBX3u5K/2p0PDRI362YYhSsUby7s4sR8Ruxn0kLrZLaW22/bdOy9y6uUgoSP5DYFj1S6k8ZloOFGvWx8iB1XvBt9cWD6rO422MurwngEaS3wOXNiZi96yQmkbn0C8VXP430ZNYypeTxudvce5lYVPYhKvBptPkRCObQAp49iBGmGxjuO1+Sj4dGSDnGDafpU42H+jVbXmGqz0/50Qs4N8qHqPjeiBzwpqlmw/6ZGHFWC6snFe5Zf3fq2P7fvd2PiRDQ1+O6m4QGpZEidhxT/JTHAmVYZ4Kx6jY+hkTAHu7s3V8s8a2TTXWTqmQWILeHiEn3nS0AsFg==
X-YMail-OSG: ADDi5DIVM1kVXW_pjhtzH.O_GMuoiWkDyjewD.0HOMOipv6z_5nx3sDEIhsZSNF
 KweaYjZ6QBKKJmRujrhf7Xk5tKaVZppQBTZEfWrJmXQZRnzA7clZM1EqLnKkF_BAUwkCL1bdiG4l
 JpqvuhlIz3M8vCWCi.8ttoQ36BzS5PZOTkMr97ezBNLgBtE1_BgkWFDLqNKqzOqQ7lmvuELzBtQn
 2HMqIsqjW._kfo4ctXYb4xmuxvUbpluyX1EvaLk3I8bNGPcR084MJpuCPIWCZ4WC4AHRYHwrGk5c
 SCDVv1OHRbwWwGVbOaQaCJ3ygg1NJ9AAfTAdMX3iKMbfOAQ_SdDYvSlBSLME_dojYVlcTQInyGlp
 DoYM.stpk9aF_PNDNXlCyGOin8HVuZdGPDV.4V7wdrELSWfPGO7rJ20TpZy6EJkvu3l9lPoWtsql
 sXFmd0BBux.qUSYpiphPwfITu0S_KB9_QP6UH4zicJNzz_.jS.BQan0DlljaZ579BNX0cKQZtolR
 EO_xlXE90AOV6uQ9CZRw8NCQnoNdauQj59OyFsl3PILjLSWPczeUBWavpEEXEJyEEaf.yJs.J.DL
 pnbYHpRD.pVvRFrzv1fXwKkf_TH3CrgKlVB94mIdXtqLtsUi5J9P7jULkIt2Si723gpTJHkpGw5b
 l0H9rjj01ucp2OLlXvn4MmpmrLnwYwKS1g9ZBzh5gWCWNYbeASazGFIEnSUxBO93b9fi0znDmHkG
 Ac_iRjORQN.JEYE1VNFBnEM0fiRoeQn5YvA2xWpKMFBjVP7m6wZd5eNLfrwcjAXk9N2.VoQt3aER
 doRYf_a4fdT65c1X9uPHf1agNq0Gt87C8jIs0jkX.HUyREKOfFoZAg28xsGKYCuwq1dND_TXkhI1
 gDGJE_qHCJDqibcSXCgehTVdT4IrclaHGuJZaMyv0KNoqct5ubNB4j3a_fgWD961x4Tc7dUR4KeB
 pBNXC.6hXgYwxnLEPYMLu6TQzGuESs0_SMcg_4C1PKkIHqbbIK2pcB1VG.1WIKgcEqHCoG76tfO4
 mJfscN30ZlszYDCh0lgiFt4BS2nriU3DJIV9hVfprN_FS4t82x_VWzLvap0Ik7z6FRl_4WH9.FKe
 zqMr3p2qJpKPJmoKzPGrUmuH4WEsT0PVU.SAB3wXlKGanwf2V9kLzKDW9Tmk3sh5HXG.xkPM0tpx
 QgEWl1nG4ClwAKPYyy.F0bwZg.Js_CwhsGyqI6MhX1K.GVNjGbcgtsHUOhCs3C1NQ31R2u4s.og3
 taKKZWNFyyYz6zFph1wbOc.KZtQ1CXn9vretQ9elXn.TrkTUU4RCWiLiZEnr41pdEIlFxPUNqN7D
 TQQleBhByfkr8P69ogg1M.saX4cxnMPfWFKrYiN8H1OLI_XGXptvp9S2dqspOKCXB8e4MWNk9HKU
 DbCHBEH6M1SZX6jgJm9TlxkCAHwN5NE4YhYcVp_qxp1I55Vx0FJ8knvDBrTiWEXWwQ9Psd2W6Lzn
 Kqi4WiH29ya.BeoYFmuTvlLuAqf8D61.m4RW9SkskMf0sTXRGM0KMUdyIvCW8Y8WQ7MHAIKuo2kb
 T4QIVIaHZ4sjbzfvIiVNS1riG4Nmtybhz1I1WOAv82a1dszBGAv.uUi_0Cl1qmi8gMbyFtRb8geA
 LJMjrgwXVmPeZzVhNCEowHpFSBjOn1HXfGND1u6BxyYnCNlV5w8NFcgta.hF22JSZCkJGEhuKgB4
 I4gNZHdkrbnG86WRa_Qx1atdlOg9C4ClASlTTweZ7cNkQJ_BDZ9Daoi0jLn_gkMkgQ1OCFdY48Mi
 X7JUCgTd5ny7aa9g9dI60ws69n0IhpJD8u_nOy.Q7eVqnE.qSOfSvW0jFXrJvXp2O.ZdUHEW5l8.
 w9Avsz4f.XSE49SJ..8nVuo.cL9n11Tdug1k6NHvA_hCzGPHAlvlysakKD38G.TAbnrBEhjk43a3
 eKahZsGr8aB6Q4YpmVE73RQ1rH_XHVbPaRlidj6DTLI4DGdyqlPa7SUkDi.Jp82.4UPkSHbch_J9
 fsGj2n2qy9ANhKd2s05KGMRxopSTVEmoZESaS2keF.BlyIeRWO9uO6jra2lO.RmpNOOAuYwu23.O
 _kpOb520_pOes34iV4odhdQuCZLVQ1dAJI1OuTffsDh8g5aKbjk82HGfvPgHz7ftfdPSk42qyOx3
 VlIcJ.7qOeVI_xqaSDU4zyTFG0McGl2DG7q.XkhrrSIpXtKA3F6mZfdIjkvxh61tJR3tKbLC2rLX
 8QemaVJevLFzay6paJxgKozuVbyjm5BaX.sRxzcW6wu2L.5uTdry_7ujTZaKU
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: e0f91883-8b2d-450b-92a2-0f8c0068216c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 Jan 2025 07:20:18 +0000
Received: by hermes--production-ir2-c694d79d9-5hgbf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 98351194d8389ee219e41e6a43fd9fd3;
          Tue, 28 Jan 2025 06:09:23 +0000 (UTC)
Date: Tue, 28 Jan 2025 07:09:07 +0100
From: Jeremy Dean <deaner92@yahoo.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: markus.elfring@web.de, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: Remove unnecessary braces around single line statement
Message-ID: <Z5h0gwpIu4STLvqL@vmi2410184.contaboserver.net>
References: <Z5aMrXwnmEXxKWkC@vmi2410184.contaboserver.net>
 <452f118f-2a0d-4b54-9285-063ccbe6e5ab@web.de>
 <Z5f7BcSERmImx0_H@vmi2410184.contaboserver.net>
 <CABBYNZKxhq33FXEb_8LMLV4whhX0jc100tUPYCAs9t1q9_5MBA@mail.gmail.com>
 <Z5gAJboUiYtDWdSr@vmi2410184.contaboserver.net>
 <CABBYNZJKjVC0sb1pBY6bBxjYTiVn6b84kTEB0bHRtG3bZPMhWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZJKjVC0sb1pBY6bBxjYTiVn6b84kTEB0bHRtG3bZPMhWg@mail.gmail.com>
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Mon, Jan 27, 2025 at 05:02:22PM -0500, Luiz Augusto von Dentz wrote:
Luiz,
> Are referring to:
> 
> https://patchwork.kernel.org/project/bluetooth/patch/20250125165804.11486-1-deaner92@yahoo.com/?
> 
> Id just include the output of checkpatch and perhaps reword it to
> something like:
> 
> Bluetooth: Fix code style warning
I could not find a way to change the subject/title to remove the typo
in my first patch submision. For this reason I created a new patch
it can be found at the following link:

https://patchwork.kernel.org/project/bluetooth/patch/20250127221052.197899-2-deaner92@yahoo.com/

This submission is perferred because it removes the typo. 

The question remains: How do I close this patch submission?


Jeremy D C
