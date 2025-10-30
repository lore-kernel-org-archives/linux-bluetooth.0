Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9D239E61
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833225; cv=none; b=cUsUjV0Juaml88H3VT+zQM5U0bFc/wmMviMx6Tg+1mOZkGK+Lp/CtXpbKMuEbhIFU7fJKEkAveQM9JBoQ4g+vAA+v28txzguP4p/YK8B+uS6Amwgirgj+k0jiKELMPQhMqTL/mGAJKTdbQ8z7i92sy4RP5x0QYcTos2Tep8DA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833225; c=relaxed/simple;
	bh=niMRWov0/FpcnpX9pBvfk+UWxbs84JocGCGMJZqAIME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruDuixu7MAW3Cu4jpno9H5rePeg+OvQAd9n4r47zXTv/tG7B8oAWp+QrPdQuTvQRvR9k+flsEOxpBtwCEXf1Ll0vVYmGj+LnAzxqo+5rmUjK0luLhu8L/sMevo7yn8rgv016g5/5c9OQzcCHvpzCCxlZi+n4fhUb0nOaAFutmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh4+3u4t; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh4+3u4t"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3737d0920e6so12822631fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761833222; x=1762438022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LDM0pJPsUIjFS0/vnmri5SudN8cRtll4fqg1go2C1M=;
        b=Zh4+3u4tDrTRxmiCmH18D6LEZKA8wemleCeNtcN1Ik9KafB8oru2I+w3aFKV5XVVe7
         URs1ivXrT8lsLVdEQyKi3o76zPbBQQjy+f3VVonW/uMtWPRVjol8U3aR4wX8bkqZaywM
         JnYgpg6nPSmHk1V4qtBj043OHx46jHJ7i4Nz9cDHR9CEPObWqGe+YKpDnqB1TWFBgw/p
         YR4ddoaXHcXnTw8fsmM7LOqqxoV10IXJOrBaLhs8elxyeZ/GU7VQssr8f38zU4ctqUUq
         N+qmaMAk7S/w9hY512iBNrsae9ya2MO5sMKCr7+EXR275CUXw4RavbOhyTfqAVmkGDAF
         fhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833222; x=1762438022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LDM0pJPsUIjFS0/vnmri5SudN8cRtll4fqg1go2C1M=;
        b=plAP9SzDxZ0pemCJI7bsYlZ4n7sQt7hdrW44aGsMYIxhsF1oaPnodaxAFe5mWvGG9j
         3G4RtBAIssoVgbBvMqdbEPXLsf090xXFswc0NIeOBw5kKI6NSKLNHnQ6o6tRHPCFi4He
         ZeSQLVeQ6GylXbsslZBfEVRP8bHfGrPDDs69lo7mcoSmPs2LSoKCNvb6Y75fmSrwY/pd
         toQvVS+/vAaeYsTDZyhRLZjs9a/qOIEdeOqX9DlAFfh+Gs8jr0MYVfJHaHwI039CuAH9
         1wHuTURL6iCCfRO/7sk/i8ByViNIUS2hg6T/V2D4MSG2R4/VyYRW7ilJ/9usftzB85hj
         ffsQ==
X-Gm-Message-State: AOJu0YwbQnFrRRybwrfu8UYugPvqh3w7+5DO6JQiTaTVdHjdbG4Ow9hX
	AJgp3ttEgUybSkdqv4Wh9MCqD2+0jJgd2ItBvtVeBjgE1T6wNf31vRBmamnnL+BYeRv0L01GmDX
	e/alTSLtKRpUiXepV5eU/DP9xv5xA3mWTPMhy
X-Gm-Gg: ASbGncvGjo6lhw4sMVPjS8ojiIMpl9fzNqNuhAbx1fPxv4D5VlhP8KtRCqBebjbX44A
	D7iORyzlAcV06Uv+0Hh3x23otgn67UjtbPT8AsuLyndGlYnnXwynM91HA3z5zfrGYc7xEPByg4d
	mzd3M0CodY/i+9FycGzJ/FS5buRnygMMYKf5XnaN/5ySV22xkGFxJ6QmVAKLEUWn1DiIL9RpVzw
	oMbyX+HVEm/IMXWQ7e1XV8RtxLCE+Ev91rkPbBOZNchd6ESsYTR18/m1khy0QgOTmpY/w==
X-Google-Smtp-Source: AGHT+IEuNEC4pm+0zl9cJzGGFZkDQLsDDgUw2C0WzX8igZyMQz6nnP9Fbp9967uipsaYZotxhjfNM5AZ6gEHKGoJue8=
X-Received: by 2002:a05:651c:1505:b0:351:786c:e533 with SMTP id
 38308e7fff4ca-37a023cc689mr19286601fa.15.1761833221816; Thu, 30 Oct 2025
 07:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030134856.2726882-1-mahesh.talewad@nxp.com>
In-Reply-To: <20251030134856.2726882-1-mahesh.talewad@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Oct 2025 10:06:49 -0400
X-Gm-Features: AWmQ_bkq4uyVrMNw18M-iTJtvu5s6V4XYkLR5hMXHNrnIkn4PLH-w58uQPEhJAU
Message-ID: <CABBYNZLzezrT+0Gx=cCR2s2wztCn_qXsqFq35ckvnRVK1dGPpA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 0/1] Enhanced or Legacy Accept Synchronous
 Connection Request command'
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, vinit.mehta@nxp.com, 
	sarveshwar.bajaj@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Thu, Oct 30, 2025 at 9:47=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.=
com> wrote:
>
> Hello Maintainers,
>
>         In the current implementation, when Connect request for eSco is r=
eceived,
>         Bluez Kernel is sending 'Accept Synchronous Connection Request co=
mand'
>         [legacy command], irrespective of whether controller supports
>         enhanced synchronous connection command or not.
>
>         In this PR, When Connect request for eSco is received, if control=
ler
>         supports enhanced synchronous connection command then it will go =
for
>         'Enhanced Accept Synchronous Connection Request command' or else =
it will
>         go for legacy command['Accept Synchronous       Connection Reques=
t command'].

That sounds fine, but we will need to introduce support for Enhanced
command into BlueZ emulator and have a test under iso-tester that
utilizes the new code.

> Thanks and regards,
> Mahesh Vithal Talewad
>
> Mahesh Talewad (1):
>   When Connect request for eSco is received, if enhanced synchronous
>     connection command is supported it will go for     'Enhanced Accept
>     Synchronous Connection Request command' else it will go for
>     legacy command['Accept Synchronous Connection Request comand']
>
>  include/net/bluetooth/hci.h |  34 ++++++++++++
>  net/bluetooth/sco.c         | 103 ++++++++++++++++++++++++++----------
>  2 files changed, 109 insertions(+), 28 deletions(-)
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
