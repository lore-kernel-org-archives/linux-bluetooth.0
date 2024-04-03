Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1115218F
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164501; cv=none; b=cThk1fH4FIdgQCv9GSzNMbWvB+Z6M6QNdY7HvnscigHNANaDq7CHobBmsI6VGzv/mnnkvQA7yvOQ9ziEBpyDiJUR2WDOVyJ8x6OYtBi43nsNX1E4gWSnYz/rwZ6TM/bY6MU+NCDKvGwV0itflf4Mns5WTWpi4YGYpEvGTs77vwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164501; c=relaxed/simple;
	bh=djOGx53iyD6XQpzd8p7vEgUOeE5D/NxrPP+OaZti6Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huaBvfHf3GO1GbuWR12glwFq3SBtENXsXEvTjAxVou9Rf3s+oaDlX+G3qW9wKVuloeQh4qdpJCd1I422dMOdxiESJKhvbCQs95judthqdQX7sLNATvasP7sgf8WYuP2Iw0dN/B6nwRvqG+w4x5Pi1xvD90ao8QKIMpx+ZlU131Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUKK5lTl; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUKK5lTl"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaa6so669161fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712164496; x=1712769296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djOGx53iyD6XQpzd8p7vEgUOeE5D/NxrPP+OaZti6Co=;
        b=cUKK5lTl96i/m9nzTliyVP8JIR/0S32rQI73ss6bi2t7A7dbTjaGH6bYkEm5zBDPfE
         JBckaKb6Ncp9BBKzrTyMCt3/ojvYBNwmLGG38yrSXBBLbgMx/Uk29TBUu1P/yQD/qH+b
         wMLBQiTTHPozhre2ocgflSwXD3Uh5iVaDXgNHVhAEodNqNTEdrA3dlkc+j7NzeK8xqQ2
         VMI/527fSMj89TSSamPvA9Wdh/lJBwmc0Rx07vW1y+JCs33UP4bzbCxzb4HF3fosbl75
         X/4CRtTz6dGokZYYHGm4IKQLaNlQF12wLu09BVO30iz183+jgXUlRmYtyyXTXIVrVYUg
         bA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712164496; x=1712769296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djOGx53iyD6XQpzd8p7vEgUOeE5D/NxrPP+OaZti6Co=;
        b=dOWn0nBFUYF/GaULo+dvtDmjVNNkEfPik6EW/3rqnB4BB8Yzp5wSM9GCTl8I4C/mhL
         P+z1MfA/mS4q9qBRmdKJm76DM5br1J9J0b69VV7zuJeEIHHZVmlaRjeMfJlYRZZpoYp0
         0oS+bSwU+QNJBWkPwl4kvYHkQmhtPrPlTyXc1kLtM14TgfjcpH45SebuPqsAalnkpHdE
         6vg6l+YjBzTXz77usb37Ex52XeaHhnA7m3f/6mAfp4juhBaNcxwgZ6oe52ZoqQvH5rpB
         G+gLBBR7jdCK4zP3ZlxQDTrwT8sXJG6YYf5FOpnuacVBwMKCq0mVWmUVntShslD+XxtA
         IvKQ==
X-Gm-Message-State: AOJu0YzUhF1k65GgzV3OSM9OgoQkgIUGLDrmfxNMxBYTdwVFjED4weAR
	62vyTIeEcw4lcZOKRgXzCA9rU3VLVn29U9EiSYdX51E+gBzA7Ql8dRrr5S1YFaki+Aa4XZyYrEL
	eNBc/0hHKnG5TeXP2RsqjzjTd98QVS4CA
X-Google-Smtp-Source: AGHT+IEWuUpXwzVSV1SzajCGX7x4Zsbaz1KKZjoCn1sXXM1UDA2zi/ov7zAnY8sAjCWf5CUn3D6Uk9OH1fID9mRCL8E=
X-Received: by 2002:a2e:91d9:0:b0:2d6:eaf0:87b4 with SMTP id
 u25-20020a2e91d9000000b002d6eaf087b4mr203025ljg.11.1712164496204; Wed, 03 Apr
 2024 10:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1fd56079e4aa89aa1056a3cf185610a683ee02ba.1712161649.git.pav@iki.fi>
 <660d8dd3.630a0220.f18e4.0633@mx.google.com>
In-Reply-To: <660d8dd3.630a0220.f18e4.0633@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Apr 2024 13:14:43 -0400
Message-ID: <CABBYNZJD2Du0Y8Pf3C2GPxMEYut2AmV36g59EmONM74baARhrw@mail.gmail.com>
Subject: Re: tests: add TX timestamping tests
To: linux-bluetooth@vger.kernel.org
Cc: pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Apr 3, 2024 at 1:11=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be appli=
ed to the current HEAD of the repository.
>
> ----- Output -----
>
> error: patch failed: tools/iso-tester.c:34
> error: tools/iso-tester.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.

You probably need to rebase these changes, Ive pushed a couple of
changes to iso-tester yesterday.

--=20
Luiz Augusto von Dentz
