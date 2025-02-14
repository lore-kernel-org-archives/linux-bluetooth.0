Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC2186284
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739511132; cv=none; b=K7VAdOPxHAzZsI+JecuQ5llWSftc7BTg9jXgLSNwWYDmRLMqsdWTWV8vU9sM0RW7cWpHFN48M/8PjHfAtQ4X8Ro3utH8ng8Ys9XkfSNlpHJw/h0iqHgkVCZrzBmOBLdudh2gT6A+o9i6LOIFiGJSKYJiVCFLoGjSXDPy+tlYtAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739511132; c=relaxed/simple;
	bh=e+1bTLCSkwzuCKdRjRAJmKpxLFf3QyY4HVQ5ElfHlHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCsbnQBtKes/lXz+vLugAkBNLN+OdfLdVlHbqigSTsw9zXgDGnVnOX+JxVyDLFWC2b6+6/u5w7c2CeTR3ZlUARcgUrxQtykdCf8XNZy9U6VwtrzydDeF09FBgGZP62LWWCu5gKG/ShGXq3A6oCbRiTtUfZGq8glk8INN2kx3f6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiP4I7Dm; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiP4I7Dm"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5dab3f3880so1317264276.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 21:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739511130; x=1740115930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e+1bTLCSkwzuCKdRjRAJmKpxLFf3QyY4HVQ5ElfHlHY=;
        b=YiP4I7DmRA6P51e8LpHHg2GZj3vSNN+4zj4PyDDGd0trzlf6xRCRoYHKPFNjAv5nXa
         Fgn/ILAJWclOFczSphAvVN6Sp0rslgcQjhTRJovHgcg/sT52SnIwrSKjY8hTcWqSvA21
         JPBgr2Ltis4axJvhBkgntT7oBK9XqnyLkInBf33dPeV1qCkhPCu8vWVR3Gsz5e7j+jCh
         xFcpB7YA7iFjfBHjTBMeiWtiv88VzyPOpkHQwZg2Ci4QkE2/uKp//878XUaQ0c9lpuk4
         TT393pX1b5cQZ3qrYWgZ1wuf7OKBgW+gAxY5H7QwixUbXubCHojucxy4D/b3nbAwEqTV
         g5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739511130; x=1740115930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+1bTLCSkwzuCKdRjRAJmKpxLFf3QyY4HVQ5ElfHlHY=;
        b=qcAZSkQXrVKCw+Bb8uhI9v3oHdiYkSzgaUb4z+4va/LfDSk9Tq3Y6bZYvfXSWGRRO2
         +rnqMa3KWJ5uxiJDGz50C9auKaBd4XzCqg8q6yxZP0pzUFGyX+fPiCsJBjdCgdGuj9lY
         /TtBuKjBhBQrQCz3v2b2UrJyroq2Xr+2zUkGNc4w/mGFmmchU3gqrlSi3GptZs5Ak1b+
         EmTiBEb3MG8wbqk+D3T2rgB+cGY9FBvg7ZmmfzJxFiMb8TGt/ncoPM0DWmGTI0DtRXSJ
         isw656it/U+jhv3ODyb+6HCzxl69HvY3zlcJyJ/dIQ9frt1F3H+5AbuQubTKB9mKZWl7
         0myQ==
X-Gm-Message-State: AOJu0YzcHlcdqGJWepKIJEsbTgSOFViiPiFdSC1ZsQK5eLbhDvT+pApz
	2kuJyxHFQ+SLhuSUH73UurFXijTP8Ry/R9T9i6y2P6kpMI+gtLLj9t9cMkf3sbQp8LV003t+Xhs
	2w+h7lB0BBFZjMTqKC2ucVbrY5cvNHHDusOU=
X-Gm-Gg: ASbGncvpI98fK83zQymSDhgN1Vzx9JWz9oJZa6dnVUYskixses+lGkpXr4HiglXqiqZ
	iDeVs4Lzx5amSbDP7R12L4at6dR23Xui9nRXdLEX7HrseblFZFsOKweUi/HqWe4nA1chkuVkVmA
	==
X-Google-Smtp-Source: AGHT+IGVbFui7OivOHBMCsKt6W1SJqUp5E+IScpuLXm6R1WAWgslt2U5H4tHtlIat0tQxeT6UL77JDpIJrqHMRkrKwk=
X-Received: by 2002:a05:6902:1143:b0:e5b:3394:ea0c with SMTP id
 3f1490d57ef6-e5d9f0c99a7mr9703491276.10.1739511129816; Thu, 13 Feb 2025
 21:32:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123134908.805346-1-arnd@kernel.org> <67ae71e1.170a0220.69f3b.9ade@mx.google.com>
 <CABBYNZJz0yFAyphL-wRPWJHhqUBX_s5r1U91bZo+U7V46c7yMw@mail.gmail.com>
In-Reply-To: <CABBYNZJz0yFAyphL-wRPWJHhqUBX_s5r1U91bZo+U7V46c7yMw@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Fri, 14 Feb 2025 06:31:58 +0100
X-Gm-Features: AWEUYZkitp-cMVeRbYppel1bck-EnwMVtdqMfyx_oBcZn1UnV68a9yMpofUg5VU
Message-ID: <CAGFh0267CagMx0UFg9YQputn2EK=OHVgx+n_OTbZ7tZYMYU76Q@mail.gmail.com>
Subject: Re: hid: intel-thc: fix CONFIG_HID dependency
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Content-Type: text/plain; charset="UTF-8"

> I guess these errors are related to the last change aren't they? Most
> likely github hosts don't have KVM enabled or something like that.

Yes... It's because of "-cpu host". So, this change must be reverted
if CI does not have KVM support. I was not aware of that, sorry.

Regards,
Arek
