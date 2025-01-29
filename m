Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C61422A8
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738133044; cv=none; b=G4lidfVswnqIYjlG4JKKJLp4y8HuoIsow0yP9Gd92AUemIH7tGMRRX7cO8ga2+MYQX86h0I6vgVnvLS1zRqs0VXQnONI8+IFPuRuaeZghYl5nCs2hP0PbWCHwop8VglCciH/9ezPBjns9Uew/OOHEqPqWVPizvKYRZK8KWfbtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738133044; c=relaxed/simple;
	bh=iWTLO1RHDyFJagLDTJZiYe25Jc981v3Ve9KIS3aeugQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzpRKEbucOsNUTX9mj9JEV0+xwOcwpUbc2AXukz8d4H5M/YfMW4UkHv+Ez+MxA0JCdam3CsGHoCW13EasDRqZSRyzYaukKQOAtRCH9FAo8byJUn7uumHbHxrH8TSIzHFk3XK0P+d/zncbuZy+xh/75EUArNUjOHP6Q+/qDNe+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=C5vNGkQi; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="C5vNGkQi"
Received: from fpc (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7668A4076749;
	Wed, 29 Jan 2025 06:43:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7668A4076749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1738133037;
	bh=o0WhhKQK5SbU4/31ccMjwy+bKct36riywNMHVEheySM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5vNGkQig7vptVhg8Hz/ICZlPVXGs/huoh2L+I9aKN8OxxKku1ngtq9aWXOPkwd4i
	 fzhrwyyFRowrkCnnXQVyEqr7rVPay9jlkU/k7JQ/mfqYGOeVy0+x0k8Y5VMsEUlzwz
	 b4Hti1+usASPWbJBcmZuiCb7iNHe+90dC4KgpEDI=
Date: Wed, 29 Jan 2025 09:43:53 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH BlueZ 1/2] audio: actually try to enable MTU auto-tuning
Message-ID: <20250129-09f4ae92a480f899d9ab178f-pchelkin@ispras.ru>
References: <20250128210354.73732-1-pchelkin@ispras.ru>
 <CABBYNZJD8YGRtS9tKUAmAYfoarGmEeXhMJChGOQG8jma-rCiKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABBYNZJD8YGRtS9tKUAmAYfoarGmEeXhMJChGOQG8jma-rCiKQ@mail.gmail.com>

On Tue, 28. Jan 16:59, Luiz Augusto von Dentz wrote:
> > @@ -622,7 +623,7 @@ static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
> >                 return FALSE;
> >         }
> >
> > -       if (imtu)
> > +       if (imtu || auto_mtu)
> >                 l2o.imtu = imtu;
> 
> We might need to do some more special handling for auto_mtu, so in
> case it fail we retry with the default values instead.

Yep, a good point. And I see now it _might_ fail here for the kernels
without the corresponding patch.

> >  static gboolean l2cap_set(int sock, uint8_t src_type, int sec_level,
> > -                               uint16_t imtu, uint16_t omtu, uint8_t mode,
> > -                               int central, int flushable, uint32_t priority,
> > -                               GError **err)
> > +                               uint16_t imtu, uint16_t omtu, uint8_t auto_mtu,
> > +                               uint8_t mode, int central, int flushable,
> > +                               uint32_t priority, GError **err)
> >  {
> > -       if (imtu || omtu || mode) {
> > +       if (imtu || omtu || auto_mtu || mode) {
> >                 gboolean ret = FALSE;
> >
> >                 if (src_type == BDADDR_BREDR)
> > -                       ret = set_l2opts(sock, imtu, omtu, mode, err);
> > +                       ret = set_l2opts(sock, imtu, omtu, auto_mtu, mode, err);
> 
> Perhaps here we do:
> 
> if (ret && auto_mtu)
>   ret = set_l2opts(sock, imtu, omtu, false, mode, err);
> 
> Thoughts?

Agreed, trying the original default behavior will work with existing
kernels. I'll respin the series.

> 
> >                 else {
> > -                       if (imtu)
> > +                       if (imtu || auto_mtu)
> >                                 ret = set_le_imtu(sock, imtu, err);

Huh, the BT_RCVMTU case may also fail for L2CAP_MODE_EXT_FLOWCTL (that's
not something I'm prepared to reproduce though).

l2cap_chan_reconfigure() will reject a zero imtu. Worth adding some another
kernel patch or ECRED should not actually support MTU auto-tuning?
