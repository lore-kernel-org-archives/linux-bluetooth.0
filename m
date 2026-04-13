Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DDA3DA7C2
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089866; cv=pass; b=c3n0EiqSO2NQ0vnHaJzEur4hJTziPBOYFgkuDvXLlrefq8vaug4vZ+8ZIYf/Zxwgwj5Zn6Y7uGQwkUmvL3SPdbCCscbci5nA9DSHBffi5OzpkHTiSc+EHS3ozFerokpZhimu0k9TD5w4cpD1XaXHwFtSzt3+L+otlSc/oOzT9BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089866; c=relaxed/simple;
	bh=XOWtyuKAL6gknkEFXx55R8cXf6NZ6Z0A/mZTOk+MOIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCnDKqXcJoMiDtHEafRurdcaMTwFrdKCVfKBlfXbo3lbXi9a5mnS2UmNAyjCVx8gbfpRb/bkl2rUcgWN1VFYful9CpSuV6s4wh6gySdB4zi/g5kefqd4najUNEu/kbNZs1+dJnbd12D4DM81swTkQGLiWXirjulnG8dNnnOo/MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnPpT8qb; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnPpT8qb"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64d5a7926cfso3939375d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 07:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776089864; cv=none;
        d=google.com; s=arc-20240605;
        b=OcgHIaf2vXJFO1cEEYt46bojhEcsmhrA5sbmKGEsMLkVCpT5HUJCibjdzMbjQqWOh8
         o5xcaphCufyw8LdNROk/kcxD9yA+B3FKpbLI8spV+D9RB5Rl6k41dNWFgeacmIsHyqgo
         EsLkNTim3O7aN9+7J4W794Ylw8cgCyQkd3SBFulAiXPgDIwTaZghhvWuthNaKBKqgUza
         4niR86gS8HvwKlam/UYY6etU1pV73McENMfE0XNdIm0+TguptqHK8d3enpM5OFM3u9Ju
         4YsrQ3HyFE75TUwS5kWEe67FEXOdh0j6lNTwt79k4MgOzqge75X3p+5sE85vtUYZ8sOl
         r1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HO1lkDQOSwGSvR/focNvY3aOrH3YoM0fafS2AdZgUTY=;
        fh=9yQUZ4OnDlMC62pJ/CZb+zQbZxUtSGeIq5bOiVCID98=;
        b=DUTEjlZCURkUBaXzP98xvgCpwKRVHasPT8isR+q9omPDDqDkTnzYePPGAaAROvH+t8
         O+Hif0nbF5Rn0YTq6WUouqrYA5pO3tC1BWYTdGFYlUDQySE6atbgpXQyKACuE0XfHskU
         GccRdml8ziDkPxQf5+pFE01fj2XHcLc9P24XYnr2LMADGN29KW8CyDH+w155pxX0cFmc
         8tp7ekwoEx/+gUNOAN40boE+QIQcT+m5+oU/v4uV8ftokI9iHCgAY64i++vwPfgQ9dLk
         R9zc5g1v+wAWZIoGzMeFK7BxS4tEO0vCyNuGE+xe/AextFYKlu2rFDFGmLzY+DlBycL3
         ni2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776089864; x=1776694664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO1lkDQOSwGSvR/focNvY3aOrH3YoM0fafS2AdZgUTY=;
        b=HnPpT8qbHyhPDmN/dPHIXaGDlDeib59kq8iKanjNpICG3aVDGseKl9FxktAuRTrNC6
         BUCxVOZ5x7KZvzPtVLlOC1eebuSXAs/FfwjW4XGr3BoKAY3hUgqRlW/CnGcXc2hOumYU
         yAQygbevdsDGeHRYS3V8tu5ai3Sq+i6BjAesQwe9emIZaXS8/zhxNuDI6wScfjkFzh6j
         8YIskihrkNtCt4FlbFYwoNvQAJboqZgryFOBl9p0plOZwZ5absjUBO+H5N7FnVRbhjfe
         Zl1atzNIlWjxgGhAjk7/sHqgJnlF3uCCXrkznzyHiEaaR9WjncS20l4QodsbUXnhG8Rt
         OrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089864; x=1776694664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HO1lkDQOSwGSvR/focNvY3aOrH3YoM0fafS2AdZgUTY=;
        b=HeItJoWEWYLoMDU9/X/KBdvLeR9kn69jk1ENlTqNtiw6/tyFlZZ9BatHkt+YsrBoC5
         bT+ZwSZ88Vm3+0wQaaHb7Q2OIrh1U2npjhf0KXEFHJpXVI6qeb/oGrUo1q36GZ62XjM6
         yrbNmg0J0vh8VfUmRJnRZz+WjwIE3xsznzKZfLjlo+1TwjH070czlGNhJoZxHxdOczcz
         eboMt0VBeMCSHqkId5A93za2waYFnZGsQfxugC3YaNXdpDJpiFw+5V/VXt38X91RZHpa
         cQmVJHe9devm6HPoP/sYIskggswZcK6sK8hfO2ddzhNesMhPYy7MQYj+gjnSigTFreEA
         31aA==
