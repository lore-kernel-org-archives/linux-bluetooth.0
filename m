Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466373AD524
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683600; cv=pass; b=u1gUAiLFp2U6kjEFCztgSMOzfUG3gEr5OFpAbTgiWS5zA4wzBF18QUFHmu/R4lU8FTMjeHirEtICedCVTadpe/RS3dwRECeZ7p9CG1b6WP7NyP8Yxs2Wz4p15nvYdczI38vHd4SDDvYuif4ixezsBDUcSx8goqne94AoeGCa4bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683600; c=relaxed/simple;
	bh=6wOvck8B9uFXya9iTPvAh0w47Usck52wJZBuwmt8ZhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbNEuxIxvsvbZILRnBkn/sLktfol5Cw6e41Hx5LIKhy/XUYBi/cG/CXSOJjzkMqJqMFI5OGJQqZaq5yBYmj3jYiZFn4ducuMyvFnYQsFjN7T4RRS59zdf4hZCv/LY2YlWhY1JlboV9l4HJ3ykSm4CUh1NWsBNRBiBkuMRJkxLL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9KpAPT+; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9KpAPT+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c166ec26696so337366b.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 11:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787683597; cv=none;
        d=google.com; s=arc-20260327;
        b=c5/9vao90xMMh6u4a6iHnhgrkVXpP5tm7T5ghR6nJZQvohITSahT51o3CFQBf8D2Jr
         mAWK6FvwP374pfjiJUJClQw6x6/KYQu8bO35QBa0UvNiCsxE0loQiTicO8a1h554Ix6t
         sqvhmDKV39xbQrKdcJcwtWH9xm1p+PhbqJJO5DGo5fpMxZ0oksaqvKuLohADcCThdR+7
         EGRag/9EVZV8PlHJ8p5T/jyfnAFIFSohyWaoeNOQQhA4X/VSp9P8BPg7Yq0cxMYWbHEF
         R7WdnEHriTxcAPDUWJHl05mryu7RiT7l2y/UOgbnzpJ9MPJN9B+dYeF7ImLIxkXtX6FN
         el5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6wOvck8B9uFXya9iTPvAh0w47Usck52wJZBuwmt8ZhU=;
        fh=EdPacPkXz7f9kL4GqQpW4Hj0NvZjIQIQT+rpHr186ng=;
        b=gu2+09Np8nusEnVvJJZSMIO49ZYzG9SNIfj6cSY1nX7D9Kg7tlNe0eTOPX3cPYJY0H
         9P16oJk6RO+2KlzeV+qA7x1/KlAaFvo+QAAO3XucC74jz4YlEtNsQoU5/hxnI/0NZ33j
         uNlQsVqhi8LdMAlCXKzi4+CH+LINseGDEYa19isL8YDWSrEwoMcw6YgLWxjISFczI39f
         ekz5hmSNYodE+dYxTVsuNAKHgmhlet3FgZhrUQUhKp3g9NPsaxpuo1hQyHoVZkE1byfU
         KnUCvGlFoYPLn0GLuYH7ntG/XbrD8FwN4OXZXHn6yOaRtem0ZdBw4B+e/6WTlhEVsHjn
         aHoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787683597; x=1788288397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6wOvck8B9uFXya9iTPvAh0w47Usck52wJZBuwmt8ZhU=;
        b=j9KpAPT+PqNtqTZML7Sbmzhi7NyRp+KYNrt1iMWhVlxBNM/BjQp7Y5RonSvuDEPUuT
         BhFxfTdgcGE7qgp1QLUUU45fe0aOYhKeTAR0ljTAw7c/5DzlhAkNElevxwhLPXVAm+GW
         5A4jS7UsWSi3llA1ZGInQLEEJCXMQqOvuIZmOBf4+JXvYEPCNUsIT8tlwXMawRAxvpB/
         4E+7NDc1AISawnnG/mzlyVsXJGhx+aMy9rnSkInGS9i6l7xLbCFxtyPhr4VOw50+Ue9b
         PisSwHNo+/Ot/0lxTwASlI+YwWzxEeXNErGj7rHwlSrBZedHQMo5+EgLpe4bTtSrK/aC
         6nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683597; x=1788288397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6wOvck8B9uFXya9iTPvAh0w47Usck52wJZBuwmt8ZhU=;
        b=gzuvIj9au/rnjWTttkTiUiALqDKtoBTwuhjAGr3yuIh7BhpklaZLi2sj4OLVQlddC4
         fAI5uu35dHzbIjDvRjrD4uBGMP8KMPXr1nx3D5p/QMMl1ms5hIzyhGQBh+hYhxlpO9QZ
         m3SN3iB4okpNQsO6XM/o4A3UhkYmPER9lRj68Yrau5G61pN7FuVmFRhJgXPr4OsJGkNr
         fKGlr1z8TYCi3kPzOCdYgVFSBd58cPLbiiKq2AmRmiZYjrT64lwX887nd+39gwqN2SHm
         sl/ok8iephwPLck6wNZUm2FX9hEnDRueHk02Ok5gqFUKpnKvaJ4WFv9wnPraEjzGwe3O
         KeWQ==
