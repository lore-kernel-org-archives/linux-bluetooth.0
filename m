Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D38372EE6
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355122; cv=none; b=NpND1Vgw6yMA1j8CvDz6m8aAUSD7FzRL0kGhO6ng6Xerp4FjlVhP609XmHeCD1spB6A0vE5ngb+5Z8TjO0Un8bg8GfOpLaaDdSMQYnXTb3xOXmKEtYavNJ9JB3wQyR52G9ZgSpceRkcwpgf6OOo2tfOsTVKOPC9ftrBj3qeSAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355122; c=relaxed/simple;
	bh=azw12yvo1KzS4bOAY2lRlKmNg9Zna4MNvidgXEzteRo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxP+x0eyJntLy6+ES57S79PMZFRYsR0OLse7Bk6NttriaqwWLFkVJLQoGVphNsTq8wMKnZuTbf6WcZIMXmqPEVZmU/GUzQMi3s3Yd3S2vlZRCD1b1/nYW9PPJpuS6cGH54eRCIJ1keT/bqk4OG64gs29SmQlVLIe4or+tXCzrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZjKXkQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZjKXkQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337EE1F00A3F
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355120;
	bh=azw12yvo1KzS4bOAY2lRlKmNg9Zna4MNvidgXEzteRo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=OZjKXkQZv5hnNqa14eYjTh92IdTWlvwfWTIj7QQ6zZkUx4SgYVrNqah27+wXDgjGC
	 gWwVAF16Zx+3ZNyDxS6R+5KspgS41D1YJfszZPUbt2Md0a0LqzG7ynooFeMF2V31I8
	 76cf66sJHbi5RPQcIc7DKra4Ji2OrLpqBOSTcDvYsrXUd2yw0e3ApjSrnJNYq6TT73
	 58761eq7Ho0Sqkpuy5VllINNeKqtQSUBUGMhZN3puywZnymXRkvzVdipe1CKKmvPww
	 ynhSv0XuKxAeDdeMgEcZavvEKxm7PRzgtkeJq5LP6jnjJG3BcpNij4gUdTpNghCnTH
	 usyNtekRbqhxw==
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1357c851a48so6614715c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 02:18:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/L4QyZOK+8WfySK0gVHzCHxodufrqS5CGhS3AOU7pCZh0K4U33hK5tNICwPmFpjvy4yo8zbRpY95U+ustbYag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS9lrVQNHpKi0TzSN+zp7lCKQ0e7NUwpRGv4IajDobNSD8ZggR
	WNXmFbYt3fevmPp1w2JxnAsOpgwh21JSF8A/L4bMd1D2BZjPwDZy98MPwjLwSp7lC00fzpIPdIw
	uVJ6gW5pTeTZ9ipsgv4kI/onYzvS67amYOytkTGIg7Q==
X-Received: by 2002:a05:7023:b82:b0:135:a75e:7d93 with SMTP id
 a92af1059eb24-13632c2e98dmr919788c88.32.1779355119421; Thu, 21 May 2026
 02:18:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 02:18:35 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 02:18:35 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com>
Date: Thu, 21 May 2026 02:18:35 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdddNGkost=5XD9nvxwcCE4mRHQhAow9gS+Hap_b32mpA@mail.gmail.com>
X-Gm-Features: AVHnY4IBgnLNrnXiblCXaybZXjL6TZAv5y3zJhw560hCdBFpu5oS9qCU09vJltQ
Message-ID: <CAMRc=MdddNGkost=5XD9nvxwcCE4mRHQhAow9gS+Hap_b32mpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Fixes/improvements for the PCI M.2 power
 sequencing driver
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 10:55:55 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> Hi,
>
> This series has several key improvements and fixes to the M.2 power sequencing
> driver and also the BT HCI_QCA driver. Notably, this series allows the M.2 power
> sequencing driver to work with more M.2 cards, not just WCN7850. It also allows
> the BT HCI_QCA driver to detect whether it can control BT_EN (or W_DISABLE2#)
> signal on the connector and set the HCI_QUIRK_NON_PERSISTENT_SETUP quirk.
>
> Testing
> =======
>
> This series was tested on Lenovo Thinkpad T14s together with the below DTS
> patches:
> https://github.com/Mani-Sadhasivam/linux/commit/29534d15307551b2355eb254601dec511169f0aa
> https://github.com/Mani-Sadhasivam/linux/commit/f4eaacfe647674be200847092b43cdef2194fc55
>
> Merge Strategy
> ==============
>
> Since the BT HCI_QCA changes depend on the pwrseq changes, it would be good to
> merge the whole series through pwrseq tree or through an immutable branch.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Luiz, Augusto: this series looks good to me. Do you want me to queue the pwrseq
patches on an immutable branch or should I just take the entire thing?

Bart
