Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435A363C57
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712919; cv=pass; b=RJuWMkrz9RqX1cAxJ5uYNlxMemyBG3ceE6BhOnTm7UZvnWLJ3yRFEyhmjQLvE41MQ7fFLBz0gwIgU4BjqLjYdHjBNTe2nsNaXacSCg715dWvgd/ho9QCe39zKDHIL9+NJSwTFdAue9XW8el+jgIIWjZ9lTZ2kUFSD8UOW0iwes8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712919; c=relaxed/simple;
	bh=vY9FKveqFrRV3ClTlM83ORSWKjrWLoOk+yJt0rbCb6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeChRqEdbzAicBM8HmVFW+F7t2dWgjelERLKESZgB3P8bV8lXaZS7hQSb+jvSPgSvCBacub+cMbjrq99EeRZE6AMuabBX+4DzFueGD+Ua+DtQHWRFVFcaIO5DG+6znrPiyvSGPVVDJPcLOlghybvmKrjLwPdgINa33c4c8fK4x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCJirjnf; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCJirjnf"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9f69eeb6cso809444a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 12:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783712917; cv=none;
        d=google.com; s=arc-20260327;
        b=QLV7PFL7OABc9a7WYI9AJQU9UfciD4bVjqL3Yrvuc5vUH0x6VUVeRkvri5AUgIzpk4
         qmUA7hDSEpKzG3PndXzSTcKO6U5NfuYeg3AnKYM6Rug8wBcMoPoxcdyPIe9CBPsjXolV
         SGBpUJ7y9iS9t0dX4r6yz+/BkYvwB9TYt6UjwG8hxIZKuSiu5tAKuDDLPLYxLrw37tmH
         r2CyEYeksx+5qnp8Ctcmqi7b9Y1x6ZmYMc7fUhu505FO15zh+ASKml+f0gXxuzZBU+vT
         Q0zFekGgZcwNTUfpfcTwxfMqkTp3atiKBRuNpQzUP3KwO39PhrjmFxcrv5149uTXCn9G
         qKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vY9FKveqFrRV3ClTlM83ORSWKjrWLoOk+yJt0rbCb6k=;
        fh=HupYpFwhm6hoi9e1IeLDXDAOFcTk3wTUGkAEEGvTqgA=;
        b=sUeTVHMs91g5ApH3no4DI+HStbxgk2HkZT7KiggbNe6pkMp/QNT3RADG/oJJuh8FfI
         wgC/Na5A+0Em7/j5s1LjOAul7YwqCFYgW3JTjAAvU9QJhOOInOoPdFeJgasnNX6q7Nds
         p4trJqDfOasNEda+3x7UiHVpfRwjkPL5y6JJxBjKiNJ7MEyVGm2YPVlUr2uSOcbvkBI8
         sqo9fm+A5APR6Mk8lqPZJ/hf4MOIdytCXdlv0uX3h4QgY6KbI5QjPwd4Lqthom87sTeT
         YdfYPatDghtSRU/XGUJXAK1tVnArvq+B93/wTidrJ3q1xif37VzVKJ0vVG+nS5Tot+V4
         tfEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783712917; x=1784317717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vY9FKveqFrRV3ClTlM83ORSWKjrWLoOk+yJt0rbCb6k=;
        b=dCJirjnfe36omAhRpMertyPq6pnWvni1uTNyqUDUiTFekjCKccqstQ7F8kU6mZYeus
         am40fs9KEgVYWaTXKJFtzaxbquCCHxNqIa1zn5dE26b+IONHm+sIM4Av5CqSANefby38
         z4+rmcJgPwmmvVAqNrE1teW86f5SfjTLMc0FCSDrgpiPelVlRGoedk2VG8tVX0Kh1NTG
         c+t8pmOeldM5DNMlArAAsA2eAMS+01LCt5hfFisaebkuvT/Htf0dXyAnnMZjQmSRP+u7
         D55hrpWzWXLXwc6Yd5QZn3YhRvyMSfuC51/PrxIuhSNJtz5GYtpkCidbg91F1fcVjDmN
         5LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712917; x=1784317717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vY9FKveqFrRV3ClTlM83ORSWKjrWLoOk+yJt0rbCb6k=;
        b=Q6Ot5Uzc6Vo6M8UwYQlDUBw/ehoRunYopULSi0hthfIM+LSryNy9LLhOD6QDctESss
         2TIiAXO2OvoNg9S2+MHGK15UPK/CiLDLlLx9GfjC9KVsieoY0NciDCh7Dpd7F416n3gD
         prYzhLksP4v1HZl+XD+DMm5w1Yf7tWtr5StpqdnXhZc1uoTUHuz8ID78nZuGQVKS6/Lb
         u2v4dxI2dUvWNkq9JPLTrU1wcOcW/F50USWgRcmwEYjDRVhq9l2XclxrTn7bBHxFi2Ms
         il+oWzG/M6QLuIDJwN6MNmx+xdXlb4J4KRQacmxZcKr3jH9N3/UwpezalnGOrerhXjod
         Vuug==
