Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FAD1D6193
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325574; cv=none; b=FAAbxWsPyu0y3YN7HfUwdwL/FP4TdSlstShyCllwg3wy+BqQ/I9PlPvfIuYGjuJDjAXkh4hEvycbBtlCFBzMjYfi6Owim/R0nYhvogxdKhXFLR+Yb8dcaYgDveACj/oEKvsecSef2A85F0ZCmg8l5RhupD4ACVR0DjIFOEVFBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325574; c=relaxed/simple;
	bh=zLSxG4VpjKfXa1kqVV1JIekOAzPlFE7OtT93YgC8jtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWS5xwrnQ3FkfdOaFhxS+i+WpWi+LLcA7hcMq0rTSAJTkbJl5Y0eHivZS00R6NR1tsoreJFWcJ22/Htfd+uOP0L+Dbh6M87lOXYs+JgV1ce0vtWEjWM1LZ2Y2PQ/AvNw0Ci/HCtdVCqe7xChOj7NF5x3WjIQeDFol6qUoZBz4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zfl/iW3K; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfl/iW3K"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bd11bfec6so61060501fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742325570; x=1742930370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLSxG4VpjKfXa1kqVV1JIekOAzPlFE7OtT93YgC8jtQ=;
        b=Zfl/iW3KotDCp+C7nDn7pYEweU/cU8bSREbmbNz2PBaiwC1sX7LZhRcctN9EW2ddW0
         4LKe5IZuyi8rsOx8SbTxYvZFD4NNP8XH8XGrHARFxd9t0ag1JUXDiu1MpuUvjAsiv/0g
         WPKzGcpLKsJi0SrGUHLqvhYvB+aNQtQSMkBG7psrv3su15mntaevjqhCjR4A2ZE6bXUl
         +1fSYI34S/f9Lg5rzew902Td/ZgF4qfthzgvDye7OzuetMsi9NELth8LVCR/ChbU842k
         /LNeITNMKt8pUiszm2uHCJ/2PzwveOGSQf8/5kb/zd81TEhmYMyxoHn276QEMG0GSjtO
         Zn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742325570; x=1742930370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLSxG4VpjKfXa1kqVV1JIekOAzPlFE7OtT93YgC8jtQ=;
        b=u/Oz2cPrxsM8M5SSpkUyuvba5Y9DLFks+q3Dv3k6fyW8TSiafoqA6Y4m/YjRHFMGTN
         TW8QyqP/z3XRL4mvBZH5eZNw54NPIrsiOWuKMwnoBHsxP6QvKzMe7sxL87qjy1umiuRc
         6X/aQGlhUEWLE3OLanbSXVwgUpvJ/NCIPHJU+390TLACiuPKejZk/SCLIQ5RVk4VXxGj
         Qoj+UcIc9JsnbHkfErjCkuAeo56Crzb/qHW2Q+tFXWHq68jsawW3EZ+5z8ooOYQjFgkV
         enu/wMCHj4UmwwH9q7eI5LZfbeuRxT+1qEFxoopcx8tu3pllDdA9X22ecB4b93f61mu1
         FfBw==
X-Gm-Message-State: AOJu0YxiPpDtAs3wxBv3Xp1djmbLbu31AobYWyrBQLKHsCmNNGXi453Q
	MaULbYbnvdtae7XF6or0lMuq5PRx5/5m3Z2/ozHCj3JTeOj288wTJ0P4mkomKTN83QBVsgVIcEk
	E3RXo2nFvUpzxg8B+UQm5z017pj81QQr5
X-Gm-Gg: ASbGncuXRMsa8T5K2J0UMDXcGSnv41nplqOvUxDHcinT7yT1zk6gvKsJpEkc87I+sz3
	HvZ1dxLWNAXdw7nKsEdcwk4z7CA98kwJM2Ne0mvx3V26gqSewqnVImQtmnYz8DaIYe/X/p3ccc7
	iDnGCW8lv+lBj54cWOvynKM0yW
X-Google-Smtp-Source: AGHT+IG96FVwzgsMtilXLd8sJo/kg/T6vazmVQaXHXKfbOSR0KTwMvHk8365hHVFLqh1n5ShRTRpmB03f66QtM+Hw6w=
X-Received: by 2002:a2e:81c4:0:b0:30c:5c6:91d6 with SMTP id
 38308e7fff4ca-30c9754a28fmr31650121fa.16.1742325569601; Tue, 18 Mar 2025
 12:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
 <67d9c5fe.170a0220.21d2a4.7507@mx.google.com>
In-Reply-To: <67d9c5fe.170a0220.21d2a4.7507@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Mar 2025 15:19:16 -0400
X-Gm-Features: AQ5f1JoQ4WqF-mRD0BHPPuhSDIKy_HiRIrFROmgMvpIgk0QojrfH2KQtSC1ye1w
Message-ID: <CABBYNZLP6OMn0uOp_+B+ErBo4oUhn3NK5Pwz0+65gPhSOi99HA@mail.gmail.com>
Subject: Re: net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
To: linux-bluetooth@vger.kernel.org
Cc: pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Mar 18, 2025 at 3:15=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
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
> error: patch failed: include/linux/skbuff.h:478
> error: include/linux/skbuff.h: patch does not apply
> error: patch failed: net/core/skbuff.c:5523
> error: net/core/skbuff.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.

Did you base in something other than bluetooth-next? Do we need to
rebase bluetooth-next to net-next perhaps?

--=20
Luiz Augusto von Dentz
