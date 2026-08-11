Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7044682B
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459794; cv=pass; b=KNkREAzbL/z7YZOORPHZnasgcYe7C3aNNv4nh9eZHOK1e3GYlWClBUPumI47RKkaD5LWFxJB4TNzQthvmGhZrE/SScDQX3zgK2GKk6vB/Q/uI6YjM2Kl0pTny2VcBQ0gvI/JYgd86EEefVXDXwuHWB2vYNJfkr1M4fFJRAYLvAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459794; c=relaxed/simple;
	bh=egPLXr9J/YHh1Sy9mQm+JhenE+/91AXLSxpNDQkGuxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLA90HGo8bFbBqQuPkbMEnQ8/06uOSSYxvnvlqBK8DEkpVL5CsHmfVjI/QBdR6RBR/qBATh0bCEGgzfyCcz873VbXb271mlv9RM2xcAHyTQ4MHQp/nVLl2v9LGxg+UpLO+rhjSWK+x02EwYZnf+v/qZ+MY5ontK06Zzpt1g5cP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/bOW9p/; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/bOW9p/"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8114a4542b2so46730727b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 07:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786459788; cv=none;
        d=google.com; s=arc-20260327;
        b=atOOtsf2VtN0S2dGFyXFlNzKA8/KILKG4ulueLSlVfuXAKnwexsrP84riL6Xk44W/Y
         WdqVdMyBP3BwH8FBXUgJPr++ABa5xLRlNx6dFsxPYgmb0/8rPcqIRIVh5MCi4VcUBSGN
         ERHhWAcgFa/AgtjGTVJb2V07g64C1RWxUf7iThC0/VUQR7P6TyAqjiz/VgYFAM8X18Rf
         v9dkgiY0ApXfyCvYE70igLGeqbPmq4vBfyUgGIvmL4hZKFBKPyTsj0rCh+8uewgiHtWx
         TevVE7MnEef6iQLfGYkUbPvzKYqkC/euTDeYwFw32QPJi3ghcES4cMx9hibizz6+nDqf
         NSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=egPLXr9J/YHh1Sy9mQm+JhenE+/91AXLSxpNDQkGuxg=;
        fh=Op3E5HLcggvb8//r6Zg/oem+rFLoYgsR4Qs0Yy9pSPE=;
        b=D5XcbDHpGmnjdBUpyowCC7xH6ESv6FmM3skAU4pN66biavhBC8POQMJCNdNke9rbae
         y+9I861kFQhWAWmvzwcv8q5WL5nfIZg7fvaX71S2+11ZHs5Y7c5P1NH8w6xx7nox7GmO
         W3oMuI5CgAIYdOHsVOLI6+nc8fNEnlUmiPhG67VhnbfcpiRTkR/i8GMQrFmWsqM9WU2c
         Wln3U1PpFM0apBe+JGOrp6M3mBv9KtGewJ61QhjMAzl2zv9IqkXFp2yh5C2LLdRWsWc6
         tq5WuWbZkgXWU7Zix5NPrBfM32+2R4uus7JlWuIZs1UGjEvh8EgKz5BqVPj++ca9j8Rz
         w7Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786459788; x=1787064588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=egPLXr9J/YHh1Sy9mQm+JhenE+/91AXLSxpNDQkGuxg=;
        b=T/bOW9p/s3MW4WdKyNihYsWm379N1NyNP+QPCMXJUH99WI+uKMsFasP2ZBz7coSTs5
         yklpO8PFFfSyLfV8sfv9FjFC8Iy8qbmsyCVYwymS6z6xqL/h1lKWR2DRuWYbJi9vU9/t
         EdgFQ9vN+L0H72nu8s9RKf+YBMoMXS96OrmnzyK9opjrUNSOzTWzpR+Q3+XU5MHZ0zD9
         mO2H/VhbYW5w/61p+fImHLFUGeWsucjGyTPF1ZQA0u7jdZRrEboI+y0Xk/bTpu/piiCs
         YFPjr8aHvcMhuBaWFyIUW6+GaPxF2KUPDI1J/iZCbft05JJtfygIEVjG2HTpUAzMXznm
         9maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459788; x=1787064588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=egPLXr9J/YHh1Sy9mQm+JhenE+/91AXLSxpNDQkGuxg=;
        b=czhSra7VIUEI33RJVFem9yFzt8W8MZH9S1A9WjmgvgeUdCTfjnu4qn84w1fXZvc1Ns
         OC0v8nCiDzWOb0abPALdcRPmODz1VHGEQYqSGlJ1zIxN95/ygqnHSgx9yRpXD/T/269s
         Q/llyce0HnGzr83ZopQ1eQELp6B1c/9QHmHThTNBacANj5c0hO7oJk0gz++xazwDkk6B
         jQDAHkNbhy8lyFsBIFZSobfr5VaYYBRDq3MHBh5E/Atw80tuDQ3A8ymE25OXJ+dn2lLP
         2gKb4aTFqtMVzpi1B5lRV11FSr/iA1T8Mh/MRjt2GQPyJb73I6Vqi3dgGRG8OJJH26Sg
         2W8w==
