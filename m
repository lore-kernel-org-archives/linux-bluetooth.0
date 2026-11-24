Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795533645;
	b=ye2LvrYAlPHcWCvDa6LlPNQON+4A+mh01AJ2uK7tuBCBs5j/8rGsZg0VqnB4gpmQRvxN
	 sF0wz5udcNEeopJ058pp4J7oQcQSjfkHoesGl2NimgAEfr5pnJ+Yn5i4vATs8T2xZZtWt
	 l0Jl4xYIF0YHaZB5Iw7XhMFvsOaN5VRM1gI7I38pM92LSSxQN85UJcO1bkBKTor5JJ1oX
	 4RNWn8BNNdHoM1cRziQCkm2M267vI7Cdb1QuGgDuoeyQ8Lxj4F2xkali2fWMB0+qMIea5
	 Sdl+vvsqXSLTuOpOzuuZCU0uz+t8dEDhJetlTEKG0/DiuAu5+V6U6iaOxCLsiW640hA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9o5z9ynSh62lZy+tzi0Ll5SycpVaykB/mbkJ1yNVL30=;
	b=jCR+0wTNOuDCzJAqas7EZloJcfeOLylGuvxx+zlC19VmgUAm3nw5z+oujLhOPIbAB3fw
	 kFpsIUfdCZEFM/5Si6dzdT2a5DP7gcneaK/FvvWgQbdE2DdRSLoSCQj2OMsITk4lY+ntv
	 FOmSethsrJT+xm9r5+hsP891y31/uj0wyXcANDNBohI5A1R5if7XHYEF7j6xvVxskKX1T
	 k0Mc4Yi1Aau0Pv1CyqHR9iJoCQLI68Zhb+ucEXV9E5fh2fuLac2YS0yxPa5NJIbFQi9Mm
	 mXIHeB+VtM49A2H3wd8w8hbl8UIB0hWxZ2tI8UZ+8vw1CrHNL/cWitSjPRYfKA84D4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p9bI8dGU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0A606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9D0A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p9bI8dGU
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67990a45e02so4724410d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:20:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795533644; cv=none;
        d=google.com; s=arc-20260327;
        b=ZOKPt9PgvST8Ds09pVZvj/R3pdwml+N8ShdM8wknCp8JME9eTvKCHZs/E1brZ9NONO
         l/V0qo1CbmEOM1Vu2fZyCdOsK4ukfwagFIPDqIj2teAlW8hoQfEP5tKucRpgcIQ5jB0q
         PJ4569/EjBRtjxC9QCBFPrX0LIihoPEvNIV7sBEQ0Bs2Hge0j2QdeOlMifToYyXhduC/
         cQCItgDB+cgtTQnoNExWHt/rVu+p2pdhRp3ewa10cOQhzvncyYf9H8ufmP/ch0fiUhNA
         P/rQH7MvCICzdSYLNkhGimvYhdH5ah12aaOFl4Pw810FVlbP9uivQfTeXIqZ8BpvE/2m
         CZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9o5z9ynSh62lZy+tzi0Ll5SycpVaykB/mbkJ1yNVL30=;
        fh=dTzD+sIqnwBkIcVZ80uGkoLsiNeeBlhM/8JkiCbQjww=;
        b=KJMPuJi+bqzucG1ke8rchbeMwVJzN8VqJCeWARhnt8AhIGvaUVNfqoXcQorXPFjCOP
         tn0JfGESr8dB/jlrVv3XE4JNTMmEQxg6BtfWQynZl7GrrLtwhRF4YL5G5W0hP1jD92+S
         tmtnzcuUMVpsOuOahNrboad50v2Eml7b1JtE+SpOaIY96NBX4hWsFI+wtGPNoAQ6ou0z
         g1pCSKf6sVhzIh0lZ1ONnHpuL2Ow3AdfnUfmrscXEPfyG6uZ4cyF9oycLqmgpZYsrBNo
         TnxlWf86MNXCuHaGoUNWTSY9wfk7rnSl/BW3H5K136RzxJ5r/sRNTMu2Vmefd0s7/3xr
         TCmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795533644; x=1796138444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9o5z9ynSh62lZy+tzi0Ll5SycpVaykB/mbkJ1yNVL30=;
        b=p9bI8dGUlqa1TR0QaCz5qk7oCpsEtHRA+LIBwV4SgcMVr6SRpnWXoaHt2m5IIy00St
         Xrx2a+x+SG6masNNqhy/6klnGjVQk5r8DvQMDl3iRA3n6WItS4QpDFThV4DXEXKohISJ
         GHcxob/s0c0AZmMpCGQOtslSHLEd7QvIJY4TPPZPPSTH7tKBNnIDJSKzuif04S0OlHaQ
         M4ENIaEHGUlaCcvEBkcTO12RVM8qL67rfM/q76ZoYuTZxtzWmFdBoXWOxAtajhwyxi5O
         dWnNa7+T75Il3/kTKEbLJB2xyM2w8VsgeAZrWz6AafsFA/iKG2Ut3MhlBZBBAn1tcldi
         C11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795533644; x=1796138444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9o5z9ynSh62lZy+tzi0Ll5SycpVaykB/mbkJ1yNVL30=;
        b=c6KVirvfQKp3odrGcf/MVBGiAlBEvHHnUvbN8W3ntTX8R6+C2dZt6KAfsw1UipbkS5
         opGG7FkVvW9r61ejTbX1nJLeluKK8QdHUBYgqb3bpSUlIolmZwiiKNmKVv244swFs/QI
         P8CXztjA1T8oxWJ0yi0SOSTsnxbgSOHOSq8JEJZv1HINWnwwYfzJWMb3henD9L6S2Wyy
         4iNy+ZxPCgDavZVVBOu3KQmgYMIyPW4ppgkkvqnYJmSPBH3eB7Y338S/18RspV5BF9+Q
         KLcKhGjPxIyAvbHjGX/sZzer/jQxCyJxqkexGxulGWgV1T05FmP0c4F339lG+TAWfb6L
         6JpA==
