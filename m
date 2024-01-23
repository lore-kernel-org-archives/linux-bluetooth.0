Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3B41A85
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022567; cv=none; b=CYkq7fJW+n0yOKJ3s9WknusgVXu7YtO2d1+MwRsLGULUKO3+i4HtJ4SFD1Hy6oifRFiKhRJJwkk+JV8Glo039hw0g2aEGmfmRGrW2hx1GOB/pU68aURQqwzQYFQdAdp8kAGxSkfwvyfSmjc6HxvXZPkz57ey+dc5qGwNNayMMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022567; c=relaxed/simple;
	bh=KAqpawEFW49hi7iVGRhJ4EG/tCqhQzAJ/JDouIaV2Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSOpp8SlRRxjSEI9KXFQds5C3jupI4PWyVGmxwnvhuOf2C/zs7cbvcf1p8huJeH08Tqfzvhu0lygE+OxjsKiLe0YYHdFbT2i8V0PPEIoltPnPinbSZsld8uzCkGYUUeRhxr8jxNklKjH4F2POQSSRQa59ShnQYe+YlHeB5xSz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsArs03B; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsArs03B"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6de83f5a004so3015476a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 07:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706022565; x=1706627365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7VudIcvJSX4LNklYqs4aBtlROOo4UizMxhfkYUDRSg=;
        b=nsArs03BJnE7gzohYU4f4tHHNDIXTAX1nI81uVIl9Q/mrVLMiifaaQuIZiAsdy7VQI
         F5/hDky/uwAJKEhOy6iS2rgKnwTo5FgCk/EQ0duoNx8BfLYbTmAUT0cSDenbgT+Bhx8f
         a0UKi0ieHiHSZkhL2st5JHf7XLhVBc0iykCD3Tuj1MGWD3TxIoj/LxtF8U/k6mkUOejJ
         dO/CweJM1kV3og9PVOPwAXcni4mleVJp6vcWbRyjtjlnSsiXamzt+iSKLSPwOVrIRF+P
         MVaRBFJggdwLfMRgFrcKL6/v7ZVQVKScqNzZ2nBs3UHQ5Zf83+L1ZjPB4ijZ5dirodXN
         gqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022565; x=1706627365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7VudIcvJSX4LNklYqs4aBtlROOo4UizMxhfkYUDRSg=;
        b=n/iRkr6h+ZRPFEEiKLQCRZeWY+AUyAObvcyeuSy3Ll7zLLUrWQ7efJtxrwULmk4HMg
         BXb7WFUZ/uc/20wFoBi7Givp5+OKSNflfdsNisV7KZM98S2A/BXf9+C+pwzLyhFeWxuF
         yxrvkpjyj4IxgTq4BcvxApJSxpKZKgGnlOSqLWZ+qEIA6NEM/WPbZoxDkIZcD2UrFuRw
         /h9bR8qGbfyBq1FJnUtGtHu4uG7k9JJsdN8X7ndVAWPO1/PXzwvPhB9ukul5BAnVmNNF
         KAbUeguUKMhgvayCxxPVVTZ1Rg+KFQkVsyy1bjWPkxxrWhCEQjh0LXNELUXk+RE32S9W
         1Ggg==
X-Gm-Message-State: AOJu0YwD+bzXPTJ5Kpho/dJzgRvk0hO74jTZgl2v8fA2FuloYwCXxry9
	4tZstLdh18TxiBz6dIUlKDwZaTfSecn+ROqv4lDlqDa3f9Mx/XHKJQl+MnF9rh8vM15yrU5uvE1
	L/dVXOzwQ8VnlyernuLsOuXHWWxc=
X-Google-Smtp-Source: AGHT+IFr7qQGaMnAdYtl2V7sLAGBTs7vTwajgjsKKI8J1hp6obsD2w/wig7aDE3QoUdrTB0n7duIVsBi+GINukVPTQs=
X-Received: by 2002:a05:6830:71a1:b0:6e0:16cb:4b5c with SMTP id
 el33-20020a05683071a100b006e016cb4b5cmr7200938otb.54.1706022565304; Tue, 23
 Jan 2024 07:09:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
 <CABBYNZKv+KFAAY-5-LwMdYKDHKtyh3BRbigUv06h_ZBLJPQobQ@mail.gmail.com>
 <CACvgo535rjwHh1J+kX8L8wYrgZJ0ui4DaLsjDqtptm5XU8dSHw@mail.gmail.com> <CABBYNZKgnVd80m0tkrVtMaKO8Ba+rnXk9CUawCrsa9uLuV7W-A@mail.gmail.com>
In-Reply-To: <CABBYNZKgnVd80m0tkrVtMaKO8Ba+rnXk9CUawCrsa9uLuV7W-A@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 23 Jan 2024 15:09:13 +0000
Message-ID: <CACvgo50Hmdytpdnc2N2agAYD_rmwQtjhbmKPCqs8UQBg-bneFg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/8] Remove support for external plugins
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 at 14:00, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Emil,
>
> On Tue, Jan 23, 2024 at 8:54=E2=80=AFAM Emil Velikov <emil.l.velikov@gmai=
l.com> wrote:
> >
> > On Mon, 22 Jan 2024 at 18:35, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Emil,
> > >
> > > On Tue, Jan 16, 2024 at 9:19=E2=80=AFAM Emil Velikov via B4 Relay
> > > <devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
> > > >
> > > > Greetings one and all,
> > > >
> > > > In this series, we prune support for external plugins and cleanup t=
he
> > > > associated code. The inspiration here is multiple-fold:
> > > >  - the plugins are under linked - generally a bad idea
> > > >  - the plugins use undefined, unscoped, unversioned internal API
> > > >  - the main daemons expose their internal API increasing their size
> > >
> > > Im not so sure I want to remove the external plugins support
> > > completely, but I do understand that normally distros don't really
> > > want to have it enabled in production due to the reasons mentioned
> > > above, but I think we could find a middle ground here by disabling it
> > > by default but still let systems to re-enable it if they have some
> > > custom plugin that they may still want to use as external plugin.
> > >
> >
> > Thanks for the feedback. Sure, I can convert this to a "configure
> > --support-external-plugins", where all the presently removed code will
> > be compiled out.
> >
> > Still not entirely sure how external plugins are supposed to work,
> > considering the API/ABI mentioned earlier - any pointers? Do you know
> > of any example plugins that you can mention?
>
> Not really, well just the sixaxis but that can be converted to be
> built-in, but that being external means that there could be external
> plugins we don't know about thus why I think we would be better to
> have a flag to re-enable them just in case. Anyway I think for sixaxis
> we could just have it as built-in since it seems popular enough with
> the likes of steam deck, etc.
>

Ack, much appreciated. Will send v2 shortly.

Emil
