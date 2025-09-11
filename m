Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8522C21EA
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622775; cv=none; b=LVidBOnx2R2Bbr8ty3jfe0b4bAqzkcPd3VNW1zcidPh5fdNiGArqCQs65hoqLH1kPici5zSoBxi01YpAKqh+gPg/jNALPubuJra1RTRkhQrg61Aa6F7xnoLbe4UKSu4ylzYRhBwmU5f5ZDV9X/ULK+P+QygwScCV1LdaiLahZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622775; c=relaxed/simple;
	bh=0BSekf1PSCGDmYkvLr1Q1FZhKOj2WBDaZSLY+1kpPBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1Rdd8ytAjeqf+IUUZa2Y5I2w5fkH7AE8r9s15Uxqn4fLOVP+qvfUDUJMWf2bCk6/oD3yyHpOAlARRe1esSUaF4iHZ1q5xHqd1t+wylgx+T1RIEDbzg9xmFfIkAsmbGoCchks1ZXbGfDyPuBEXG9TIfEp/d6Z1MvUmddfPzT18s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3gMXget; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3gMXget"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-336dc57f562so10280161fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757622771; x=1758227571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BSekf1PSCGDmYkvLr1Q1FZhKOj2WBDaZSLY+1kpPBU=;
        b=h3gMXgetl9q6aWGXwmKpn/MGcxvQwHGonQPuFMXPZMW7XZIKC/4OFz8spmMpZ+n07D
         geEchEbWg27ZyINg5lzPNwR+77M5hKHedbI0D/1qgyxo7X1M1me3t4aDbEwH/bvdMiwx
         PlrXnGh5SyWn7EYOPpsoatVh3LoAGkMYi0jmPytyrCb3QMf0KHyNgClunMUoVPBETyTe
         ly3yytTAIoG2hx/u1YFpdVQIYGzMC+sXSyswOpzYi93nAkhkhlgHi/E6OOQQNc+IqwKs
         l6V2Sh4Gm+VzAIwLlw0uBktLHJZq8Lq5gdP89aVgII0KVzg5SEFgASO9hl3gd04IWywA
         wKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757622771; x=1758227571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BSekf1PSCGDmYkvLr1Q1FZhKOj2WBDaZSLY+1kpPBU=;
        b=vp0oyTMThiTdDOZVYSKelEQMW0te+pKBdSM9i4oQocT1Vu6pGyC3NyuedUY9/vrAfc
         E/NR33W7QDi50ajr2fTres+9AYX1TWJs99DFSADJ9ishAihccXzMk45XeIXVAXl0RzWI
         lzRoJq4DbA90JmMOtACDObLNxyXzWFWqRD3MN/LGG+Xv+14Emjfh2E/vyR9KSOSJ2Z71
         x7FXj6xBYzfC1jySbvmKZzoa00GTBJSkhVa0OPy8d+0yCm0lctrB/ERz5Rw0APONo1Od
         B03xmw5WN2hSytM/SMxdUkKHcKsXeUTtmrQc3Mm1MMMOWGsZOzZDd5uD52lqCj2bQLyC
         2S4A==
X-Forwarded-Encrypted: i=1; AJvYcCV62FjWhCkyxtW0an6wv6O3baRWEVj7BBIopXcob96f6Xx5DzWjweRtF3atCZDMwIB2g1Tzg0eoI2YNKc0+sws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIhmOh6SmeFzt1Ab0M6RbskQX/cAyhbin4t270EZ4aENkiWTR
	B2Jqx5vWBod/ZQzYwk19lcJyH6NYBwRdMz+B4DS5ZcktsEBEqFXA9X80uovGfD8/PvHJo+MdK98
	dXbDbJ3Gm0Rh+EX5hwZP0YT50Mcot7QDPxLEy
X-Gm-Gg: ASbGncue0pt36IhU+/Hm8mwyhLg2zlrxyuLnZWijIOEegyq7lVFihqIX5qzYVuJkYJg
	fEi7+K6z1jorbHBoqvqXHELo5If9yt+TjXA18lVm49i8EZnZRaLgPdgPttruj0AV+ZR23MObdqi
	Q5JTdIDtla1UJMcd9Qm11BaSPWXSbhqC/TMsWSnz6nf58OGYymTCeNTtUDm+I0V1BIXvoiQ4qVK
	6T5EESAsg3tXXQOfXj4M1p4C56PBJihqywJrQq+pfrJLFX4TpIN32iZvK5+Wy1GdTs=
X-Google-Smtp-Source: AGHT+IGhdukz1D1N5ZgPIRqwsa6WNonQyyhxAY/7xAllbzBn+GaYsN6TNSZZIR+aS3VtIBfJXWJTrgkiXxRKBwB4p54=
X-Received: by 2002:a05:651c:4347:10b0:336:cf86:d405 with SMTP id
 38308e7fff4ca-351197b209dmr1236271fa.18.1757622771068; Thu, 11 Sep 2025
 13:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911135301.1538126-1-pwaago@cisco.com> <CABBYNZLBJ_Q6S+OGam-Q92Agbe0HK5dX4WxFrFpnntcDhu1gow@mail.gmail.com>
 <PH0PR11MB5596318A1EFBC5DF72C41D5CCF09A@PH0PR11MB5596.namprd11.prod.outlook.com>
 <CABBYNZ+==BYte8=C5jLwDrMs-GJkvOOxAXRMPO2Zv=2zxk8C2Q@mail.gmail.com> <PH0PR11MB5596133842B1D4C387EB2486CF09A@PH0PR11MB5596.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5596133842B1D4C387EB2486CF09A@PH0PR11MB5596.namprd11.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Sep 2025 16:32:37 -0400
