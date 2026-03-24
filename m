Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC12DB787
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382515; cv=pass; b=OqzSRyrdf4/ziapY8GGZY+FE9rV3raW2YV27dLtSGnEdwayNGJfWOA+lzthIxk9wK56It5czLKjxVEQtJYkkgK066h4WD/IUfanYzQY8Pl6xLq3wg1W/WyWfdcri2NikGaIxNs2cYQcR757byK+XqP/EV0AY1z0pMRbQl+l3izI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382515; c=relaxed/simple;
	bh=3JinU9QWdjNKRGVl4u2wkJq2V/mu2RPYfuIoKkH3R7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTakrFxCBoA4fXMTH5dfLHTo2+kADbyYDhOx/gXS1c7ydeSCx8GThUy3uHHwOBvsQBUwQOk+o3G8yzxC6xKXTK7ZtgsHfjiirHOApH2J5VvPZIskqC/R8NjAeb+XOeMxCmm9UMz8iRp7G5UBMjG7bwLzW7kYeaS6ZdwJfHZXkmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn+fVF0f; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn+fVF0f"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7986e538decso27219877b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 13:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774382512; cv=none;
        d=google.com; s=arc-20240605;
        b=eKnAX8D/5jxdzdGNBeAPHSqNqeDESjv2RE2NmEh/QzoR75kk2rmuJVbwub9wailGQP
         piqX/+iz3/MHHuHgN2YSmYcCAe4jUa4ssC/6gfEVrIk9shwX7CLrH2L4hT52UNuFgdXd
         ZJDuuEVQrwUG5nCY7Tw9cGtU5SwXHGzHJD02r37/Zi+znF2CUcBlIoHLBllgEZl3YiyA
         uHPjnZyxFVE0sjzqGSA50FraSGSD2Qfyk1miA1cUJPKBHJaBMKRZDXdiPSGtV5wakzz1
         wWBUsBOQBcSlDx0xNC2YyZiMZPSjd7uvtEzp8JZlf/XbI+cirUdDabNr9n5yIxmFjC6U
         2fpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3JinU9QWdjNKRGVl4u2wkJq2V/mu2RPYfuIoKkH3R7k=;
        fh=OPa5Q+3ruYdVUAnRhf4AqAxdSEHPyTq5dluOrixPLfc=;
        b=Rrtl6ktGjVr4ZpFgD/c+DL06aHMl+j0CWZ1HhyD/zHMLUr937wD7YwNrdftMKIz7El
         H/qasPsSLk8Rk+Ltu/mE+IBled14DjO5+QHswczE+BvZv3zMmNs+Pt98cRli8LyOybkH
         N2JFpoamHBrFTGdjKMUlDEY+ErZwjTErkG6783PuuBFOXQYTfa7jd/BzjIDfwz+z9zg+
         9mEnVzimUz4tj8poj75oq3IyVEGb4ckCi167sfbPYLDFIUjN40/duTAngTnNDYmjgTjO
         2++yYsufN2u1UPZTjpp8SLqaWXuUds7pp2QCmmMW2y91lqCgpk4v4kAVi8CVzR4+7T3r
         eZjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774382512; x=1774987312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JinU9QWdjNKRGVl4u2wkJq2V/mu2RPYfuIoKkH3R7k=;
        b=Tn+fVF0fjTgazMuxVZq6qL/swU+Iwqw5CD5KzV/evry2xLMPljSVrgLnCXJYn6kGsF
         T8FOtc9Lxr9aXBSsasOXo3tK/FOy9cnz2ex2z/RbdYni18CB9jHiKfUZhr3w8PTUUB11
         +DFjVXqMG9i3wA1JnG726Ed4ec0aZCv1mv8bKzPLFpC8zHItv0aSOW1iVjlSUYNqkZAt
         NpMiDphKXeLBjackdnxjejqlHFxNT9zW43zIZhArnB9achMzk8QUSqS5lCarjkBxTKzZ
         apn0QtX1BsJ1DR3bASe5hkFQotmcF7SAdw/l9NSJ9wfCqrsHmy85jMXq5Ogp8G8MCKaY
         bRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382512; x=1774987312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3JinU9QWdjNKRGVl4u2wkJq2V/mu2RPYfuIoKkH3R7k=;
        b=GOZtfFTKZtWuJQ6V1zbcIfVHFNkBX4WP6zdpmIj0MLGmoLRH3dSiN2WsLzq7IwIjjQ
         tMysqE5ZDwBq/apRGWzG45hEc3E/2zQo0WYjM0cLs6UYxLETnyxUyjekiu6vzqREMrKe
         Tge+qkTZrFPvXvFTY4vWOj8ZtLmA5KjlyP4mc/jaC88ZoxdKnZBK513l5MM/jdKPDaGD
         qVy6QJ210/BPdJEdPjaIh30t8pz74d/oOrLfHP45qxCmPzrJ/+vV/ZzyRubFSetSlwz1
         U/yqRi+f/f+I0fIcPcBGq/k/vyOek79Bs1dhrb6zy8YdWJ+LYXbiiTOPHNDR3TIYzKsS
         qjmw==
