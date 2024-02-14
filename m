Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138A41419A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952600; cv=none; b=aDB62wFt4yykUeUe/TPDllcNm6gFSpg5VPNfGCI3l43hu7yBUwpvnAgD3e2gBOgkGsVeaOWiSpHgqiTFIhKPCC/tpFN8RrrMnqdA0NqVDd+tn2tKokmmnyTInKdnXkS+gtpPXjMQc5fYyiDp0zspV7ga3JZ8EyXHDYDAcA8oFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952600; c=relaxed/simple;
	bh=thU1puzkf5xu90tYmibJ7iDxLXJpfyKugq5SN0EVHuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qljrw7csmv9Bepcn+UNJ5yEI9qyTi/Z6MCxJedhMDdPwxX4CX9gE9xuTMYedlYriL6QAJM8f69L6L918OTFqxdRToygotyN06PmWY80waS1aq+TnK3aP+K0RrLyLJ+507vKe4VJUDu9Nc86Ii92W+o2mM6l8J4Kv/zn6z0DLDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA7xolbc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA7xolbc"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso303705276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 15:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707952598; x=1708557398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=thU1puzkf5xu90tYmibJ7iDxLXJpfyKugq5SN0EVHuY=;
        b=aA7xolbcSlCNRZcpmc/xKqB7RQp0KOPwCPez1KjRsxxSFwSKxR+z5V5TsNX8tsqHcd
         upn+bUmPx3Q8cknVn4Db44KBedyom+hesb3VFhJ5jhZxS8pWjuCvxtIy2FGQQC3vh2d1
         Kwl4PIaYBvjRYr8enKbKxSeRmYLnPljGqksKJ7oHfCVRGIbjugTmu01wyNr/J9w+YjKj
         XWBnvl9TfdxYWjwaSrwDdnrEFwRXmO4YDXHjqLq/bJl3cXPfhtyeQOAwN2aNqMw0cZTL
         DHGD2Kb3qn0TUXzsCG6cmYI1CLM9X4desIS8Yo58j6AhI7dtpV/0/MUUkH1IxOu4437G
         3lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952598; x=1708557398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thU1puzkf5xu90tYmibJ7iDxLXJpfyKugq5SN0EVHuY=;
        b=c7Kva80vm+NUOKIp/96HPqGe1huACM6ms0SC09M3A6RLgcyZniZ2NI66dAJvsZNF/w
         m9LuSFx7pygyDPrbCWOGIhljBGAiI8Pyl6oDClsed5/njkGMcWjdDaMLu+/2HiUQfW9Z
         nU+5f2HO45DGXD1HFkCQIKZsO2JUKm1U7GPwpTLaPrAi8LBBnvgw0sRBBT/X/+vvuzSN
         Skq0Z4AtiNAYpQ6obumcl7ldzpEdy+9AgOx1kyIae6OhJSku1kaDu+iX/aZdo+upF9JY
         3+7e1OZDY0GhghQqRqOmJ25kUec1o7g2P7iPmA4m28H2WmI84c8Vy28619PM/dxU4arY
         EOAw==
X-Gm-Message-State: AOJu0YyaYugY1x0++2nshodrI2fG4mCaiuGz1hTDZnu+feXe22mI+TXJ
	vQHIGkIzVM3/Nx//CWfpuf2UlJoAt981kM12jN2Fg3J68SoHc5XLVjDUzG/ZVhIJYVVUCf9y/Zo
	DLDBwBQB9I6YQBf+Eb47ZGQRtQY+FGQX2ERU=
X-Google-Smtp-Source: AGHT+IFMr8LytqwZoyD9jVIubn2Ht3c6xuKBc4KYSPqRmvpb+sshxCvLkzvVR4WXqrWGPok3sxFGav+WWI8F2DnbUSw=
X-Received: by 2002:a25:c8c1:0:b0:dc6:c670:c957 with SMTP id
 y184-20020a25c8c1000000b00dc6c670c957mr2570457ybf.32.1707952597906; Wed, 14
 Feb 2024 15:16:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACvgo50dSAw_L3uC7WST_+9ixMWLBdfVJc8cQNQNZ48dWdUijw@mail.gmail.com>
 <CABBYNZLrg=gYTuzB=u60_AJPSQ6YVs87u1s47fjD6v7S45M3GA@mail.gmail.com>
 <CACvgo519JTmp1B4pMGJzHyeVsKzBxyC9ODqq9SFmcxspEX7_yg@mail.gmail.com>
 <CABBYNZLkJziPw-_pdmpHWzf9Xi3EcWsZ2SLiLo0PtctkqW92pg@mail.gmail.com>
 <CACvgo52uHwf-0UZbdNWukAvjnNFTvrYTY=f4Yx1raYQjmVyUzQ@mail.gmail.com> <CABBYNZLe6R0T90SkOqVyBpwO4p0ZgeR0=jyBtyAcoQvKX9YwWQ@mail.gmail.com>
In-Reply-To: <CABBYNZLe6R0T90SkOqVyBpwO4p0ZgeR0=jyBtyAcoQvKX9YwWQ@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 14 Feb 2024 23:16:26 +0000
Message-ID: <CACvgo5288FAUjR_b0RtfD_qu4D5uzNKn8OVh8ko35O4ELfp_Vg@mail.gmail.com>
Subject: Re: Re: [PATCH BlueZ v2 00/10] Distribution inspired fixes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

On Wed, 14 Feb 2024 at 21:31, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

[snip]

> > >
> > > --with-phonebook=tracker
> > >
> > > It does seem to work,
> >
> > I think you meant to say s/work/is allowed/ :-) Commit "obex: remove
> > phonebook tracker backend" bans this as an option.
>
> Hmm, I don't have anything like that on git log, do you have the actual hash?
>

It hasn't been merged yet - it is 7/10 of the series.

[snip]

>
> For messages I guess you are right, we can just remove them since they
> were never really used, but at least the phonebook-ebook was used at
> some point, so perhaps we just switch to use it by default, so we can
> remove the backend options, etc.
>

Just double-checking:
Your proposal is to implicitly and unconditionally enable
--with-phonebook=ebook, remove the configure option alongside the
other phonebook-dummy.c backend?
Overall I like the idea of having fewer knobs to manage and things
that could go wrong.

Looking at libebook, I'm not 100% sure it's a wise move though ...
 - size: indirectly pulls well over 60 libraries - blkid, brotli,
camel, gpg, krb5, lzma, libsecret, libsoup, sqlite, nss, tpm2-tss,
nspr, libnghttp2, libpsl
 - users: cannot find anyone outside of Gnome circle - KDE, XFCE,
elementary, etc nothing
 - functionality: the dummy backend produces simple vcf files,
supported by a wide range of tools

As a selfish example, switching to libebook will force extra ~200MiB
worth of packages, while simultaneously removing the vcf/VCard
support.

Ignoring my choice of DE and distribution, I am not sure that
quadrupling the dependencies is a good idea - currently obexd pulls
~20, with the proposal we're looking at over 80. Since the obex daemon
can receive potentially malicious data and with so many dependencies
the word "honeypot" comes to mind.

Just earlier today, a distribution maintainer highlighted something
interesting. Overall when managing/packaging/shipping software one
should consider a) the overall number of package/library dependencies
and b) how often they are hit by CVEs.
I'm grossly paraphrasing, only part of what they said but I think the
message is clear.

With that in mind, I would prefer if (lib)ebook is not the default.

Thanks
Emil
