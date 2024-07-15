Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35F18E749
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052967; cv=none; b=R7ph+cg89b8Ll3mkDw1xlSXyZAFzJYIjppvFkdk8/qESsXzqaO74OQkPKCuqRkG/u/nUAPAZYTQhi9zNkFIB7NjpFhnE3lIxg93r70E9dxO999EoTI0Ax1IEcGEtnpeNNE7xwybfyNZDUEVSYJDNzhib0u9IVvCoSNashc1PjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052967; c=relaxed/simple;
	bh=zPrpwQlL2crmjNa4smp42LfL5xsAOvhXZdKXxy3/kok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSWhW19ILLslURMlTxNxC/N4hsEFY0sh4TfyRmtpRWmp7+uNkkK7gkMRCtFuRRV2K5PT4AsndEAMEiYdF4hHBG+A7hZLjmEmHa0mbORDvS3YVNgnT8Pj3QMMn9YpU6v9kgbGu2J2j2OmrJpq1UpRtYZA/b0G1D8NxbaKzbVTki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=raBh8GWe; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raBh8GWe"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66108213e88so11720917b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721052960; x=1721657760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zPrpwQlL2crmjNa4smp42LfL5xsAOvhXZdKXxy3/kok=;
        b=raBh8GWeDzPOe1Sf7/OA3W/diJOEBNaYEAIoWdVRYZHHbPW1+kvl6LSaSpeL48JV6G
         mi6AGA5Yy/ctGWqR2Dx+EY/Ux4Lz23RE2Cs/jxXZoCKJQIF8ZHSkRS2Bx2fapzeCUuZy
         eOlfPeT4RKlWBTQrFtOFKZrdz7e0P/Dm/sO+DB3nf2Jx5LB7AN0atnFG1EeKK+bbQI1R
         0nnX09NjI1y2Lha2g6wyyIa4stoD+KLkZLtiZ69ojELTRUSnxBxPGa6CD6qZyoo9w5k6
         mnlR60Fw5oJtJ2QCXXV0Kwq1AK93HBHttF8aar6eUnVjkzs8BqYthM5xQoSgsE8+I50F
         J37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721052960; x=1721657760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPrpwQlL2crmjNa4smp42LfL5xsAOvhXZdKXxy3/kok=;
        b=rHRpBXuMjwsEeKGiL5gce1N+LlBZSfUAUoyz+HdxW1DOEtAuvRhQapBngr2ezyBqVQ
         bXuYL9551QLR87b5+OJVFUx/Lqm/kT02Uyl5JbDAGQCEWcn0PJdZlH8CmpPfMQaz1I++
         hrkpInb4pX+QIR6SAC5s+gH4ZDr2s24XJeSYBILr8ID1jSQ6Bx+21RkuxSJRxd7eq3cR
         4n1gqWEsuN0UHE0rd4ewIL8zwPrOUL2e63ohWp1pgajA8YiXE+mvjMvnImz+JcFmuujR
         8FjzTL230oJvcsGcZ2tP5byP9HNpWxdZ951z2eA0xtRKDwVqpQJhTN299/zDT85FAxoZ
         grHg==
X-Forwarded-Encrypted: i=1; AJvYcCUHUKko/HLfbMc0Xhbk8UEJJYz9vOv3pFpU7rnKhUoKaxVUyTDMTKzFOEsEBAJXkZsZvpl16LSdaSRt/Mt2d3iAmik79//FlcIteYgCwi7Y
X-Gm-Message-State: AOJu0Ywzy5LKfXpcLqXET1f2vIGUgVoXzRdJZ8io6+ep8H/NXykGz6hF
	xa4t2KD4TFdRzFACxIGUM46OmnPJONHMmHPqcULinutNAar+OR2kxmM1ioOnoKSnunjJm2eULtP
	kFPIpaBOsEZNXpIc3E735wX1RfPKW5/5rEm58tA==
X-Google-Smtp-Source: AGHT+IHb+gxnONbxy8xXZCJ33d+B6X9hNWCDsDZDbco0SUpBCc4PyUSEL4qETxb9/3bZVvm7kgJWWoBjZ4eb5yfwpaQ=
X-Received: by 2002:a0d:fc82:0:b0:65f:9f0f:7912 with SMTP id
 00721157ae682-65f9f0f793amr74093307b3.20.1721052960083; Mon, 15 Jul 2024
 07:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
 <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com> <20240715070133.63140316@kernel.org>
In-Reply-To: <20240715070133.63140316@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 15 Jul 2024 16:15:49 +0200
Message-ID: <CACMJSestJBr=yXgEXDrZj8djZP6G7udOjCgUpwZhgfowgQGbww@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 16:01, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 15 Jul 2024 15:55:56 +0200 Bartosz Golaszewski wrote:
> > Luiz pulled the immutable branch I provided (on which my PR to Linus
> > is based) but I no longer see the Merge commit in the bluetooth-next
> > tree[1]. Most likely a bad rebase.
> >
> > Luiz: please make sure to let Linus (or whomever your upstream is)
> > know about this. I'm afraid there's not much we can do now, the
> > commits will appear twice in mainline. :(
>
> If Luiz does rebases, maybe he could rebase, drop the patches and
> re-pull again? Or, you know, re-pull in the middle of a rebase
> so that build doesn't break. Should be pretty.. doable.. ?

Oh, I thought this already went upstream to net-next? If not, then
sure, Luiz can rebuild his tree.

Bart