X-Forwarded-Encrypted: i=1; AHgh+RowZynx7oDqh/O+HpbR8ZJKgy+1SyvBpBtylB49QUwWvu+D501zF0XUK+Yu5MBLmu5h66RfT3NRUZxgY3RYjlA=@vger.kernel.org
X-Gm-Message-State: AFuF++lojg2fmmaX1apeTWB0yNjy1nOgRN7hcHnIaPRytEk9ulYdezRk
	0N5+5ahFuKNOiZtEeSkTsEylVxE4k5i4BQpVtot9SVuMnmLVIi9B6AoTn+OYszBRLnpWT0N7HEh
	kGvPh8pg58IILrmq7nAfWJulFCq9YMG4=
X-Gm-Gg: AR+sD10njKyuv3vGUJHKfV1U3bFcT0TSsxoVohU60oS+Po9eAVIO6PczvQB5KjwGG/B
	jeXEnpmWUPTFn5pKF8lDtzXqUxDAUQ7U9h8cQVjKyidZ6qqNqWUkfEiXkptmL/RWnCnF+iOvOTg
	9d5vHoUwdAzADLHHQwn4AoDI2Jee+5wElMCEM9B09NEKPu9wy7PZT2qqTdlX6rX/X5CBBt35siy
	r5pQRiEy4BbrW5S0bH0lieN4nYuRFIGHQPnEMfSHyrf+0n/E3mcodWiXQW8wkKrgamnFsWOaIeY
	d1DiZGogWixrB4R/fZFZvDe7carOTccfhVRAwl77lWEXbTCOE9Cxv4AuW5SOTehTrl9/+Bkyhlg
	=
X-Received: by 2002:a17:906:6a1d:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c250c46e2a8mr39875166b.3.1787683597474; Tue, 25 Aug 2026
 11:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
 <178759021163.3014491.6954824460297136867.git-patchwork-notify@kernel.org>
 <5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi> <CABBYNZJotKc4k55jEEweD6aP6XEhYyKAgk4BamV5vfp8HHi0Tw@mail.gmail.com>
In-Reply-To: <CABBYNZJotKc4k55jEEweD6aP6XEhYyKAgk4BamV5vfp8HHi0Tw@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 26 Aug 2026 02:46:25 +0800
X-Gm-Features: AcwNN1Wo0UdOc9O2d4eIjZGkfhUhoFh1uhDN-_aeGYC7cwhApQHDp3cnjINmNfg
Message-ID: <CAAo+4rXEQ7DbjtB4ZTUAm5Yg3-jKRzmWbH+gTfUF510PU5caYQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize security confirmation handling
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, patchwork-bot+bluetooth@kernel.org, marcel@holtmann.org, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Tue, Aug 25, 2026 at 4:24=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Interesting, I though the kernel_connect would actually behave as a
> syscall and use it own thread so it wouldn't result into
> l2cap_chan_connect, in that case it is probably useless to use it in
> place of l2cap_chan_connect directly, so we may take the opportunity
> and clean this up.

Sorry for the negligence of the possible deadlock cycle. Could we
avoid the locking cycle by directly moving the session lookup and DLC
walk onto krfcommd so rfcomm_security_cfm() no longer takes
rfcomm_mutex from hci_rx_work? If we need a fix like this, should I
send a follow-up patch or send a v2?

Best regards,
Chengfeng
