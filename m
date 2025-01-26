Received: from sonic304-10.consmr.mail.bf2.yahoo.com (sonic304-10.consmr.mail.bf2.yahoo.com [74.6.128.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F0156C74
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737921493; cv=none; b=d0kATi9WNAAZqjqzRKORDmwnsytmSV7jbcOc7/ZbIbgYFI3pTpfk6ub6sY8VMimaUUFtQCXjrUikl0LW0vYzqgLRvXNmM/OSR6fdUfC1P0TgkG71ip2JnXQItJzehsg3rVEsdSMHCKoZ7Tenrrcob5dn5UaXIr3Vq7XcNRybUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737921493; c=relaxed/simple;
	bh=uVcpo1bk2yEzaWZpSDhxgFEK5nb/IUwNcZSGVlz8Zrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp240R5JGDdMgbwdcX22O/4ibBFJ/lq71CEcXr/F8v05KJL8vzW+TmXyK5E7Q+dQxSLCOmZWq1eBC1iYvTAWIDG6I73FpUi0whznCE8U0oqxiL49tSv5C8bPYiLRZaCVyDlf2rCRcsYQfbrbktc6MhtYjtdCgTC+KqxjhJGsai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NOlRXOJ9; arc=none smtp.client-ip=74.6.128.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NOlRXOJ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737921490; bh=esnEHYbr+tA6Hk36266Ao3jle9+dwUmdzcUBmbXjGoA=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=NOlRXOJ9h0AwqxUIc/wfQYuCtoMnOzOz0I5Mo+a3+76qeKhO5ODnA96644h+/xUOZe7o1liIzpSA2yqwLxiFsggZm7CWRm77iiFFQ1jsvJoJRBESXhP1NLPeOLNTXFrn8qQFPQnnmeqmaIO0Dw8cCVamduZw4FdEURIxX/2vU9yByvr47dvxe+0gIpbm5Hoh9LzWE9X2ABid1CvHbqtWwc8QZqmOY352e0PWyU/OgMRcqaHiGCjwYiEQQP54s2lqk/N1wsKOk2XS1Cw7Ad8QZnMLH1mQ5njbYVH4+wqBVllq5SAoGnpFzwVEAIF5R1M79wC5VwsmD/1BCmpv9c7AjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737921490; bh=zcqo8a7DlklIGWB26F2DVsetRoLVByb6RSKx/rorUIl=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=k61/MkcVcBh1wRQxJbv7GozsJtDGQEflYrwa8rLqE+jhmuyvD0z4PF+cqclyP0DxTmXX+CM2kd1JfKmUePhAo3W+4Czji4Blo9wA8REqLWMBvohbwvlylWUS2HIIwOCmuwMDUkKskQQJaX/WH6X2z+lHCcUuEsKXXtJGx3xh10dPxHG5lZt2He922ZAnooKO4ReA6b7AMjEYfYexdwbN4OpX84spVIBPMoyvz7qigTE4mVaQpPpwNKyf+HPsS+8CDX2wiMiSapfNVnPl23MSDP6bMLelW02/oP7WaGoBYstA0+6NUtHOkhSMFgmYxMcYN2swRwafZ6QBexTcQh0zZg==
X-YMail-OSG: 60mDLPUVM1kyH6hLI7tOY5VXYJe300OZNwB6p0pH22pbFWcx6qxp3.QeuI4yC8e
 vI.J9bsr7E0W6EKOSUuXqCQFZtdjQ_Ez.rsj4f15emMIWStJdBrZ32puTXXd82GaPRqy9vsHFKi9
 vsS2g2BlWQiapBjC7U25zE6gFgi2NdJFOuXNUuBEDRuhTAX1Vphl2XGphIEVaoOfAFIAj2JG7Org
 sPE_qVDfl9bYQabUu6BcgNw9_vw_q.O6DI3B..IrEOKtUNps.M9QwDYUrKbqwIFVUOs4jGNgJYL6
 321izCbtBsMyWUn8yqGC.6HElZ1BUjI.B93k8a0B_OceCZrnf19oRYwxA5jC5y1m42JgbFMywXfK
 z.zMLbIhzpv3EkA0VntmKgKkZ_KEHFQ4aGWlolW4CFnACFZfx1uPbXuuCagRXBuDjdKaHgIwHMnT
 Lxcyo_bK8DKPH78XokorDAHvlOC1zVwq1TSGBWNIxcD1rqEd6_N209Df8m_gv_1_BVqJ2h6dJvvq
 .CcYnwqB4azyxn22Oo6YoHjS2DHOlVKtNzh.Hgn4p7AvN5kXMBWYj6qyyLyWsEv9uAxQbh.8t9f7
 L4SyYrP55sCCSMOADhtQGQ062rtVwitZn0jAuFYL46ayd48DY3AjoHj65gRhcZFeJF.7ag9d4.Tv
 aARcwQ6lUOEBYpac2ZNU4C2Nr22V4Tu5x3ibI_CYjEihJqCAhLNLyTE8XCCUtg8juLrOlF8wnHLH
 x4o_vEqoNLdSsmu50QTmf8TuGX1ZAEPija67D2utJ4fbaNdHuaj0LfODdbNdDaqU.Ep6HvAen8C.
 Eiu0pisMUNsGbl4PdJv7cCf10tRbzrFuKkAEDS85_QqHeZbU196x0mG8Zj9NMzIMcdpyRYJlvxuL
 iJH48SI8rJ9vZWo70XnlJzLx_bo1BTNdR63fXgPxTc.qEK_RrNUSjeEvxdj8frAChiMoPKHI1PTV
 MmoUX4Y83C1Fgfyzmhq6AxYjpjcd50X2Uxd7kDka4JM4z16XySllmhq22E.nKxQDvkvq8W_C9kPD
 svAQbG5.l8_UmT7uKFALQNR0P_gF9rs4rShNq0E4Bi0wxIKBYE6PrdRc9a9zQurX4ISNMgHkFc8I
 xE0Vx3lEWqOwd7I3yPsCe1je3DCQIshunbzQJFPQh02Vvp5oIrG2fYfop5TMPiSXlwnt1L7v_Vpb
 c_0KHB43kQJI5t46vY35KoLrWvHQmifrPlFIXtXWk8M5YISm7W6S7ax6pJB8QFy4mjmjmo6l9tmu
 kQIpyElwG7fj4kekMfFsbPJishLck9maDMvv27HLvtG9oMyqGbJ9PfLGQ7uQWJqixdMu.aiyp_6W
 YiB31ygkEv.oyX1ZAFF.CbaZFJaTjWDpIqTEr47XRceWA1QF1RLLl5i5WS1ty8HtBUiNTpKUIpMv
 KDg7jXpSsoOiHqnXasqOz4hzqVZEve_twVtnnmCsn2.7UtBoDAX8p6.NKJcY9weUHAgs7XfMl.I_
 xWwg5xTLHDmUlZMVEuGy_.X9ArJr8d.1XsA123QSOi3qHgAzwEagCMDKJK.naV9ELJ9H0CM76_8x
 nlgRsFTJvrm152q0FVs7omnhxEz4o5w_99qImg4I7HtS_b8hJcXWArmc50pS0dJp6aLe8u2WKM15
 dP3CbdvegAG9q8C1Y9o9Fv_mciRquwnm9KocrAphxkZuOLeo0V.yqU1nfJOjpFbsKUrf1g3QM5WK
 Ogl.xh8Z5RpqbVXEJ.LwkmtogayWKQgGBkrbT4CWXuB1UNRZzmKobz.CGVFgBWXIYfbOb_ENmUq2
 pi.rAVExX2odEE6r.SsbDeufxHVJANlWL2Od03VdJymMtdVf6MyUqzvh.urOa24uTzoy05pJ5F5D
 PDbOQVRQVE2baU0mM._gm6hr5RHshTS_X3OGQ7bprt.C8Hs9PQFr67rh4nLYfp2MmbGxrFkhhbQZ
 La6f0rucxEnLTDHFu4wcdZDWkGboUCpONi4lUCpdaGfoWScobiGzjQqy8W8rlZSMmLkUDT5zsLXS
 x2nBJ7xURud3nl2VCz7frHCM8KgT_a0PNFT.h3MeZ7kgKpGh13hQ3hsZVk6Ds8rbuO9J.mlDkHos
 XSJxjK92HAAR2LYAjG9tmqGTB9ZxIbh_tWz15an7IaOXsKpcZbSgI1zo3ziE08zHKeC_0G8VmdAn
 I3_SvQ8FEZXa9Jh1dlllYYFquWGpzXFugic7Jf4G7v1On3VZgOZfLrHazgXzpF1a3M59vUqkCgxV
 wdFOXWw2IryWG_tPooT5_IfSPzpHuQggWyhir3Fmd4DB1XPkehahFm3h9
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: fe6c9231-8238-4bb7-81e4-337ae316a0ef
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Sun, 26 Jan 2025 19:58:10 +0000
Received: by hermes--production-ir2-c694d79d9-5hgbf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 121b8431dc09d07e9bd18937baffc388;
          Sun, 26 Jan 2025 19:27:44 +0000 (UTC)
Date: Sun, 26 Jan 2025 20:27:41 +0100
From: Jeremy Dean <deaner92@yahoo.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unnecessary braces around single line
 statement
Message-ID: <Z5aMrXwnmEXxKWkC@vmi2410184.contaboserver.net>
References: <20250125165804.11486-1-deaner92.ref@yahoo.com>
 <20250125165804.11486-1-deaner92@yahoo.com>
 <62d9db39-5d2b-4980-99e5-f15c4555b57f@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62d9db39-5d2b-4980-99e5-f15c4555b57f@molgen.mpg.de>
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Dear Paul,

I have changed the subject. 

Fixes: Coding style, unnecessary braces

On Sun, Jan 26, 2025 at 09:02:04AM +0100, Paul Menzel wrote:
> Dear Jeremy,
> 
> 
> Thank you for your patch. Could you please make the summary/title a
> statement, and remove the dot/period at the end:
> 
> Bluetooth: Remove unnecessary braces around single line statement
> 
> Am 25.01.25 um 17:58 schrieb deaner92@yahoo.com:
> > From: Jeremy Clifton <deaner92@yahoo.com>
> > 
> > Warning found with checkpatch.pl script. Removed unnecessary braces.
> 
> I’d use imperative mood for the second sentence:
> 
> Remove unnecessary braces.
> 
> Also please add a Fixes: tag.
> 
> > Signed-off-by: Jeremy Clifton <deaner92@yahoo.com>
> > ---
> >   drivers/bluetooth/bfusb.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> > index cab93935cc7f..0d6ad50da046 100644
> > --- a/drivers/bluetooth/bfusb.c
> > +++ b/drivers/bluetooth/bfusb.c
> > @@ -365,9 +365,8 @@ static void bfusb_rx_complete(struct urb *urb)
> >   			buf   += 3;
> >   		}
> > -		if (count < len) {
> > +		if (count < len)
> >   			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
> > -		}
> >   		if ((hdr & 0xe1) == 0xc1)
> >   			bfusb_recv_block(data, hdr, buf, len);
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
