Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531391DED7C
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133221; cv=none; b=auwiaqEF1a4sLnArf4S4EmKaLs2kIt0FBB2oU+DIgBKxULjUYichlxUEmRer37rSpMiUiZraf+p6+IOGzz9pP9Rogf+sC0M5/m7x5hwBCbUfUIAuUJYLoYXWwMtLTMR4CDoqdstrFzTXWti4Bj0bH5iCf35tRIJ4TPxnr7s2rLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133221; c=relaxed/simple;
	bh=FbGm8I24d6rLYFTSo3ZDP4RDPJV4yK9HMrrKFbShLbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QG+sOn708o6YLffCWPZKX9U0C7JW1LIOPJ/7cCBDc+KA3botkXbtthz0N/mIL5KNjheyYHmQ0ys/TE8JPeHWlHfbPBSQZosbto2j1wyYMPmHeqvBqsTfphx5YlfPUehSViATxWZia67Dut+JkeXRH34GP5fSG1pK7E18t4Oyj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8xix5t4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8xix5t4"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5fbc40239so2569584b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730133217; x=1730738017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sA+lJtcYDLxuowgxxa1JBBRiCYzBSv6/erkXPLeHw8Y=;
        b=K8xix5t44UILnd9/2la2ggIrASW7tx/ilBMw6WITEdIEQPs+6FyiBn6gFsvtGU39C0
         nQ2LZylWnNiLXw4phdyoj2Juj+s2il4Zc8Qm+F0wY6hEl5ySBzdswuY0MaCg33UAB4xw
         njMbdvPjNaHMLwJCCekhnBoxakt0DQ1b7+21QWO+my32dYlWly5KV+2aQqhVgeteQkO/
         DPLn0vQsvSsqUW0Jwci2yjE1KpWFwa//QjRgV4sdJe5FEY5IfsxMdk1DSnGjfJr9I5bw
         1icot5Wf9k3ANVcJrlcP4VBAYayldJ3se6wrfyvcKckXpZTNanzqz6cZ7VTwsZWSwpum
         trBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133217; x=1730738017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sA+lJtcYDLxuowgxxa1JBBRiCYzBSv6/erkXPLeHw8Y=;
        b=N+NLpoZUSYFIFJ+WtgDqCK7zzwVi3usWqSua9zuPSIJoy4uf7zncgEaSLh5H0jd4sZ
         81wvsh8SrK4baMMRK//9By4Jdk8ap3QMBO8qP4dKZ8eIH8wCKS4xh42LU9yt3mq+Timu
         myO3m4ORikzoLOJnUlC7E8RN0cOnOk6rI7UlNOvzCgBxkyLFRu299uC4ZPeJyweRFs57
         V53JR41KZMyGm+Y63UH+nF7z5aUGSDorvhyMS2Y4xav6DQ4gpkBfKoNeqSZQS9C5XmBX
         VJm5mnM+MdHeh3aK7Dk4GXEZa+UtNUXTyPPs7lXl9sccrTRN+yoMHbZx+jmpRETqx6Z+
         5TSw==
X-Gm-Message-State: AOJu0YzZOiSSztkHMh0wXbH08kZRTsqogEtxtalSz688HQaIS1Wrrlca
	v7h9pwBn2xZoYYjtKTomQTZDIVfs+g1/OKMADd99YZFdqk7UmijMcI9/Rr/H4BVjHLS7qvReJtR
	LM9uJdNNi64aRwjR4jNLSO7YRCTpZZmz9
X-Google-Smtp-Source: AGHT+IE3ibcSlAeJNVZeq+6/5nALFQjLpLPNxuYgMIcm0ZxS3bXqnzJMV6C2y28SMw6MxduMT9ttDLfXvVS573MtqU8=
X-Received: by 2002:a05:6808:1506:b0:3e5:d11d:5314 with SMTP id
 5614622812f47-3e6384ad59dmr6552685b6e.46.1730133215997; Mon, 28 Oct 2024
 09:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026191434.556716-1-arkadiusz.bokowy@gmail.com> <CABBYNZKs5JNZJV17gZ_Nrbj_f-NbFJVfrBy5tuWcKk1yq58uMg@mail.gmail.com>
In-Reply-To: <CABBYNZKs5JNZJV17gZ_Nrbj_f-NbFJVfrBy5tuWcKk1yq58uMg@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Mon, 28 Oct 2024 17:32:45 +0100
Message-ID: <CAGFh0257uWwvACrcnOJYW5VB8LtAa0917u_pgEzWVPX-Szu6aw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] transport: Expose DelayReporting on
 MediaTransport interface
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >
> > +boolean DelayReporting [readonly]
> > +
> > +       Indicates if the endpoint associated with the transport supports Delay
> > +       Reporting.
>
> The presence of Delay indicates delay reporting is supported, so no
> need to add another property for it.

Yes, after a patch which allows 0 to be returned that totally makes
sense. I have not thought about that!