X-Gm-Message-State: AOJu0YxMCa6aFfC8alLEiWFc5hg+JqZuIMF0hBBy/QyGjNzZ/Yx4RSeZ
	n7/w56rvxO2iUb/LeEUMGFlB3tj8HQxzXWSf10fAr6WP3kMF+bqliE2mQANF2l2ErzHeD3LoA4g
	VnYsNca/Yw9dp1re0Nd3a0ss0rdUOq2Q=
X-Gm-Gg: AR+sD11pqeg09MAxNYiJ02TYdJPSk/cU6V2Od6a8cP/hm2hleg9zusHq5AqXNUm/iXW
	/o1es8q/5rcNHzS3mmWLOgzkzGPRRylSpyxM6hZ0hio36J2INDueQGiINRY6oVPq/gLI6xbrbfW
	m0fQQKG0Q91kNmen3Ck44uLwflN5DdX+z6PAJDVNMzgUtvDlh/EbQ1xd427FBluWPCcgShHL993
	7Ymt9jHXAcH/8TQNDlsT5cHTKDlLD2w4duLa4QDNb7XFfEY4pVltLvtv0imVYvxNIarPc6ZDoDI
	Pw6ZPU3rorWqAgybepvtjPiEZTbWejk4Dv52Er/hf3Sj1knOc83oIBl5G1aggyIYWFrvwEOlKid
	CPYCERAKSKZmxsK5YugUaWB6S9iwSL2jz4t8MMoqCAw==
X-Received: by 2002:a05:690c:6990:b0:7d1:dd7b:b71f with SMTP id
 00721157ae682-82f2e45a812mr29621077b3.29.1786459787792; Tue, 11 Aug 2026
 07:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
 <6a7ae9ed.9e118ab0.227f96.1808@mx.google.com> <f1e1dcdd-cca7-4670-abf0-febf16c72e15@oss.qualcomm.com>
 <CABBYNZKPA8UjfY0uo8cPE4BbxTRON-OgEpMuuHdwJ=br91H3Tw@mail.gmail.com> <13692d14-6093-457c-bf39-42afd2d5f8a7@oss.qualcomm.com>
In-Reply-To: <13692d14-6093-457c-bf39-42afd2d5f8a7@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Aug 2026 10:49:35 -0400
X-Gm-Features: AUfX_mzSrPLAlOfClJoK60ZLc0zFcj-7yF8FV2kdVvxAoclStacGcgLVjNCfsVM
Message-ID: <CABBYNZJmhxN+BPA+1WUp_-d8-da9WaH2ynXu_qM8iW2UJY_gkA@mail.gmail.com>
Subject: Re: [1/2] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping
 the last request
To: johannes.goede@oss.qualcomm.com
Cc: linux-bluetooth@vger.kernel.org, 
	Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, Aug 11, 2026 at 10:43=E2=80=AFAM <johannes.goede@oss.qualcomm.com> =
wrote:
>
> Hi Luiz,
>
> On 11-Aug-26 15:59, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Tue, Aug 11, 2026 at 7:05=E2=80=AFAM <johannes.goede@oss.qualcomm.co=
m> wrote:
>
> <snip>
>
> >> I'm seeing the exact same failures in other CI runs from recent
> >> patches, e.g. :
> >>
> >> https://lore.kernel.org/linux-bluetooth/20260808062541.3705446-1-zhang=
chen200426@163.com/T/#t
> >>
> >> So I'm assuming that these are pre-existing CI issues and
> >> not caused by this patch.
> >
> > Yeah, don't worry about those, there is an issue found by sashiko that
> > perhaps we need to address:
> >
> > https://sashiko.dev/#/patchset/20260811083730.71393-1-johannes.goede%40=
oss.qualcomm.com
>
> Thank you for pointing that out.
>
> The Sashiko suggestion to make the clearing of the flag unconditionally
> (after freeing the skb if it is there) seems to make sense.
>
> Shall I prepare a v2 with that change ?

Yes, please respin.

> Regards,
>
> Hans
>
>
>


--=20
Luiz Augusto von Dentz