X-Gm-Message-State: APuU4Z83vPu93R5oh/mt8zSGRRAHFV0P17jywLhBtZLd6mgBtEjGyLH4
	OKD+lCPzsDshtP1TGKcw1QKlfSrzqwcFf5NIygDF9aB9G4eJ/I1joE1SNo8KmplX4bED56Moj51
	LDuHSY+HoizU68d1g5b2Dm4vzNoE7VRk=
X-Gm-Gg: AZFdTZd1WTN2+HW1VLgN4GsFXGZY7DMeCg+y9+QFd8FIWY+gglnZU6NhGgSkTupbn7u
	+m8q6nWJUnk+Oehf/UxzzxZShz6OS1BtO/SlTctqjEw7iJGXv6/S7Xqcd1bwRwr6fAnohATX7cj
	37sM3XKrBHt5ngu1Pm8AdEVKDn72AhGSH+wiK/ZJy9nEGL6lgRG/FvIKE0JuWopsFcRM32nhITT
	Dwq5Ud+W/9q0RGui9qnqAESW/EfBl9wPfD36tVgiviSIj1+OB9NKfim8oicromp1HKUbfOOxyCy
	CNEFLyszb4DpdP9x0ad2/IEzQK3yAoyGeOVrMm25N4L3UnH1eL6j60doKzRtOh6r3YQKmE0FgJX
	psoDxNVH4Z+lZsXS5NBpNXW3KNveu/2YxwjToOX+FSNiZu6L1QBp+24GVReN2JemhP2EloI35no
	mL30NYSLUsirN/VbdgVCMyO+LjNVchCJ+cnrbj0t5OwuDFc6yyH6sRWoYJ
X-Received: by 2002:a05:690e:4790:10b0:67d:a6fc:6bb5 with SMTP id
 956f58d0204a3-67df44405bfmr4581791d50.57.1795533643649; Tue, 24 Nov 2026
 07:20:43 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
 <20261122-tr_arm64-v1-2-4eccf35daeca@oss.qualcomm.com> <edb6288e11cf9eab058cada5151c0c071587eb3e.camel@iki.fi>
 <249d8212-f68a-4eee-b92c-efb339dd9de4@oss.qualcomm.com> <CABBYNZ+-8kb2wA4fd5oYq=_hi9BSfFwie-RSpsZdVbCM57qCUQ@mail.gmail.com>
 <eb42aa05-3065-446e-b257-b08477e04c6f@oss.qualcomm.com>
In-Reply-To: <eb42aa05-3065-446e-b257-b08477e04c6f@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Nov 2026 10:20:32 -0500
X-Gm-Features: Aa3M54qA0J0XoJryHHTVXfTjl4FFiFRAPoS3H1MgHgfnpPUyTjb1kXejGRWEJcw
Message-ID: <CABBYNZJbEbXWVocnyvr2_Yb46xC9_1vJv2tULuZ4sFWu4SRjiw@mail.gmail.com>
Subject: Re: [PATCH bluez 2/3] tools/test-runner: Support running on arm64 hosts
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Mon, Nov 23, 2026 at 9:57=E2=80=AFPM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> On 11/23/2026 10:45 PM, Luiz Augusto von Dentz wrote:
> >>> Should it actually determine whether to run qemu x86 vs aarch based o=
n
> >>> what the kernel image is, and not the host system this is compiled fo=
r?
> >> I don't think so. Choosing at build time is correct and simpler than
> >> at runtime:
> >>
> >> 1) The guest shares the host rootfs and runs the host binaries, with
> >>  test-runner itself as init, so guest arch =3D=3D host arch =3D=3D the=
 arch
> >>  test-runner is built for, namely, the build arch decides both the
> >>  host and guest arch.
> >>
> >> 2) Kernel images come in many formats (bzImage, vmlinux, Image,
> >>  Image.gz, ...), so detecting the arch at runtime would add more
> >>  logic than it is worth, while QEMU for a given arch already parses
> >>  its formats with -kernel.
> > I guess that is a fair point: the tools binaries would have to be
> > built for the same arch of the kernel image. However, that doesn't
> > rule out running test-runner on an x86 host while mounting the rootfs
> > with a cross compiled tools. I guess we shouldn't recommend that setup
>
> That doesn't work, e.g. on an x86 host:
> test-runner(x86) -q qemu-system-aarch64 -k arch/arm64/boot/Image -- /bin/=
bash(arm64)
> since test-runner(x86) can't run in the arm64 guest as the init
>
> > since it's counterproductive and considerably slower to compile and
>
> Agreed. Actually, test-runner requires:
> arch test-runner is built for =3D=3D host arch =3D=3D guest kernel arch
> and failing when this rule is violated is expected.
>
> > run. That said we could perhaps print an error if the user attempts to
> > pass a kernel image of a different arch; test-runner should probably
> > fail with a clear message stating that this is not supported.
>
> So, is it acceptable to illustrate this rule in the ARCHITECTURE
> section of doc/test-runner.rst instead of parsing the various guest
> kernel image formats to detect the arch and print an error?

Well, I'd think it probably trivial to parse the header to check if
the kernel image matches test-runners arch, or you have a problem
doing that?

--=20
Luiz Augusto von Dentz