X-Forwarded-Encrypted: i=1; AJvYcCVttudQDzjd6bIhTd+w1fwEKAkX+WOYnig7gmVey93suzoFCoowG+vKZOaeycVGy5SqxDJo9spIMvfkbOst4EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRoB4ZOpqhPUN5X2AHrOIaZLCdCJqNaz2F66n4r7oi56uE/EZP
	S1YR8vELxdlxjgfMYlRwwP+DOkmLgcj/0N7q6qFYTAInE0CgEK7Mr2bhdskWGSOHVHWi2AxhxYJ
	mJHcVYj8rISOEPVGB3HposN/SlOha078=
X-Gm-Gg: ATEYQzw/EEYUQaVo5U3u2uUm1wgwf3yfq2iizaHB3gjtqtvNAwrKD9ma1W9HJieDKil
	LofEYltRDF4PlBodeWfZjpwGMt49BRRnRX8vJv1xUfB5g242JeAvApeii2Jsz7Nfn68pcfgVT/t
	MR7GEOqrh6naQEcuWt3sSJfJIh2IhXHl2lJBxAN9u5xsohX4rq6Nykrquvjc5lLYDQ7boeL8XoE
	Ro5W0TL5OVJMBafMcnpvqxosKpJ+0ntDsh90278HHJmuJUEGlS6+L1ELcw9iY9BGzZEfpvs52VN
	ERgCDwSdM3gVE2QXMoGjb6uRVBAOfzlqopAHe4P5jgTdoY/2s3eA2/oK/iiojSAY9SRmJg==
X-Received: by 2002:a05:690c:46c4:b0:799:3a3:2f25 with SMTP id
 00721157ae682-79acf67c2cfmr12621797b3.38.1774382511723; Tue, 24 Mar 2026
 13:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324023016.3889062-1-shuai.zhang@oss.qualcomm.com> <CAMRc=Mf4gVhwUZ8t1jQ_ohX9dfGcAX7ay3WGZP+LmsTM87xL8w@mail.gmail.com>
In-Reply-To: <CAMRc=Mf4gVhwUZ8t1jQ_ohX9dfGcAX7ay3WGZP+LmsTM87xL8w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Mar 2026 16:01:40 -0400
X-Gm-Features: AaiRm53yjaS3XqrluSz7mPGhKsBUwhRbocFl2autndacf2K5TbU3vzsowbQ_exc
Message-ID: <CABBYNZJciviNAL_n4ce+Ncn-bHn1utcBj4VVJGFhpYMRZxrH5g@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_qca: disable power control for WCN7850
 when bt_en is not defined
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Shuai Zhang <shuai.zhang@oss.qualcomm.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Tue, Mar 24, 2026 at 6:33=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Tue, Mar 24, 2026 at 3:30=E2=80=AFAM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
> >
> > On platforms using an M.2 slot with both UART and USB support, bt_en is
> > pulled high by hardware. In this case, software-based power control
> > should be disabled. The current platforms are Lemans-EVK and Monaco-EVK=
.
> >
> > Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
> > cleared when bt_en is not software-controlled (or absent), aligning its
> > behavior with WCN6750 and WCN6855
> >
> > Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> > ---
>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Let's check if the following is true before I push it:

https://sashiko.dev/#/patchset/20260324023016.3889062-1-shuai.zhang%40oss.q=
ualcomm.com

--=20
Luiz Augusto von Dentz