X-Gm-Features: Ac12FXzrzwHtqMvxIKBRK76jYVAiOYF4sh-gWHQEu8k1_Mn5ZG-5WMHdnaOlA_E
Message-ID: <CABBYNZ+VuP2Z5WP78xsu4vpyhnQedxnchjyP8rcc2unnnOX6Sg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio: Add support for specific error codes for
 A2DP configuration
To: "Per Waago (pwaago)" <pwaago@cisco.com>
Cc: Pauli Virtanen <pav@iki.fi>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Per,

On Thu, Sep 11, 2025 at 3:56=E2=80=AFPM Per Waago (pwaago) <pwaago@cisco.co=
m> wrote:
>
>
>
>
> > ________________________________________
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Thursday, September 11, 2025 17:52
> > To: Per Waago (pwaago)
> > Cc: Pauli Virtanen; linux-bluetooth@vger.kernel.org
> > Subject: Re: [PATCH BlueZ] audio: Add support for specific error codes =
for A2DP configuration
> >
> > Hi Per,
> >
> > On Thu, Sep 11, 2025 at 11:12=E2=80=AFAM Per Waago (pwaago) <pwaago@cis=
co.com> wrote:
> > >
> > > Hi Luiz, thanks for reviewing.
> > >
> > > > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > > Sent: Thursday, September 11, 2025 16:43
> > > > To: Per Waago (pwaago); Pauli Virtanen
> > > > Cc: linux-bluetooth@vger.kernel.org
> > > > Subject: Re: [PATCH BlueZ] audio: Add support for specific error co=
des for A2DP > configuration
> > > >
> > > > Hi Per,
> > > >
> > > > On Thu, Sep 11, 2025 at 9:56=E2=80=AFAM Per Waag=C3=B8 <pwaago@cisc=
o.com> wrote:
> > > > >
> > > > > The A2DP specification defines error codes that shall be used if
> > > > > the codec capabilities contain improper settings. This change all=
ows
> > > > > clients to trigger the sending of these specific error codes by
> > > > > returning the corresponding error messages from
> > > > > MediaEndpoint1.SetConfiguration.
> > > > >
> > > > > This update is fully backwards compatible: clients passing other =
error
> > > > > messages will continue to receive the default error code as befor=
e. On
> > > > > older BlueZ versions, these new errors will also result in the de=
fault
> > > > > error code, enabling clients to implement support for the new err=
ors
> > > > > without breaking compatibility.
> > > >
> > > > While I can see the value for debugging I doubt we could do any
> > > > handling of these errors, so the result would be the same regardles=
s
> > > > of what error is sent back it is not recoverable.
> > > >
> > >
> > > The main motivation for adding them is to be able to pass the
> > > mandatory qualification tests, which now checks the errors codes
> > > returned from SetConfiguration in detail. I don't think they are very
> > > useful otherwise.
> > >
> > > The errors are specified in table 5.5 in the A2DP spec:
> > > > https://www.bluetooth.com/specifications/specs/html/?src=3Da2dp_v1-=
4-1_1752513648/A2DP_v1.4.1/o> ut/en/index-en.html#UUID-0ba19ee9-7277-1068-d=
2dc-b9e638cca568_Table_5.5
> > >
> > > I included all of them for completeness. In that table, it is also st=
ated
> > > which codecs they apply to. Some are SBC-specific, some apply to all =
codecs or
> > > other codecs.
> >
> > Ok this is very annoying if PTS suddenly adds a new test case that
> > checks error codes that otherwise are only useful for debugging. I'd
> > say that it probably needs a configuration entry to skip these tests,
> > btw this seems to be introduced in 1.4.1:
> >
> > https://www.bluetooth.com/specifications/specs/html/?src=3Da2dp_v1-4-1_=
1752513648/A2DP_v1.4.1/o> ut/en/index-en.html#UUID-05a1c924-2070-eb38-c2cc-=
a9ffa178bdb9
> >
> > BlueZ SDP record is still 1.4 (a2dp_ver =3D 0x0104), it seems 1.4.1 is
> > an errata only change but that introduces new error codes which is
> > really intrusive to say the least.really intrusive to say the least.
>
> I have tried to read the specs in some more detail now. It seems the erro=
r
> codes themselves have been there all the time. The errata that was incorp=
orated
> in 1.4.1 actually eases the requirements a bit, so the spec now says
> that these error codes shall be returned if error codes from GAVDP or AVD=
TP
> aren't used. So the way I interpret it, returning AVDTP_UNSUPPORTED_CONFI=
GURAION
> could be ok according to 1.4.1.

Indeed it says 'are not rejected with error codes specified by GAVDTP or AV=
DTP:

'If the Codec Specific Information Elements include improper settings
and are not rejected with the error codes specified by GAVDP [3] or
AVDTP [4], then an applicable error code from the list in Table 5.5
shall be returned.'

So why it was failing if we returned AVDTP_UNSUPPORTED_CONFIGURATION,
that should still be valid according to the above AVDTP error codes
are still valid.

--=20
Luiz Augusto von Dentz