X-Forwarded-Encrypted: i=1; AFNElJ/66Hi+vNnlvxxBod3AdefG80PGWGezF70IsUWxqaSWnyV4J2Z/8mrcq3o71G2XdWb0YLEhoEeBeXXDu5renFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA54h8b9FvLWgAgHLw674uBZrxAxKObEKEwamFINrtLFor7z2o
	j79ULUtkWMwBp1bk1UvHIQCsgllq6uQmG9QdolhTDfVkPUMsw5bqWbcXzDOPmkOIlgNszr0IKl+
	VdGzwaPT/BsbRojDPgtQhKPI1aR9b+Bk=
X-Gm-Gg: AeBDiesjuyB2UN5GHfqN1JZDT3DbDsICQfL3SkSvibLnW9K1xfAdA2OvAgPmYR1eEuv
	hHiXWSxfqlwJ8KpUCcp7yndg655fWFlYDJoINLyhcAuj/JCylwoTdDRfEr37BtTRotB0Y2e+HOS
	/enFAxpGXEhuapoqfnUvYi0TTx6kN9FR/1jgEV9Wsy5gbJ/YZTasQATV4HY3+zFoXLxSsFasffs
	UKExY1G87kmt7Ig3q0U74KcCbCNlpzIuX8okXoCKNoN5IXYhOnN4fjKtB/+tfvDWPiTSWHsji3C
	rIgip63UOc1rOf9v+caeIc1CoP7xOsoZTie/hjJv/J4AGUfQoNv/8f/xDt17KILe/UkHGw==
X-Received: by 2002:a05:690e:12c4:b0:64e:a9a1:fdb9 with SMTP id
 956f58d0204a3-65198b56526mr12424704d50.34.1776089863932; Mon, 13 Apr 2026
 07:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413132247.320961-1-luiz.dentz@gmail.com> <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
 <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
In-Reply-To: <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 10:17:32 -0400
X-Gm-Features: AQROBzDl9NV24zFCz_h_KMQw8MsSN5GmeKZTjLt0RmjZYHnqkefpAK2oyFhy9q4
Message-ID: <CABBYNZ+7zr1jQ7a-2p88zNqMdvn6MAB5NAZ7b4OW=P56DcMT5g@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 13, 2026 at 10:11=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Paolo,
>
> On Mon, Apr 13, 2026 at 9:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 4/13/26 3:22 PM, Luiz Augusto von Dentz wrote:
> > > The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe=
434ad7:
> > >
> > >   tools: ynl: tests: fix leading space on Makefile target (2026-04-09=
 20:41:40 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-n=
ext.git tags/for-net-next-2026-04-13
> > >
> > > for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd=
6f:
> > >
> > >   Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling =
(2026-04-13 09:19:42 -0400)
> > >
> > > ----------------------------------------------------------------
> > > bluetooth-next pull request for net-next:
> >
> > Net-next is closed for the merge window. I guess Jakub could still
> > consider merging this, but unless you want it very, very badly, I hope
> > it can just be postponed, as the PW queue is already long.
>
> This update includes quite a few new hardware supports. This is a
> resend because the last one was dropped due to an invalid 'Fixes' tag.
>
>  Btw, I don't know why the entire PR needs to be dropped if only a few
> items have invalid tags? Can't we just dropped those?

Maybe Im doing something wrong in my side, the issue with the Fixes
that is that sometimes they become invalid once I rebase on top of
net-next, which, afaik, is necessary to detect already applied
patches. Or is rebasing is not really necessary and should only be
done once when rc1 is tagged?

> > Thanks,
> >
> > /P
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