X-Gm-Message-State: AOJu0YwLIC7QYYFMSjI9jYBiWOZes2YrDSXHyI+923MYXx7qXh9FF9fd
	PAFwVCJf3fka3JRVsorzZNllB6u3kdvqIyfmBoI/NIzvGCEeGMtLxxWIXx8IKLWSRPBkKZG3US5
	WJvJkF1HvDg4tBW5diIKltSxSWWvebuFzMD1sNGp5c4RR
X-Gm-Gg: AfdE7cmqb+guxzm2aa6GV2T19b/C3sE+2k7E+moseu8b1piuqFQr4feUleAQi8vV+Us
	Wlu0akpsGg/ytAIoC7pAaCVA6oSD3rwnHcIEgb0W4YU8IJkP3VlVTLdwHp3BaIbhwMODcnmFrdF
	ibCxSMIFzhaapdWA7tanqn9ca+R6D/rvg/qeufOCeovS6nKsRvIWyRKVMz34BEyL+e+jgUNEyy0
	/1NayWwhPBK7Pci/TTkBC15/3QAXniYrkwYQLi2YgRqRK2fDuPz0iXVxP823jv8DTUO6Fs=
X-Received: by 2002:a05:6830:6f8d:b0:7dc:d967:63de with SMTP id
 46e09a7af769-7ec095fca3emr198807a34.3.1783712916836; Fri, 10 Jul 2026
 12:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710072817.270328-1-mikhail.v.gavrilov@gmail.com> <CABBYNZLCu3hKsf-N8xTaFtUDGOMJTL+bOgppppe5WyhdRkxbdw@mail.gmail.com>
In-Reply-To: <CABBYNZLCu3hKsf-N8xTaFtUDGOMJTL+bOgppppe5WyhdRkxbdw@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 11 Jul 2026 00:48:24 +0500
X-Gm-Features: AVVi8CcY4NcxfIjmacDFD8_RNDEJ_HXM_Ung_a8KcQm5dfISEL45OefZgyMo5zM
Message-ID: <CABXGCsOyrEOGeZGGkAyKMiOCGQn59K8KTczwBrhT0yPc+jzwnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] a2dp: Fix loading of remote SEP from cache
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 7:19=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Would it be simpler to just fix it with size >=3D 2?
>

Not really. size is the length of the hex string in characters, not a
byte count, and the 'i >=3D 2' was evaluated on every iteration with i
starting at 0, so the body never ran at all. Replacing it with
'size >=3D 2' would move the test to the whole loop condition rather than
the entry, and the loop would still be walking a stale counter. The
entry guard and the body need to be separated, which is what splitting
the loop does.

>
> Or is this just to warn the system that the endpoint cache is broken
> or something?
>

Right, that part is not needed to fix the regression itself. It rejects
a malformed entry (odd length, or one that would overflow data[128]).
caps is read with '%512s', so size / 2 can be up to 256 bytes into a
128-byte buffer; the original commit meant to guard that but the check
never took effect. The revert of the regression is just moving g_free()
and dropping 'i >=3D 2'; the size check is added hardening for that
overflow. Happy to split it into a separate patch if you'd prefer to
keep the two concerns apart.

--=20
Thanks,
Mikhail
